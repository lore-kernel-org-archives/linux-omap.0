From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] CLK: TI: add dpll_clksel_mac_clk node
Date: Tue, 14 Jul 2015 04:06:27 -0700
Message-ID: <20150714110626.GQ17550@atomide.com>
References: <1434614473-8500-1-git-send-email-j-keerthy@ti.com>
 <55828A18.6030608@ti.com>
 <558C0624.4060008@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <558C0624.4060008@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <a0393675@ti.com>
Cc: Mugunthan V N <mugunthanvnm@ti.com>, Keerthy <j-keerthy@ti.com>, linux-omap@vger.kernel.org, galak@codeaurora.org, t-kristo@ti.com, pawel.moll@arm.com, linux-kernel@vger.kernel.org, bcousson@baylibre.com, linux-clk@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Keerthy <a0393675@ti.com> [150625 06:48]:
> 
> On Thursday 18 June 2015 02:36 PM, Mugunthan V N wrote:
> >On Thursday 18 June 2015 01:31 PM, Keerthy wrote:
> >>The series adds the missing clock node needed for cpsw.
> >>
> >>Keerthy (2):
> >>   CLK: TI: add dpll_clksel_mac_clk node
> >>   ARM: dts: am4372: Set the default clock rate for dpll_clksel_mac_clk
> >>     clock
> >>
> >>  arch/arm/boot/dts/am4372.dtsi        | 7 +++++--
> >>  arch/arm/boot/dts/am43xx-clocks.dtsi | 9 +++++++++
> >>  drivers/clk/ti/clk-43xx.c            | 1 +
> >>  3 files changed, 15 insertions(+), 2 deletions(-)
> >>
> >
> >Tested-by: Mugunthan V N <mugunthanvnm@ti.com>
> 
> Thanks Mugunthan.
> 
> A gentle ping on this series.

Tero, care to review this series?

Regards,

Tony
