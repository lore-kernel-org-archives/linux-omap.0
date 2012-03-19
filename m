From: jean.pihet@newoldbits.com
Subject: [PATCH 5/9] ARM: OMAP3: hwmod: rename the smartreflex entries
Date: Mon, 19 Mar 2012 17:12:54 +0100
Message-ID: <1332173578-27422-6-git-send-email-j-pihet@ti.com>
References: <1332173578-27422-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1332173578-27422-1-git-send-email-j-pihet@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>
Cc: Jean Pihet <j-pihet@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Jean Pihet <j-pihet@ti.com>

Change the name field value to better reflect the smartreflex
integration in the system

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    8 ++++----
 arch/arm/mach-omap2/smartreflex.c          |    2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index d7d4c70..40f57c4 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -2751,7 +2751,7 @@ static struct omap_hwmod_ocp_if *omap34xx_sr1_slaves[] = {
 };
 
 static struct omap_hwmod omap34xx_sr1_hwmod = {
-	.name		= "sr1",
+	.name		= "mpu_iva",
 	.class		= &omap34xx_smartreflex_hwmod_class,
 	.main_clk	= "sr1_fck",
 	.prcm		= {
@@ -2775,7 +2775,7 @@ static struct omap_hwmod_ocp_if *omap36xx_sr1_slaves[] = {
 };
 
 static struct omap_hwmod omap36xx_sr1_hwmod = {
-	.name		= "sr1",
+	.name		= "mpu_iva",
 	.class		= &omap36xx_smartreflex_hwmod_class,
 	.main_clk	= "sr1_fck",
 	.prcm		= {
@@ -2803,7 +2803,7 @@ static struct omap_hwmod_ocp_if *omap34xx_sr2_slaves[] = {
 };
 
 static struct omap_hwmod omap34xx_sr2_hwmod = {
-	.name		= "sr2",
+	.name		= "core",
 	.class		= &omap34xx_smartreflex_hwmod_class,
 	.main_clk	= "sr2_fck",
 	.prcm		= {
@@ -2827,7 +2827,7 @@ static struct omap_hwmod_ocp_if *omap36xx_sr2_slaves[] = {
 };
 
 static struct omap_hwmod omap36xx_sr2_hwmod = {
-	.name		= "sr2",
+	.name		= "core",
 	.class		= &omap36xx_smartreflex_hwmod_class,
 	.main_clk	= "sr2_fck",
 	.prcm		= {
diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index c18d47d..b2728a5 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -184,7 +184,7 @@ static void sr_set_regfields(struct omap_sr *sr)
 		sr->err_weight = OMAP3430_SR_ERRWEIGHT;
 		sr->err_maxlimit = OMAP3430_SR_ERRMAXLIMIT;
 		sr->accum_data = OMAP3430_SR_ACCUMDATA;
-		if (!(strcmp(sr->name, "sr1"))) {
+		if (!(strcmp(sr->name, "sr_mpu_iva"))) {
 			sr->senn_avgweight = OMAP3430_SR1_SENNAVGWEIGHT;
 			sr->senp_avgweight = OMAP3430_SR1_SENPAVGWEIGHT;
 		} else {
-- 
1.7.5.4
