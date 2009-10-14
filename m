From: Alistair Buxton <a.j.buxton@gmail.com>
Subject: [PATCH 07/17] OMAP7XX: PM: Add omap850 support
Date: Wed, 14 Oct 2009 20:51:05 +0100
Message-ID: <3d374d00910141251r217de76es37e4bb2a83b867bf@mail.gmail.com>
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
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This patch is part of a series which unifies all duplicated code between
omap730 and omap850. All cpu checks are converted to cpu_is_omap7xx() and
CONFIG_ARCH_OMAP850 is added to all CONFIG_ARCH_OMAP730 checks.

This file had no omap850 specific code. Original omap850 support in Linwizard
was done by cloning the omap730 code. That work was done by Zebediah C. McClure.

Signed-off-by: Alistair Buxton <a.j.buxton@gmail.com>
Reviewed-by: Zebediah C. McClure <zmc@lurian.net>
---
 arch/arm/mach-omap1/pm.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
index 5218943..12f246e 100644
--- a/arch/arm/mach-omap1/pm.c
+++ b/arch/arm/mach-omap1/pm.c
@@ -183,7 +183,7 @@ static void omap_pm_wakeup_setup(void)
 	 * drivers must still separately call omap_set_gpio_wakeup() to
 	 * wake up to a GPIO interrupt.
 	 */
-	if (cpu_is_omap730())
+	if (cpu_is_omap7xx())
 		level1_wake = OMAP_IRQ_BIT(INT_730_GPIO_BANK1) |
 			OMAP_IRQ_BIT(INT_730_IH2_IRQ);
 	else if (cpu_is_omap15xx())
@@ -195,7 +195,7 @@ static void omap_pm_wakeup_setup(void)

 	omap_writel(~level1_wake, OMAP_IH1_MIR);

-	if (cpu_is_omap730()) {
+	if (cpu_is_omap7xx()) {
 		omap_writel(~level2_wake, OMAP_IH2_0_MIR);
 		omap_writel(~(OMAP_IRQ_BIT(INT_730_WAKE_UP_REQ) |
 				OMAP_IRQ_BIT(INT_730_MPUIO_KEYPAD)),
@@ -253,7 +253,7 @@ void omap1_pm_suspend(void)
 	 * Save interrupt, MPUI, ARM and UPLD control registers.
 	 */

-	if (cpu_is_omap730()) {
+	if (cpu_is_omap7xx()) {
 		MPUI730_SAVE(OMAP_IH1_MIR);
 		MPUI730_SAVE(OMAP_IH2_0_MIR);
 		MPUI730_SAVE(OMAP_IH2_1_MIR);
@@ -306,7 +306,7 @@ void omap1_pm_suspend(void)
 	omap_writew(omap_readw(ARM_RSTCT1) & ~(1 << DSP_EN), ARM_RSTCT1);

 		/* shut down dsp_ck */
-	if (!cpu_is_omap730())
+	if (!cpu_is_omap7xx())
 		omap_writew(omap_readw(ARM_CKCTL) & ~(1 << EN_DSPCK), ARM_CKCTL);

 	/* temporarily enabling api_ck to access DSP registers */
@@ -383,7 +383,7 @@ void omap1_pm_suspend(void)
 	ULPD_RESTORE(ULPD_CLOCK_CTRL);
 	ULPD_RESTORE(ULPD_STATUS_REQ);

-	if (cpu_is_omap730()) {
+	if (cpu_is_omap7xx()) {
 		MPUI730_RESTORE(EMIFS_CONFIG);
 		MPUI730_RESTORE(EMIFF_SDRAM_CONFIG);
 		MPUI730_RESTORE(OMAP_IH1_MIR);
@@ -461,7 +461,7 @@ static int omap_pm_read_proc(
 	ULPD_SAVE(ULPD_DPLL_CTRL);
 	ULPD_SAVE(ULPD_POWER_CTRL);

-	if (cpu_is_omap730()) {
+	if (cpu_is_omap7xx()) {
 		MPUI730_SAVE(MPUI_CTRL);
 		MPUI730_SAVE(MPUI_DSP_STATUS);
 		MPUI730_SAVE(MPUI_DSP_BOOT_CONFIG);
@@ -517,7 +517,7 @@ static int omap_pm_read_proc(
 		   ULPD_SHOW(ULPD_STATUS_REQ),
 		   ULPD_SHOW(ULPD_POWER_CTRL));

-		if (cpu_is_omap730()) {
+		if (cpu_is_omap7xx()) {
 			my_buffer_offset += sprintf(my_base + my_buffer_offset,
 			   "MPUI730_CTRL_REG	     0x%-8x \n"
 			   "MPUI730_DSP_STATUS_REG:      0x%-8x \n"
@@ -668,7 +668,7 @@ static int __init omap_pm_init(void)
 	 * These routines need to be in SRAM as that's the only
 	 * memory the MPU can see when it wakes up.
 	 */
-	if (cpu_is_omap730()) {
+	if (cpu_is_omap7xx()) {
 		omap_sram_suspend = omap_sram_push(omap730_cpu_suspend,
 						   omap730_cpu_suspend_sz);
 	} else if (cpu_is_omap15xx()) {
@@ -686,7 +686,7 @@ static int __init omap_pm_init(void)

 	pm_idle = omap1_pm_idle;

-	if (cpu_is_omap730())
+	if (cpu_is_omap7xx())
 		setup_irq(INT_730_WAKE_UP_REQ, &omap_wakeup_irq);
 	else if (cpu_is_omap16xx())
 		setup_irq(INT_1610_WAKE_UP_REQ, &omap_wakeup_irq);
@@ -700,7 +700,7 @@ static int __init omap_pm_init(void)
 	omap_writew(ULPD_POWER_CTRL_REG_VAL, ULPD_POWER_CTRL);

 	/* Configure IDLECT3 */
-	if (cpu_is_omap730())
+	if (cpu_is_omap7xx())
 		omap_writel(OMAP730_IDLECT3_VAL, OMAP730_IDLECT3);
 	else if (cpu_is_omap16xx())
 		omap_writel(OMAP1610_IDLECT3_VAL, OMAP1610_IDLECT3);
-- 
1.6.5
