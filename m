From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/5] ARM: omap2plus_defconfig: Enable PCF857X and
 EXTCON_GPIO_USB
Date: Mon, 19 Jan 2015 11:38:42 -0800
Message-ID: <20150119193841.GD18552@atomide.com>
References: <1421689942-10201-1-git-send-email-rogerq@ti.com>
 <1421689942-10201-6-git-send-email-rogerq@ti.com>
 <20150119184546.GA18552@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150119184546.GA18552@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: balbi@ti.com, myungjoo.ham@samsung.com, cw00.choi@samsung.com, george.cherian@ti.com, nsekhar@ti.com, devicetree@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [150119 10:52]:
> * Roger Quadros <rogerq@ti.com> [150119 09:55]:
> > Both are needed for USB cable type detection on dra7-evm.
> > 
> > Signed-off-by: Roger Quadros <rogerq@ti.com>
> > ---
> >  arch/arm/configs/omap2plus_defconfig | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> > index c2c3a85..bc23b90 100644
> > --- a/arch/arm/configs/omap2plus_defconfig
> > +++ b/arch/arm/configs/omap2plus_defconfig
> > @@ -203,6 +203,7 @@ CONFIG_SPI_OMAP24XX=y
> >  CONFIG_PINCTRL_SINGLE=y
> >  CONFIG_DEBUG_GPIO=y
> >  CONFIG_GPIO_SYSFS=y
> > +CONFIG_GPIO_PCF857X=y
> >  CONFIG_GPIO_TWL4030=y
> >  CONFIG_W1=y
> >  CONFIG_BATTERY_BQ27x00=m
> 
> Looks like I have this too but as a loadable module :) So I'll keep
> that one.
> 
> > @@ -326,6 +327,7 @@ CONFIG_DMADEVICES=y
> >  CONFIG_TI_EDMA=y
> >  CONFIG_DMA_OMAP=y
> >  CONFIG_EXTCON=y
> > +CONFIG_EXTCON_GPIO_USB=y
> >  CONFIG_EXTCON_PALMAS=y
> >  CONFIG_PWM=y
> >  CONFIG_PWM_TIECAP=y
> 
> I'll apply this part into omap-for-v3.20/defconfig but make it into =m
> instead of =y.

Oh but this depends on the driver being added, so not applying.
Can you please repost a patch adding CONFIG_EXTCON_GPIO_USB=m
once the driver is merged?

Regards,

Tony
