From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP2+: enable TPS65217 support in omap2plus_defconfig
Date: Fri, 14 Dec 2012 09:32:18 -0800
Message-ID: <20121214173218.GU4989@atomide.com>
References: <50AA1BD5.1000002@gmail.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA76FDB@DBDE01.ent.ti.com>
 <CAK0ocyD+N7t5Tm38p3Qt6fNSUEHuL-=_Pw7twDVPbDJ81K3-Xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:14940 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752622Ab2LNRcV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Dec 2012 12:32:21 -0500
Content-Disposition: inline
In-Reply-To: <CAK0ocyD+N7t5Tm38p3Qt6fNSUEHuL-=_Pw7twDVPbDJ81K3-Xg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Mazanov <i.mazanov@gmail.com>
Cc: "AnilKumar, Chimata" <anilkumar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Igor Mazanov <i.mazanov@gmail.com> [121120 09:12]:
> On Tue, Nov 20, 2012 at 2:15 PM, AnilKumar, Chimata <anilkumar@ti.com> wrote:
> > On Mon, Nov 19, 2012 at 17:15:25, Igor Mazanov wrote:
> >> TPS65217 is described in arch/arm/boot/dts/am335x-bone.dts
> >> but doesn't enabled in arch/arm/configs/omap2plus_defconfig.
> >>
> >> Enable TPS65217 support in omap2plus_defconfig.
> >>
> >> Signed-off-by: Igor Mazanov <i.mazanov@gmail.com>
> >> ---
> >>   arch/arm/configs/omap2plus_defconfig |    3 +++
> >>   1 files changed, 3 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/arch/arm/configs/omap2plus_defconfig
> >> b/arch/arm/configs/omap2plus_defconfig
> >> index 6230304..00f2ce3 100644
> >> --- a/arch/arm/configs/omap2plus_defconfig
> >> +++ b/arch/arm/configs/omap2plus_defconfig
> >> @@ -240,3 +240,6 @@ CONFIG_CRC_ITU_T=y
> >>   CONFIG_CRC7=y
> >>   CONFIG_LIBCRC32C=y
> >>   CONFIG_SOC_OMAP5=y
> >> +CONFIG_MFD_CORE=y
> >> +CONFIG_MFD_TPS65217=y
> >> +CONFIG_REGULATOR_TPS65217=y
> >
> > Hi Igor,
> >
> > Can you try this, MFD_CORE is selected by default and note that
> > remaining flags should be added at appropriate places.
> >
> > Author: AnilKumar Ch <anilkumar@ti.com>
> > Date:   Tue Nov 20 15:34:51 2012 +0530
> >
> >     Custom: ARM: OMAP2+: omap2plus_defconfig: Add tps65217 support
> >
> >     Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> >
> > diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> > index 6230304..69ddbf7 100644
> > --- a/arch/arm/configs/omap2plus_defconfig
> > +++ b/arch/arm/configs/omap2plus_defconfig
> > @@ -132,9 +132,11 @@ CONFIG_POWER_SUPPLY=y
> >  CONFIG_WATCHDOG=y
> >  CONFIG_OMAP_WATCHDOG=y
> >  CONFIG_TWL4030_WATCHDOG=y
> > +CONFIG_MFD_TPS65217=y
> >  CONFIG_REGULATOR_TWL4030=y
> >  CONFIG_REGULATOR_TPS65023=y
> >  CONFIG_REGULATOR_TPS6507X=y
> > +CONFIG_REGULATOR_TPS65217=y
> >  CONFIG_FB=y
> >  CONFIG_FIRMWARE_EDID=y
> >  CONFIG_FB_MODE_HELPERS=y
> >
> 
> OK, I made changes as you say and it works. Thanks for a tip about
> default selection of CONFIG_MFD.

Thanks applying into omap-for-v3.8/fixes-for-merge-window.

Regards,

Tony
