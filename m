From: "B, Ravi" <ravibabu@ti.com>
Subject: RE: [PATCH v8 08/13] arm/dts: am33xx: Add dt data for usbss
Date: Fri, 31 Aug 2012 10:01:18 +0000
Message-ID: <6C6B28D4DC342643927BEAFCE8707BF63E9F3633@DBDE01.ent.ti.com>
References: <1346323825-24385-1-git-send-email-ravibabu@ti.com>
 <1346323825-24385-9-git-send-email-ravibabu@ti.com>
 <503F50FC.5040200@mvista.com> <20120831095441.GC8270@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46489 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752186Ab2HaKB3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 Aug 2012 06:01:29 -0400
In-Reply-To: <20120831095441.GC8270@arwen.pp.htv.fi>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>, Sergei Shtylyov <sshtylyov@mvista.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "tony@atomide.com" <tony@atomide.com>, "ajayguptaj@gmail.com" <ajayguptaj@gmail.com>

> On Thu, Aug 30, 2012 at 03:39:40PM +0400, Sergei Shtylyov wrote:
> > Hello.
> > 
> > On 30-08-2012 14:50, Ravi Babu wrote:
> > 
> > >From: Ajay Kumar Gupta <ajay.gupta@ti.com>
> > 
> > >Added device tree data for usbss on am33xx. There are two musb 
> > >controllers on am33xx platform so have port0_mode and 
> port1_mode additional data.
> > 
> > >Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> > >Signed-off-by: Ravi Babu <ravibabu@ti.com>
> > >Signed-off-by: Santhapuri, Damodar <damodar.santhapuri@ti.com>
> > >Signed-off-by: Ravi Babu <ravibabu@ti.com>
> > >---
> > >  arch/arm/boot/dts/am33xx.dtsi |   11 +++++++++++
> > >  1 files changed, 11 insertions(+), 0 deletions(-)
> > 
> > >diff --git a/arch/arm/boot/dts/am33xx.dtsi 
> > >b/arch/arm/boot/dts/am33xx.dtsi index 59509c4..778b95e 100644
> > >--- a/arch/arm/boot/dts/am33xx.dtsi
> > >+++ b/arch/arm/boot/dts/am33xx.dtsi
> > >@@ -154,5 +154,16 @@
> > >  			#size-cells = <0>;
> > >  			ti,hwmods = "i2c3";
> > >  		};
> > >+
> > >+		usb_otg_hs: usb_otg_hs {
> > >+			compatible = "ti,musb-am33xx";
> > >+			ti,hwmods = "usb_otg_hs";
> > >+			multipoint = <1>;
> > >+			num_eps = <16>;
> > >+			ram_bits = <12>;
> > >+			port0_mode = <3>;
> > >+			port1_mode = <3>;
> > 
> >    Hyphen is preferred traditionally to underscore in the 
> device tree files...
> 
> Are we having a v2 of this patch ??

Felipe, I will send it shortly.

Regards
Ravi B
> 
> --
> balbi
> 