From: "Madhusudhan Chikkature Rajashekar" <madhu.cr@ti.com>
Subject: [RFC/PATCH 1/5] HDQ/1-wire support for OMAP2430/3430
Date: Tue, 11 Dec 2007 15:13:55 +0530
Message-ID: <002901c83bda$5a8f4ff0$fe8818ac@ent.ti.com>
References: <20071210182827.GF19104@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20071210182827.GF19104@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: 'Tony Lindgren' <tony@atomide.com>
Cc: 'Evgeniy Polyakov' <johnpol@2ka.mipt.ru>, linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Tony,

I am reposting the patch after removing the defines from omap24xx.h/omap34xx.h and moved the define to devices.c as per your
suggestion.

Thanks,
Madhu
-------------------------------------------------------------------------------------

This patch adds HDQ base address defines and registers hdq as platform device.

Signed-off-by: Madhusudhan Chikkature<madhu.cr@ti.com>

---
 arch/arm/mach-omap2/devices.c |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+)

Index: linux-omap-2.6/arch/arm/mach-omap2/devices.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/devices.c	2007-12-10 11:08:36.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/devices.c	2007-12-11 13:57:43.700015270 +0530
@@ -221,6 +221,38 @@
 void omap_init_eac(struct eac_platform_data *pdata) {}
 #endif
 
+#if defined(CONFIG_HDQ_MASTER_OMAP) || defined(CONFIG_HDQ_MASTER_OMAP_MODULE)
+#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3430)
+#define OMAP_HDQ_BASE	0x480B2000 
+static struct resource omap_hdq_resources[] = {
+	{
+		.start		= OMAP_HDQ_BASE,
+		.end		= OMAP_HDQ_BASE + 0x1C,
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.start		= INT_24XX_HDQ_IRQ,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+static struct platform_device omap_hdq_dev = {
+	.name = "omap_hdq",
+	.id = 0,
+	.dev = {
+		.platform_data = NULL,
+	},
+	.num_resources  = ARRAY_SIZE(omap_hdq_resources),
+	.resource       = omap_hdq_resources,
+};
+static inline void omap_hdq_init(void)
+{
+	(void) platform_device_register(&omap_hdq_dev);
+}
+#endif
+#else
+static inline void omap_hdq_init(void) {}
+#endif
+
 /*-------------------------------------------------------------------------*/
 
 static int __init omap2_init_devices(void)
@@ -231,6 +263,7 @@
 	omap_init_camera();
 	omap_init_mbox();
 	omap_init_mcspi();
+	omap_hdq_init();
 	omap_init_sti();
 
 	return 0;
