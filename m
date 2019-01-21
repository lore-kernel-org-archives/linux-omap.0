From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH: linux-next] ARM: dts: am33xx: Remove unnecessary
 properties
Date: Mon, 21 Jan 2019 09:13:20 -0800
Message-ID: <20190121171320.GE5544@atomide.com>
References: <20181218143931.4151-1-fb@ltec.ch>
 <31a68b35-8b78-8fee-3dd9-5beb3c386247@ltec.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <31a68b35-8b78-8fee-3dd9-5beb3c386247@ltec.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Felix Brack <fb@ltec.ch>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, mpfj@newflow.co.uk, mark.rutland@arm.com, robh+dt@kernel.org, linux@armlinux.org.uk, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Felix Brack <fb@ltec.ch> [190119 17:38]:
> Hi Tony,
> On 18.12.18 15:39, Felix Brack wrote:
> > Remove the unnecessary properties #address-cells and #size-cells
> > of node pinmux as there are no child-nodes with property reg.
> > 
> > Signed-off-by: Felix Brack <fb@ltec.ch>
> > ---
> >   arch/arm/boot/dts/am33xx-l4.dtsi | 2 --
> >   1 file changed, 2 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/am33xx-l4.dtsi b/arch/arm/boot/dts/am33xx-l4.dtsi
> > index 7b818d9d2eab..e957370f8aec 100644
> > --- a/arch/arm/boot/dts/am33xx-l4.dtsi
> > +++ b/arch/arm/boot/dts/am33xx-l4.dtsi
> > @@ -288,8 +288,6 @@
> >   				am33xx_pinmux: pinmux@800 {
> >   					compatible = "pinctrl-single";
> >   					reg = <0x800 0x238>;
> > -					#address-cells = <1>;
> > -					#size-cells = <0>;
> >   					#pinctrl-cells = <1>;
> >   					pinctrl-single,register-width = <32>;
> >   					pinctrl-single,function-mask = <0x7f>;
> > 
> 
> Just a gentle ping. BTW: the patch applies not just to linux-next correctly
> but now also to linux.

Sorry I'm still struggling with pending regressions for
the -rc cycle.. I should get to applying patches for next
merge window this week though.

Regards,

Tony
