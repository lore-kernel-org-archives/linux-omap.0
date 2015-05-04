From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: omap2plus_defconfig: Enable EXTCON_USB_GPIO
Date: Mon, 4 May 2015 09:11:27 -0700
Message-ID: <20150504161126.GI24469@atomide.com>
References: <1427192359-19168-1-git-send-email-rogerq@ti.com>
 <20150324142647.GA9145@kahuna>
 <20150324164422.GG31024@saruman.tx.rr.com>
 <20150324165754.GA24734@kahuna>
 <20150324170935.GC24168@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:48978 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750918AbbEDQL3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 May 2015 12:11:29 -0400
Content-Disposition: inline
In-Reply-To: <20150324170935.GC24168@saruman.tx.rr.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Roger Quadros <rogerq@ti.com>, linux-omap@vger.kernel.org

* Felipe Balbi <balbi@ti.com> [150324 10:10]:
> On Tue, Mar 24, 2015 at 11:57:54AM -0500, Nishanth Menon wrote:
> > On 11:44-20150324, Felipe Balbi wrote:
> > > On Tue, Mar 24, 2015 at 09:26:48AM -0500, Nishanth Menon wrote:
> > > > On 12:19-20150324, Roger Quadros wrote:
> > > > > We need to enable EXTCON_USB_GPIO_USB and not
> > > > > EXTCON_GPIO_USB.
> > > > > 
> > > > > Fixes: c08a54c0ebeb ("ARM: omap2plus_defconfig: Enable EXTCON_GPIO_USB")
> > > > > 
> > > > > Reported-by: Nishant Menon <nm@ti.com>
> > > > > Signed-off-by: Roger Quadros <rogerq@ti.com>
> > > > > ---
> > > > >  arch/arm/configs/omap2plus_defconfig | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> > > > > index 04b4c8e..daf9412 100644
> > > > > --- a/arch/arm/configs/omap2plus_defconfig
> > > > > +++ b/arch/arm/configs/omap2plus_defconfig
> > > > > @@ -391,7 +391,7 @@ CONFIG_TI_EDMA=y
> > > > >  CONFIG_DMA_OMAP=y
> > > > >  # CONFIG_IOMMU_SUPPORT is not set
> > > > >  CONFIG_EXTCON=m
> > > > > -CONFIG_EXTCON_GPIO=m
> > > > > +CONFIG_EXTCON_USB_GPIO=m
> > > > >  CONFIG_EXTCON_PALMAS=m
> > > > >  CONFIG_TI_EMIF=m
> > > > >  CONFIG_PWM=y
> > > > > -- 
> > > > > 2.1.0
> > > > 
> > > > Yep and it finally works! Yipiee!!
> > > > http://pastebin.ubuntu.com/10669565/
> > > 
> > > I don't see the peripheral side IRQ in /proc/interrupts. What's going
> > > on? Can you load g_zero or g_mass_storage and verify peripheral side
> > > also works ?
> > my board is remote atm and does not have the usb peripheral cable hooked in.
> > However, I did load g_zero and looks like 73 is registered.
> 
> thanks, that should be enough :-)
> 
> Reviewed-by: Felipe Balbi <balbi@ti.com>
> Acked-by: Felipe Balbi <balbi@ti.com>

Applying into omap-for-v4.1/fixes thanks.

Tony
