From: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Subject: Realistic bandwidth to get through ehci controller on a dm3730?
Date: Thu, 14 Jul 2011 16:14:07 +0100
Message-ID: <4E1F07BF.5090105@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi All,

Just wondering if anyone had any figures for how much data one can expect
the omap3's usb controller to handle?

I'm trying to get a playstation eye (ov534) camera to run as at 60fps,
but gspca is giving me payload errors at 50fps or 60fps. (50*640*480 bytes
per sec, or about 122Mbits / sec (15MB / sec)

Quick and dirty tests of the beagle xm's network adapter suggest about
4MB/s so even at 40 fps when the camera is fine, I'm way above that.

Anyhow. Basically I'm trying to work out if I've run into a brick wall
or if it is worth more time to get this to work?

Thanks,

Jonathan
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
