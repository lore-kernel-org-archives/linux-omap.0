From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/6] PM / clock_ops: Add helpers combining generic runtime and generic clock PM
Date: Thu, 24 Apr 2014 12:26:32 +0200
Message-ID: <1398335198-26555-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Several platform support codes combine pm_generic_runtime_suspend() and
pm_clk_suspend(), resp. pm_clk_resume() and pm_generic_runtime_resume() in
their .runtime_suspend resp. .runtime_resume callbacks.

Create helpers to consolidate.

  - [1/6] PM / clock_ops: Add helpers combining generic runtime and generic
	  clock PM
  - [2/6] ARM: davinci: Use generic runtime and clock helpers
  - [3/6] ARM: keystone: Use generic runtime and clock helpers
  - [4/6] ARM: omap: Use generic runtime and clock helpers
  - [5/6] drivers: sh: Use generic runtime and clock helpers
  - [6/6] of/clk: Use generic runtime and clock helpers

Patches 5 and 6 have dependencies (listed in the individual patches),
but they can be postponed and handled later.

Thanks!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
