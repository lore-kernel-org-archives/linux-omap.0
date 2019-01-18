From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 3/3] arm: omap_hwmod disable ick autoidling when a
 hwmod requires that
Date: Fri, 18 Jan 2019 07:48:07 -0800
Message-ID: <20190118154807.GV5544@atomide.com>
References: <20190116220429.9136-1-andreas@kemnade.info>
 <20190116220429.9136-4-andreas@kemnade.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190116220429.9136-4-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>
Cc: t-kristo@ti.com, mturquette@baylibre.com, sboyd@kernel.org, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, bcousson@baylibre.com, paul@pwsan.com, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

Hi,

* Andreas Kemnade <andreas@kemnade.info> [190116 22:04]:
> Deny autoidle for hwmods with the OCPIF_SWSUP_IDLE flag,
> that makes hwmods working properly which cannot handle
> autoidle properly in lower power states.

Sorry if I'm still missing something :)

But doesn't this now block autoidle for all modules
with OCPIF_SWSUP_IDLE even if they work just fine with
autoidle?

I think what you want to do is keep clocks enabled
while in use?

If so, how about using HWMOD_CLKDM_NOAUTO:

"HWMOD_CLKDM_NOAUTO: Allows the hwmod's clockdomain to
 be prevented from entering HW_AUTO while hwmod is
 active."

> Affected is e. g. the omap_hdq.

Have you already tried what happens if you just tag
omap_hdq with HWMOD_CLKDM_NOAUTO?

Regards,

Tony
