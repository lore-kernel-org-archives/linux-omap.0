From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 0/2] ARM: OMAP2+: Fix dpll rounding
Date: Fri, 17 Jan 2014 09:44:57 +0200
Message-ID: <1389944699-27962-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Mike Turquette <mturquette@linaro.org>, Paul Walmsley <paul@pwsan.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

We had a problem with beaglebone black's HDMI output, where setting some clock
rates to the display PLL failed oddly. The main issue was that the dpll code
doesn't actually try to round the given rate, it only finds exact matches. That
is what these patches fix (well, the second patch).

However, there is another issue, which made finding and debugging this a bit
difficult. When the dpll round_rate failed, it returned ~0 as a rate. However,
drivers/clk/clk-divider.c, which called the round_rate, didn't realize that is
an error value, and so didn't fail but proceeded, which didn't lead to anything
good.

This series doesn't try to fix that other issue.

There's also a third issue that I think happens more easily after this series
is applied: there are no checks for maximum rate for the DPLLs. I think the
maximum rate is generally 2GHz, but at least my BeagleBone Black refused to
lock the display PLL with anything over 1.3GHz-1.4GHz.

High PLL clock rates happen quite easily with a setup where there's a DPLL and
an additional divider, handled by clk-divider.c. When the clk-divider.c is
asked to provide a clock rate (that could be quite low), it'll try to find a
good clock from its parent, the DPLL, that it can divide down to the requested
clock. As the DPLL driver is only limited by its multiplier and divider
register widths, it'll gladly offer 2GHz+ clocks, which eventually will fail as
they can't be locked.

So this series is only a partial fix for the clock issues. Also, while the
board debugged was BB Black, I think the same code is used and thus the same
issues are present on all (or most) omap2+ SoCs.

 Tomi

Tomi Valkeinen (2):
  ARM: OMAP2+: fix rate prints
  ARM: OMAP2+: fix dpll round_rate() to actually round

 arch/arm/mach-omap2/clkt_dpll.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

-- 
1.8.3.2
