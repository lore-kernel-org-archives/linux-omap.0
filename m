From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm/dts: am33xx wdt node
Date: Mon, 9 Jul 2012 01:59:44 -0700
Message-ID: <20120709085944.GC1122@atomide.com>
References: <1341405037-16391-1-git-send-email-afzal@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A2FE9@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:22203 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121Ab2GII7q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Jul 2012 04:59:46 -0400
Content-Disposition: inline
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E9A2FE9@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>

* Mohammed, Afzal <afzal@ti.com> [120704 06:44]:
> + Grant and device tree, watchdog lists
> 
> On Wed, Jul 04, 2012 at 18:00:37, Mohammed, Afzal wrote:
> > Add am33xx wdt node.
> > 
> > Signed-off-by: Afzal Mohammed <afzal@ti.com>
> > ---
> > 
> > Hi,
> > 
> > This was tested on AM335X EVM. This depends on,
> > http://www.mail-archive.com/linux-omap@vger.kernel.org/msg69424.html

Thanks I'll apply this into omap devel-dt branch now that we have
an ack from Wim on the wdt changes.

Tony

> > Regards
> > Afzal
> > 
> > 
> >  arch/arm/boot/dts/am33xx.dtsi | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> > index f46e353..08b2a5b 100644
> > --- a/arch/arm/boot/dts/am33xx.dtsi
> > +++ b/arch/arm/boot/dts/am33xx.dtsi
> > @@ -185,5 +185,10 @@
> >  			compatible = "ti,omap3-hsmmc";
> >  			ti,hwmods = "mmc3";
> >  		};
> > +
> > +		wdt2: wdt@44e35000 {
> > +			compatible = "ti,omap3-wdt";
> > +			ti,hwmods = "wd_timer2";
> > +		};
> >  	};
> >  };
> > -- 
> > 1.7.11.1
> > 
> > 
> 
