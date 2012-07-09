From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH 1/2] arm/dts: Add AM33XX basic pinctrl support
Date: Mon, 9 Jul 2012 13:37:32 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13E9F3195@DBDE01.ent.ti.com>
References: <1341479616-18630-1-git-send-email-anilkumar@ti.com>
 <1341479616-18630-2-git-send-email-anilkumar@ti.com>
 <20120706082343.GN1122@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43963 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753989Ab2GINiJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Jul 2012 09:38:09 -0400
In-Reply-To: <20120706082343.GN1122@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>

Hi Tony,

Thanks for reviewing.

On Fri, Jul 06, 2012 at 13:53:44, Tony Lindgren wrote:
> * AnilKumar Ch <anilkumar@ti.com> [120705 02:18]:
> > Adds basic pinctrl support for AM33XX family of devices. This patch
> > is based on the pinctrl-simple driver submitted by Tony Lindgren's
> > here: http://lwn.net/Articles/496075/
> > 
> > Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> > ---
> >  arch/arm/boot/dts/am33xx.dtsi |   12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> > index 59509c4..85def31 100644
> > --- a/arch/arm/boot/dts/am33xx.dtsi
> > +++ b/arch/arm/boot/dts/am33xx.dtsi
> > @@ -40,6 +40,18 @@
> >  		};
> >  	};
> >  
> > +	am3358_pinmux: pinmux@44E10800 {
> > +		compatible = "ti,omap4-padconf";
> > +		reg = <0x44E10800 0x0338>;
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +		#pinctrl-cells = <2>;
> > +		pinctrl-simple,register-width = <32>;
> > +		pinctrl-simple,function-mask = <0x7>;
> > +		pinctrl-simple,function-off = <0xffffffff>;
> > +		pinctrl-simple,pinconf-mask = <0x78>;
> > +	};
> > +
> 
> You might want to update to the latest version, which is now called
> pinctrl-single instead of pinctrl-simple. Should be easy to update,
> note that we're still waiting on people to comment on the binding,
> so you might want to wait a bit before reposting so we have the
> driver merged.

In that case, I will submit the patches with respect to pinctrl-single
after it is available in linux-next tree.

Thanks
AnilKumar

