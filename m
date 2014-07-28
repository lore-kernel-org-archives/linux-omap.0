From: Belisko Marek <marek.belisko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/3] arm: dts: Add gta04a5 model
Date: Mon, 28 Jul 2014 22:06:07 +0200
Message-ID: <CAAfyv351g1R6TnmW+JKM1sDQsegEFExV6p9BEN=izOdR4n8zEQ@mail.gmail.com>
References: <1406577213-9642-1-git-send-email-marek@goldelico.com>
	<1406577213-9642-4-git-send-email-marek@goldelico.com>
	<CAOf5uwk=ctww=pP4Ae+1C6i-oOtiYTv2NJbj1GpuPwVSKXB4Hw@mail.gmail.com>
	<CAAfyv35jvhzvjCKMwrpa=RQ1JkfcmthCsGDzwLW9Y6bq3Ww_fg@mail.gmail.com>
	<CAOf5uw=Fm9FXEH5ESqDC8pGjMbn5VQ1+MyPJVXSqGh_9+JRLHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOf5uw=Fm9FXEH5ESqDC8pGjMbn5VQ1+MyPJVXSqGh_9+JRLHw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
Cc: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, "Dr. H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Jul 28, 2014 at 10:04 PM, Michael Trimarchi
<michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org> wrote:
> Hi
>
> Il 28/lug/2014 22:02 "Belisko Marek" <marek.belisko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> ha scritto:
>
>
>>
>> Hi Michael,
>>
>> On Mon, Jul 28, 2014 at 9:56 PM, Michael Trimarchi
>> <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org> wrote:
>> > Hi Marek
>> >
>> > Il 28/lug/2014 21:54 "Marek Belisko" <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> ha scritto:
>> >
>> >
>> >>
>> >> Add model a5 which have additional jack detection.
>> >>
>> >> Signed-off-by: Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
>> >> ---
>> >>  arch/arm/boot/dts/Makefile          |  1 +
>> >>  arch/arm/boot/dts/omap3-gta04a5.dts | 17 +++++++++++++++++
>> >>  2 files changed, 18 insertions(+)
>> >>  create mode 100644 arch/arm/boot/dts/omap3-gta04a5.dts
>> >>
>> >> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> >> index 7d45fde..576c595 100644
>> >> --- a/arch/arm/boot/dts/Makefile
>> >> +++ b/arch/arm/boot/dts/Makefile
>> >> @@ -285,6 +285,7 @@ dtb-$(CONFIG_ARCH_OMAP3) += am3517-craneboard.dtb \
>> >>         omap3-evm-37xx.dtb \
>> >>         omap3-gta04a3.dtb \
>> >>         omap3-gta04a4.dtb \
>> >> +       omap3-gta04a5.dtb \
>> >>         omap3-igep0020.dtb \
>> >>         omap3-igep0030.dtb \
>> >>         omap3-ldp.dtb \
>> >> diff --git a/arch/arm/boot/dts/omap3-gta04a5.dts
>> >> b/arch/arm/boot/dts/omap3-gta04a5.dts
>> >> new file mode 100644
>> >> index 0000000..210317c3
>> >> --- /dev/null
>> >> +++ b/arch/arm/boot/dts/omap3-gta04a5.dts
>> >> @@ -0,0 +1,17 @@
>> >> +/*
>> >> + * Copyright (C) 2014 H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
>> >> + *
>> >> + * This program is free software; you can redistribute it and/or
>> >> modify
>> >> + * it under the terms of the GNU General Public License version 2 as
>> >> + * published by the Free Software Foundation.
>> >> + */
>> >> +
>> >> +#include "omap3-gta04.dtsi"
>> >> +
>> >> +/ {
>> >> +       model = "Goldelico GTA04A5;
>> >> +
>> >> +       sound {
>> >> +               ti,jack-det-gpio = <&twl_gpio 2 0>;    /* GTA04A5 only
>> >> */
>> >> +       };
>> >> +};
>> >> --
>> >> 1.9.1
>> >>
>> >
>> > Can we have only one dts with status enabled/disabled?
>> Do you mean to define this node it gta04.dtsi disabled and enable only
>> for a5 model?
>> >
>
> This should be possible in the bootloader
Sorry I didn't get that. Can you give me some short example (or
existing board which using it)?
Thanks.
>
> Right?
>
> Michael
>
>> > Michael
>> >
>> >> --
>> >> To unsubscribe from this list: send the line "unsubscribe linux-omap"
>> >> in
>> >> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>> BR,
>>
>> marek
>>
>> --
>> as simple and primitive as possible
>> -------------------------------------------------
>> Marek Belisko - OPEN-NANDRA
>> Freelance Developer
>>
>> Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
>> Tel: +421 915 052 184
>> skype: marekwhite
>> twitter: #opennandra
>> web: http://open-nandra.com

BR,

marek

-- 
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
twitter: #opennandra
web: http://open-nandra.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
