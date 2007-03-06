From: Imre Deak <imre.deak@solidboot.com>
Subject: Re: [PATCH] board_nokia770: add hwa742 platform data
Date: Tue, 6 Mar 2007 18:48:16 +0200
Message-ID: <20070306164814.GB4450@bitbox.mine.nu>
References: <85ejo5i6g9.fsf@orfeo.duckcorp.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="IJpNTDwzlM2Ie8A6"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <85ejo5i6g9.fsf@orfeo.duckcorp.org>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 04, 2007 at 12:39:02PM +0100, Arnaud Patard wrote:
> 
> The n800fb changes introduced some platform_data for the hwa742 and
> needs now to be defined for getting it working.  This patch adds the
> necessary bits needed for getting fb working again on n770.
> This patch comes from the n800 kernel from maemo.org
> 
> 
> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>

Thanks for pointing this out. In this updated patch I adding missing init
/ registration for other devices, as well as API fixes for the SoSSI /
HWA742 code.

With these LCD, touchscreen should work ok on the N770, after the
omap_uwire code is merged from upstream.

--Imre

--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-ARM-N770-add-missing-LCD-LCD-controller-touchscreen-device-registration.patch"

>From 177959ac68f637dd0397e8f22e29a9f080fb0e36 Mon Sep 17 00:00:00 2001
From: Imre Deak <imre.deak@solidboot.com>
Date: Tue, 6 Mar 2007 18:20:00 +0200
Subject: [PATCH] ARM: N770: add missing LCD, LCD controller, touchscreen device registration

These were left out from the board file when merging these drivers,
add them here.

Call GPIO init from the board file as well, since the platform device init
code uses the GPIO API.

Signed-off-by: Imre Deak <imre.deak@solidboot.com>
---
 arch/arm/mach-omap1/board-nokia770.c |   88 ++++++++++++++++++++++++++++++++++
 1 files changed, 88 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index 8ea0cef..acb2331 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -33,9 +33,14 @@
 #include <asm/arch/dsp_common.h>
 #include <asm/arch/aic23.h>
 #include <asm/arch/gpio.h>
+#include <asm/arch/omapfb.h>
+#include <asm/arch/hwa742.h>
+#include <asm/arch/lcd_mipid.h>
 
 #include "../plat-omap/dsp/dsp_common.h"
 
+#define ADS7846_PENDOWN_GPIO	15
+
 static void __init omap_nokia770_init_irq(void)
 {
 	/* On Nokia 770, the SleepX signal is masked with an
@@ -96,6 +101,41 @@ static struct platform_device *nokia770_devices[] __initdata = {
 	&nokia770_kp_device,
 };
 
+static void mipid_shutdown(struct mipid_platform_data *pdata)
+{
+	if (pdata->nreset_gpio != -1) {
+		printk(KERN_INFO "shutdown LCD\n");
+		omap_set_gpio_dataout(pdata->nreset_gpio, 0);
+		msleep(120);
+	}
+}
+
+static struct mipid_platform_data nokia770_mipid_platform_data = {
+	.shutdown = mipid_shutdown,
+};
+
+static void mipid_dev_init(void)
+{
+	const struct omap_lcd_config *conf;
+
+	conf = omap_get_config(OMAP_TAG_LCD, struct omap_lcd_config);
+	if (conf != NULL) {
+		nokia770_mipid_platform_data.nreset_gpio = conf->nreset_gpio;
+		nokia770_mipid_platform_data.data_lines = conf->data_lines;
+	}
+}
+
+static void ads7846_dev_init(void)
+{
+	if (omap_request_gpio(ADS7846_PENDOWN_GPIO) < 0)
+		printk(KERN_ERR "can't get ads7846 pen down GPIO\n");
+}
+
+static int ads7846_get_pendown_state(void)
+{
+	return !omap_get_gpio_datain(ADS7846_PENDOWN_GPIO);
+}
+
 static struct ads7846_platform_data nokia770_ads7846_platform_data __initdata = {
 	.x_max		= 0x0fff,
 	.y_max		= 0x0fff,
@@ -103,6 +143,8 @@ static struct ads7846_platform_data nokia770_ads7846_platform_data __initdata =
 	.pressure_max	= 255,
 	.debounce_max	= 10,
 	.debounce_tol	= 3,
+	.debounce_rep	= 1,
+	.get_pendown_state	= ads7846_get_pendown_state,
 };
 
 static struct spi_board_info nokia770_spi_board_info[] __initdata = {
@@ -111,6 +153,7 @@ static struct spi_board_info nokia770_spi_board_info[] __initdata = {
 		.bus_num        = 2,
 		.chip_select    = 3,
 		.max_speed_hz   = 12000000,
+		.platform_data	= &nokia770_mipid_platform_data,
 	},
 	[1] = {
 		.modalias       = "ads7846",
@@ -122,6 +165,47 @@ static struct spi_board_info nokia770_spi_board_info[] __initdata = {
 	},
 };
 
+static struct {
+	struct clk *sys_ck;
+} hwa742;
+
+static int hwa742_get_clocks(void)
+{
+	hwa742.sys_ck = clk_get(NULL, "bclk");
+	if (IS_ERR(hwa742.sys_ck)) {
+		printk(KERN_ERR "can't get HWA742 clock\n");
+		return PTR_ERR(hwa742.sys_ck);
+	}
+	return 0;
+}
+
+static unsigned long hwa742_get_clock_rate(struct device *dev)
+{
+	return clk_get_rate(hwa742.sys_ck);
+}
+
+static void hwa742_power_up(struct device *dev)
+{
+	clk_enable(hwa742.sys_ck);
+}
+
+static void hwa742_power_down(struct device *dev)
+{
+	clk_disable(hwa742.sys_ck);
+}
+
+static struct hwa742_platform_data nokia770_hwa742_platform_data = {
+	.get_clock_rate	= hwa742_get_clock_rate,
+	.power_up	= hwa742_power_up,
+	.power_down	= hwa742_power_down,
+	.te_connected	= 1,
+};
+
+static void hwa742_dev_init(void)
+{
+	hwa742_get_clocks();
+	omapfb_set_ctrl_platform_data(&nokia770_hwa742_platform_data);
+}
 
 /* assume no Mini-AB port */
 
@@ -287,8 +371,12 @@ static void __init omap_nokia770_init(void)
 				ARRAY_SIZE(nokia770_spi_board_info));
 	omap_board_config = nokia770_config;
 	omap_board_config_size = ARRAY_SIZE(nokia770_config);
+	omap_gpio_init();
 	omap_serial_init();
 	omap_dsp_init();
+	hwa742_dev_init();
+	ads7846_dev_init();
+	mipid_dev_init();
 }
 
 static void __init omap_nokia770_map_io(void)
-- 
1.5.0.rc3


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0002-ARM-OMAP1-SoSSI-update-IRQ-name-and-callback-table-name.patch"

>From 1b1197720183c12f9202b11ed6dd4328f31cc37e Mon Sep 17 00:00:00 2001
From: Imre Deak <imre.deak@solidboot.com>
Date: Tue, 6 Mar 2007 18:27:16 +0200
Subject: [PATCH] ARM: OMAP1: SoSSI: update IRQ name and callback table name

These were changed in the generic FB code, but not updated for the OMAP1
specific parts.

Signed-off-by: Imre Deak <imre.deak@solidboot.com>
---
 drivers/video/omap/sossi.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap/sossi.c b/drivers/video/omap/sossi.c
index 71467b3..505b932 100644
--- a/drivers/video/omap/sossi.c
+++ b/drivers/video/omap/sossi.c
@@ -23,6 +23,7 @@
 #include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/clk.h>
+#include <linux/irq.h>
 
 #include <asm/io.h>
 
@@ -640,7 +641,8 @@ static int sossi_init(struct omapfb_device *fbdev)
 	l &= ~(1 << 31); /* REORDERING */
 	sossi_write_reg(SOSSI_INIT1_REG, l);
 
-	if ((r = request_irq(INT_SOSSI_MATCH, sossi_match_irq, IRQT_FALLING,
+	if ((r = request_irq(INT_1610_SoSSI_MATCH, sossi_match_irq,
+			     IRQT_FALLING,
 	     "sossi_match", sossi.fbdev->dev)) < 0) {
 		dev_err(sossi.fbdev->dev, "can't get SoSSI match IRQ\n");
 		goto err;
@@ -661,7 +663,7 @@ static void sossi_cleanup(void)
 	clk_put(sossi.fck);
 }
 
-struct lcd_ctrl_extif sossi_extif = {
+struct lcd_ctrl_extif omap1_ext_if = {
 	.init			= sossi_init,
 	.cleanup		= sossi_cleanup,
 	.get_clk_info		= sossi_get_clk_info,
-- 
1.5.0.rc3


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0003-ARM-OMAP-HWA742-fix-capability-query-callback.patch"

>From 45e70c8c6cb959b1b3e5d8a2077fcb86b822ec1a Mon Sep 17 00:00:00 2001
From: Imre Deak <imre.deak@solidboot.com>
Date: Tue, 6 Mar 2007 18:35:00 +0200
Subject: [PATCH] ARM: OMAP: HWA742: fix capability query callback

This was changed in the generic FB code, but not updated in the HWA742
specific part.

Signed-off-by: Imre Deak <imre.deak@solidboot.com>
---
 drivers/video/omap/hwa742.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/video/omap/hwa742.c b/drivers/video/omap/hwa742.c
index 67a7484..5d92f59 100644
--- a/drivers/video/omap/hwa742.c
+++ b/drivers/video/omap/hwa742.c
@@ -893,14 +893,15 @@ static int setup_tearsync(unsigned long pix_clk, int extif_div)
 					    hs_pol_inv, vs_pol_inv, extif_div);
 }
 
-static unsigned long hwa742_get_caps(void)
+static void hwa742_get_caps(int plane, struct omapfb_caps *caps)
 {
-	unsigned long caps;
-
-	caps = OMAPFB_CAPS_MANUAL_UPDATE;
+	hwa742.int_ctrl->get_caps(plane, caps);
+	caps->ctrl |= OMAPFB_CAPS_MANUAL_UPDATE |
+		      OMAPFB_CAPS_WINDOW_PIXEL_DOUBLE;
 	if (hwa742.te_connected)
-		caps |= OMAPFB_CAPS_TEARSYNC;
-	return caps;
+		caps->ctrl |= OMAPFB_CAPS_TEARSYNC;
+	caps->wnd_color |= (1 << OMAPFB_COLOR_RGB565) |
+			   (1 << OMAPFB_COLOR_YUV420);
 }
 
 static void hwa742_suspend(void)
-- 
1.5.0.rc3


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0004-ARM-N770-update-n770_defconfig.patch"

>From 902056d8e38ebca482c927492e2d2dee0e3dc6da Mon Sep 17 00:00:00 2001
From: Imre Deak <imre.deak@solidboot.com>
Date: Tue, 6 Mar 2007 18:46:48 +0200
Subject: [PATCH] ARM: N770: update n770_defconfig

Add lcd_mipid.

Signed-off-by: Imre Deak <imre.deak@solidboot.com>
---
 arch/arm/configs/n770_defconfig |  307 ++++++++++++++++++++++++++++-----------
 1 files changed, 222 insertions(+), 85 deletions(-)

diff --git a/arch/arm/configs/n770_defconfig b/arch/arm/configs/n770_defconfig
index ef33d82..557d04d 100644
--- a/arch/arm/configs/n770_defconfig
+++ b/arch/arm/configs/n770_defconfig
@@ -1,12 +1,25 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.16-rc2-omap1
-# Fri Feb 10 15:29:21 2006
+# Linux kernel version: 2.6.21-rc2-omap1
+# Tue Mar  6 18:10:23 2007
 #
 CONFIG_ARM=y
+CONFIG_SYS_SUPPORTS_APM_EMULATION=y
+# CONFIG_GENERIC_TIME is not set
 CONFIG_MMU=y
+# CONFIG_NO_IOPORT is not set
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
+CONFIG_HARDIRQS_SW_RESEND=y
+CONFIG_GENERIC_IRQ_PROBE=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
+# CONFIG_ARCH_HAS_ILOG2_U32 is not set
+# CONFIG_ARCH_HAS_ILOG2_U64 is not set
+CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_ZONE_DMA=y
+CONFIG_VECTORS_BASE=0xffff0000
+CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
 # Code maturity level options
@@ -22,15 +35,21 @@ CONFIG_LOCALVERSION=""
 CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
+# CONFIG_IPC_NS is not set
+CONFIG_SYSVIPC_SYSCTL=y
 CONFIG_POSIX_MQUEUE=y
 # CONFIG_BSD_PROCESS_ACCT is not set
-CONFIG_SYSCTL=y
+# CONFIG_TASKSTATS is not set
+# CONFIG_UTS_NS is not set
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
-CONFIG_INITRAMFS_SOURCE=""
-CONFIG_UID16=y
+CONFIG_SYSFS_DEPRECATED=y
+# CONFIG_RELAY is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_SYSCTL=y
 # CONFIG_EMBEDDED is not set
+CONFIG_UID16=y
+CONFIG_SYSCTL_SYSCALL=y
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_ALL is not set
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
@@ -42,11 +61,9 @@ CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
 CONFIG_SHMEM=y
-CONFIG_CC_ALIGN_FUNCTIONS=0
-CONFIG_CC_ALIGN_LABELS=0
-CONFIG_CC_ALIGN_LOOPS=0
-CONFIG_CC_ALIGN_JUMPS=0
 CONFIG_SLAB=y
+CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
 # CONFIG_SLOB is not set
@@ -57,7 +74,6 @@ CONFIG_BASE_SMALL=0
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_MODULE_FORCE_UNLOAD is not set
-CONFIG_OBSOLETE_MODPARM=y
 # CONFIG_MODVERSIONS is not set
 # CONFIG_MODULE_SRCVERSION_ALL is not set
 # CONFIG_KMOD is not set
@@ -65,6 +81,10 @@ CONFIG_OBSOLETE_MODPARM=y
 #
 # Block layer
 #
+CONFIG_BLOCK=y
+# CONFIG_LBD is not set
+# CONFIG_BLK_DEV_IO_TRACE is not set
+# CONFIG_LSF is not set
 
 #
 # IO Schedulers
@@ -82,16 +102,29 @@ CONFIG_DEFAULT_IOSCHED="cfq"
 #
 # System Type
 #
+# CONFIG_ARCH_AAEC2000 is not set
+# CONFIG_ARCH_INTEGRATOR is not set
+# CONFIG_ARCH_REALVIEW is not set
+# CONFIG_ARCH_VERSATILE is not set
+# CONFIG_ARCH_AT91 is not set
 # CONFIG_ARCH_CLPS7500 is not set
 # CONFIG_ARCH_CLPS711X is not set
 # CONFIG_ARCH_CO285 is not set
 # CONFIG_ARCH_EBSA110 is not set
+# CONFIG_ARCH_EP93XX is not set
 # CONFIG_ARCH_FOOTBRIDGE is not set
-# CONFIG_ARCH_INTEGRATOR is not set
-# CONFIG_ARCH_IOP3XX is not set
+# CONFIG_ARCH_NETX is not set
+# CONFIG_ARCH_H720X is not set
+# CONFIG_ARCH_IMX is not set
+# CONFIG_ARCH_IOP32X is not set
+# CONFIG_ARCH_IOP33X is not set
+# CONFIG_ARCH_IOP13XX is not set
 # CONFIG_ARCH_IXP4XX is not set
 # CONFIG_ARCH_IXP2000 is not set
+# CONFIG_ARCH_IXP23XX is not set
 # CONFIG_ARCH_L7200 is not set
+# CONFIG_ARCH_NS9XXX is not set
+# CONFIG_ARCH_PNX4008 is not set
 # CONFIG_ARCH_PXA is not set
 # CONFIG_ARCH_RPC is not set
 # CONFIG_ARCH_SA1100 is not set
@@ -99,12 +132,6 @@ CONFIG_DEFAULT_IOSCHED="cfq"
 # CONFIG_ARCH_SHARK is not set
 # CONFIG_ARCH_LH7A40X is not set
 CONFIG_ARCH_OMAP=y
-# CONFIG_ARCH_VERSATILE is not set
-# CONFIG_ARCH_REALVIEW is not set
-# CONFIG_ARCH_IMX is not set
-# CONFIG_ARCH_H720X is not set
-# CONFIG_ARCH_AAEC2000 is not set
-# CONFIG_ARCH_AT91RM9200 is not set
 
 #
 # TI OMAP Implementations
@@ -124,6 +151,7 @@ CONFIG_OMAP_GPIO_SWITCH=y
 # CONFIG_OMAP_MUX is not set
 CONFIG_OMAP_STI=y
 CONFIG_OMAP_STI_CONSOLE=y
+CONFIG_OMAP_MCBSP=y
 # CONFIG_OMAP_MPU_TIMER is not set
 CONFIG_OMAP_32K_TIMER=y
 CONFIG_OMAP_32K_TIMER_HZ=128
@@ -131,6 +159,10 @@ CONFIG_OMAP_DM_TIMER=y
 CONFIG_OMAP_LL_DEBUG_UART1=y
 # CONFIG_OMAP_LL_DEBUG_UART2 is not set
 # CONFIG_OMAP_LL_DEBUG_UART3 is not set
+CONFIG_OMAP_DSP=y
+# CONFIG_OMAP_DSP_MBCMD_VERBOSE is not set
+CONFIG_OMAP_DSP_TASK_MULTIOPEN=y
+CONFIG_OMAP_DSP_FBEXPORT=y
 
 #
 # OMAP Core Type
@@ -159,10 +191,6 @@ CONFIG_OMAP_ARM_216MHZ=y
 # CONFIG_OMAP_ARM_120MHZ is not set
 # CONFIG_OMAP_ARM_60MHZ is not set
 # CONFIG_OMAP_ARM_30MHZ is not set
-CONFIG_OMAP_DSP=y
-# CONFIG_OMAP_DSP_MBCMD_VERBOSE is not set
-CONFIG_OMAP_DSP_TASK_MULTIOPEN=y
-CONFIG_OMAP_DSP_FBEXPORT=y
 
 #
 # Processor Type
@@ -174,6 +202,8 @@ CONFIG_CPU_ABRT_EV5TJ=y
 CONFIG_CPU_CACHE_VIVT=y
 CONFIG_CPU_COPY_V4WB=y
 CONFIG_CPU_TLB_V4WBI=y
+CONFIG_CPU_CP15=y
+CONFIG_CPU_CP15_MMU=y
 
 #
 # Processor Features
@@ -183,6 +213,7 @@ CONFIG_ARM_THUMB=y
 # CONFIG_CPU_DCACHE_DISABLE is not set
 # CONFIG_CPU_DCACHE_WRITETHROUGH is not set
 # CONFIG_CPU_CACHE_ROUND_ROBIN is not set
+# CONFIG_OUTER_CACHE is not set
 
 #
 # Bus support
@@ -198,6 +229,7 @@ CONFIG_ARM_THUMB=y
 #
 # CONFIG_PREEMPT is not set
 CONFIG_NO_IDLE_HZ=y
+CONFIG_HZ=128
 # CONFIG_AEABI is not set
 # CONFIG_ARCH_DISCONTIGMEM_ENABLE is not set
 CONFIG_SELECT_MEMORY_MODEL=y
@@ -208,6 +240,8 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4096
+# CONFIG_RESOURCES_64BIT is not set
+CONFIG_ZONE_DMA_FLAG=1
 # CONFIG_LEDS is not set
 CONFIG_ALIGNMENT_TRAP=y
 
@@ -218,6 +252,7 @@ CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="root=1f03 rootfstype=jffs2 time"
 # CONFIG_XIP_KERNEL is not set
+# CONFIG_KEXEC is not set
 
 #
 # CPU Frequency scaling
@@ -250,7 +285,8 @@ CONFIG_BINFMT_ELF=y
 CONFIG_PM=y
 # CONFIG_PM_LEGACY is not set
 # CONFIG_PM_DEBUG is not set
-# CONFIG_APM is not set
+# CONFIG_PM_SYSFS_DEPRECATED is not set
+# CONFIG_APM_EMULATION is not set
 
 #
 # Networking
@@ -264,6 +300,10 @@ CONFIG_NET=y
 CONFIG_PACKET=y
 # CONFIG_PACKET_MMAP is not set
 CONFIG_UNIX=y
+CONFIG_XFRM=y
+# CONFIG_XFRM_USER is not set
+# CONFIG_XFRM_SUB_POLICY is not set
+# CONFIG_XFRM_MIGRATE is not set
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
@@ -281,16 +321,26 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_INET_AH is not set
 # CONFIG_INET_ESP is not set
 # CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_XFRM_TUNNEL is not set
 # CONFIG_INET_TUNNEL is not set
+CONFIG_INET_XFRM_MODE_TRANSPORT=y
+CONFIG_INET_XFRM_MODE_TUNNEL=y
+CONFIG_INET_XFRM_MODE_BEET=y
 # CONFIG_INET_DIAG is not set
 # CONFIG_TCP_CONG_ADVANCED is not set
-CONFIG_TCP_CONG_BIC=y
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_TCP_MD5SIG is not set
 
 #
 # IP: Virtual Server Configuration
 #
 # CONFIG_IP_VS is not set
 # CONFIG_IPV6 is not set
+# CONFIG_INET6_XFRM_TUNNEL is not set
+# CONFIG_INET6_TUNNEL is not set
+# CONFIG_NETLABEL is not set
+# CONFIG_NETWORK_SECMARK is not set
 CONFIG_NETFILTER=y
 # CONFIG_NETFILTER_DEBUG is not set
 
@@ -300,14 +350,15 @@ CONFIG_NETFILTER=y
 CONFIG_NETFILTER_NETLINK=y
 # CONFIG_NETFILTER_NETLINK_QUEUE is not set
 # CONFIG_NETFILTER_NETLINK_LOG is not set
-# CONFIG_NF_CONNTRACK is not set
+# CONFIG_NF_CONNTRACK_ENABLED is not set
 # CONFIG_NETFILTER_XTABLES is not set
 
 #
 # IP: Netfilter Configuration
 #
-# CONFIG_IP_NF_CONNTRACK is not set
 # CONFIG_IP_NF_QUEUE is not set
+# CONFIG_IP_NF_IPTABLES is not set
+# CONFIG_IP_NF_ARPTABLES is not set
 
 #
 # DCCP Configuration (EXPERIMENTAL)
@@ -332,7 +383,6 @@ CONFIG_NETFILTER_NETLINK=y
 # CONFIG_ATALK is not set
 # CONFIG_X25 is not set
 # CONFIG_LAPB is not set
-# CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
 
@@ -368,6 +418,7 @@ CONFIG_BT_HIDP=y
 CONFIG_BT_HCIBRF6150=y
 # CONFIG_BT_HCIVHCI is not set
 # CONFIG_IEEE80211 is not set
+CONFIG_WIRELESS_EXT=y
 
 #
 # Device Drivers
@@ -380,6 +431,8 @@ CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 CONFIG_FW_LOADER=y
 # CONFIG_DEBUG_DRIVER is not set
+# CONFIG_DEBUG_DEVRES is not set
+# CONFIG_SYS_HYPERVISOR is not set
 
 #
 # Connector - unified userspace <-> kernelspace linker
@@ -402,11 +455,13 @@ CONFIG_MTD_CMDLINE_PARTS=y
 # User Modules And Translation Layers
 #
 CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLKDEVS=y
 CONFIG_MTD_BLOCK=y
 # CONFIG_FTL is not set
 # CONFIG_NFTL is not set
 # CONFIG_INFTL is not set
 # CONFIG_RFD_FTL is not set
+# CONFIG_SSFDC is not set
 
 #
 # RAM/ROM/Flash chip drivers
@@ -442,7 +497,6 @@ CONFIG_MTD_CFI_I2=y
 # CONFIG_MTD_SLRAM is not set
 # CONFIG_MTD_PHRAM is not set
 # CONFIG_MTD_MTDRAM is not set
-# CONFIG_MTD_BLKMTD is not set
 # CONFIG_MTD_BLOCK2MTD is not set
 
 #
@@ -457,17 +511,16 @@ CONFIG_MTD_CFI_I2=y
 #
 CONFIG_MTD_NAND=y
 # CONFIG_MTD_NAND_VERIFY_WRITE is not set
-# CONFIG_MTD_NAND_TOTO is not set
+# CONFIG_MTD_NAND_ECC_SMC is not set
+CONFIG_MTD_NAND_OMAP_HW=y
 CONFIG_MTD_NAND_IDS=y
 # CONFIG_MTD_NAND_DISKONCHIP is not set
 # CONFIG_MTD_NAND_NANDSIM is not set
-CONFIG_MTD_NAND_OMAP_HW=y
 
 #
 # OneNAND Flash Device Drivers
 #
 # CONFIG_MTD_ONENAND is not set
-# CONFIG_MTD_ONENAND_SYNC_READ is not set
 
 #
 # Parallel port support
@@ -477,6 +530,7 @@ CONFIG_MTD_NAND_OMAP_HW=y
 #
 # Plug and Play support
 #
+# CONFIG_PNPACPI is not set
 
 #
 # Block devices
@@ -487,7 +541,7 @@ CONFIG_BLK_DEV_LOOP=y
 # CONFIG_BLK_DEV_NBD is not set
 # CONFIG_BLK_DEV_UB is not set
 # CONFIG_BLK_DEV_RAM is not set
-CONFIG_BLK_DEV_RAM_COUNT=16
+# CONFIG_BLK_DEV_INITRD is not set
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
 
@@ -496,6 +550,8 @@ CONFIG_BLK_DEV_RAM_COUNT=16
 #
 # CONFIG_RAID_ATTRS is not set
 CONFIG_SCSI=y
+# CONFIG_SCSI_TGT is not set
+# CONFIG_SCSI_NETLINK is not set
 # CONFIG_SCSI_PROC_FS is not set
 
 #
@@ -514,23 +570,29 @@ CONFIG_BLK_DEV_SD=y
 # CONFIG_SCSI_MULTI_LUN is not set
 # CONFIG_SCSI_CONSTANTS is not set
 # CONFIG_SCSI_LOGGING is not set
+# CONFIG_SCSI_SCAN_ASYNC is not set
 
 #
-# SCSI Transport Attributes
+# SCSI Transports
 #
 # CONFIG_SCSI_SPI_ATTRS is not set
 # CONFIG_SCSI_FC_ATTRS is not set
 # CONFIG_SCSI_ISCSI_ATTRS is not set
 # CONFIG_SCSI_SAS_ATTRS is not set
+# CONFIG_SCSI_SAS_LIBSAS is not set
 
 #
 # SCSI low-level drivers
 #
 # CONFIG_ISCSI_TCP is not set
-# CONFIG_SCSI_SATA is not set
 # CONFIG_SCSI_DEBUG is not set
 
 #
+# Serial ATA (prod) and Parallel ATA (experimental) drivers
+#
+# CONFIG_ATA is not set
+
+#
 # Multi-device support (RAID and LVM)
 #
 # CONFIG_MD is not set
@@ -586,12 +648,13 @@ CONFIG_MII=y
 # Wireless LAN (non-hamradio)
 #
 CONFIG_NET_RADIO=y
+# CONFIG_NET_WIRELESS_RTNETLINK is not set
 
 #
 # Obsolete Wireless cards support (pre-802.11)
 #
 # CONFIG_STRIP is not set
-# CONFIG_ATMEL is not set
+# CONFIG_USB_ZD1201 is not set
 # CONFIG_HOSTAP is not set
 
 #
@@ -608,6 +671,7 @@ CONFIG_PPP_BSDCOMP=y
 # CONFIG_PPP_MPPE is not set
 # CONFIG_PPPOE is not set
 # CONFIG_SLIP is not set
+CONFIG_SLHC=y
 # CONFIG_SHAPER is not set
 # CONFIG_NETCONSOLE is not set
 # CONFIG_NETPOLL is not set
@@ -622,6 +686,7 @@ CONFIG_PPP_BSDCOMP=y
 # Input device support
 #
 CONFIG_INPUT=y
+# CONFIG_INPUT_FF_MEMLESS is not set
 
 #
 # Userland interfaces
@@ -644,6 +709,7 @@ CONFIG_INPUT_KEYBOARD=y
 # CONFIG_KEYBOARD_LKKBD is not set
 # CONFIG_KEYBOARD_XTKBD is not set
 # CONFIG_KEYBOARD_NEWTON is not set
+# CONFIG_KEYBOARD_STOWAWAY is not set
 CONFIG_KEYBOARD_OMAP=y
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_INPUT_JOYSTICK is not set
@@ -653,7 +719,10 @@ CONFIG_TOUCHSCREEN_ADS7846=y
 # CONFIG_TOUCHSCREEN_ELO is not set
 # CONFIG_TOUCHSCREEN_MTOUCH is not set
 # CONFIG_TOUCHSCREEN_MK712 is not set
-# CONFIG_TOUCHSCREEN_OMAP is not set
+# CONFIG_TOUCHSCREEN_PENMOUNT is not set
+# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
+# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
+# CONFIG_TOUCHSCREEN_UCB1400 is not set
 # CONFIG_INPUT_MISC is not set
 
 #
@@ -670,6 +739,7 @@ CONFIG_SERIO_SERPORT=y
 CONFIG_VT=y
 CONFIG_VT_CONSOLE=y
 CONFIG_HW_CONSOLE=y
+# CONFIG_VT_HW_CONSOLE_BINDING is not set
 # CONFIG_SERIAL_NONSTANDARD is not set
 
 #
@@ -704,29 +774,25 @@ CONFIG_WATCHDOG_NOWAYOUT=y
 # Watchdog Device Drivers
 #
 # CONFIG_SOFT_WATCHDOG is not set
+CONFIG_OMAP_WATCHDOG=y
 
 #
 # USB-based Watchdog Cards
 #
 # CONFIG_USBPCWATCHDOG is not set
-CONFIG_OMAP_WATCHDOG=y
+CONFIG_HW_RANDOM=m
+CONFIG_HW_RANDOM_OMAP=m
 CONFIG_OMAP_RNG=y
 # CONFIG_NVRAM is not set
-# CONFIG_RTC is not set
 # CONFIG_OMAP_RTC is not set
 # CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
-
-#
-# Ftape, the floppy tape device driver
-#
 # CONFIG_RAW_DRIVER is not set
 
 #
 # TPM devices
 #
 # CONFIG_TCG_TPM is not set
-# CONFIG_TELCLOCK is not set
 
 #
 # I2C support
@@ -744,10 +810,11 @@ CONFIG_I2C=y
 #
 # I2C Hardware Bus support
 #
+# CONFIG_I2C_OCORES is not set
+CONFIG_I2C_OMAP=y
 # CONFIG_I2C_PARPORT_LIGHT is not set
 # CONFIG_I2C_STUB is not set
 # CONFIG_I2C_PCA_ISA is not set
-CONFIG_I2C_OMAP=y
 
 #
 # Miscellaneous I2C Chip support
@@ -758,13 +825,11 @@ CONFIG_I2C_OMAP=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_RTC8564 is not set
 # CONFIG_ISP1301_OMAP is not set
 # CONFIG_TPS65010 is not set
 CONFIG_SENSORS_TLV320AIC23=y
 # CONFIG_GPIOEXPANDER_OMAP is not set
 # CONFIG_SENSORS_MAX6875 is not set
-# CONFIG_RTC_X1205_I2C is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
 # CONFIG_I2C_DEBUG_BUS is not set
@@ -786,6 +851,13 @@ CONFIG_SPI_OMAP_UWIRE=y
 #
 # SPI Protocol Masters
 #
+# CONFIG_TSC2102 is not set
+# CONFIG_SPI_AT25 is not set
+
+#
+# Dallas's 1-wire bus
+#
+# CONFIG_W1 is not set
 
 #
 # Hardware Monitoring support
@@ -798,7 +870,21 @@ CONFIG_SPI_OMAP_UWIRE=y
 #
 
 #
-# Multimedia Capabilities Port drivers
+# Multifunction device drivers
+#
+# CONFIG_MFD_SM501 is not set
+
+#
+# LED devices
+#
+# CONFIG_NEW_LEDS is not set
+
+#
+# LED drivers
+#
+
+#
+# LED Triggers
 #
 
 #
@@ -810,26 +896,38 @@ CONFIG_SPI_OMAP_UWIRE=y
 # Digital Video Broadcasting Devices
 #
 # CONFIG_DVB is not set
+# CONFIG_USB_DABUSB is not set
 
 #
 # Graphics support
 #
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 CONFIG_FB=y
+# CONFIG_FIRMWARE_EDID is not set
+# CONFIG_FB_DDC is not set
 # CONFIG_FB_CFB_FILLRECT is not set
 # CONFIG_FB_CFB_COPYAREA is not set
 # CONFIG_FB_CFB_IMAGEBLIT is not set
+# CONFIG_FB_SVGALIB is not set
 # CONFIG_FB_MACMODES is not set
+# CONFIG_FB_BACKLIGHT is not set
 # CONFIG_FB_MODE_HELPERS is not set
 # CONFIG_FB_TILEBLITTING is not set
+
+#
+# Frambuffer hardware drivers
+#
 # CONFIG_FB_S1D13XXX is not set
+# CONFIG_FB_VIRTUAL is not set
 CONFIG_FB_OMAP=y
 CONFIG_FB_OMAP_LCDC_EXTERNAL=y
 CONFIG_FB_OMAP_LCDC_HWA742=y
+# CONFIG_FB_OMAP_LCDC_BLIZZARD is not set
 CONFIG_FB_OMAP_MANUAL_UPDATE=y
-CONFIG_FB_OMAP_LCD_LPH8923=y
+CONFIG_FB_OMAP_LCD_MIPID=y
 # CONFIG_FB_OMAP_BOOTLOADER_INIT is not set
+CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=2
 # CONFIG_FB_OMAP_DMA_TUNE is not set
-# CONFIG_FB_VIRTUAL is not set
 
 #
 # Console display driver support
@@ -842,7 +940,6 @@ CONFIG_DUMMY_CONSOLE=y
 # Logo configuration
 #
 # CONFIG_LOGO is not set
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Sound
@@ -862,6 +959,7 @@ CONFIG_SND_RAWMIDI=y
 # CONFIG_SND_PCM_OSS is not set
 # CONFIG_SND_DYNAMIC_MINORS is not set
 # CONFIG_SND_SUPPORT_OLD_API is not set
+CONFIG_SND_VERBOSE_PROCFS=y
 # CONFIG_SND_VERBOSE_PRINTK is not set
 # CONFIG_SND_DEBUG is not set
 
@@ -877,6 +975,9 @@ CONFIG_SND_DUMMY=y
 # ALSA ARM devices
 #
 CONFIG_SND_OMAP_AIC23=y
+# CONFIG_SND_OMAP_TSC2101 is not set
+# CONFIG_SND_SX1 is not set
+# CONFIG_SND_OMAP_TSC2102 is not set
 
 #
 # USB devices
@@ -884,15 +985,27 @@ CONFIG_SND_OMAP_AIC23=y
 CONFIG_SND_USB_AUDIO=y
 
 #
+# SoC audio support
+#
+# CONFIG_SND_SOC is not set
+
+#
 # Open Sound System
 #
 # CONFIG_SOUND_PRIME is not set
 
 #
+# HID Devices
+#
+CONFIG_HID=y
+# CONFIG_HID_DEBUG is not set
+
+#
 # USB support
 #
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
+# CONFIG_USB_ARCH_HAS_EHCI is not set
 CONFIG_USB=y
 # CONFIG_USB_DEBUG is not set
 
@@ -900,25 +1013,27 @@ CONFIG_USB=y
 # Miscellaneous USB options
 #
 CONFIG_USB_DEVICEFS=y
-CONFIG_USB_BANDWIDTH=y
 # CONFIG_USB_DYNAMIC_MINORS is not set
 CONFIG_USB_SUSPEND=y
 CONFIG_USB_OTG=y
 # CONFIG_USB_OTG_WHITELIST is not set
+# CONFIG_USB_OTG_BLACKLIST_HUB is not set
 
 #
 # USB Host Controller Drivers
 #
 # CONFIG_USB_ISP116X_HCD is not set
 CONFIG_USB_OHCI_HCD=y
-# CONFIG_USB_OHCI_BIG_ENDIAN is not set
+# CONFIG_USB_OHCI_BIG_ENDIAN_DESC is not set
+# CONFIG_USB_OHCI_BIG_ENDIAN_MMIO is not set
 CONFIG_USB_OHCI_LITTLE_ENDIAN=y
 # CONFIG_USB_SL811_HCD is not set
+# CONFIG_USB_MUSB_HDRC is not set
+# CONFIG_USB_GADGET_MUSB_HDRC is not set
 
 #
 # USB Device Class drivers
 #
-# CONFIG_OBSOLETE_OSS_USB_DRIVER is not set
 # CONFIG_USB_ACM is not set
 # CONFIG_USB_PRINTER is not set
 
@@ -939,13 +1054,13 @@ CONFIG_USB_STORAGE=y
 # CONFIG_USB_STORAGE_SDDR55 is not set
 # CONFIG_USB_STORAGE_JUMPSHOT is not set
 # CONFIG_USB_STORAGE_ALAUDA is not set
+# CONFIG_USB_STORAGE_KARMA is not set
 # CONFIG_USB_LIBUSUAL is not set
 
 #
 # USB Input Devices
 #
 CONFIG_USB_HID=y
-CONFIG_USB_HIDINPUT=y
 # CONFIG_USB_HIDINPUT_POWERBOOK is not set
 # CONFIG_HID_FF is not set
 # CONFIG_USB_HIDDEV is not set
@@ -954,15 +1069,14 @@ CONFIG_USB_HIDINPUT=y
 # CONFIG_USB_ACECAD is not set
 # CONFIG_USB_KBTAB is not set
 # CONFIG_USB_POWERMATE is not set
-# CONFIG_USB_MTOUCH is not set
-# CONFIG_USB_ITMTOUCH is not set
-# CONFIG_USB_EGALAX is not set
+# CONFIG_USB_TOUCHSCREEN is not set
 # CONFIG_USB_YEALINK is not set
 # CONFIG_USB_XPAD is not set
 # CONFIG_USB_ATI_REMOTE is not set
 # CONFIG_USB_ATI_REMOTE2 is not set
 # CONFIG_USB_KEYSPAN_REMOTE is not set
 # CONFIG_USB_APPLETOUCH is not set
+# CONFIG_USB_GTCO is not set
 
 #
 # USB Imaging devices
@@ -971,31 +1085,24 @@ CONFIG_USB_HIDINPUT=y
 # CONFIG_USB_MICROTEK is not set
 
 #
-# USB Multimedia devices
-#
-# CONFIG_USB_DABUSB is not set
-
-#
-# Video4Linux support is needed for USB Multimedia device support
-#
-
-#
 # USB Network Adapters
 #
 # CONFIG_USB_CATC is not set
 # CONFIG_USB_KAWETH is not set
 # CONFIG_USB_PEGASUS is not set
 # CONFIG_USB_RTL8150 is not set
+# CONFIG_USB_USBNET_MII is not set
 CONFIG_USB_USBNET=y
 # CONFIG_USB_NET_AX8817X is not set
 CONFIG_USB_NET_CDCETHER=y
+# CONFIG_USB_NET_DM9601 is not set
 # CONFIG_USB_NET_GL620A is not set
 CONFIG_USB_NET_NET1080=y
 # CONFIG_USB_NET_PLUSB is not set
+# CONFIG_USB_NET_MCS7830 is not set
 # CONFIG_USB_NET_RNDIS_HOST is not set
 # CONFIG_USB_NET_CDC_SUBSET is not set
 CONFIG_USB_NET_ZAURUS=y
-# CONFIG_USB_ZD1201 is not set
 # CONFIG_USB_MON is not set
 
 #
@@ -1008,8 +1115,9 @@ CONFIG_USB_NET_ZAURUS=y
 CONFIG_USB_SERIAL=y
 CONFIG_USB_SERIAL_CONSOLE=y
 # CONFIG_USB_SERIAL_GENERIC is not set
+# CONFIG_USB_SERIAL_AIRCABLE is not set
 # CONFIG_USB_SERIAL_AIRPRIME is not set
-# CONFIG_USB_SERIAL_ANYDATA is not set
+# CONFIG_USB_SERIAL_ARK3116 is not set
 # CONFIG_USB_SERIAL_BELKIN is not set
 # CONFIG_USB_SERIAL_WHITEHEAT is not set
 # CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
@@ -1017,6 +1125,7 @@ CONFIG_USB_SERIAL_CONSOLE=y
 # CONFIG_USB_SERIAL_CYPRESS_M8 is not set
 # CONFIG_USB_SERIAL_EMPEG is not set
 # CONFIG_USB_SERIAL_FTDI_SIO is not set
+# CONFIG_USB_SERIAL_FUNSOFT is not set
 # CONFIG_USB_SERIAL_VISOR is not set
 # CONFIG_USB_SERIAL_IPAQ is not set
 # CONFIG_USB_SERIAL_IR is not set
@@ -1029,29 +1138,41 @@ CONFIG_USB_SERIAL_CONSOLE=y
 # CONFIG_USB_SERIAL_KLSI is not set
 # CONFIG_USB_SERIAL_KOBIL_SCT is not set
 # CONFIG_USB_SERIAL_MCT_U232 is not set
+# CONFIG_USB_SERIAL_MOS7720 is not set
+# CONFIG_USB_SERIAL_MOS7840 is not set
+# CONFIG_USB_SERIAL_NAVMAN is not set
 CONFIG_USB_SERIAL_PL2303=y
 # CONFIG_USB_SERIAL_HP4X is not set
 # CONFIG_USB_SERIAL_SAFE is not set
+# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
 # CONFIG_USB_SERIAL_TI is not set
 # CONFIG_USB_SERIAL_CYBERJACK is not set
 # CONFIG_USB_SERIAL_XIRCOM is not set
+# CONFIG_USB_SERIAL_OPTION is not set
 # CONFIG_USB_SERIAL_OMNINET is not set
+# CONFIG_USB_SERIAL_DEBUG is not set
 
 #
 # USB Miscellaneous drivers
 #
 # CONFIG_USB_EMI62 is not set
 # CONFIG_USB_EMI26 is not set
+# CONFIG_USB_ADUTUX is not set
 # CONFIG_USB_AUERSWALD is not set
 # CONFIG_USB_RIO500 is not set
 # CONFIG_USB_LEGOTOWER is not set
 # CONFIG_USB_LCD is not set
+# CONFIG_USB_BERRY_CHARGE is not set
 # CONFIG_USB_LED is not set
+# CONFIG_USB_CYPRESS_CY7C63 is not set
 # CONFIG_USB_CYTHERM is not set
-# CONFIG_USB_PHIDGETKIT is not set
-# CONFIG_USB_PHIDGETSERVO is not set
+# CONFIG_USB_PHIDGET is not set
 # CONFIG_USB_IDMOUSE is not set
+# CONFIG_USB_FTDI_ELAN is not set
+# CONFIG_USB_APPLEDISPLAY is not set
 # CONFIG_USB_LD is not set
+# CONFIG_USB_TRANCEVIBRATOR is not set
+# CONFIG_USB_IOWARRIOR is not set
 # CONFIG_USB_TEST is not set
 
 #
@@ -1070,6 +1191,7 @@ CONFIG_USB_GADGET_SELECTED=y
 # CONFIG_USB_GADGET_LH7A40X is not set
 CONFIG_USB_GADGET_OMAP=y
 CONFIG_USB_OMAP=y
+# CONFIG_USB_GADGET_AT91 is not set
 # CONFIG_USB_GADGET_DUMMY_HCD is not set
 # CONFIG_USB_GADGET_DUALSPEED is not set
 # CONFIG_USB_ZERO is not set
@@ -1079,6 +1201,7 @@ CONFIG_USB_ETH_RNDIS=y
 CONFIG_USB_FILE_STORAGE=m
 CONFIG_USB_FILE_STORAGE_TEST=y
 # CONFIG_USB_G_SERIAL is not set
+# CONFIG_USB_MIDI_GADGET is not set
 
 #
 # MMC/SD Card support
@@ -1086,15 +1209,13 @@ CONFIG_USB_FILE_STORAGE_TEST=y
 CONFIG_MMC=y
 # CONFIG_MMC_DEBUG is not set
 CONFIG_MMC_BLOCK=y
-CONFIG_MMC_BLOCK_BROKEN_RFD=y
-CONFIG_MMC_BULKTRANSFER=y
 CONFIG_MMC_OMAP=y
 
 #
-# Synchronous Serial Interfaces (SSI)
+# Real Time Clock
 #
-CONFIG_OMAP_UWIRE=y
-# CONFIG_OMAP_TSC2101 is not set
+CONFIG_RTC_LIB=y
+# CONFIG_RTC_CLASS is not set
 
 #
 # CBUS support
@@ -1120,6 +1241,7 @@ CONFIG_EXT3_FS=y
 CONFIG_EXT3_FS_XATTR=y
 # CONFIG_EXT3_FS_POSIX_ACL is not set
 # CONFIG_EXT3_FS_SECURITY is not set
+# CONFIG_EXT4DEV_FS is not set
 CONFIG_JBD=y
 # CONFIG_JBD_DEBUG is not set
 CONFIG_FS_MBCACHE=y
@@ -1127,6 +1249,7 @@ CONFIG_FS_MBCACHE=y
 # CONFIG_JFS_FS is not set
 # CONFIG_FS_POSIX_ACL is not set
 # CONFIG_XFS_FS is not set
+# CONFIG_GFS2_FS is not set
 # CONFIG_OCFS2_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
@@ -1157,11 +1280,12 @@ CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
 # Pseudo filesystems
 #
 CONFIG_PROC_FS=y
+CONFIG_PROC_SYSCTL=y
 CONFIG_SYSFS=y
 CONFIG_TMPFS=y
+# CONFIG_TMPFS_POSIX_ACL is not set
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
-# CONFIG_RELAYFS_FS is not set
 # CONFIG_CONFIGFS_FS is not set
 
 #
@@ -1174,11 +1298,11 @@ CONFIG_RAMFS=y
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
-# CONFIG_JFFS_FS is not set
 CONFIG_JFFS2_FS=y
 CONFIG_JFFS2_FS_DEBUG=0
 CONFIG_JFFS2_FS_WRITEBUFFER=y
 CONFIG_JFFS2_SUMMARY=y
+# CONFIG_JFFS2_FS_XATTR is not set
 CONFIG_JFFS2_COMPRESSION_OPTIONS=y
 CONFIG_JFFS2_ZLIB=y
 CONFIG_JFFS2_RTIME=y
@@ -1282,6 +1406,11 @@ CONFIG_NLS_ISO8859_15=y
 CONFIG_NLS_UTF8=y
 
 #
+# Distributed Lock Manager
+#
+# CONFIG_DLM is not set
+
+#
 # Profiling support
 #
 # CONFIG_PROFILING is not set
@@ -1290,25 +1419,34 @@ CONFIG_NLS_UTF8=y
 # Kernel hacking
 #
 # CONFIG_PRINTK_TIME is not set
+CONFIG_ENABLE_MUST_CHECK=y
 CONFIG_MAGIC_SYSRQ=y
+# CONFIG_UNUSED_SYMBOLS is not set
+# CONFIG_DEBUG_FS is not set
+# CONFIG_HEADERS_CHECK is not set
 CONFIG_DEBUG_KERNEL=y
+# CONFIG_DEBUG_SHIRQ is not set
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_DETECT_SOFTLOCKUP=y
 # CONFIG_SCHEDSTATS is not set
+# CONFIG_TIMER_STATS is not set
 # CONFIG_DEBUG_SLAB is not set
-CONFIG_DEBUG_MUTEXES=y
+# CONFIG_DEBUG_RT_MUTEXES is not set
+# CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
+CONFIG_DEBUG_MUTEXES=y
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
 # CONFIG_DEBUG_KOBJECT is not set
 CONFIG_DEBUG_BUGVERBOSE=y
 # CONFIG_DEBUG_INFO is not set
-# CONFIG_DEBUG_FS is not set
 # CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_LIST is not set
 CONFIG_FRAME_POINTER=y
 CONFIG_FORCED_INLINING=y
 # CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_FAULT_INJECTION is not set
 # CONFIG_DEBUG_USER is not set
-# CONFIG_DEBUG_WAITQ is not set
 CONFIG_DEBUG_ERRORS=y
 # CONFIG_DEBUG_LL is not set
 
@@ -1320,7 +1458,6 @@ CONFIG_SECURITY=y
 # CONFIG_SECURITY_NETWORK is not set
 # CONFIG_SECURITY_CAPABILITIES is not set
 # CONFIG_SECURITY_ROOTPLUG is not set
-# CONFIG_SECURITY_SECLVL is not set
 
 #
 # Cryptographic options
@@ -1328,15 +1465,15 @@ CONFIG_SECURITY=y
 # CONFIG_CRYPTO is not set
 
 #
-# Hardware crypto devices
-#
-
-#
 # Library routines
 #
+CONFIG_BITREVERSE=y
 CONFIG_CRC_CCITT=y
 # CONFIG_CRC16 is not set
 CONFIG_CRC32=y
 # CONFIG_LIBCRC32C is not set
 CONFIG_ZLIB_INFLATE=y
 CONFIG_ZLIB_DEFLATE=y
+CONFIG_PLIST=y
+CONFIG_HAS_IOMEM=y
+CONFIG_HAS_IOPORT=y
-- 
1.5.0.rc3


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--IJpNTDwzlM2Ie8A6--
