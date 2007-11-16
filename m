From: "Reddy, Teerth" <teerth@ti.com>
Subject: [PATCH]Watchdog: Fix for the watchdog reset issue on OMAP3
Date: Fri, 16 Nov 2007 06:49:02 -0600
Message-ID: <465714FA584D6D49BD2ADB26BB64FD0D01902198@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

This patch fixes the watchdog reset issue for OMAP3. OMAP_WATCHDOG_BASE =
is being added twice so this patch resolves the issue and the watchdog =
works fine.

Regards,
Teerth


Fix for the watchdog reset defect.The watchdog header file has been =
modified in the mainline merge due to which the watchdog was not =
functioning.
OMAP_WATCHDOG_BASE is being added twice so this patch is required for =
the watchdog to function.

Signed-off-by: Teerth Reddy <teerth@ti.com>
---

Index: linux/drivers/watchdog/omap_wdt.h =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-omap-git-20071030/drivers/watchdog/omap_wdt.h	2007-11-14 =
05:51:05.830299544 -0500
+++ linux-omap-2.6-25thOct/drivers/char/watchdog/omap_wdt.h	2007-11-13 =
09:30:33.772264576 -0500
@@ -30,25 +30,15 @@
 #ifndef _OMAP_WATCHDOG_H
 #define _OMAP_WATCHDOG_H
=20
-#define OMAP1610_WATCHDOG_BASE		0xfffeb000
-#define OMAP2420_WATCHDOG_BASE		0x48022000	/*WDT Timer 2 */
-
-#ifdef CONFIG_ARCH_OMAP24XX
-#define OMAP_WATCHDOG_BASE 		OMAP2420_WATCHDOG_BASE
-#else
-#define OMAP_WATCHDOG_BASE 		OMAP1610_WATCHDOG_BASE
-#define RM_RSTST_WKUP			0
-#endif
-
-#define OMAP_WATCHDOG_REV		(OMAP_WATCHDOG_BASE + 0x00)
-#define OMAP_WATCHDOG_SYS_CONFIG	(OMAP_WATCHDOG_BASE + 0x10)
-#define OMAP_WATCHDOG_STATUS		(OMAP_WATCHDOG_BASE + 0x14)
-#define OMAP_WATCHDOG_CNTRL		(OMAP_WATCHDOG_BASE + 0x24)
-#define OMAP_WATCHDOG_CRR		(OMAP_WATCHDOG_BASE + 0x28)
-#define OMAP_WATCHDOG_LDR		(OMAP_WATCHDOG_BASE + 0x2c)
-#define OMAP_WATCHDOG_TGR		(OMAP_WATCHDOG_BASE + 0x30)
-#define OMAP_WATCHDOG_WPS		(OMAP_WATCHDOG_BASE + 0x34)
-#define OMAP_WATCHDOG_SPR		(OMAP_WATCHDOG_BASE + 0x48)
+#define OMAP_WATCHDOG_REV		(0x00)
+#define OMAP_WATCHDOG_SYS_CONFIG	(0x10)
+#define OMAP_WATCHDOG_STATUS		(0x14)
+#define OMAP_WATCHDOG_CNTRL		(0x24)
+#define OMAP_WATCHDOG_CRR		(0x28)
+#define OMAP_WATCHDOG_LDR		(0x2c)
+#define OMAP_WATCHDOG_TGR		(0x30)
+#define OMAP_WATCHDOG_WPS		(0x34)
+#define OMAP_WATCHDOG_SPR		(0x48)
=20
 /* Using the prescaler, the OMAP watchdog could go for many
  * months before firing.  These limits work without scaling,
