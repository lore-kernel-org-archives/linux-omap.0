From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 3/3] OMAP: GPIO: ensure debounce clocks are disabled during
	idle/suspend
Date: Thu, 23 Sep 2010 11:18:55 -0700
Message-ID: <1285265935-3477-4-git-send-email-khilman@deeprootsystems.com>
References: <1285265935-3477-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1285265935-3477-1-git-send-email-khilman@deeprootsystems.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

If a GPIO bank has more than one GPIO with debounce enabled, the
debounce clock will not be fully disabled before going to
idle/suspend.

In the idle path, we just do a single clk_disable() of the bank's
debounce clock.  If there are multiple debounce-enabled GPIOs in the
bank, that clocks usage count will be > 1, so the clk_disable() will
not actually disable the clock.

So the fix is to clk_disable() for every debounce-enabled GPIO in the
bank (and an equivalent clk_enable() of course.)

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/plat-omap/gpio.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 7951eef..11c5b0e 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -2085,8 +2085,9 @@ void omap2_gpio_prepare_for_idle(int power_state)
 	for (i = min; i < gpio_bank_count; i++) {
 		struct gpio_bank *bank = &gpio_bank[i];
 		u32 l1, l2;
+		int j;
 
-		if (bank->dbck_enable_mask)
+		for (j = 0; j < hweight_long(bank->dbck_enable_mask); j++)
 			clk_disable(bank->dbck);
 
 		if (power_state > PWRDM_POWER_OFF)
@@ -2152,8 +2153,9 @@ void omap2_gpio_resume_after_idle(void)
 	for (i = min; i < gpio_bank_count; i++) {
 		struct gpio_bank *bank = &gpio_bank[i];
 		u32 l, gen, gen0, gen1;
+		int j;
 
-		if (bank->dbck_enable_mask)
+		for (j = 0; j < hweight_long(bank->dbck_enable_mask); j++)
 			clk_enable(bank->dbck);
 
 		if (!workaround_enabled)
-- 
1.7.2.1
