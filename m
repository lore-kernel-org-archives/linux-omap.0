From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] ARM: omap2plus_defconfig: Enable EXTCON_USB_GPIO
Date: Tue, 24 Mar 2015 11:57:54 -0500
Message-ID: <20150324165754.GA24734@kahuna>
References: <1427192359-19168-1-git-send-email-rogerq@ti.com>
 <20150324142647.GA9145@kahuna>
 <20150324164422.GG31024@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51113 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752558AbbCXQ55 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Mar 2015 12:57:57 -0400
Content-Disposition: inline
In-Reply-To: <20150324164422.GG31024@saruman.tx.rr.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Roger Quadros <rogerq@ti.com>, tony@atomide.com, linux-omap@vger.kernel.org

On 11:44-20150324, Felipe Balbi wrote:
> On Tue, Mar 24, 2015 at 09:26:48AM -0500, Nishanth Menon wrote:
> > On 12:19-20150324, Roger Quadros wrote:
> > > We need to enable EXTCON_USB_GPIO_USB and not
> > > EXTCON_GPIO_USB.
> > > 
> > > Fixes: c08a54c0ebeb ("ARM: omap2plus_defconfig: Enable EXTCON_GPIO_USB")
> > > 
> > > Reported-by: Nishant Menon <nm@ti.com>
> > > Signed-off-by: Roger Quadros <rogerq@ti.com>
> > > ---
> > >  arch/arm/configs/omap2plus_defconfig | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> > > index 04b4c8e..daf9412 100644
> > > --- a/arch/arm/configs/omap2plus_defconfig
> > > +++ b/arch/arm/configs/omap2plus_defconfig
> > > @@ -391,7 +391,7 @@ CONFIG_TI_EDMA=y
> > >  CONFIG_DMA_OMAP=y
> > >  # CONFIG_IOMMU_SUPPORT is not set
> > >  CONFIG_EXTCON=m
> > > -CONFIG_EXTCON_GPIO=m
> > > +CONFIG_EXTCON_USB_GPIO=m
> > >  CONFIG_EXTCON_PALMAS=m
> > >  CONFIG_TI_EMIF=m
> > >  CONFIG_PWM=y
> > > -- 
> > > 2.1.0
> > 
> > Yep and it finally works! Yipiee!!
> > http://pastebin.ubuntu.com/10669565/
> 
> I don't see the peripheral side IRQ in /proc/interrupts. What's going
> on? Can you load g_zero or g_mass_storage and verify peripheral side
> also works ?
my board is remote atm and does not have the usb peripheral cable hooked in.
However, I did load g_zero and looks like 73 is registered.
root@am57xx-evm:~# cat /proc/interrupts 
           CPU0       CPU1       
 16:          0          0      CBAR  32  gp_timer
 19:       2296       2083       GIC  27  arch_timer
 22:          1          0      CBAR   4  l3-dbg-irq
 23:          1          0     WUGEN  10  l3-app-irq
 28:       6002          0      CBAR   8  omap-dma-engine
 32:          2          0  4ae10000.gpio   0  palmas
224:          0          0  4805d000.gpio  27  4809c000.mmc cd
254:          0          0  48051000.gpio  24  extcon_usb2
255:          0          0  48051000.gpio  25  extcon_usb1
295:        507          0      CBAR  69  OMAP UART2
308:        524          0      CBAR  51  48070000.i2c
309:          6          0      CBAR  56  48060000.i2c
310:       8334          0      CBAR  78  mmc0
311:       1451          0      CBAR  81  mmc1
312:        233          0      CBAR  49  4a140000.sata
313:          0          0      CBAR 217  rtc0
314:          5          0      CBAR  72  dwc3-omap
315:          2          0      CBAR  87  dwc3-omap
317:        727          0      CBAR 335  48484000.ethernet
318:         22          0      CBAR 336  48484000.ethernet
331:          1          0      PRCM  pinctrl
386:          1          0   pinctrl 584  OMAP UART2
387:          0          0    palmas   8  48070000.i2c:tps659038@58:tps659038_rtc
388:          0          0    palmas   1  48070000.i2c:tps659038@58:tps659038_pwr_button
389:          0          0      CBAR   2  mcp7941x
390:        460          0      CBAR  71  xhci-hcd:usb1
391:         11          0      CBAR  73  dwc3
IPI0:          0          1  CPU wakeup interrupts
IPI1:          0          0  Timer broadcast interrupts
IPI2:       2723       3962  Rescheduling interrupts
IPI3:          0          0  Function call interrupts
IPI4:        279        214  Single function call interrupts
IPI5:          0          0  CPU stop interrupts
IPI6:          0          0  IRQ work interrupts
IPI7:          0          0  completion interrupts
Err:          0

Looking at arch/arm/boot/dts/am57xx-beagle-x15.dts
looks like extcon is used for both host and peripheral - am I mistaken - if I am right,
then at least the host devices seem to work (usb storage).
extcon_usb1: extcon_usb1 {
        compatible = "linux,extcon-usb-gpio";
        id-gpio = <&gpio7 25 GPIO_ACTIVE_HIGH>;
        pinctrl-names = "default";
        pinctrl-0 = <&extcon_usb1_pins>;
};

extcon_usb2: extcon_usb2 {                        
        compatible = "linux,extcon-usb-gpio";
        id-gpio = <&gpio7 24 GPIO_ACTIVE_HIGH>;
        pinctrl-names = "default";
        pinctrl-0 = <&extcon_usb2_pins>;
};
...
 &usb2_phy1 {
         phy-supply = <&ldousb_reg>;
 };
 
 &usb1 {
         dr_mode = "host";
         pinctrl-names = "default";
         pinctrl-0 = <&usb1_pins>;
 };
 
 &omap_dwc3_1 {
         extcon = <&extcon_usb1>;
 };
 
 &omap_dwc3_2 {
         extcon = <&extcon_usb2>;              
 };
 
 &usb2 {
         dr_mode = "peripheral";
 };


Anything I am missing?

-- 
Regards,
Nishanth Menon
