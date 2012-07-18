From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH v2 08/11] arm/dts: am33xx: add dt data for usb nop phy
Date: Wed, 18 Jul 2012 07:05:19 +0000
Message-ID: <47CEF8C4B26E8C44B22B028A650E0EA93EAD9C63@DBDE01.ent.ti.com>
References: <1342516407-16515-1-git-send-email-ajay.gupta@ti.com>
 <1342516407-16515-9-git-send-email-ajay.gupta@ti.com>
 <50055DB6.7020602@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59375 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752224Ab2GRHFa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Jul 2012 03:05:30 -0400
In-Reply-To: <50055DB6.7020602@mvista.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "tony@atomide.com" <tony@atomide.com>

Hi,

> > AM33xx has two musb controller and they have one NOP PHY each.
> > Added the device tree data for NOP PHY.
> 
> > Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> > ---
> >   arch/arm/boot/dts/am33xx.dtsi |    8 ++++++++
> >   1 files changed, 8 insertions(+), 0 deletions(-)
> 
> > diff --git a/arch/arm/boot/dts/am33xx.dtsi
> b/arch/arm/boot/dts/am33xx.dtsi
> > index b572803..3bd9911 100644
> > --- a/arch/arm/boot/dts/am33xx.dtsi
> > +++ b/arch/arm/boot/dts/am33xx.dtsi
> > @@ -155,6 +155,14 @@
> >   			ti,hwmods = "i2c3";
> >   		};
> >
> > +		usb0_phy: phy@1 {
> > +			compatible = "ti,nop-xceiv-usb";
> > +		};
> > +
> > +		usb1_phy: phy@2 {
> > +			compatible = "ti,nop-xceiv-usb";
> > +		};
> 
>     No "reg" property again, and address postfix in the node name?

I will update this to 
+		usb0_phy: phy0 {
+		usb1_phy: phy1 {

Thanks,
Ajay
> 
> WBR, Sergei
> 

