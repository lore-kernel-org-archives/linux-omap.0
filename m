From: Kyungmin Park <kmpark-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: omap_apollon_2420_defconfig
Date: Tue, 10 Feb 2009 10:54:25 +0900
Message-ID: <9c9fda240902091754q7f723bf2ha46206e52641297b@mail.gmail.com>
References: <20090209192614.GF19453@n2100.arm.linux.org.uk>
	 <20090209205319.GH14200@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090209205319.GH14200-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

In the previous patch, it's only fixed host side. But apollon case, it
only used udc, so udc configuration should select USB_OTG_UTILS also.

Signed-off-by: Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index 3219d13..b26d6e6 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -191,6 +191,7 @@ config USB_GADGET_OMAP
 	boolean "OMAP USB Device Controller"
 	depends on ARCH_OMAP
 	select ISP1301_OMAP if MACH_OMAP_H2 || MACH_OMAP_H3 || MACH_OMAP_H4_OTG
+	select USB_OTG_UTILS if ARCH_OMAP
 	help
 	   Many Texas Instruments OMAP processors have flexible full
 	   speed USB device controllers, with support for up to 30


On Tue, Feb 10, 2009 at 5:53 AM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> * Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> [090209 11:27]:
>> It would be nice to get the last OMAP defconfig in mainline working.
>> It's broken since 2.6.29-rc2-git3 due to this persistent problem:
>>
>> drivers/built-in.o: In function `omap_udc_probe':
>> omap.c:(.init.text+0x30cc): undefined reference to `otg_get_transceiver'
>> omap.c:(.init.text+0x38a4): undefined reference to `otg_put_transceiver'
>
> Hmm, looks like 2bf5fa13fc8e34d7b86307b99f64a24cb7a83852 did not fix it.
> Dave, do you already have a patch for this?
>
> Regards,
>
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
