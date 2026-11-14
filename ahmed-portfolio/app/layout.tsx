import type { Metadata } from 'next';
import './globals.css';
export const metadata: Metadata = {
  metadataBase: new URL(process.env.NEXT_PUBLIC_SITE_URL || 'https://example.com'),
  title: 'أحمد محمد محمد عبد الحميد | مطور برمجيات في مصر والإسماعيلية',
  description: 'الموقع الرسمي لأحمد محمد محمد عبد الحميد، مطور برمجيات ومطور Full-Stack في مصر والإسماعيلية. استكشف المشاريع والخدمات والحلول الرقمية.',
  openGraph: { title: 'Ahmed Mohamed | Software Engineer', description: 'Software Engineer & Full-Stack Developer in Egypt.', type: 'website', images: ['/images/ahmed-profile.jpg'] },
  robots: { index: true, follow: true }
};
export default function RootLayout({children}:{children:React.ReactNode}) { return <html lang="ar" dir="rtl"><body>{children}</body></html>; }
