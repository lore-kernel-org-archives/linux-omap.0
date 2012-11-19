From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH 270/493] arm: remove use of __devinit
Date: Mon, 19 Nov 2012 13:23:39 -0500
Message-ID: <1353349642-3677-270-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: Russell King <linux@arm.linux.org.uk>, Will Deacon <will.deacon@arm.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sascha Hauer <kernel@pengutronix.de>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, David Brown <davidb@codeaurora.org>, Daniel Walker <dwalker@fifo99.com>, Bryan Huntsman <bryanh@codeaurora.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Barry Song <baohua.song@csr.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, patches@opensource.wolfsonmicro.com, linux-tegra@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

CONFIG_HOTPLUG is going away as an option so __devinit is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Russell King <linux@arm.linux.org.uk> 
Cc: Will Deacon <will.deacon@arm.com> 
Cc: Jason Cooper <jason@lakedaemon.net> 
Cc: Andrew Lunn <andrew@lunn.ch> 
Cc: Sascha Hauer <kernel@pengutronix.de> 
Cc: Eric Miao <eric.y.miao@gmail.com> 
Cc: Haojian Zhuang <haojian.zhuang@gmail.com> 
Cc: David Brown <davidb@codeaurora.org> 
Cc: Daniel Walker <dwalker@fifo99.com> 
Cc: Bryan Huntsman <bryanh@codeaurora.org> 
Cc: Tony Lindgren <tony@atomide.com> 
Cc: Kevin Hilman <khilman@ti.com> 
Cc: Barry Song <baohua.song@csr.com> 
Cc: Ben Dooks <ben-linux@fluff.org> 
Cc: Kukjin Kim <kgene.kim@samsung.com> 
Cc: linux-arm-kernel@lists.infradead.org 
Cc: linux-arm-msm@vger.kernel.org 
Cc: linux-omap@vger.kernel.org 
Cc: linux-samsung-soc@vger.kernel.org 
Cc: patches@opensource.wolfsonmicro.com 
Cc: linux-tegra@vger.kernel.org 
---
 arch/arm/common/sa1111.c                     |  5 ++---
 arch/arm/common/scoop.c                      |  2 +-
 arch/arm/kernel/bios32.c                     | 16 ++++++++--------
 arch/arm/kernel/etm.c                        |  4 ++--
 arch/arm/kernel/perf_event_cpu.c             |  6 +++---
 arch/arm/kernel/perf_event_v6.c              |  4 ++--
 arch/arm/kernel/perf_event_v7.c              | 12 ++++++------
 arch/arm/kernel/perf_event_xscale.c          |  4 ++--
 arch/arm/mach-dove/pcie.c                    |  2 +-
 arch/arm/mach-imx/cpufreq.c                  |  2 +-
 arch/arm/mach-imx/mmdc.c                     |  2 +-
 arch/arm/mach-iop13xx/pci.c                  |  2 +-
 arch/arm/mach-kirkwood/pcie.c                |  2 +-
 arch/arm/mach-ks8695/board-acs5k.c           |  2 +-
 arch/arm/mach-mmp/sram.c                     |  2 +-
 arch/arm/mach-msm/proc_comm.c                |  2 +-
 arch/arm/mach-msm/smd.c                      |  2 +-
 arch/arm/mach-mv78xx0/pcie.c                 |  2 +-
 arch/arm/mach-omap1/mailbox.c                |  2 +-
 arch/arm/mach-omap2/gpmc.c                   |  4 ++--
 arch/arm/mach-omap2/mailbox.c                |  2 +-
 arch/arm/mach-orion5x/pci.c                  |  2 +-
 arch/arm/mach-prima2/pm.c                    |  2 +-
 arch/arm/mach-prima2/rtciobrg.c              |  2 +-
 arch/arm/mach-pxa/corgi_pm.c                 |  2 +-
 arch/arm/mach-pxa/sharpsl_pm.c               |  4 ++--
 arch/arm/mach-pxa/spitz_pm.c                 |  2 +-
 arch/arm/mach-s3c24xx/h1940-bluetooth.c      |  2 +-
 arch/arm/mach-s3c24xx/mach-osiris-dvs.c      |  2 +-
 arch/arm/mach-s3c64xx/mach-crag6410-module.c |  2 +-
 arch/arm/mach-sa1100/jornada720_ssp.c        |  2 +-
 arch/arm/mach-sa1100/neponset.c              |  2 +-
 arch/arm/mach-tegra/pcie.c                   |  6 +++---
 arch/arm/mach-tegra/tegra2_emc.c             |  4 ++--
 arch/arm/mach-u300/dummyspichip.c            |  2 +-
 arch/arm/plat-omap/dma.c                     |  2 +-
 arch/arm/plat-omap/dmtimer.c                 |  2 +-
 arch/arm/plat-pxa/ssp.c                      |  2 +-
 38 files changed, 61 insertions(+), 62 deletions(-)

diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index 9173d11..e57d7e5 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -686,8 +686,7 @@ sa1111_init_one_child(struct sa1111 *sachip, struct resource *parent,
  *	%-EINVAL	no platform data passed
  *	%0		successful.
  */
-static int __devinit
-__sa1111_probe(struct device *me, struct resource *mem, int irq)
+static int __sa1111_probe(struct device *me, struct resource *mem, int irq)
 {
 	struct sa1111_platform_data *pd = me->platform_data;
 	struct sa1111 *sachip;
@@ -1011,7 +1010,7 @@ static int sa1111_resume(struct platform_device *dev)
 #define sa1111_resume  NULL
 #endif
 
-static int __devinit sa1111_probe(struct platform_device *pdev)
+static int sa1111_probe(struct platform_device *pdev)
 {
 	struct resource *mem;
 	int irq;
diff --git a/arch/arm/common/scoop.c b/arch/arm/common/scoop.c
index 7cac8dd..2b62571 100644
--- a/arch/arm/common/scoop.c
+++ b/arch/arm/common/scoop.c
@@ -176,7 +176,7 @@ static int scoop_resume(struct platform_device *dev)
 #define scoop_resume	NULL
 #endif
 
-static int __devinit scoop_probe(struct platform_device *pdev)
+static int scoop_probe(struct platform_device *pdev)
 {
 	struct scoop_dev *devptr;
 	struct scoop_config *inf;
diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index f136307..7e25c18 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -78,7 +78,7 @@ void pcibios_report_status(u_int status_mask, int warn)
  * Bug 3 is responsible for the sound DMA grinding to a halt.  We now
  * live with bug 2.
  */
-static void __devinit pci_fixup_83c553(struct pci_dev *dev)
+static void pci_fixup_83c553(struct pci_dev *dev)
 {
 	/*
 	 * Set memory region to start at address 0, and enable IO
@@ -130,7 +130,7 @@ static void __devinit pci_fixup_83c553(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_WINBOND, PCI_DEVICE_ID_WINBOND_83C553, pci_fixup_83c553);
 
-static void __devinit pci_fixup_unassign(struct pci_dev *dev)
+static void pci_fixup_unassign(struct pci_dev *dev)
 {
 	dev->resource[0].end -= dev->resource[0].start;
 	dev->resource[0].start = 0;
@@ -142,7 +142,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_WINBOND2, PCI_DEVICE_ID_WINBOND2_89C940F,
  * if it is the host bridge by marking it as such.  These resources are of
  * no consequence to the PCI layer (they are handled elsewhere).
  */
-static void __devinit pci_fixup_dec21285(struct pci_dev *dev)
+static void pci_fixup_dec21285(struct pci_dev *dev)
 {
 	int i;
 
@@ -161,7 +161,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_DEC, PCI_DEVICE_ID_DEC_21285, pci_fixup_d
 /*
  * PCI IDE controllers use non-standard I/O port decoding, respect it.
  */
-static void __devinit pci_fixup_ide_bases(struct pci_dev *dev)
+static void pci_fixup_ide_bases(struct pci_dev *dev)
 {
 	struct resource *r;
 	int i;
@@ -182,7 +182,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pci_fixup_ide_bases);
 /*
  * Put the DEC21142 to sleep
  */
-static void __devinit pci_fixup_dec21142(struct pci_dev *dev)
+static void pci_fixup_dec21142(struct pci_dev *dev)
 {
 	pci_write_config_dword(dev, 0x40, 0x80000000);
 }
@@ -204,7 +204,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_DEC, PCI_DEVICE_ID_DEC_21142, pci_fixup_d
  * functional.  However, The CY82C693U _does not work_ in bus
  * master mode without locking the PCI bus solid.
  */
-static void __devinit pci_fixup_cy82c693(struct pci_dev *dev)
+static void pci_fixup_cy82c693(struct pci_dev *dev)
 {
 	if ((dev->class >> 8) == PCI_CLASS_STORAGE_IDE) {
 		u32 base0, base1;
@@ -254,7 +254,7 @@ static void __devinit pci_fixup_cy82c693(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_CONTAQ, PCI_DEVICE_ID_CONTAQ_82C693, pci_fixup_cy82c693);
 
-static void __devinit pci_fixup_it8152(struct pci_dev *dev)
+static void pci_fixup_it8152(struct pci_dev *dev)
 {
 	int i;
 	/* fixup for ITE 8152 devices */
@@ -380,7 +380,7 @@ EXPORT_SYMBOL(pcibios_fixup_bus);
  * PCI standard swizzle is implemented on plug-in cards and Cardbus based
  * PCI extenders, so it can not be ignored.
  */
-static u8 __devinit pcibios_swizzle(struct pci_dev *dev, u8 *pin)
+static u8 pcibios_swizzle(struct pci_dev *dev, u8 *pin)
 {
 	struct pci_sys_data *sys = dev->sysdata;
 	int slot, oldpin = *pin;
diff --git a/arch/arm/kernel/etm.c b/arch/arm/kernel/etm.c
index 36d20bd..9b6de8c 100644
--- a/arch/arm/kernel/etm.c
+++ b/arch/arm/kernel/etm.c
@@ -339,7 +339,7 @@ static struct miscdevice etb_miscdev = {
 	.fops = &etb_fops,
 };
 
-static int __devinit etb_probe(struct amba_device *dev, const struct amba_id *id)
+static int etb_probe(struct amba_device *dev, const struct amba_id *id)
 {
 	struct tracectx *t = &tracer;
 	int ret = 0;
@@ -531,7 +531,7 @@ static ssize_t trace_mode_store(struct kobject *kobj,
 static struct kobj_attribute trace_mode_attr =
 	__ATTR(trace_mode, 0644, trace_mode_show, trace_mode_store);
 
-static int __devinit etm_probe(struct amba_device *dev, const struct amba_id *id)
+static int etm_probe(struct amba_device *dev, const struct amba_id *id)
 {
 	struct tracectx *t = &tracer;
 	int ret = 0;
diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
index 9a4f630..cfc2728 100644
--- a/arch/arm/kernel/perf_event_cpu.c
+++ b/arch/arm/kernel/perf_event_cpu.c
@@ -132,7 +132,7 @@ static int cpu_pmu_request_irq(struct arm_pmu *cpu_pmu, irq_handler_t handler)
 	return 0;
 }
 
-static void __devinit cpu_pmu_init(struct arm_pmu *cpu_pmu)
+static void cpu_pmu_init(struct arm_pmu *cpu_pmu)
 {
 	int cpu;
 	for_each_possible_cpu(cpu) {
@@ -198,7 +198,7 @@ static struct platform_device_id __devinitdata cpu_pmu_plat_device_ids[] = {
 /*
  * CPU PMU identification and probing.
  */
-static int __devinit probe_current_pmu(struct arm_pmu *pmu)
+static int probe_current_pmu(struct arm_pmu *pmu)
 {
 	int cpu = get_cpu();
 	unsigned long cpuid = read_cpuid_id();
@@ -252,7 +252,7 @@ static int __devinit probe_current_pmu(struct arm_pmu *pmu)
 	return ret;
 }
 
-static int __devinit cpu_pmu_device_probe(struct platform_device *pdev)
+static int cpu_pmu_device_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *of_id;
 	int (*init_fn)(struct arm_pmu *);
diff --git a/arch/arm/kernel/perf_event_v6.c b/arch/arm/kernel/perf_event_v6.c
index f3e22ff..041d052 100644
--- a/arch/arm/kernel/perf_event_v6.c
+++ b/arch/arm/kernel/perf_event_v6.c
@@ -653,7 +653,7 @@ static int armv6_map_event(struct perf_event *event)
 				&armv6_perf_cache_map, 0xFF);
 }
 
-static int __devinit armv6pmu_init(struct arm_pmu *cpu_pmu)
+static int armv6pmu_init(struct arm_pmu *cpu_pmu)
 {
 	cpu_pmu->name		= "v6";
 	cpu_pmu->handle_irq	= armv6pmu_handle_irq;
@@ -685,7 +685,7 @@ static int armv6mpcore_map_event(struct perf_event *event)
 				&armv6mpcore_perf_cache_map, 0xFF);
 }
 
-static int __devinit armv6mpcore_pmu_init(struct arm_pmu *cpu_pmu)
+static int armv6mpcore_pmu_init(struct arm_pmu *cpu_pmu)
 {
 	cpu_pmu->name		= "v6mpcore";
 	cpu_pmu->handle_irq	= armv6pmu_handle_irq;
diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index 7d0cce8..4fbc757 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -1226,7 +1226,7 @@ static void armv7pmu_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->max_period	= (1LLU << 32) - 1;
 };
 
-static u32 __devinit armv7_read_num_pmnc_events(void)
+static u32 armv7_read_num_pmnc_events(void)
 {
 	u32 nb_cnt;
 
@@ -1237,7 +1237,7 @@ static u32 __devinit armv7_read_num_pmnc_events(void)
 	return nb_cnt + 1;
 }
 
-static int __devinit armv7_a8_pmu_init(struct arm_pmu *cpu_pmu)
+static int armv7_a8_pmu_init(struct arm_pmu *cpu_pmu)
 {
 	armv7pmu_init(cpu_pmu);
 	cpu_pmu->name		= "ARMv7 Cortex-A8";
@@ -1246,7 +1246,7 @@ static int __devinit armv7_a8_pmu_init(struct arm_pmu *cpu_pmu)
 	return 0;
 }
 
-static int __devinit armv7_a9_pmu_init(struct arm_pmu *cpu_pmu)
+static int armv7_a9_pmu_init(struct arm_pmu *cpu_pmu)
 {
 	armv7pmu_init(cpu_pmu);
 	cpu_pmu->name		= "ARMv7 Cortex-A9";
@@ -1255,7 +1255,7 @@ static int __devinit armv7_a9_pmu_init(struct arm_pmu *cpu_pmu)
 	return 0;
 }
 
-static int __devinit armv7_a5_pmu_init(struct arm_pmu *cpu_pmu)
+static int armv7_a5_pmu_init(struct arm_pmu *cpu_pmu)
 {
 	armv7pmu_init(cpu_pmu);
 	cpu_pmu->name		= "ARMv7 Cortex-A5";
@@ -1264,7 +1264,7 @@ static int __devinit armv7_a5_pmu_init(struct arm_pmu *cpu_pmu)
 	return 0;
 }
 
-static int __devinit armv7_a15_pmu_init(struct arm_pmu *cpu_pmu)
+static int armv7_a15_pmu_init(struct arm_pmu *cpu_pmu)
 {
 	armv7pmu_init(cpu_pmu);
 	cpu_pmu->name		= "ARMv7 Cortex-A15";
@@ -1274,7 +1274,7 @@ static int __devinit armv7_a15_pmu_init(struct arm_pmu *cpu_pmu)
 	return 0;
 }
 
-static int __devinit armv7_a7_pmu_init(struct arm_pmu *cpu_pmu)
+static int armv7_a7_pmu_init(struct arm_pmu *cpu_pmu)
 {
 	armv7pmu_init(cpu_pmu);
 	cpu_pmu->name		= "ARMv7 Cortex-A7";
diff --git a/arch/arm/kernel/perf_event_xscale.c b/arch/arm/kernel/perf_event_xscale.c
index 0c8265e..2b0fe30 100644
--- a/arch/arm/kernel/perf_event_xscale.c
+++ b/arch/arm/kernel/perf_event_xscale.c
@@ -440,7 +440,7 @@ static int xscale_map_event(struct perf_event *event)
 				&xscale_perf_cache_map, 0xFF);
 }
 
-static int __devinit xscale1pmu_init(struct arm_pmu *cpu_pmu)
+static int xscale1pmu_init(struct arm_pmu *cpu_pmu)
 {
 	cpu_pmu->name		= "xscale1";
 	cpu_pmu->handle_irq	= xscale1pmu_handle_irq;
@@ -810,7 +810,7 @@ static inline void xscale2pmu_write_counter(struct perf_event *event, u32 val)
 	}
 }
 
-static int __devinit xscale2pmu_init(struct arm_pmu *cpu_pmu)
+static int xscale2pmu_init(struct arm_pmu *cpu_pmu)
 {
 	cpu_pmu->name		= "xscale2";
 	cpu_pmu->handle_irq	= xscale2pmu_handle_irq;
diff --git a/arch/arm/mach-dove/pcie.c b/arch/arm/mach-dove/pcie.c
index 0ef4435..8a275f2 100644
--- a/arch/arm/mach-dove/pcie.c
+++ b/arch/arm/mach-dove/pcie.c
@@ -135,7 +135,7 @@ static struct pci_ops pcie_ops = {
 	.write = pcie_wr_conf,
 };
 
-static void __devinit rc_pci_fixup(struct pci_dev *dev)
+static void rc_pci_fixup(struct pci_dev *dev)
 {
 	/*
 	 * Prevent enumeration of root complex.
diff --git a/arch/arm/mach-imx/cpufreq.c b/arch/arm/mach-imx/cpufreq.c
index 36e8b39..d8c75c3 100644
--- a/arch/arm/mach-imx/cpufreq.c
+++ b/arch/arm/mach-imx/cpufreq.c
@@ -188,7 +188,7 @@ static struct cpufreq_driver mxc_driver = {
 	.name = "imx",
 };
 
-static int __devinit mxc_cpufreq_driver_init(void)
+static int mxc_cpufreq_driver_init(void)
 {
 	return cpufreq_register_driver(&mxc_driver);
 }
diff --git a/arch/arm/mach-imx/mmdc.c b/arch/arm/mach-imx/mmdc.c
index c461e98..7a9686a 100644
--- a/arch/arm/mach-imx/mmdc.c
+++ b/arch/arm/mach-imx/mmdc.c
@@ -21,7 +21,7 @@
 #define BP_MMDC_MAPSR_PSD	0
 #define BP_MMDC_MAPSR_PSS	4
 
-static int __devinit imx_mmdc_probe(struct platform_device *pdev)
+static int imx_mmdc_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	void __iomem *mmdc_base, *reg;
diff --git a/arch/arm/mach-iop13xx/pci.c b/arch/arm/mach-iop13xx/pci.c
index 2f28018..9082b84 100644
--- a/arch/arm/mach-iop13xx/pci.c
+++ b/arch/arm/mach-iop13xx/pci.c
@@ -504,7 +504,7 @@ iop13xx_pci_abort(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 
 /* Scan an IOP13XX PCI bus.  nr selects which ATU we use.
  */
-struct pci_bus * __devinit iop13xx_scan_bus(int nr, struct pci_sys_data *sys)
+struct pci_bus *iop13xx_scan_bus(int nr, struct pci_sys_data *sys)
 {
 	int which_atu;
 	struct pci_bus *bus = NULL;
diff --git a/arch/arm/mach-kirkwood/pcie.c b/arch/arm/mach-kirkwood/pcie.c
index ec54491..3b65cae 100644
--- a/arch/arm/mach-kirkwood/pcie.c
+++ b/arch/arm/mach-kirkwood/pcie.c
@@ -207,7 +207,7 @@ static int __init kirkwood_pcie_setup(int nr, struct pci_sys_data *sys)
 	return 1;
 }
 
-static void __devinit rc_pci_fixup(struct pci_dev *dev)
+static void rc_pci_fixup(struct pci_dev *dev)
 {
 	/*
 	 * Prevent enumeration of root complex.
diff --git a/arch/arm/mach-ks8695/board-acs5k.c b/arch/arm/mach-ks8695/board-acs5k.c
index 255502d..b0c306c 100644
--- a/arch/arm/mach-ks8695/board-acs5k.c
+++ b/arch/arm/mach-ks8695/board-acs5k.c
@@ -92,7 +92,7 @@ static struct i2c_board_info acs5k_i2c_devs[] __initdata = {
 	},
 };
 
-static void __devinit acs5k_i2c_init(void)
+static void acs5k_i2c_init(void)
 {
 	/* The gpio interface */
 	platform_device_register(&acs5k_i2c_device);
diff --git a/arch/arm/mach-mmp/sram.c b/arch/arm/mach-mmp/sram.c
index a6c08ed..7e5765b 100644
--- a/arch/arm/mach-mmp/sram.c
+++ b/arch/arm/mach-mmp/sram.c
@@ -61,7 +61,7 @@ struct gen_pool *sram_get_gpool(char *pool_name)
 }
 EXPORT_SYMBOL(sram_get_gpool);
 
-static int __devinit sram_probe(struct platform_device *pdev)
+static int sram_probe(struct platform_device *pdev)
 {
 	struct sram_platdata *pdata = pdev->dev.platform_data;
 	struct sram_bank_info *info;
diff --git a/arch/arm/mach-msm/proc_comm.c b/arch/arm/mach-msm/proc_comm.c
index 8f1eecd..507f5ca 100644
--- a/arch/arm/mach-msm/proc_comm.c
+++ b/arch/arm/mach-msm/proc_comm.c
@@ -120,7 +120,7 @@ int msm_proc_comm(unsigned cmd, unsigned *data1, unsigned *data2)
  * and unknown state. This function should be called early to
  * wait on the ARM9.
  */
-void __devinit proc_comm_boot_wait(void)
+void proc_comm_boot_wait(void)
 {
 	void __iomem *base = MSM_SHARED_RAM_BASE;
  
diff --git a/arch/arm/mach-msm/smd.c b/arch/arm/mach-msm/smd.c
index c5a2edd..b1588a1 100644
--- a/arch/arm/mach-msm/smd.c
+++ b/arch/arm/mach-msm/smd.c
@@ -988,7 +988,7 @@ int smd_core_init(void)
 	return 0;
 }
 
-static int __devinit msm_smd_probe(struct platform_device *pdev)
+static int msm_smd_probe(struct platform_device *pdev)
 {
 	/*
 	 * If we haven't waited for the ARM9 to boot up till now,
diff --git a/arch/arm/mach-mv78xx0/pcie.c b/arch/arm/mach-mv78xx0/pcie.c
index a9a154a..ee8c0b5 100644
--- a/arch/arm/mach-mv78xx0/pcie.c
+++ b/arch/arm/mach-mv78xx0/pcie.c
@@ -173,7 +173,7 @@ static struct pci_ops pcie_ops = {
 	.write = pcie_wr_conf,
 };
 
-static void __devinit rc_pci_fixup(struct pci_dev *dev)
+static void rc_pci_fixup(struct pci_dev *dev)
 {
 	/*
 	 * Prevent enumeration of root complex.
diff --git a/arch/arm/mach-omap1/mailbox.c b/arch/arm/mach-omap1/mailbox.c
index e7e1f2a..f2109dd 100644
--- a/arch/arm/mach-omap1/mailbox.c
+++ b/arch/arm/mach-omap1/mailbox.c
@@ -142,7 +142,7 @@ static struct omap_mbox mbox_dsp_info = {
 
 static struct omap_mbox *omap1_mboxes[] = { &mbox_dsp_info, NULL };
 
-static int __devinit omap1_mbox_probe(struct platform_device *pdev)
+static int omap1_mbox_probe(struct platform_device *pdev)
 {
 	struct resource *mem;
 	int ret;
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index b4226a4..2fc3dd4 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -714,7 +714,7 @@ static void __devexit gpmc_mem_exit(void)
 
 }
 
-static int __devinit gpmc_mem_init(void)
+static int gpmc_mem_init(void)
 {
 	int cs, rc;
 	unsigned long boot_rom_space = 0;
@@ -748,7 +748,7 @@ static int __devinit gpmc_mem_init(void)
 	return 0;
 }
 
-static __devinit int gpmc_probe(struct platform_device *pdev)
+static int gpmc_probe(struct platform_device *pdev)
 {
 	int rc;
 	u32 l;
diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 64308f4..1e48d5e 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -342,7 +342,7 @@ struct omap_mbox mbox_2_info = {
 struct omap_mbox *omap4_mboxes[] = { &mbox_1_info, &mbox_2_info, NULL };
 #endif
 
-static int __devinit omap2_mbox_probe(struct platform_device *pdev)
+static int omap2_mbox_probe(struct platform_device *pdev)
 {
 	struct resource *mem;
 	int ret;
diff --git a/arch/arm/mach-orion5x/pci.c b/arch/arm/mach-orion5x/pci.c
index cd50e32..d9c7c3b 100644
--- a/arch/arm/mach-orion5x/pci.c
+++ b/arch/arm/mach-orion5x/pci.c
@@ -506,7 +506,7 @@ static int __init pci_setup(struct pci_sys_data *sys)
 /*****************************************************************************
  * General PCIe + PCI
  ****************************************************************************/
-static void __devinit rc_pci_fixup(struct pci_dev *dev)
+static void rc_pci_fixup(struct pci_dev *dev)
 {
 	/*
 	 * Prevent enumeration of root complex.
diff --git a/arch/arm/mach-prima2/pm.c b/arch/arm/mach-prima2/pm.c
index fb5a791..9936c18 100644
--- a/arch/arm/mach-prima2/pm.c
+++ b/arch/arm/mach-prima2/pm.c
@@ -123,7 +123,7 @@ static const struct of_device_id memc_ids[] = {
 	{}
 };
 
-static int __devinit sirfsoc_memc_probe(struct platform_device *op)
+static int sirfsoc_memc_probe(struct platform_device *op)
 {
 	struct device_node *np = op->dev.of_node;
 
diff --git a/arch/arm/mach-prima2/rtciobrg.c b/arch/arm/mach-prima2/rtciobrg.c
index 9d80f1e..5573536 100644
--- a/arch/arm/mach-prima2/rtciobrg.c
+++ b/arch/arm/mach-prima2/rtciobrg.c
@@ -107,7 +107,7 @@ static const struct of_device_id rtciobrg_ids[] = {
 	{}
 };
 
-static int __devinit sirfsoc_rtciobrg_probe(struct platform_device *op)
+static int sirfsoc_rtciobrg_probe(struct platform_device *op)
 {
 	struct device_node *np = op->dev.of_node;
 
diff --git a/arch/arm/mach-pxa/corgi_pm.c b/arch/arm/mach-pxa/corgi_pm.c
index 048c429..7a39efc 100644
--- a/arch/arm/mach-pxa/corgi_pm.c
+++ b/arch/arm/mach-pxa/corgi_pm.c
@@ -198,7 +198,7 @@ static struct sharpsl_charger_machinfo corgi_pm_machinfo = {
 
 static struct platform_device *corgipm_device;
 
-static int __devinit corgipm_init(void)
+static int corgipm_init(void)
 {
 	int ret;
 
diff --git a/arch/arm/mach-pxa/sharpsl_pm.c b/arch/arm/mach-pxa/sharpsl_pm.c
index ec55c57..0a36d35 100644
--- a/arch/arm/mach-pxa/sharpsl_pm.c
+++ b/arch/arm/mach-pxa/sharpsl_pm.c
@@ -829,7 +829,7 @@ static const struct platform_suspend_ops sharpsl_pm_ops = {
 };
 #endif
 
-static int __devinit sharpsl_pm_probe(struct platform_device *pdev)
+static int sharpsl_pm_probe(struct platform_device *pdev)
 {
 	int ret, irq;
 
@@ -941,7 +941,7 @@ static struct platform_driver sharpsl_pm_driver = {
 	},
 };
 
-static int __devinit sharpsl_pm_init(void)
+static int sharpsl_pm_init(void)
 {
 	return platform_driver_register(&sharpsl_pm_driver);
 }
diff --git a/arch/arm/mach-pxa/spitz_pm.c b/arch/arm/mach-pxa/spitz_pm.c
index 842596d..e191f99 100644
--- a/arch/arm/mach-pxa/spitz_pm.c
+++ b/arch/arm/mach-pxa/spitz_pm.c
@@ -232,7 +232,7 @@ struct sharpsl_charger_machinfo spitz_pm_machinfo = {
 
 static struct platform_device *spitzpm_device;
 
-static int __devinit spitzpm_init(void)
+static int spitzpm_init(void)
 {
 	int ret;
 
diff --git a/arch/arm/mach-s3c24xx/h1940-bluetooth.c b/arch/arm/mach-s3c24xx/h1940-bluetooth.c
index 57aee91..3f40c61 100644
--- a/arch/arm/mach-s3c24xx/h1940-bluetooth.c
+++ b/arch/arm/mach-s3c24xx/h1940-bluetooth.c
@@ -62,7 +62,7 @@ static const struct rfkill_ops h1940bt_rfkill_ops = {
 	.set_block = h1940bt_set_block,
 };
 
-static int __devinit h1940bt_probe(struct platform_device *pdev)
+static int h1940bt_probe(struct platform_device *pdev)
 {
 	struct rfkill *rfk;
 	int ret = 0;
diff --git a/arch/arm/mach-s3c24xx/mach-osiris-dvs.c b/arch/arm/mach-s3c24xx/mach-osiris-dvs.c
index b7b712b..08bd8fc 100644
--- a/arch/arm/mach-s3c24xx/mach-osiris-dvs.c
+++ b/arch/arm/mach-s3c24xx/mach-osiris-dvs.c
@@ -93,7 +93,7 @@ static struct notifier_block osiris_dvs_nb = {
 	.notifier_call	= osiris_dvs_notify,
 };
 
-static int __devinit osiris_dvs_probe(struct platform_device *pdev)
+static int osiris_dvs_probe(struct platform_device *pdev)
 {
 	int ret;
 
diff --git a/arch/arm/mach-s3c64xx/mach-crag6410-module.c b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
index c6d8dba..b4f7600c 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410-module.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
@@ -343,7 +343,7 @@ static __devinitdata const struct {
 	  .i2c_devs = wm2200_i2c, .num_i2c_devs = ARRAY_SIZE(wm2200_i2c) },
 };
 
-static __devinit int wlf_gf_module_probe(struct i2c_client *i2c,
+static int wlf_gf_module_probe(struct i2c_client *i2c,
 					 const struct i2c_device_id *i2c_id)
 {
 	int ret, i, j, id, rev;
diff --git a/arch/arm/mach-sa1100/jornada720_ssp.c b/arch/arm/mach-sa1100/jornada720_ssp.c
index 7f07f08..b143c46 100644
--- a/arch/arm/mach-sa1100/jornada720_ssp.c
+++ b/arch/arm/mach-sa1100/jornada720_ssp.c
@@ -130,7 +130,7 @@ void jornada_ssp_end(void)
 };
 EXPORT_SYMBOL(jornada_ssp_end);
 
-static int __devinit jornada_ssp_probe(struct platform_device *dev)
+static int jornada_ssp_probe(struct platform_device *dev)
 {
 	int ret;
 
diff --git a/arch/arm/mach-sa1100/neponset.c b/arch/arm/mach-sa1100/neponset.c
index c408b8b..a039b54 100644
--- a/arch/arm/mach-sa1100/neponset.c
+++ b/arch/arm/mach-sa1100/neponset.c
@@ -233,7 +233,7 @@ static struct sa1111_platform_data sa1111_info = {
 	.disable_devs	= SA1111_DEVID_PS2_MSE,
 };
 
-static int __devinit neponset_probe(struct platform_device *dev)
+static int neponset_probe(struct platform_device *dev)
 {
 	struct neponset_drvdata *d;
 	struct resource *nep_res, *sa1111_res, *smc91x_res;
diff --git a/arch/arm/mach-tegra/pcie.c b/arch/arm/mach-tegra/pcie.c
index 53d0858..bffcd64 100644
--- a/arch/arm/mach-tegra/pcie.c
+++ b/arch/arm/mach-tegra/pcie.c
@@ -331,7 +331,7 @@ static struct pci_ops tegra_pcie_ops = {
 	.write	= tegra_pcie_write_conf,
 };
 
-static void __devinit tegra_pcie_fixup_bridge(struct pci_dev *dev)
+static void tegra_pcie_fixup_bridge(struct pci_dev *dev)
 {
 	u16 reg;
 
@@ -345,7 +345,7 @@ static void __devinit tegra_pcie_fixup_bridge(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, tegra_pcie_fixup_bridge);
 
 /* Tegra PCIE root complex wrongly reports device class */
-static void __devinit tegra_pcie_fixup_class(struct pci_dev *dev)
+static void tegra_pcie_fixup_class(struct pci_dev *dev)
 {
 	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
 }
@@ -353,7 +353,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0bf0, tegra_pcie_fixup_class);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0bf1, tegra_pcie_fixup_class);
 
 /* Tegra PCIE requires relaxed ordering */
-static void __devinit tegra_pcie_relax_enable(struct pci_dev *dev)
+static void tegra_pcie_relax_enable(struct pci_dev *dev)
 {
 	pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_RELAX_EN);
 }
diff --git a/arch/arm/mach-tegra/tegra2_emc.c b/arch/arm/mach-tegra/tegra2_emc.c
index 837c7b9..30f40de 100644
--- a/arch/arm/mach-tegra/tegra2_emc.c
+++ b/arch/arm/mach-tegra/tegra2_emc.c
@@ -268,7 +268,7 @@ static struct tegra_emc_pdata *tegra_emc_dt_parse_pdata(
 }
 #endif
 
-static struct tegra_emc_pdata __devinit *tegra_emc_fill_pdata(struct platform_device *pdev)
+static struct tegra_emc_pdata *tegra_emc_fill_pdata(struct platform_device *pdev)
 {
 	struct clk *c = clk_get_sys(NULL, "emc");
 	struct tegra_emc_pdata *pdata;
@@ -296,7 +296,7 @@ static struct tegra_emc_pdata __devinit *tegra_emc_fill_pdata(struct platform_de
 	return pdata;
 }
 
-static int __devinit tegra_emc_probe(struct platform_device *pdev)
+static int tegra_emc_probe(struct platform_device *pdev)
 {
 	struct tegra_emc_pdata *pdata;
 	struct resource *res;
diff --git a/arch/arm/mach-u300/dummyspichip.c b/arch/arm/mach-u300/dummyspichip.c
index 7c06188..f7a2a92 100644
--- a/arch/arm/mach-u300/dummyspichip.c
+++ b/arch/arm/mach-u300/dummyspichip.c
@@ -222,7 +222,7 @@ static ssize_t dummy_looptest(struct device *dev,
 
 static DEVICE_ATTR(looptest, S_IRUGO, dummy_looptest, NULL);
 
-static int __devinit pl022_dummy_probe(struct spi_device *spi)
+static int pl022_dummy_probe(struct spi_device *spi)
 {
 	struct dummy *p_dummy;
 	int status;
diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 3317867..d33e814 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -2000,7 +2000,7 @@ void omap_dma_global_context_restore(void)
 			omap_clear_dma(ch);
 }
 
-static int __devinit omap_system_dma_probe(struct platform_device *pdev)
+static int omap_system_dma_probe(struct platform_device *pdev)
 {
 	int ch, ret = 0;
 	int dma_irq;
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 4a40f25..97903e9 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -688,7 +688,7 @@ EXPORT_SYMBOL_GPL(omap_dm_timers_active);
  * Called by driver framework at the end of device registration for all
  * timer devices.
  */
-static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
+static int omap_dm_timer_probe(struct platform_device *pdev)
 {
 	unsigned long flags;
 	struct omap_dm_timer *timer;
diff --git a/arch/arm/plat-pxa/ssp.c b/arch/arm/plat-pxa/ssp.c
index def0648..caa33eb 100644
--- a/arch/arm/plat-pxa/ssp.c
+++ b/arch/arm/plat-pxa/ssp.c
@@ -72,7 +72,7 @@ void pxa_ssp_free(struct ssp_device *ssp)
 }
 EXPORT_SYMBOL(pxa_ssp_free);
 
-static int __devinit pxa_ssp_probe(struct platform_device *pdev)
+static int pxa_ssp_probe(struct platform_device *pdev)
 {
 	const struct platform_device_id *id = platform_get_device_id(pdev);
 	struct resource *res;
-- 
1.8.0
