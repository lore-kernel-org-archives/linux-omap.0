From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH v3 5/5] ARM: OMAP2+: omap2plus_defconfig: Enable RTC
 support
Date: Mon, 26 Nov 2012 05:54:18 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA7A4B7@DBDE01.ent.ti.com>
References: <1353404927-14412-1-git-send-email-anilkumar@ti.com>
 <1353404927-14412-6-git-send-email-anilkumar@ti.com>
 <50AFAA6B.9020706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36292 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751641Ab2KZFyZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Nov 2012 00:54:25 -0500
In-Reply-To: <50AFAA6B.9020706@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "i.mazanov@gmail.com" <i.mazanov@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "tony@atomide.com" <tony@atomide.com>

On Fri, Nov 23, 2012 at 22:25:07, Igor Mazanov wrote:
> AnilKumar Ch wrote:
> > AM33XX family of devices uses RTC module, one has to manually enable
> > this support to use RTC features. So this patch enable RTC driver in
> > omap2plus_defconfig.
> > 
> > Signed-off-by: AnilKumar Ch <anilkumar-l0cyMroinI0@public.gmane.org>
> > ---
> >  arch/arm/configs/omap2plus_defconfig |    1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> > index a4b330e..8839ac9 100644
> > --- a/arch/arm/configs/omap2plus_defconfig
> > +++ b/arch/arm/configs/omap2plus_defconfig
> > @@ -194,6 +194,7 @@ CONFIG_SDIO_UART=y
> >  CONFIG_MMC_OMAP=y
> >  CONFIG_MMC_OMAP_HS=y
> >  CONFIG_RTC_CLASS=y
> > +CONFIG_RTC_DRV_OMAP=y
> >  CONFIG_RTC_DRV_TWL92330=y
> >  CONFIG_RTC_DRV_TWL4030=y
> >  CONFIG_DMADEVICES=y
> 
> Hello,
> 
> But this is not enough, we need to change drivers/rtc/Kconfig too. This change 
> was offered in this thread
> 
> http://marc.info/?l=linux-arm-kernel&m=135057569913027&w=2
> 
> But, may be all this previous rtc-related changes accounted already in some 
> development branch. I just doesn't see it in the current master. In this case, 
> when could we get RTC support in the current kernel?

The Kconfig modification already present in mainline (linux-next/master)

Thanks
AnilKumar
