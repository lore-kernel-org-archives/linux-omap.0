From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] Fix PRCM_SYSCONFIG & PRCM_REVISION addresses for 24XX
Date: Tue, 29 May 2007 22:02:24 -0600
Message-ID: <20070530040243.850870657@pwsan.com>
References: <20070530040223.689051525@pwsan.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline; filename=fix-prcm-sysconfig-revision-offsets.patch
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

Fix OMAP24XX_PRCM_REVISION and OMAP24XX_PRCM_SYSCONFIG addresses,
which were incorrectly using 3430 PRM_{REVISION,SYSCONFIG} addresses.
Bug found by Richard Woodruff <r-woodruff2@ti.com>.


Signed-off-by: Paul Walmsley <paul@pwsan.com>

- Paul

---
 arch/arm/mach-omap2/prm.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/prm.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/prm.h
+++ linux-omap/arch/arm/mach-omap2/prm.h
@@ -31,8 +31,8 @@
  *
  */
 
-#define OMAP24XX_PRCM_REVISION		OMAP_PRM_REGADDR(OCP_MOD, 0x0004)
-#define OMAP24XX_PRCM_SYSCONFIG		OMAP_PRM_REGADDR(OCP_MOD, 0x0014)
+#define OMAP24XX_PRCM_REVISION		OMAP_PRM_REGADDR(OCP_MOD, 0x0000)
+#define OMAP24XX_PRCM_SYSCONFIG		OMAP_PRM_REGADDR(OCP_MOD, 0x0010)
 
 #define OMAP24XX_PRCM_IRQSTATUS_MPU	OMAP_PRM_REGADDR(OCP_MOD, 0x0018)
 #define OMAP24XX_PRCM_IRQENABLE_MPU	OMAP_PRM_REGADDR(OCP_MOD, 0x001c)

-- 
