From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/3] ARM: OMAP2+: Fix SoC detection for dra62x j5-eco
Date: Thu,  3 Dec 2015 15:11:38 -0800
Message-ID: <1449184300-15693-2-git-send-email-tony@atomide.com>
References: <1449184300-15693-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1449184300-15693-1-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Matthijs van Duin <matthijsvanduin@gmail.com>, Neil Armstrong <narmstrong@baylibre.com>, Philipp Rosenberger <ilu@linutronix.de>, Delio Brignoli <dbrignoli@audioscience.com>, Brian Hutchinson <b.hutchman@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

We can boot dra62x j5-eco using the dm814x code as the clocks and
devices are mapped in the device tree. The dra62x is also known
as jacinto 5.

We may want to add separate soc_is macros for dra62x if needed,
but this gets us to the point where we can boot dra62x with just
dts changes.

Let's also print out the unknown hawkeye register to make things
a bit easier for new SoC variants.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/id.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 8a2ae82..d85c249 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -488,6 +488,7 @@ void __init omap3xxx_check_revision(void)
 		}
 		break;
 	case 0xb8f2:
+	case 0xb968:
 		switch (rev) {
 		case 0:
 		/* FALLTHROUGH */
@@ -511,7 +512,8 @@ void __init omap3xxx_check_revision(void)
 		/* Unknown default to latest silicon rev as default */
 		omap_revision = OMAP3630_REV_ES1_2;
 		cpu_rev = "1.2";
-		pr_warn("Warning: unknown chip type; assuming OMAP3630ES1.2\n");
+		pr_warn("Warning: unknown chip type: hawkeye %04x, assuming OMAP3630ES1.2\n",
+			hawkeye);
 	}
 	sprintf(soc_rev, "ES%s", cpu_rev);
 }
-- 
2.6.2
