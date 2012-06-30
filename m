From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] ARM: OMAP4: hwmod data: temporarily remove data for the
 usb_host_fs and aess IP blocks
Date: Fri, 29 Jun 2012 21:53:26 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206292151290.2338@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-162668941-1341028406=:2338"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60664 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216Ab2F3Dx1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Jun 2012 23:53:27 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: b-cousson@ti.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-162668941-1341028406=:2338
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE


The OMAP4 usb_host_fs (OHCI) and AESS IP blocks require some special
programming for them to enter idle.  Without this programming, they
will prevent the rest of the chip from entering full chip idle.

To implement the idle programming cleanly, this will take some
coordination between maintainers.  This is likely to take some time,
so it is probably best to leave this for 3.6 or 3.7.  So, in the
meantime, simply remove this data.

Later, once the appropriate support is available, this patch can be
reverted.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=EEt Cousson <b-cousson@ti.com>
---
Intended for v3.5-rc.

 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  178 ------------------------=
----
 1 file changed, 178 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-oma=
p2/omap_hwmod_44xx_data.c
index f30e861..95cbfe6 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -296,60 +296,6 @@ static struct omap_hwmod omap44xx_ocp_wp_noc_hwmod =3D=
 {
  */
=20
 /*
- * 'aess' class
- * audio engine sub system
- */
-
-static struct omap_hwmod_class_sysconfig omap44xx_aess_sysc =3D {
-=09.rev_offs=09=3D 0x0000,
-=09.sysc_offs=09=3D 0x0010,
-=09.sysc_flags=09=3D (SYSC_HAS_MIDLEMODE | SYSC_HAS_SIDLEMODE),
-=09.idlemodes=09=3D (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
-=09=09=09   MSTANDBY_FORCE | MSTANDBY_NO | MSTANDBY_SMART |
-=09=09=09   MSTANDBY_SMART_WKUP),
-=09.sysc_fields=09=3D &omap_hwmod_sysc_type2,
-};
-
-static struct omap_hwmod_class omap44xx_aess_hwmod_class =3D {
-=09.name=09=3D "aess",
-=09.sysc=09=3D &omap44xx_aess_sysc,
-};
-
-/* aess */
-static struct omap_hwmod_irq_info omap44xx_aess_irqs[] =3D {
-=09{ .irq =3D 99 + OMAP44XX_IRQ_GIC_START },
-=09{ .irq =3D -1 }
-};
-
-static struct omap_hwmod_dma_info omap44xx_aess_sdma_reqs[] =3D {
-=09{ .name =3D "fifo0", .dma_req =3D 100 + OMAP44XX_DMA_REQ_START },
-=09{ .name =3D "fifo1", .dma_req =3D 101 + OMAP44XX_DMA_REQ_START },
-=09{ .name =3D "fifo2", .dma_req =3D 102 + OMAP44XX_DMA_REQ_START },
-=09{ .name =3D "fifo3", .dma_req =3D 103 + OMAP44XX_DMA_REQ_START },
-=09{ .name =3D "fifo4", .dma_req =3D 104 + OMAP44XX_DMA_REQ_START },
-=09{ .name =3D "fifo5", .dma_req =3D 105 + OMAP44XX_DMA_REQ_START },
-=09{ .name =3D "fifo6", .dma_req =3D 106 + OMAP44XX_DMA_REQ_START },
-=09{ .name =3D "fifo7", .dma_req =3D 107 + OMAP44XX_DMA_REQ_START },
-=09{ .dma_req =3D -1 }
-};
-
-static struct omap_hwmod omap44xx_aess_hwmod =3D {
-=09.name=09=09=3D "aess",
-=09.class=09=09=3D &omap44xx_aess_hwmod_class,
-=09.clkdm_name=09=3D "abe_clkdm",
-=09.mpu_irqs=09=3D omap44xx_aess_irqs,
-=09.sdma_reqs=09=3D omap44xx_aess_sdma_reqs,
-=09.main_clk=09=3D "aess_fck",
-=09.prcm =3D {
-=09=09.omap4 =3D {
-=09=09=09.clkctrl_offs =3D OMAP4_CM1_ABE_AESS_CLKCTRL_OFFSET,
-=09=09=09.context_offs =3D OMAP4_RM_ABE_AESS_CONTEXT_OFFSET,
-=09=09=09.modulemode   =3D MODULEMODE_SWCTRL,
-=09=09},
-=09},
-};
-
-/*
  * 'c2c' class
  * chip 2 chip interface used to plug the ape soc (omap) with an external =
modem
  * soc
@@ -3285,55 +3231,6 @@ static struct omap_hwmod omap44xx_uart4_hwmod =3D {
 };
=20
 /*
- * 'usb_host_fs' class
- * full-speed usb host controller
- */
-
-/* The IP is not compliant to type1 / type2 scheme */
-static struct omap_hwmod_sysc_fields omap_hwmod_sysc_type_usb_host_fs =3D =
{
-=09.midle_shift=09=3D 4,
-=09.sidle_shift=09=3D 2,
-=09.srst_shift=09=3D 1,
-};
-
-static struct omap_hwmod_class_sysconfig omap44xx_usb_host_fs_sysc =3D {
-=09.rev_offs=09=3D 0x0000,
-=09.sysc_offs=09=3D 0x0210,
-=09.sysc_flags=09=3D (SYSC_HAS_MIDLEMODE | SYSC_HAS_SIDLEMODE |
-=09=09=09   SYSC_HAS_SOFTRESET),
-=09.idlemodes=09=3D (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
-=09=09=09   SIDLE_SMART_WKUP),
-=09.sysc_fields=09=3D &omap_hwmod_sysc_type_usb_host_fs,
-};
-
-static struct omap_hwmod_class omap44xx_usb_host_fs_hwmod_class =3D {
-=09.name=09=3D "usb_host_fs",
-=09.sysc=09=3D &omap44xx_usb_host_fs_sysc,
-};
-
-/* usb_host_fs */
-static struct omap_hwmod_irq_info omap44xx_usb_host_fs_irqs[] =3D {
-=09{ .name =3D "std", .irq =3D 89 + OMAP44XX_IRQ_GIC_START },
-=09{ .name =3D "smi", .irq =3D 90 + OMAP44XX_IRQ_GIC_START },
-=09{ .irq =3D -1 }
-};
-
-static struct omap_hwmod omap44xx_usb_host_fs_hwmod =3D {
-=09.name=09=09=3D "usb_host_fs",
-=09.class=09=09=3D &omap44xx_usb_host_fs_hwmod_class,
-=09.clkdm_name=09=3D "l3_init_clkdm",
-=09.mpu_irqs=09=3D omap44xx_usb_host_fs_irqs,
-=09.main_clk=09=3D "usb_host_fs_fck",
-=09.prcm =3D {
-=09=09.omap4 =3D {
-=09=09=09.clkctrl_offs =3D OMAP4_CM_L3INIT_USB_HOST_FS_CLKCTRL_OFFSET,
-=09=09=09.context_offs =3D OMAP4_RM_L3INIT_USB_HOST_FS_CONTEXT_OFFSET,
-=09=09=09.modulemode   =3D MODULEMODE_SWCTRL,
-=09=09},
-=09},
-};
-
-/*
  * 'usb_host_hs' class
  * high-speed multi-port usb host controller
  */
@@ -3863,14 +3760,6 @@ static struct omap_hwmod_ocp_if omap44xx_l4_cfg__l3_=
main_2 =3D {
 =09.user=09=09=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-/* usb_host_fs -> l3_main_2 */
-static struct omap_hwmod_ocp_if omap44xx_usb_host_fs__l3_main_2 =3D {
-=09.master=09=09=3D &omap44xx_usb_host_fs_hwmod,
-=09.slave=09=09=3D &omap44xx_l3_main_2_hwmod,
-=09.clk=09=09=3D "l3_div_ck",
-=09.user=09=09=3D OCP_USER_MPU | OCP_USER_SDMA,
-};
-
 /* usb_host_hs -> l3_main_2 */
 static struct omap_hwmod_ocp_if omap44xx_usb_host_hs__l3_main_2 =3D {
 =09.master=09=09=3D &omap44xx_usb_host_hs_hwmod,
@@ -3921,14 +3810,6 @@ static struct omap_hwmod_ocp_if omap44xx_l4_cfg__l3_=
main_3 =3D {
 =09.user=09=09=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-/* aess -> l4_abe */
-static struct omap_hwmod_ocp_if omap44xx_aess__l4_abe =3D {
-=09.master=09=09=3D &omap44xx_aess_hwmod,
-=09.slave=09=09=3D &omap44xx_l4_abe_hwmod,
-=09.clk=09=09=3D "ocp_abe_iclk",
-=09.user=09=09=3D OCP_USER_MPU | OCP_USER_SDMA,
-};
-
 /* dsp -> l4_abe */
 static struct omap_hwmod_ocp_if omap44xx_dsp__l4_abe =3D {
 =09.master=09=09=3D &omap44xx_dsp_hwmod,
@@ -4003,42 +3884,6 @@ static struct omap_hwmod_ocp_if omap44xx_l4_cfg__ocp=
_wp_noc =3D {
 =09.user=09=09=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_aess_addrs[] =3D {
-=09{
-=09=09.pa_start=09=3D 0x401f1000,
-=09=09.pa_end=09=09=3D 0x401f13ff,
-=09=09.flags=09=09=3D ADDR_TYPE_RT
-=09},
-=09{ }
-};
-
-/* l4_abe -> aess */
-static struct omap_hwmod_ocp_if omap44xx_l4_abe__aess =3D {
-=09.master=09=09=3D &omap44xx_l4_abe_hwmod,
-=09.slave=09=09=3D &omap44xx_aess_hwmod,
-=09.clk=09=09=3D "ocp_abe_iclk",
-=09.addr=09=09=3D omap44xx_aess_addrs,
-=09.user=09=09=3D OCP_USER_MPU,
-};
-
-static struct omap_hwmod_addr_space omap44xx_aess_dma_addrs[] =3D {
-=09{
-=09=09.pa_start=09=3D 0x490f1000,
-=09=09.pa_end=09=09=3D 0x490f13ff,
-=09=09.flags=09=09=3D ADDR_TYPE_RT
-=09},
-=09{ }
-};
-
-/* l4_abe -> aess (dma) */
-static struct omap_hwmod_ocp_if omap44xx_l4_abe__aess_dma =3D {
-=09.master=09=09=3D &omap44xx_l4_abe_hwmod,
-=09.slave=09=09=3D &omap44xx_aess_hwmod,
-=09.clk=09=09=3D "ocp_abe_iclk",
-=09.addr=09=09=3D omap44xx_aess_dma_addrs,
-=09.user=09=09=3D OCP_USER_SDMA,
-};
-
 /* l3_main_2 -> c2c */
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__c2c =3D {
 =09.master=09=09=3D &omap44xx_l3_main_2_hwmod,
@@ -5847,24 +5692,6 @@ static struct omap_hwmod_ocp_if omap44xx_l4_per__uar=
t4 =3D {
 =09.user=09=09=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_usb_host_fs_addrs[] =3D {
-=09{
-=09=09.pa_start=09=3D 0x4a0a9000,
-=09=09.pa_end=09=09=3D 0x4a0a93ff,
-=09=09.flags=09=09=3D ADDR_TYPE_RT
-=09},
-=09{ }
-};
-
-/* l4_cfg -> usb_host_fs */
-static struct omap_hwmod_ocp_if omap44xx_l4_cfg__usb_host_fs =3D {
-=09.master=09=09=3D &omap44xx_l4_cfg_hwmod,
-=09.slave=09=09=3D &omap44xx_usb_host_fs_hwmod,
-=09.clk=09=09=3D "l4_div_ck",
-=09.addr=09=09=3D omap44xx_usb_host_fs_addrs,
-=09.user=09=09=3D OCP_USER_MPU | OCP_USER_SDMA,
-};
-
 static struct omap_hwmod_addr_space omap44xx_usb_host_hs_addrs[] =3D {
 =09{
 =09=09.name=09=09=3D "uhh",
@@ -6014,13 +5841,11 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp=
_ifs[] __initdata =3D {
 =09&omap44xx_iva__l3_main_2,
 =09&omap44xx_l3_main_1__l3_main_2,
 =09&omap44xx_l4_cfg__l3_main_2,
-=09&omap44xx_usb_host_fs__l3_main_2,
 =09&omap44xx_usb_host_hs__l3_main_2,
 =09&omap44xx_usb_otg_hs__l3_main_2,
 =09&omap44xx_l3_main_1__l3_main_3,
 =09&omap44xx_l3_main_2__l3_main_3,
 =09&omap44xx_l4_cfg__l3_main_3,
-=09&omap44xx_aess__l4_abe,
 =09&omap44xx_dsp__l4_abe,
 =09&omap44xx_l3_main_1__l4_abe,
 =09&omap44xx_mpu__l4_abe,
@@ -6029,8 +5854,6 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp_i=
fs[] __initdata =3D {
 =09&omap44xx_l4_cfg__l4_wkup,
 =09&omap44xx_mpu__mpu_private,
 =09&omap44xx_l4_cfg__ocp_wp_noc,
-=09&omap44xx_l4_abe__aess,
-=09&omap44xx_l4_abe__aess_dma,
 =09&omap44xx_l3_main_2__c2c,
 =09&omap44xx_l4_wkup__counter_32k,
 =09&omap44xx_l4_cfg__ctrl_module_core,
@@ -6136,7 +5959,6 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp_i=
fs[] __initdata =3D {
 =09&omap44xx_l4_per__uart2,
 =09&omap44xx_l4_per__uart3,
 =09&omap44xx_l4_per__uart4,
-=09&omap44xx_l4_cfg__usb_host_fs,
 =09&omap44xx_l4_cfg__usb_host_hs,
 =09&omap44xx_l4_cfg__usb_otg_hs,
 =09&omap44xx_l4_cfg__usb_tll_hs,
--=20
1.7.10

--155748971-162668941-1341028406=:2338--
