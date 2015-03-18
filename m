From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] ARM: dts: dra7: remove ti,hwmod property from pcie
 phy
Date: Wed, 18 Mar 2015 09:57:06 -0700
Message-ID: <20150318165706.GQ31346@atomide.com>
References: <1424422274-27946-1-git-send-email-kishon@ti.com>
 <1424422274-27946-2-git-send-email-kishon@ti.com>
 <5509A998.2080509@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:38383 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754670AbbCRRBu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Mar 2015 13:01:50 -0400
Content-Disposition: inline
In-Reply-To: <5509A998.2080509@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, grygorii.strashko@linaro.org, paul@pwsan.com, nsekhar@ti.com, linux-omap@vger.kernel.org, sumit.semwal@linaro.org, linux-arm-kernel@lists.infradead.org, nm@ti.com, t-kristo@ti.com

* Grygorii Strashko <grygorii.strashko@ti.com> [150318 09:37]:
> Hi Tony,
> 
> As I can see Patch 1 from this series was merged in 4.0-rc4,
> but this patch wasn't. As result, I can see below warning all the time during boot now:
> 
> [    0.594591] platform 4a094000.pciephy: Cannot lookup hwmod 'pcie1-phy'
 
OK. Is this needed as a fix for the v4.0-rc series, or can this wait
for v4.1?

Regards,

Tony
 
> On 02/20/2015 10:51 AM, Kishon Vijay Abraham I wrote:
> > Now that we don't have hwmod entry for pcie PHY remove the
> > ti,hwmod property from PCIE PHY's
> > 
> > Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> > ---
> >   arch/arm/boot/dts/dra7.dtsi |    2 --
> >   1 file changed, 2 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> > index 5827fed..18a904d 100644
> > --- a/arch/arm/boot/dts/dra7.dtsi
> > +++ b/arch/arm/boot/dts/dra7.dtsi
> > @@ -1111,7 +1111,6 @@
> >   					      "wkupclk", "refclk",
> >   					      "div-clk", "phy-div";
> >   				#phy-cells = <0>;
> > -				ti,hwmods = "pcie1-phy";
> >   			};
> >   
> >   			pcie2_phy: pciephy@4a095000 {
> > @@ -1130,7 +1129,6 @@
> >   					      "wkupclk", "refclk",
> >   					      "div-clk", "phy-div";
> >   				#phy-cells = <0>;
> > -				ti,hwmods = "pcie2-phy";
> >   				status = "disabled";
> >   			};
> >   		};
> > 
> 
