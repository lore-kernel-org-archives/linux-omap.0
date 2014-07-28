From: Dr. H. Nikolaus Schaller <hns@goldelico.com>
Subject: Re: [PATCH 3/3] arm: dts: Add gta04a5 model
Date: Mon, 28 Jul 2014 22:42:50 +0200
Message-ID: <1FA8171E-1B7A-4684-887E-11593BB9C29E@goldelico.com>
References: <1406577213-9642-1-git-send-email-marek@goldelico.com>
 <1406577213-9642-4-git-send-email-marek@goldelico.com>
 <CAOf5uwk=ctww=pP4Ae+1C6i-oOtiYTv2NJbj1GpuPwVSKXB4Hw@mail.gmail.com>
 <CAAfyv35jvhzvjCKMwrpa=RQ1JkfcmthCsGDzwLW9Y6bq3Ww_fg@mail.gmail.com>
 <CAOf5uw=Fm9FXEH5ESqDC8pGjMbn5VQ1+MyPJVXSqGh_9+JRLHw@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAOf5uw=Fm9FXEH5ESqDC8pGjMbn5VQ1+MyPJVXSqGh_9+JRLHw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, pawel.moll@arm.com, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, Tony Lindgren <tony@atomide.com>, Marek Belisko <marek.belisko@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Benoit Cousson <bcousson@baylibre.com>, Kumar Gala <galak@codeaurora.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org


Am 28.07.2014 um 22:04 schrieb Michael Trimarchi:

> Hi
> 
> Il 28/lug/2014 22:02 "Belisko Marek" <marek.belisko@gmail.com> ha scritto:
> >
> > Hi Michael,
> >
> > On Mon, Jul 28, 2014 at 9:56 PM, Michael Trimarchi
> > <michael@amarulasolutions.com> wrote:
> > > Hi Marek
> > >
> > > Il 28/lug/2014 21:54 "Marek Belisko" <marek@goldelico.com> ha scritto:
> > >
> > >
> > >>
> > >> Add model a5 which have additional jack detection.
> > >>
> > >> Signed-off-by: Marek Belisko <marek@goldelico.com>
> > >> ---
> > >>  arch/arm/boot/dts/Makefile          |  1 +
> > >>  arch/arm/boot/dts/omap3-gta04a5.dts | 17 +++++++++++++++++
> > >>  2 files changed, 18 insertions(+)
> > >>  create mode 100644 arch/arm/boot/dts/omap3-gta04a5.dts
> > >>
> > >> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > >> index 7d45fde..576c595 100644
> > >> --- a/arch/arm/boot/dts/Makefile
> > >> +++ b/arch/arm/boot/dts/Makefile
> > >> @@ -285,6 +285,7 @@ dtb-$(CONFIG_ARCH_OMAP3) += am3517-craneboard.dtb \
> > >>         omap3-evm-37xx.dtb \
> > >>         omap3-gta04a3.dtb \
> > >>         omap3-gta04a4.dtb \
> > >> +       omap3-gta04a5.dtb \
> > >>         omap3-igep0020.dtb \
> > >>         omap3-igep0030.dtb \
> > >>         omap3-ldp.dtb \
> > >> diff --git a/arch/arm/boot/dts/omap3-gta04a5.dts
> > >> b/arch/arm/boot/dts/omap3-gta04a5.dts
> > >> new file mode 100644
> > >> index 0000000..210317c3
> > >> --- /dev/null
> > >> +++ b/arch/arm/boot/dts/omap3-gta04a5.dts
> > >> @@ -0,0 +1,17 @@
> > >> +/*
> > >> + * Copyright (C) 2014 H. Nikolaus Schaller <hns@goldelico.com>
> > >> + *
> > >> + * This program is free software; you can redistribute it and/or modify
> > >> + * it under the terms of the GNU General Public License version 2 as
> > >> + * published by the Free Software Foundation.
> > >> + */
> > >> +
> > >> +#include "omap3-gta04.dtsi"
> > >> +
> > >> +/ {
> > >> +       model = "Goldelico GTA04A5;
> > >> +
> > >> +       sound {
> > >> +               ti,jack-det-gpio = <&twl_gpio 2 0>;    /* GTA04A5 only */
> > >> +       };
> > >> +};
> > >> --
> > >> 1.9.1
> > >>
> > >
> > > Can we have only one dts with status enabled/disabled?
> > Do you mean to define this node it gta04.dtsi disabled and enable only
> > for a5 model?
> > >
> 
> This should be possible in the bootloader
> 

Yes,
the boot loader either loads gta04a3.dtb gta04.dtb or gta05.dtb
depending on board revision.

Therefore we have multiple device tree files to represent such hardware
differences. Like Gumstix Overo variants (using a  omap3-overo-base.dtsi)

And, this difference is not the only one. Other are to come later.

Unfortunately we were recommend to submit only DT nodes that already
have drivers. Therefore, the "big picture" of the device variants support
may not yet be visible from this patch.

I hope this gives a little background.

BR,
Nikolaus
