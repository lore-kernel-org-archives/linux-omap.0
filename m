From: Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH 1/2] ARM: OMAP2+: L2 cache: use macro instead of const number
Date: Fri, 28 Mar 2014 14:05:28 +0530
Message-ID: <5ea7277c21215c7b4aa776d5379dc2d6263228c6.1395994759.git.nsekhar@ti.com>
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
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

From: Afzal Mohammed <afzal@ti.com>

Its better to use the available macro than 0x1.
No functional change.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
This series applies to latest of linux-next/master

 arch/arm/mach-omap2/omap4-common.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 95e171a..8f18460 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -219,7 +219,7 @@ static int __init omap_l2_cache_init(void)
 		omap_smc1(0x109, aux_ctrl);
 
 	/* Enable PL310 L2 Cache controller */
-	omap_smc1(0x102, 0x1);
+	omap_smc1(0x102, L2X0_CTRL_EN);
 
 	if (of_have_populated_dt())
 		l2x0_of_init(aux_ctrl, L2X0_AUX_CTRL_MASK);
-- 
1.7.10.1
