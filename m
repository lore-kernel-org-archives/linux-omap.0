From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm/dts: OMAP3: fix pinctrl-single configuration
Date: Fri, 29 Mar 2013 08:17:59 -0700
Message-ID: <20130329151759.GB10155@atomide.com>
References: <1364458106.3757.11.camel@mars>
 <20130328163854.GV10155@atomide.com>
 <1364549848.4634.13.camel@mars>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:23885 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755628Ab3C2PSH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Mar 2013 11:18:07 -0400
Content-Disposition: inline
In-Reply-To: <1364549848.4634.13.camel@mars>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Daniel Mack <daniel@zonque.org>, "Hans J. Koch" <hjk@hansjkoch.de>

* Christoph Fritz <chf.fritz@googlemail.com> [130329 02:41]:
> On Thu, 2013-03-28 at 09:38 -0700, Tony Lindgren wrote:
> > * Christoph Fritz <chf.fritz@googlemail.com> [130328 01:12]:
> > > - Fix 'function-mask' referring to TRM Section 7.4.4:
> > >   "Pad Functional Multiplexing and Configuration".
> > > - Fix 'omap3_pmx_core' referring to TRM Table 7-4:
> > >   "Core Control Module Pad Configuration Register Fields"
> > > - Fix 'omap3_pmx_wkup' referring to TRM Table 7-6:
> > >   "Wake-Up Control Module Pad Configuration Register Fields".
> > 
> > Maybe mention which TRM this is so people will know.
> >  
> > > Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
> > > ---
> > >  arch/arm/boot/dts/omap3.dtsi |   12 ++++++------
> > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
> > > index 1acc261..6ce3b5c 100644
> > > --- a/arch/arm/boot/dts/omap3.dtsi
> > > +++ b/arch/arm/boot/dts/omap3.dtsi
> > > @@ -27,7 +27,7 @@
> > >  	};
> > >  
> > >  	/*
> > > -	 * The soc node represents the soc top level view. It is uses for IPs
> > > +	 * The soc node represents the soc top level view. It is used for IPs
> > >  	 * that are not memory mapped in the MPU view or for the MPU itself.
> > >  	 */
> > >  	soc {
> > > @@ -77,20 +77,20 @@
> > >  
> > >  		omap3_pmx_core: pinmux@48002030 {
> > >  			compatible = "ti,omap3-padconf", "pinctrl-single";
> > > -			reg = <0x48002030 0x05cc>;
> > > +			reg = <0x48002030 0x234>;
> > >  			#address-cells = <1>;
> > >  			#size-cells = <0>;
> > >  			pinctrl-single,register-width = <16>;
> > > -			pinctrl-single,function-mask = <0x7fff>;
> > > +			pinctrl-single,function-mask = <0x7f1f>;
> > >  		};
> > 
> > Changing the size from 0x5cc to 0x234 misses the range ending at
> > CONTROL_PADCONF_ETK_D14[31:16] 0x480025f8 that's listed at least in
> > the 3630 TRM. Which TRM are you looking at?
> 
> I used TRM Omap35xx, and yes in the TRM Omap36xx 0x234 is fine. I'll fix
> this in the next revision of this patch.

OK 
 
> > Ack for the function-mask change for omap3, looks like those bits are not
> > used.
> >   
> > > -		omap3_pmx_wkup: pinmux@0x48002a58 {
> > > +		omap3_pmx_wkup: pinmux@0x48002a00 {
> > >  			compatible = "ti,omap3-padconf", "pinctrl-single";
> > > -			reg = <0x48002a58 0x5c>;
> > > +			reg = <0x48002a00 0x54>;
> > >  			#address-cells = <1>;
> > >  			#size-cells = <0>;
> > >  			pinctrl-single,register-width = <16>;
> > > -			pinctrl-single,function-mask = <0x7fff>;
> > > +			pinctrl-single,function-mask = <0x7f1f>;
> > >  		};
> > 
> > Hmm I think I converted these from the legacy mux framework, that seems
> > to be missing the wkup range between 0x2a00 - 0x2a58. So yes 0x2a00
> > is the right start as otherwise we're missing some wkup registers.
> > 
> > But the size should be 0x50 instead of 0x54 as the JTAG_TDO[31:16] is
> > already un-used in TRM?
> > 
> > Or it could be 0x60 if we want to map also the reserved GPIO128[31:16].
> 
> Why not 0x5c ? GPIO128[31:16] starts at 0x2a5a and its size is 2 bytes.

Oops yes 0x5c as it's 2 bytes. So the original value is fine then.

Regards,

Tony
