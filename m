From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH RESEND v2 1/2] arm/dts: Add AM33XX basic pinctrl support
Date: Tue, 7 Aug 2012 00:43:48 -0700
Message-ID: <20120807074348.GQ11011@atomide.com>
References: <1343144719-26352-1-git-send-email-anilkumar@ti.com>
 <1343144719-26352-2-git-send-email-anilkumar@ti.com>
 <50125B1C.8000209@ti.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA06E4B@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:20401 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795Ab2HGHnv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Aug 2012 03:43:51 -0400
Content-Disposition: inline
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA06E4B@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>

* AnilKumar, Chimata <anilkumar@ti.com> [120731 06:37]:
> Hi Peter,
> 
> On Fri, Jul 27, 2012 at 14:40:52, Ujfalusi, Peter wrote:
> > Hi,
> > 
> > On 07/24/2012 06:45 PM, AnilKumar Ch wrote:
> > > Adds basic pinctrl support for AM33XX family of devices. This patch
> > > is based on the pinctrl-simple driver submitted by Tony Lindgren's
> > > here: http://lwn.net/Articles/496075/
> > > 
> > > Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> > > ---
> > >  arch/arm/boot/dts/am33xx.dtsi |    9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > > 
> > > diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> > > index 59509c4..9b974dc 100644
> > > --- a/arch/arm/boot/dts/am33xx.dtsi
> > > +++ b/arch/arm/boot/dts/am33xx.dtsi
> > > @@ -40,6 +40,15 @@
> > >  		};
> > >  	};
> > >  
> > > +	am3358_pinmux: pinmux@44E10800 {
> > > +		compatible = "pinctrl-single";
> > > +		reg = <0x44E10800 0x0338>;
> > 
> > I'm just curious about the size here: how it ended up as 0x0338?
> > While looking at the TRM of AM335x I can come up with 0x0238 (0x44e10800 -
> > 0x44e10a38), but I don't see any sings of the remaining 0x0100 to be
> > documented at least.
> 
> No, pinmux registers are available till 0x44E10B38, look at AM335x latest TRM
> or pinmux utility (we cannot find the exact offsets but pins we can find after
> 0x0A38, conf_ddr_resetn) at http://www.ti.com/tool/pinmuxtool

If you have a hole inbetween the registers it sounds like you also have core and
wkup domains? In that case those should be set up as separate controllers as other
SCM registers may be inbetween those domains.

Tony
