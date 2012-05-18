From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 3/3] ARM: OMAP3+: PM: VP: check only the VPINIDLE status bit
Date: Fri, 18 May 2012 14:33:21 -0500
Message-ID: <1337369601-14915-4-git-send-email-nm@ti.com>
References: <[PATCH] ARM: OMAP3+: PM: VP: ensure VP is idle before disable>
 <1337369601-14915-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1337369601-14915-1-git-send-email-nm@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Currently we check against the entire 32 bits of the status register
Where, bits 1-31 are marked as reserved and mentioned in TRM as read
returns undefined values. Hence, check against purely the vpinidle
status bit.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Reported-by: Vinay Amancha <vinaykumar@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/vp.c          |   15 +++++++++------
 arch/arm/mach-omap2/vp.h          |    1 +
 arch/arm/mach-omap2/vp3xxx_data.c |    1 +
 arch/arm/mach-omap2/vp44xx_data.c |    1 +
 4 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/vp.c b/arch/arm/mach-omap2/vp.c
index 985091b..cdcac16 100644
--- a/arch/arm/mach-omap2/vp.c
+++ b/arch/arm/mach-omap2/vp.c
@@ -128,8 +128,9 @@ int omap_vp_forceupdate_scale(struct voltagedomain *voltdm,
 	 * This is an additional allowance to ensure we are in proper state
 	 * to enter into forceupdate state transition.
 	 */
-	omap_test_timeout((voltdm->read(vp->vstatus)),
-			  VP_IDLE_TIMEOUT, timeout);
+	omap_test_timeout((voltdm->read(vp->vstatus) &
+			   vp->common->vstatus_vpidle), VP_IDLE_TIMEOUT,
+			  timeout);
 
 	if (timeout >= VP_IDLE_TIMEOUT)
 		pr_warning("%s: vdd_%s idle timedout forceupdate(v=%ld)\n",
@@ -278,8 +279,9 @@ void omap_vp_disable(struct voltagedomain *voltdm)
 	 * Wait for VP idle Typical latency is <2us. Maximum latency is ~100us
 	 * Depending on if we catch VP in the middle of an SR operation.
 	 */
-	omap_test_timeout((voltdm->read(vp->vstatus)),
-			  VP_IDLE_TIMEOUT, timeout);
+	omap_test_timeout((voltdm->read(vp->vstatus) &
+			   vp->common->vstatus_vpidle), VP_IDLE_TIMEOUT,
+			  timeout);
 
 	if (timeout >= VP_IDLE_TIMEOUT)
 		pr_warning("%s: vdd_%s idle timedout before disable\n",
@@ -293,8 +295,9 @@ void omap_vp_disable(struct voltagedomain *voltdm)
 	/*
 	 * Wait for VP idle Typical latency is <2us. Maximum latency is ~100us
 	 */
-	omap_test_timeout((voltdm->read(vp->vstatus)),
-			  VP_IDLE_TIMEOUT, timeout);
+	omap_test_timeout((voltdm->read(vp->vstatus) &
+			   vp->common->vstatus_vpidle), VP_IDLE_TIMEOUT,
+			  timeout);
 
 	if (timeout >= VP_IDLE_TIMEOUT)
 		pr_warning("%s: vdd_%s idle timedout after disable\n",
diff --git a/arch/arm/mach-omap2/vp.h b/arch/arm/mach-omap2/vp.h
index 0abf895..876b5ab 100644
--- a/arch/arm/mach-omap2/vp.h
+++ b/arch/arm/mach-omap2/vp.h
@@ -73,6 +73,7 @@ struct omap_vp_common {
 	u8 vpconfig_initvdd;
 	u8 vpconfig_forceupdate;
 	u8 vpconfig_vpenable;
+	u8 vstatus_vpidle;
 	u8 vstepmin_stepmin_shift;
 	u8 vstepmin_smpswaittimemin_shift;
 	u8 vstepmax_stepmax_shift;
diff --git a/arch/arm/mach-omap2/vp3xxx_data.c b/arch/arm/mach-omap2/vp3xxx_data.c
index bd89f80..a65909b 100644
--- a/arch/arm/mach-omap2/vp3xxx_data.c
+++ b/arch/arm/mach-omap2/vp3xxx_data.c
@@ -44,6 +44,7 @@ static const struct omap_vp_common omap3_vp_common = {
 	.vpconfig_initvdd = OMAP3430_INITVDD_MASK,
 	.vpconfig_forceupdate = OMAP3430_FORCEUPDATE_MASK,
 	.vpconfig_vpenable = OMAP3430_VPENABLE_MASK,
+	.vstatus_vpidle = OMAP3430_VPINIDLE_MASK,
 	.vstepmin_smpswaittimemin_shift = OMAP3430_SMPSWAITTIMEMIN_SHIFT,
 	.vstepmax_smpswaittimemax_shift = OMAP3430_SMPSWAITTIMEMAX_SHIFT,
 	.vstepmin_stepmin_shift = OMAP3430_VSTEPMIN_SHIFT,
diff --git a/arch/arm/mach-omap2/vp44xx_data.c b/arch/arm/mach-omap2/vp44xx_data.c
index 8c031d1..9d14881 100644
--- a/arch/arm/mach-omap2/vp44xx_data.c
+++ b/arch/arm/mach-omap2/vp44xx_data.c
@@ -44,6 +44,7 @@ static const struct omap_vp_common omap4_vp_common = {
 	.vpconfig_initvdd = OMAP4430_INITVDD_MASK,
 	.vpconfig_forceupdate = OMAP4430_FORCEUPDATE_MASK,
 	.vpconfig_vpenable = OMAP4430_VPENABLE_MASK,
+	.vstatus_vpidle = OMAP4430_VPINIDLE_MASK,
 	.vstepmin_smpswaittimemin_shift = OMAP4430_SMPSWAITTIMEMIN_SHIFT,
 	.vstepmax_smpswaittimemax_shift = OMAP4430_SMPSWAITTIMEMAX_SHIFT,
 	.vstepmin_stepmin_shift = OMAP4430_VSTEPMIN_SHIFT,
-- 
1.7.9.5
