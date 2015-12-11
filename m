From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] clk: ti: omap5+: dpll: implement errata i810
Date: Fri, 11 Dec 2015 08:55:49 -0800
Message-ID: <20151211165549.GN23396@atomide.com>
References: <1448894605-30097-1-git-send-email-t-kristo@ti.com>
 <20151203164817.GT23396@atomide.com>
 <566A8CB7.4050701@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <566A8CB7.4050701@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, sboyd@codeaurora.org, mturquette@baylibre.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [151211 00:42]:
> On 12/03/2015 06:48 PM, Tony Lindgren wrote:
> >* Tero Kristo <t-kristo@ti.com> [151130 06:44]:
> >>+	/*
> >>+	 * Errata i810 - DPLL controller can get stuck while transitioning
> >>+	 * to a power saving state. Software must ensure the DPLL can not
> >>+	 * transition to a low power state while changing M/N values.
> >>+	 * Easiest way to accomplish this is to prevent DPLL autoidle
> >>+	 * before doing the M/N re-program.
> >>+	 */
> >>+	errata_i810 = ti_clk_get_features()->flags & TI_CLK_ERRATA_I810;
> >>+
> >>+	if (errata_i810) {
> >>+		ai = omap3_dpll_autoidle_read(clk);
> >>+		if (ai) {
> >>+			omap3_dpll_deny_idle(clk);
> >>+
> >>+			/* OCP barrier */
> >>+			omap3_dpll_autoidle_read(clk);
> >>+		}
> >>+	}
> >
> >Should we just do this unconditionally? It seems like disabling the
> >autoidle always before reprogramming is a good idea.
> 
> Well, that is a few extra register accesses, but given the DPLL
> re-programming is a slow operation it probably does not matter. Let me spin
> a new version of this patch, it will avoid the need for the errata flag
> also.

OK thanks,

Tony
