From: Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Realistic bandwidth to get through ehci controller on a dm3730?
Date: Sun, 17 Jul 2011 22:25:59 +0800
Message-ID: <CACVXFVPwqjWut8TavRGGs8Pxqj68z3FKQ91u3Pk6GhjzKyxNsA@mail.gmail.com>
References: <4E1F07BF.5090105@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4E1F07BF.5090105-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Thu, Jul 14, 2011 at 11:14 PM, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org> wrote:
> Hi All,
>
> Just wondering if anyone had any figures for how much data one can expect
> the omap3's usb controller to handle?
>
> I'm trying to get a playstation eye (ov534) camera to run as at 60fps,
> but gspca is giving me payload errors at 50fps or 60fps. (50*640*480 bytes
> per sec, or about 122Mbits / sec (15MB / sec)

As far as I know, uvc can work well at 3*1024B/uF(24MB/s) in beagle xm, and
it uses ISO transfer.

I don't know if gspca uses ISO endpoint to transfer stream data. If it uses bulk
to transfer video data, it will share the usb bandwidth with other devices.

thanks,
-- 
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
