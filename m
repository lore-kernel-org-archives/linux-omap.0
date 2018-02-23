From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 10/12] ARM: OMAP2+: Try to parse earlycon from parent too
Date: Fri, 23 Feb 2018 13:00:58 -0800
Message-ID: <20180223210100.86732-11-tony@atomide.com>
References: <20180223210100.86732-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180223210100.86732-1-tony@atomide.com>
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
Cc: Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, Dave Gerlach <d-gerlach@ti.com>, linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

With ti-sysc driver the "ti,hwmods" property will be moved to the
interconnect target module instead of the child device. To keep
earlycon working, we need to match against the interconnect target
module in the ti-sysc case.

Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -3492,6 +3492,12 @@ static void __init omap_hwmod_setup_earlycon_flags(void)
 			if (np) {
 				uart = of_get_property(np, "ti,hwmods", NULL);
 				oh = omap_hwmod_lookup(uart);
+				if (!oh) {
+					uart = of_get_property(np->parent,
+							       "ti,hwmods",
+							       NULL);
+					oh = omap_hwmod_lookup(uart);
+				}
 				if (oh)
 					oh->flags |= DEBUG_OMAPUART_FLAGS;
 			}
-- 
2.16.2
