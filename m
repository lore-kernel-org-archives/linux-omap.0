From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv4 03/15] dt-bindings: clock: add omap4 hwmod clock IDs
Date: Thu, 20 Oct 2016 06:11:43 -0700
Message-ID: <20161020131143.5cfhl3eug2lr64oa@atomide.com>
References: <1476805568-19264-1-git-send-email-t-kristo@ti.com>
 <1476805568-19264-4-git-send-email-t-kristo@ti.com>
 <20161020124742.7b65l5lz6kcfsysl@atomide.com>
 <051e2a14-8fb9-fd0f-99e0-decc5c02ae75@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <051e2a14-8fb9-fd0f-99e0-decc5c02ae75@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, mturquette@baylibre.com, sboyd@codeaurora.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [161020 06:00]:
> On 20/10/16 15:47, Tony Lindgren wrote:
> > * Tero Kristo <t-kristo@ti.com> [161018 08:47]:
> > > Add IDs for omap4 hwmod clocks. These are basically register offsets
> > > from the beginning of the clockdomain address space.
> > 
> > Looks like you have a wrong subject for this patch?
> 
> What is the correct one? There seems to be multiple approaches in place.

Oh sorry yeah never mind, I somehow thought these defines
we for drivers/clk, not for dt-bindings.. Sorry for the noise.

Tony
