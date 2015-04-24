From: Jack Mitchell <ml@communistcode.co.uk>
Subject: Enabling IPU on OMAP44xx
Date: Fri, 24 Apr 2015 17:21:20 +0100
Message-ID: <553A6D80.1080307@communistcode.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040202000908000405010004"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from eumx.net ([91.82.101.43]:58128 "EHLO owm.eumx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753565AbbDXROD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Apr 2015 13:14:03 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------040202000908000405010004
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

I've been fighting for a week with trying to get the IPU booted over 
remoteproc on an OMAP4470. I feel like I've got most of the way there 
but I don't get a response from the first kick after boot. Has anyone 
ever had the IPU booted on mainline? Dmesg from remoteproce boot is as 
below:

[   47.430084]  remoteproc0: ipu_c0 is available
[   47.431274]  remoteproc0: Note: remoteproc is still under development 
and considered experimental.
[   47.445312]  remoteproc0: THE BINARY FORMAT IS NOT YET FINALIZED, and 
backward compatibility isn't yet guaranteed.
[   47.869476]  remoteproc0: unsupported resource 5
[   47.876831]  remoteproc0: registered virtio0 (type 7)
[   47.882385]  remoteproc0: unsupported resource 5
[   47.888244] cma: cma_alloc(cma c1211f98, count 3, align 2)
[   47.897613] cma: cma_alloc(): returned deda7990
[   47.902465] cma: cma_alloc(cma c1211f98, count 3, align 2)
[   47.908813] cma: cma_alloc(): returned deda7a20
[   47.913604]  remoteproc0: powering up ipu_c0
[   47.967895]  remoteproc0: Booting fw image ducati-m3-core0.xem3, size 
14862876
[   47.983947] omap-iommu 55082000.mmu: 55082000.mmu: version 2.1
[   47.990112] cma: cma_alloc(cma c1211f98, count 1536, align 8)
[   47.997894] cma: cma_alloc(): returned deda9400
[   48.022949] cma: cma_alloc(cma c1211f98, count 58880, align 8)
[   48.047454] cma: cma_alloc(): returned dedb6c00
[   48.762756] cma: cma_alloc(cma c1211f98, count 256, align 8)
[   48.769165] cma: cma_alloc(): returned defbc400
[   48.779113]  remoteproc0: unsupported resource 5
[   48.887756] omap-rproc omap-rproc.1: JACK1
[   48.893157] omap-rproc omap-rproc.1: JACK2
[   48.893157] omap-rproc omap-rproc.1: JACK3
[   48.901794] omap-rproc omap-rproc.1: JACK4
[   48.906097]  remoteproc0: remote processor ipu_c0 is now up
[   48.912231] cma: cma_alloc(cma c1211f98, count 64, align 6)
[   48.922851] cma: cma_alloc(): returned deda8200
[   48.929321] virtio_rpmsg_bus virtio0: rpmsg host is online

What I would expect next (as is the case on my 3.4 TI vendor kernel) is 
something like:

[   13.647338] virtio_rpmsg_bus virtio0: rpmsg host is online
[   15.996520] omap-rproc omap-rproc.1: received echo reply from ipu_c0
[   15.996887] virtio_rpmsg_bus virtio0: creating channel rpmsg-dce addr 
0x2a
[   16.000335] virtio_rpmsg_bus virtio0: creating channel rpmsg-omx1 
addr 0x3c
[   16.000732] rpmsg_omx rpmsg-omx1: new OMX connection srv channel: 
1025 -> 60!
[   16.000915] virtio_rpmsg_bus virtio0: creating channel omaprpc addr 0x3b

I imagine the echo reply is remoteproc, but the other stuff is maybe 
omapdce?

The patch that I've hacked together to get this far is attached. I had 
to comment out some of the zero checking parts as it was failing, saying 
that the reserved memory was not zeroed; could this be the iommu that 
isn't translating properly?

Any input at all on the subject would be much appreciated!

Cheers,
Jack.

--------------040202000908000405010004
Content-Type: text/x-patch;
 name="ipu_rproc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ipu_rproc.patch"

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index f5e68a7..b628498 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -4792,7 +4792,7 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp_ifs[] __initdata = {
 	&omap44xx_l4_per__i2c4,
 	&omap44xx_l3_main_2__ipu,
 	&omap44xx_l3_main_2__iss,
-	/* &omap44xx_iva__sl2if, */
+	&omap44xx_iva__sl2if,
 	&omap44xx_l3_main_2__iva,
 	&omap44xx_l4_wkup__kbd,
 	&omap44xx_l4_cfg__mailbox,
diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index af11511..ad4eacf 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -14,9 +14,11 @@
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
 #include <linux/ti_wilink_st.h>
+#include <linux/dma-contiguous.h>
 
 #include <linux/platform_data/pinctrl-single.h>
 #include <linux/platform_data/iommu-omap.h>
+#include <linux/platform_data/remoteproc-omap.h>
 
 #include "common.h"
 #include "common-board-devices.h"
@@ -243,6 +245,55 @@ static void __init nokia_n900_legacy_init(void)
 	}
 }
 
+static struct platform_device omap4_ducati = {
+        .name   = "omap-rproc",
+        .id     = 1,
+};
+
+static struct omap_rproc_pdata omap4_rproc_data[] = {
+        {
+                .name           = "ipu_c0",
+                .firmware       = "ducati-m3-core0.xem3",
+                .mbox_name      = "mbox_ipu",
+                .oh_name        = "ipu",
+                .oh_name_opt    = "iss",
+                .set_bootaddr   = omap_ctrl_write_dsp_boot_addr,
+		.device_enable  = omap_device_enable,
+        },
+};
+
+static struct omap_iommu_arch_data omap4_ipu_iommu = {
+        .name = "55082000.mmu",
+};
+
+static void __init custboard_legacy_init(void)
+{
+	omap4_ducati.dev.archdata.iommu = &omap4_ipu_iommu;
+	platform_device_register(&omap4_ducati);
+
+	platform_device_add_data(&omap4_ducati,
+                                 &omap4_rproc_data,
+                                 sizeof(struct omap_rproc_pdata));
+
+}
+
 static void __init omap3_tao3530_legacy_init(void)
 {
 	hsmmc2_internal_input_clk();
@@ -361,6 +412,9 @@ static struct pdata_init pdata_quirks[] __initdata = {
 	{ "technexion,omap3-tao3530", omap3_tao3530_legacy_init, },
 #endif
 #ifdef CONFIG_SOC_OMAP5
+	{ "company,board", custboard_legacy_init, },
+#endif
+#ifdef CONFIG_SOC_OMAP5
 	{ "ti,omap5-uevm", omap5_uevm_legacy_init, },
 #endif
 	{ /* sentinel */ },

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index a3d6138..1e445c5 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -276,10 +276,10 @@ rproc_parse_vring(struct rproc_vdev *rvdev, struct fw_rsc_vdev *rsc, int i)
 				i, vring->da, vring->num, vring->align);
 
 	/* make sure reserved bytes are zeroes */
-	if (vring->reserved) {
+/*	if (vring->reserved) {
 		dev_err(dev, "vring rsc has non zero reserved bytes\n");
 		return -EINVAL;
-	}
+	}*/
 
 	/* verify queue size and vring alignment are sane */
 	if (!vring->num || !vring->align) {
@@ -514,10 +514,10 @@ static int rproc_handle_devmem(struct rproc *rproc, struct fw_rsc_devmem *rsc,
 	}
 
 	/* make sure reserved bytes are zeroes */
-	if (rsc->reserved) {
+/*	if (rsc->reserved) {
 		dev_err(dev, "devmem rsc has non zero reserved bytes\n");
 		return -EINVAL;
-	}
+	}*/
 
 	mapping = kzalloc(sizeof(*mapping), GFP_KERNEL);
 	if (!mapping) {
@@ -587,10 +587,10 @@ static int rproc_handle_carveout(struct rproc *rproc,
 	}
 
 	/* make sure reserved bytes are zeroes */
-	if (rsc->reserved) {
+/*	if (rsc->reserved) {
 		dev_err(dev, "carveout rsc has non zero reserved bytes\n");
 		return -EINVAL;
-	}
+	}*/
 
 	dev_dbg(dev, "carveout rsc: da %x, pa %x, len %x, flags %x\n",
 			rsc->da, rsc->pa, rsc->len, rsc->flags);

--------------040202000908000405010004--
