From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/2] ARM: OMAP4: Fix gpmc_fck clock
Date: Fri, 21 Feb 2014 15:23:23 -0800
Message-ID: <20140221232323.GD5342@atomide.com>
References: <1392801305-1698-1-git-send-email-florian.vaussard@epfl.ch>
 <5304DA2C.3030605@ti.com>
 <53050573.8090506@epfl.ch>
 <5305D02D.5020702@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:30200 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752769AbaBUXXi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Feb 2014 18:23:38 -0500
Content-Disposition: inline
In-Reply-To: <5305D02D.5020702@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: florian.vaussard@epfl.ch, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Mike Turquette <mturquette@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [140220 01:54]:
> On 02/19/2014 09:26 PM, Florian Vaussard wrote:
> >
> >On 02/19/2014 05:22 PM, Tero Kristo wrote:
> >>On 02/19/2014 11:15 AM, Florian Vaussard wrote:
> >>>Hello,
> >>>
> >>>Trying to get my SMSC9221 working on OMAP4 with DT,
> >>>I faced a misconfigured gpmc_fck (dummy clock set to 0)
> >>>resulting in serveral division-by-zero, misconfigured
> >>>timings and driver lost in the La La Land.
> >>>
> >>>To solve this, patch 1 removes gpmc_fck from the dummy
> >>>clocks, and patch 2 adds the gpmc_fck DT node and
> >>>reference it from the gpmc node.
> >>>
> >>>Tested on DuoVero/Parlor (OMAP4430) with SMSC9221.
> >>
> >>I can't test GPMC myself, but other than that, this set looks good to go.
> >>
> >
> >Thank you. Would you like more test coverage by other people? I would
> >like to see this in -rc if possible, as it is needed to boot my OMAP4
> >system.
> 
> Well, I just think the driver clock change should be acked by
> someone who knows gpmc better than me.

Hmm do we also need to fix this for other omaps? We at least have
the following refrerences:

$ git grep dummy_ck drivers/ | grep -i gpmc
drivers/clk/ti/clk-44xx.c:      DT_CLK("50000000.gpmc", "fck", "dummy_ck"),
drivers/clk/ti/clk-54xx.c:      DT_CLK(NULL, "gpmc_ck", "dummy_ck"),
drivers/clk/ti/clk-7xx.c:       DT_CLK(NULL, "gpmc_ck", "dummy_ck"),

Regards,

Tony
