From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH] ARM: OMAP: compile fix for CONFIG_PM_DEBUG=y
Date: Tue,  5 Jun 2007 18:00:30 -0700
Message-ID: <11810916331121-git-send-email-khilman@mvista.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Various compile fixes needed after PRCM updates for PM_DEBUG

Signed-off-by: Kevin Hilman <khilman@mvista.com>
---
 arch/arm/mach-omap2/pm.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index d6c81dd..a1655c2 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -138,7 +138,7 @@ static void serial_console_sleep(int enable)
 				serial_wakeup = 1;
 			break;
 		case 3:
-			l = prm_read_mod_reg(CORE_MOD, PM_WKST2);
+			l = prm_read_mod_reg(CORE_MOD, OMAP24XX_PM_WKST2);
 			if (l & OMAP24XX_ST_UART3)
 				serial_wakeup = 1;
 			break;
@@ -180,19 +180,19 @@ static void pm_init_serial_console(void)
 	}
 	switch (serial_console_uart) {
 	case 1:
-		l = prcm_read_mod_reg(CORE_MOD, PM_WKEN1);
+		l = prm_read_mod_reg(CORE_MOD, PM_WKEN1);
 		l |= OMAP24XX_ST_UART1;
 		prm_write_mod_reg(l, CORE_MOD, PM_WKEN1);
 		break;
 	case 2:
-		l = prcm_read_mod_reg(CORE_MOD, PM_WKEN1);
+		l = prm_read_mod_reg(CORE_MOD, PM_WKEN1);
 		l |= OMAP24XX_ST_UART2;
 		prm_write_mod_reg(l, CORE_MOD, PM_WKEN1);
 		break;
 	case 3:
-		l = prcm_read_mod_reg(CORE_MOD, PM_WKEN2);
+		l = prm_read_mod_reg(CORE_MOD, OMAP24XX_PM_WKEN2);
 		l |= OMAP24XX_ST_UART3;
-		prm_write_mod_reg(l, CORE_MOD, PM_WKEN2);
+		prm_write_mod_reg(l, CORE_MOD, OMAP24XX_PM_WKEN2);
 		break;
 	}
 }
@@ -265,7 +265,7 @@ static void omap2_pm_dump(int mode, int resume, unsigned int us)
 #endif
 	} else {
 		DUMP_PRM_MOD_REG(CORE_MOD, PM_WKST1);
-		DUMP_PRM_MOD_REG(CORE_MOD, PM_WKST2);
+		DUMP_PRM_MOD_REG(CORE_MOD, OMAP24XX_PM_WKST2);
 		DUMP_PRM_MOD_REG(WKUP_MOD, PM_WKST);
 		DUMP_PRM_REG(OMAP24XX_PRCM_IRQSTATUS_MPU);
 #if 1
@@ -293,7 +293,8 @@ static void omap2_pm_dump(int mode, int resume, unsigned int us)
 	if (!resume)
 #if defined(CONFIG_NO_IDLE_HZ) || defined(CONFIG_NO_HZ)
 		printk("--- Going to %s %s (next timer after %u ms)\n", s1, s2,
-		       jiffies_to_msecs(next_timer_interrupt() - jiffies));
+		       jiffies_to_msecs(get_next_timer_interrupt(jiffies) - 
+					jiffies));
 #else
 		printk("--- Going to %s %s\n", s1, s2);
 #endif
-- 
1.5.2
