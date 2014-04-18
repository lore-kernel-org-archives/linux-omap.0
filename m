From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: Add support for the BeagleBoard xM A/B
Date: Fri, 18 Apr 2014 15:51:12 -0700
Message-ID: <20140418225111.GP21823@atomide.com>
References: <1397574599-29573-1-git-send-email-robertcnelson@gmail.com>
 <CAOCHtYg5_Lvi3SWuWaRTDDNhLJ32jiXsKYQmrsKaShVWpM+xWQ@mail.gmail.com>
 <534D51C1.3010007@ti.com>
 <CAOCHtYhygGFbUunY9abEkjKfpQ1hh-DfRfhm160NehSYhWJSRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOCHtYhygGFbUunY9abEkjKfpQ1hh-DfRfhm160NehSYhWJSRw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [140415 08:46]:
> On Tue, Apr 15, 2014 at 10:35 AM, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org> wrote:
> > On 04/15/2014 10:12 AM, Robert Nelson wrote:
> >> On Tue, Apr 15, 2014 at 10:09 AM, Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >>> BeagleBoard xM A/B has an inverted usb hub enable line vs the xM C
> >>>
> >>> Signed-off-by: Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >>> ---
> >>>  arch/arm/boot/dts/Makefile               |  1 +
> >>>  arch/arm/boot/dts/omap3-beagle-xm-ab.dts | 15 +++++++++++++++
> >>>  2 files changed, 16 insertions(+)
> >>>  create mode 100644 arch/arm/boot/dts/omap3-beagle-xm-ab.dts
> >>>
> >>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> >>> index 35c146f..0bdeba3 100644
> >>> --- a/arch/arm/boot/dts/Makefile
> >>> +++ b/arch/arm/boot/dts/Makefile
> >>> @@ -246,6 +246,7 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
> >>>         omap3-sbc-t3730.dtb \
> >>>         omap3-devkit8000.dtb \
> >>>         omap3-beagle-xm.dtb \
> >>> +       omap3-beagle-xm-ab.dtb \
> >>>         omap3-evm.dtb \
> >>>         omap3-evm-37xx.dtb \
> >>>         omap3-ldp.dtb \
> >>> diff --git a/arch/arm/boot/dts/omap3-beagle-xm-ab.dts b/arch/arm/boot/dts/omap3-beagle-xm-ab.dts
> >>> new file mode 100644
> >>> index 0000000..9d81123
> >>> --- /dev/null
> >>> +++ b/arch/arm/boot/dts/omap3-beagle-xm-ab.dts
> >>> @@ -0,0 +1,15 @@
> >>> +/*
> >>> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
> >>> + *
> >>> + * This program is free software; you can redistribute it and/or modify
> >>> + * it under the terms of the GNU General Public License version 2 as
> >>> + * published by the Free Software Foundation.
> >>> + */
> >>> +
> >>> +#include "omap3-beagle-xm.dts"
> >>> +
> >>> +/ {
> >>> +       /* HS USB Port 2 Power enable was inverted with the xM C */
> >>> +       hsusb2_power: hsusb2_power_reg {
> >>> +               enable-active-high;
> >>        };
> >>> +};
> >>
> >> Crap, copy paste bug, there.  I can send a v2, if you guys are happy
> >> with the "omap3-beagle-xm-ab.dtb" naming..
> >>
> >> Regards,
> >>
> > Will u-boot adequately handle this as part of find_fdt?
> 
> It will after i submit something like: (this uses a new feature in v2014.04)
> 
> https://github.com/eewiki/u-boot-patches/blob/master/v2014.04/0001-am335x_evm-uEnv.txt-bootz-n-fixes.patch#L76
> 
> Essentially, test for presence of omap3-beagle-xm-ab.dtb, if not found
> drop to old omap3-beagle-xm.dtb
> 
> Background: i also tried getting this having this fixed in u-boot:

Do we still need to apply this patch then?

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
