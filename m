From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 0/2] ARM: OMAP4+: Fix gpmc_fck clock
Date: Thu, 13 Mar 2014 13:24:25 -0700
Message-ID: <20140313202425.GC5981@atomide.com>
References: <1393411089-9550-1-git-send-email-florian.vaussard@epfl.ch>
 <53216D58.2040304@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:33774 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755060AbaCMUYc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Mar 2014 16:24:32 -0400
Content-Disposition: inline
In-Reply-To: <53216D58.2040304@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Vaussard <florian.vaussard@epfl.ch>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Tero Kristo <t-kristo@ti.com>, Mike Turquette <mturquette@linaro.org>, Suman Anna <s-anna@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Florian Vaussard <florian.vaussard@epfl.ch> [140313 01:36]:
> Hi,
> 
> On 02/26/2014 11:38 AM, Florian Vaussard wrote:
> > Hello,
> > 
> > Trying to get my SMSC9221 working on OMAP4 with DT,
> > I faced a misconfigured gpmc_fck (dummy clock set to 0)
> > resulting in serveral division-by-zero, misconfigured
> > timings and driver lost in the La La Land.
> > 
> > To solve this, patch 1 removes gpmc_fck from the dummy
> > clocks, and patch 2 adds the gpmc_fck DT node and
> > reference it from the gpmc node.
> > 
> > *Note*: For DRA7, there is no DTS node for the GPMC, so I
> > was unable to set the corresponding clock. And without
> > a public TRM, I cannot do much more.
> > 
> > Tested on DuoVero/Parlor (OMAP4430) with SMSC9221 (DTS
> > was posted on the OMAP ML [1]).
> > 
> > Regards,
> > Florian
> > 
> > [1] http://thread.gmane.org/gmane.linux.ports.arm.omap/110801
> > ---
> > Since v2:
> > - Added OMAP5 and DRA7
> > Since v1:
> > - Removed the gpmc_fck clock node, and reference directly l3_ick
> > 
> > Florian Vaussard (2):
> >   CLK: TI: OMAP4/5/DRA7: Remove gpmc_fck from dummy clocks
> >   ARM: DTS: OMAP4/5: Use l3_ick for the gpmc node
> > 
> 
> Any other comments on these two patches? If it is not going into 3.15
> before the merge window, it will have to go through the -rc cycle as the
> Duovero/Parlor .dts will be upstream.

Applying both into omap-for-v3.15/fixes with Cc: stable v3.14+.

Regards,

Tony
 
> >  arch/arm/boot/dts/omap4.dtsi | 2 ++
> >  arch/arm/boot/dts/omap5.dtsi | 2 ++
> >  drivers/clk/ti/clk-44xx.c    | 1 -
> >  drivers/clk/ti/clk-54xx.c    | 1 -
> >  drivers/clk/ti/clk-7xx.c     | 1 -
> >  5 files changed, 4 insertions(+), 3 deletions(-)
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
