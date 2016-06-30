From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 5/5] ARM: AM33xx: fix module_wait_ready without clkctrl
 register
Date: Thu, 30 Jun 2016 16:15:03 +0300
Message-ID: <1467292503-4376-6-git-send-email-t-kristo@ti.com>
References: <1467292503-4376-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1467292503-4376-1-git-send-email-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

If the module has no clkctrl register defined, module_wait_ready should
not try to access this. This can potentially cause an illegal register
access, and result in bad idle reporting also.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/cm33xx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-omap2/cm33xx.c b/arch/arm/mach-omap2/cm33xx.c
index 7b181f9..c073fb5 100644
--- a/arch/arm/mach-omap2/cm33xx.c
+++ b/arch/arm/mach-omap2/cm33xx.c
@@ -220,6 +220,9 @@ static int am33xx_cm_wait_module_ready(u8 part, s16 inst, u16 clkctrl_offs,
 {
 	int i = 0;
 
+	if (!clkctrl_offs)
+		return 0;
+
 	omap_test_timeout(_is_module_ready(inst, clkctrl_offs),
 			  MAX_MODULE_READY_TIME, i);
 
-- 
1.9.1
