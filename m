From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] ARM: OMAP3: PM: restrict erratum i443 handling to OMAP3430
	only
Date: Thu, 6 Oct 2011 13:43:23 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1110061341460.4611@utopia.booyaka.com>
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
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: khilman@ti.com
List-Id: linux-omap@vger.kernel.org


Based on the documents that I have here, there doesn't appear to be an
equivalent to erratum i443 for OMAP3630, so restrict this one to OMAP34xx
chips.

Also, explicitly restrict this erratum to EMU and HS devices.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>
---
Unfortunately, I don't have any HS/EMU devices in my testbed, so it's not 
possible for me to test this one on anything but GP chips.

 arch/arm/mach-omap2/pm34xx.c |   20 +++++++++++---------
 1 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index a6156bd..9e14ae5 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -407,13 +407,14 @@ void omap_sram_idle(void)
 	omap3_intc_prepare_idle();
 
 	/*
-	* On EMU/HS devices ROM code restores a SRDC value
-	* from scratchpad which has automatic self refresh on timeout
-	* of AUTO_CNT = 1 enabled. This takes care of erratum ID i443.
-	* Hence store/restore the SDRC_POWER register here.
-	*/
-	if (omap_rev() >= OMAP3430_REV_ES3_0 &&
-	    omap_type() != OMAP2_DEVICE_TYPE_GP &&
+	 * On EMU/HS devices ROM code restores a SRDC value
+	 * from scratchpad which has automatic self refresh on timeout
+	 * of AUTO_CNT = 1 enabled. This takes care of erratum ID i443.
+	 * Hence store/restore the SDRC_POWER register here.
+	 */
+	if (cpu_is_omap3430() && omap_rev() >= OMAP3430_REV_ES3_0 &&
+	    (omap_type() == OMAP2_DEVICE_TYPE_EMU ||
+	     omap_type() == OMAP2_DEVICE_TYPE_SEC) &&
 	    core_next_state == PWRDM_POWER_OFF)
 		sdrc_pwr = sdrc_read_reg(SDRC_POWER);
 
@@ -430,8 +431,9 @@ void omap_sram_idle(void)
 		omap34xx_do_sram_idle(save_state);
 
 	/* Restore normal SDRC POWER settings */
-	if (omap_rev() >= OMAP3430_REV_ES3_0 &&
-	    omap_type() != OMAP2_DEVICE_TYPE_GP &&
+	if (cpu_is_omap3430() && omap_rev() >= OMAP3430_REV_ES3_0 &&
+	    (omap_type() == OMAP2_DEVICE_TYPE_EMU ||
+	     omap_type() == OMAP2_DEVICE_TYPE_SEC) &&
 	    core_next_state == PWRDM_POWER_OFF)
 		sdrc_write_reg(sdrc_pwr, SDRC_POWER);
 
-- 
1.7.6.3
