From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH 6/7] ARM: OMAP2+: omap2plus_defconfig: Enable leds-gpio
 driver
Date: Mon, 26 Nov 2012 09:17:39 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA7A776@DBDE01.ent.ti.com>
References: <1353481163-29462-1-git-send-email-anilkumar@ti.com>
 <1353481163-29462-7-git-send-email-anilkumar@ti.com>
 <CAAwP0s1eL_VkRfR7FgNNmUfbAeHro9yaJGFa_HO+49tNuSS3yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43986 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754573Ab2KZJRq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Nov 2012 04:17:46 -0500
In-Reply-To: <CAAwP0s1eL_VkRfR7FgNNmUfbAeHro9yaJGFa_HO+49tNuSS3yw@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Nov 26, 2012 at 13:59:24, Javier Martinez Canillas wrote:
> On Wed, Nov 21, 2012 at 7:59 AM, AnilKumar Ch <anilkumar@ti.com> wrote:
> > AM335X-EVMSK and AM335X-BONE devices have gpio controlled user leds,
> > one has to manually enable this support to use user leds. So this
> > patch enables gpio-leds driver in omap2plus_defconfig. Also enables
> > TRIGGER_TIMER and TRIGGER_HEARTBEAT.
> >
> > Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> > ---
> >  arch/arm/configs/omap2plus_defconfig |    5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> > index 133f04a..5e1a763 100644
> > --- a/arch/arm/configs/omap2plus_defconfig
> > +++ b/arch/arm/configs/omap2plus_defconfig
> > @@ -202,6 +202,11 @@ CONFIG_MMC_UNSAFE_RESUME=y
> >  CONFIG_SDIO_UART=y
> >  CONFIG_MMC_OMAP=y
> >  CONFIG_MMC_OMAP_HS=y
> > +CONFIG_NEW_LEDS=y
> > +CONFIG_LEDS_GPIO=y
> > +CONFIG_LEDS_TRIGGERS=y
> > +CONFIG_LEDS_TRIGGER_TIMER=y
> > +CONFIG_LEDS_TRIGGER_HEARTBEAT=y
> >  CONFIG_RTC_CLASS=y
> >  CONFIG_RTC_DRV_OMAP=y
> >  CONFIG_RTC_DRV_TWL92330=y
> > --
> > 1.7.9.5
> >
> 
> Hi AnilKumar,
> 
> Your patch looks good to me but I would enable
> CONFIG_LEDS_TRIGGER_DEFAULT_ON too
> since this seems to be a very popular trigger used on many boards.
> 
> But this could be made on a follow up patch too, so is your call.

I will submit v2 (with this change) in few days. I am waiting
for review comments on other patches in this series.

Thanks
AnilKumar
