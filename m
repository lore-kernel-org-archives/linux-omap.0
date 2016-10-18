From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 5/7] ARM: OMAP: DRA7xx: Make L4SEC clock domain SWSUP only
Date: Tue, 18 Oct 2016 10:55:25 +0300
Message-ID: <1476777327-700-6-git-send-email-t-kristo@ti.com>
References: <1476777327-700-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1476777327-700-1-git-send-email-t-kristo@ti.com>
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

From: Joel Fernandes <joelf@ti.com>

Using HWSUP for l4sec clock domain is causing warnings in HWMOD code for
DRA7. Based on some observations, once the clock domain goes into an IDLE
state (because of no activity etc), the IDLEST for the module goes to '0x2'
value which means Interface IDLE condition. So far so go, however once the
MODULEMODE is set to disabled for the particular IP, the IDLEST for the
module should go to '0x3', per the HW AUTO IDLE protocol. However this is
not observed and there is no reason per the protocl for the transition to
not happen. This could potentially be a bug in the HW AUTO state-machine.

Work around for this is to use SWSUP only for the particular clockdomain.
With this all the transitions of IDLEST happen correctly and warnings
don't occur.

Signed-off-by: Joel Fernandes <joelf@ti.com>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clockdomains7xx_data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/clockdomains7xx_data.c b/arch/arm/mach-omap2/clockdomains7xx_data.c
index ef9ed36..6c67965 100644
--- a/arch/arm/mach-omap2/clockdomains7xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains7xx_data.c
@@ -409,7 +409,7 @@
 	.dep_bit	  = DRA7XX_L4SEC_STATDEP_SHIFT,
 	.wkdep_srcs	  = l4sec_wkup_sleep_deps,
 	.sleepdep_srcs	  = l4sec_wkup_sleep_deps,
-	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
+	.flags		  = CLKDM_CAN_SWSUP,
 };
 
 static struct clockdomain l3main1_7xx_clkdm = {
-- 
1.9.1
