From: "Dr. H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: Re: [PATCH 3/3] arm: dts: Add gta04a5 model
Date: Tue, 29 Jul 2014 07:17:06 +0200
Message-ID: <A0AA66B6-5D28-49D7-AF83-06F0D38DA96D@goldelico.com>
References: <1406577213-9642-1-git-send-email-marek@goldelico.com> <1406577213-9642-4-git-send-email-marek@goldelico.com> <CAOf5uwk=ctww=pP4Ae+1C6i-oOtiYTv2NJbj1GpuPwVSKXB4Hw@mail.gmail.com> <CAAfyv35jvhzvjCKMwrpa=RQ1JkfcmthCsGDzwLW9Y6bq3Ww_fg@mail.gmail.com> <CAOf5uw=Fm9FXEH5ESqDC8pGjMbn5VQ1+MyPJVXSqGh_9+JRLHw@mail.gmail.com> <CAAfyv351g1R6TnmW+JKM1sDQsegEFExV6p9BEN=izOdR4n8zEQ@mail.gmail.com> <CAOf5uwmjznuK_1au1HnsnYh=BhqC=x+O_tpk6U71bqPv=hFe_A@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOf5uwmjznuK_1au1HnsnYh=BhqC=x+O_tpk6U71bqPv=hFe_A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
Cc: Marek Belisko <marek.belisko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, pawel.moll-5wv7dgnIgG8@public.gmane.org, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

Am 28.07.2014 um 22:12 schrieb Michael Trimarchi:

> Hi
> 
> Il 28/lug/2014 22:06 "Belisko Marek" <marek.belisko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> ha scritto:
> >
> > On Mon, Jul 28, 2014 at 10:04 PM, Michael Trimarchi
> > <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org> wrote:
> > > Hi
> > >
> > > Il 28/lug/2014 22:02 "Belisko Marek" <marek.belisko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> ha scritto:
> > >
> > >
> > >>
> > >> Hi Michael,
> > >>
> > >> On Mon, Jul 28, 2014 at 9:56 PM, Michael Trimarchi
> > >> <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org> wrote:
> > >> > Hi Marek
> > >> >
> > >> > Il 28/lug/2014 21:54 "Marek Belisko" <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> ha scritto:
> > >> >
> > >> >
> > >> >>
> > >> >> Add model a5 which have additional jack detection.
> > >> >>
> > >> >> Signed-off-by: Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
> > >> >> ---
> > >> >>  arch/arm/boot/dts/Makefile          |  1 +
> > >> >>  arch/arm/boot/dts/omap3-gta04a5.dts | 17 +++++++++++++++++
> > >> >>  2 files changed, 18 insertions(+)
> > >> >>  create mode 100644 arch/arm/boot/dts/omap3-gta04a5.dts
> > >> >>
> > >> >> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > >> >> index 7d45fde..576c595 100644
> > >> >> --- a/arch/arm/boot/dts/Makefile
> > >> >> +++ b/arch/arm/boot/dts/Makefile
> > >> >> @@ -285,6 +285,7 @@ dtb-$(CONFIG_ARCH_OMAP3) += am3517-craneboard.dtb \
> > >> >>         omap3-evm-37xx.dtb \
> > >> >>         omap3-gta04a3.dtb \
> > >> >>         omap3-gta04a4.dtb \
> > >> >> +       omap3-gta04a5.dtb \
> > >> >>         omap3-igep0020.dtb \
> > >> >>         omap3-igep0030.dtb \
> > >> >>         omap3-ldp.dtb \
> > >> >> diff --git a/arch/arm/boot/dts/omap3-gta04a5.dts
> > >> >> b/arch/arm/boot/dts/omap3-gta04a5.dts
> > >> >> new file mode 100644
> > >> >> index 0000000..210317c3
> > >> >> --- /dev/null
> > >> >> +++ b/arch/arm/boot/dts/omap3-gta04a5.dts
> > >> >> @@ -0,0 +1,17 @@
> > >> >> +/*
> > >> >> + * Copyright (C) 2014 H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
> > >> >> + *
> > >> >> + * This program is free software; you can redistribute it and/or
> > >> >> modify
> > >> >> + * it under the terms of the GNU General Public License version 2 as
> > >> >> + * published by the Free Software Foundation.
> > >> >> + */
> > >> >> +
> > >> >> +#include "omap3-gta04.dtsi"
> > >> >> +
> > >> >> +/ {
> > >> >> +       model = "Goldelico GTA04A5;
> > >> >> +
> > >> >> +       sound {
> > >> >> +               ti,jack-det-gpio = <&twl_gpio 2 0>;    /* GTA04A5 only
> > >> >> */
> > >> >> +       };
> > >> >> +};
> > >> >> --
> > >> >> 1.9.1
> > >> >>
> > >> >
> > >> > Can we have only one dts with status enabled/disabled?
> > >> Do you mean to define this node it gta04.dtsi disabled and enable only
> > >> for a5 model?
> > >> >
> > >
> > > This should be possible in the bootloader
> > Sorry I didn't get that. Can you give me some short example (or
> > existing board which using it)?
> > Thanks.
> > >
> 
> http://www.denx.de/wiki/view/DULG/UBootCmdFDT
> 
> I just suggest to not create a dts for each board revision but let it manage by the bootloader. I don't know if there are examples but make sense to me to avoid to add a lot of dts.
> 
> 

Hm. Why should we dynamically modify the dtb in memory through slow, interpreted FDT commands in u-boot, if the DTC can statically compile complete .dtb files by using an #include mechanism? It would slow down boot time for no other improvement. And debugging is more difficult that looking for compiler errors.

And our u-boot does not support the fdt command to avoid bloating it. IMHO boot loaders should be as small and fast as possible and contain only what is barely necessary. Everything more sophisticated should be done by the kernel and device drivers and some init user space process. I.e. boot loader should only tell the kernel only which board revision it is but not "manage" the board revisions.

We also have a nice feature that a system on an SD card has the uImage in /boot and all existing and relevant .dtb files. U-Boot simply picks and loads the right one (by file name). This keeps the boot loader stable (people always have difficulties flashing new boot loaders). Therefore we need precompiled DTBs that completely and consistently describe each board variant. This mechanism allows that we can easily swap the SD card between different boards and variants. Implementing this feature using U-Boot scripts with FDT commands to patch the DT, appears to become a nightmare. If you are interested, the whole concept is described here:

http://projects.goldelico.com/p/gta04-main/downloads/55/

Another aspect to consider: in my understanding, the main reason why DT is still maintained within the kernel is that the bindings are not yet stable. Therefore if bindings are patched, all device trees using them are also to be changed. I don't see how this can work if we have part of the board variations managed outside the kernel tree. Therefore each board revision is to be treated not differently from a completely new board. And similar parts are treated by a common .dtsi. This is how the concept IMHO should be. And the consequence is that we need a different .dts file for each board that has differences (even if they are or appear to be small).

So I don't see that your suggestion is the right way to go.

BR,
Nikolaus

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
