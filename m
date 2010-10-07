From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [RFC] tidspbridge: use a parameter to allocate shared memory
Date: Thu,  7 Oct 2010 00:45:36 -0500
Message-ID: <1286430336-20204-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57685 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752759Ab0JGFz1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Oct 2010 01:55:27 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>, Felipe Contreras <felipe.contreras@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>, Ohad Ben-Cohen <ohad@wizery.com>, Ameya Palande <ameya.palande@nokia.com>, Ernesto Ramos <ernesto@ti.com>, Ivan Gomez Castellanos <ivan.gomez@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Omar Ramirez Luna <omar.ramirez@ti.com>

tidspbridge driver uses a block of memory denominated SHared Memory
to store info & communicate with DSP, this SHM needs to be physically
contiguous and non-cacheable, to achieve the latter the driver ioremaps
the memory reserved to be SHM, this will trigger a warning if the
memory is under kernel control (because it creates another set of
mapping attributes, for the same memory area).

For now this can be avoided if a portion of memory (6MB) is left out
of kernel control (using bootarg attribute mem=) where tidspbridge
driver can make use of the memory and ioremap it without above
restriction.

Parameter has precedence over memblock allocator for shared memory.

i.e.: on a system with 256MB

set 'bootargs mem=250M ...'

cat /proc/iomem
...
80000000-8f9fffff : System RAM

So driver needs to be installed with:

insmod bridgedriver.ko phys_mempool_base=0x8FA00000

Same rationale applies for the menuconfig option.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---

Code to allocate dspbridge memblock needs to be disabled since
it will be wasting 6MB.

 arch/arm/mach-omap2/dsp.c                        |    2 +-
 drivers/staging/tidspbridge/Kconfig              |   10 ++++++++++
 drivers/staging/tidspbridge/rmgr/drv_interface.c |   15 ++++++++++++++-
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/dsp.c b/arch/arm/mach-omap2/dsp.c
index 6feeeae..0a4ba2f 100644
--- a/arch/arm/mach-omap2/dsp.c
+++ b/arch/arm/mach-omap2/dsp.c
@@ -45,7 +45,7 @@ static int __init omap_dsp_init(void)
 	int err = -ENOMEM;
 	struct omap_dsp_platform_data *pdata = &omap_dsp_pdata;
 
-	pdata->phys_mempool_base = omap_dsp_get_mempool_base();
+	pdata->phys_mempool_base = CONFIG_TIDSPBRIDGE_MEMPOOL_BASE;
 
 	if (pdata->phys_mempool_base) {
 		pdata->phys_mempool_size = CONFIG_TIDSPBRIDGE_MEMPOOL_SIZE;
diff --git a/drivers/staging/tidspbridge/Kconfig b/drivers/staging/tidspbridge/Kconfig
index 93de4f2..1214cbc 100644
--- a/drivers/staging/tidspbridge/Kconfig
+++ b/drivers/staging/tidspbridge/Kconfig
@@ -23,6 +23,16 @@ config TIDSPBRIDGE_DVFS
 	  performance and power consumption to the current processing
 	  requirements.
 
+config TIDSPBRIDGE_MEMPOOL_BASE
+	hex "Physical memory pool base (Addr)"
+	depends on TIDSPBRIDGE
+	default 0
+	help
+	  Use this address as the start of the shared memory block, it is assumed
+	  that this address is outside kernel control and configured by tweaking
+	  mem= in  bootargs. BASE + SIZE should fit in the system RAM address
+	  space.
+
 config TIDSPBRIDGE_MEMPOOL_SIZE
 	hex "Physical memory pool size (Byte)"
 	depends on TIDSPBRIDGE
diff --git a/drivers/staging/tidspbridge/rmgr/drv_interface.c b/drivers/staging/tidspbridge/rmgr/drv_interface.c
index 1981e46..4533605 100644
--- a/drivers/staging/tidspbridge/rmgr/drv_interface.c
+++ b/drivers/staging/tidspbridge/rmgr/drv_interface.c
@@ -86,6 +86,7 @@ static s32 driver_major;
 static char *base_img;
 char *iva_img;
 static s32 shm_size = 0x500000;	/* 5 MB */
+static unsigned int phys_mempool_base;
 static int tc_wordswapon;	/* Default value is always false */
 #ifdef CONFIG_TIDSPBRIDGE_RECOVERY
 #define REC_TIMEOUT 5000	/*recovery timeout in msecs */
@@ -132,6 +133,9 @@ MODULE_PARM_DESC(shm_size, "shm size, default = 4 MB, minimum = 64 KB");
 module_param(tc_wordswapon, int, 0);
 MODULE_PARM_DESC(tc_wordswapon, "TC Word Swap Option. default = 0");
 
+module_param(phys_mempool_base, uint, 0);
+MODULE_PARM_DESC(phys_mempool_base, "Physical Address base for SHM");
+
 MODULE_AUTHOR("Texas Instruments");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(DSPBRIDGE_VERSION);
@@ -298,7 +302,16 @@ static int omap3_bridge_startup(struct platform_device *pdev)
 	}
 	dev_dbg(bridge, "%s: requested shm_size = 0x%x\n", __func__, shm_size);
 
-	phys_membase = pdata->phys_mempool_base;
+	if (phys_mempool_base) {
+		/* Out of kernel SHM */
+		phys_membase = phys_mempool_base;
+	} else if (pdata->phys_mempool_base) {
+		/* Memblock allocator for SHM */
+		phys_membase = pdata->phys_mempool_base;
+	} else {
+		pr_err("%s: couldn't get SHM physical address\n", __func__);
+		goto err3;
+	}
 	phys_memsize = pdata->phys_mempool_size;
 	if (phys_membase > 0 && phys_memsize > 0)
 		mem_ext_phys_pool_init(phys_membase, phys_memsize);
-- 
1.7.1

