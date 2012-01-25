From: Paul Walmsley <paul@pwsan.com>
Subject: Re: How do I get slimbus hwmod information?
Date: Wed, 25 Jan 2012 12:46:50 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201251239150.5324@utopia.booyaka.com>
References: <20120105004503.GA4650@plastictigers.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-824831313-1327520810=:5324"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42303 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751034Ab2AYTqv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jan 2012 14:46:51 -0500
In-Reply-To: <20120105004503.GA4650@plastictigers.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Butler <marc@plastictigers.com>
Cc: linux-omap@vger.kernel.org, b-cousson@ti.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-824831313-1327520810=:5324
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

cc Beno=EEt

Hi

sorry for the delay, just caught this during a list sweep.  The maintainer=
=20
of the OMAP4 hwmod data is Beno=EEt, so I'd suggest cc'ing him for OMAP4=20
hwmod data requests.

On Wed, 4 Jan 2012, Marc Butler wrote:

> Currently omap_hwmod_44xx_data.c has slimbus1/slimbus2 included in the
> list of excluded IPs.
>=20
> Is it possible to get a version of omap_hwmod_44xx_data.c generated
> with slimbus1/2 included?=20

A good starting point is included below.

> I want this as I am currently working on a driver for the slimbus
> modules, based on the SLIMbus RFC patch posted last year.=20

That sounds really great!

> I am concerned that I do not understand how the pieces for such a
> driver should be put together: should such a driver be built from the
> ground up with hwmod interfaces, or should they be added in as the
> driver stabilizes?

The driver shouldn't have any hwmod code in it.  Any=20
omap_device/omap_hwmod code that's needed should go into an appropriate=20
file in arch/arm/mach-omap2.  The device resource metadata will flow=20
through the existing Linux resource system.  Also, currently we are using=
=20
the pm_runtime*() calls as the way to interface with the=20
omap_hwmod/omap_device enable/idle code, so your driver should be written=
=20
using those.


- Paul


diff --git a/outputs/omap4430/2.0/omap_hwmod_44xx_data.c b/outputs/omap4430=
/2.0/omap_hwmod_44xx_data.c
index 308e620..3d8b0cb 100644
--- a/outputs/omap4430/2.0/omap_hwmod_44xx_data.c
+++ b/outputs/omap4430/2.0/omap_hwmod_44xx_data.c
@@ -711,8 +711,6 @@ static struct omap_hwmod omap44xx_mpu_private_hwmod =3D=
 {
  *  prm
  *  scrm
  *  sl2if
- *  slimbus1
- *  slimbus2
  *  usb_host_fs
  *  usb_host_hs
  *  usb_phy_cm
@@ -4066,6 +4064,181 @@ static struct omap_hwmod omap44xx_mpu_hwmod =3D {
 };
=20
 /*
+ * 'slimbus' class
+ * bidirectional, multi-drop, multi-channel two-line serial interface betw=
een
+ * the device and external components
+ */
+
+static struct omap_hwmod_class_sysconfig omap44xx_slimbus_sysc =3D {
+=09.rev_offs=09=3D 0x0000,
+=09.sysc_offs=09=3D 0x0010,
+=09.sysc_flags=09=3D (SYSC_HAS_RESET_STATUS | SYSC_HAS_SIDLEMODE |
+=09=09=09   SYSC_HAS_SOFTRESET),
+=09.idlemodes=09=3D (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+=09=09=09   SIDLE_SMART_WKUP),
+=09.sysc_fields=09=3D &omap_hwmod_sysc_type2,
+};
+
+static struct omap_hwmod_class omap44xx_slimbus_hwmod_class =3D {
+=09.name=09=3D "slimbus",
+=09.sysc=09=3D &omap44xx_slimbus_sysc,
+};
+
+/* slimbus1 */
+static struct omap_hwmod omap44xx_slimbus1_hwmod;
+static struct omap_hwmod_irq_info omap44xx_slimbus1_irqs[] =3D {
+=09{ .irq =3D 97 + OMAP44XX_IRQ_GIC_START },
+=09{ .irq =3D -1 }
+};
+
+static struct omap_hwmod_dma_info omap44xx_slimbus1_sdma_reqs[] =3D {
+=09{ .name =3D "tx0", .dma_req =3D 84 + OMAP44XX_DMA_REQ_START },
+=09{ .name =3D "tx1", .dma_req =3D 85 + OMAP44XX_DMA_REQ_START },
+=09{ .name =3D "tx2", .dma_req =3D 86 + OMAP44XX_DMA_REQ_START },
+=09{ .name =3D "tx3", .dma_req =3D 87 + OMAP44XX_DMA_REQ_START },
+=09{ .name =3D "rx0", .dma_req =3D 88 + OMAP44XX_DMA_REQ_START },
+=09{ .name =3D "rx1", .dma_req =3D 89 + OMAP44XX_DMA_REQ_START },
+=09{ .name =3D "rx2", .dma_req =3D 90 + OMAP44XX_DMA_REQ_START },
+=09{ .name =3D "rx3", .dma_req =3D 91 + OMAP44XX_DMA_REQ_START },
+=09{ .dma_req =3D -1 }
+};
+
+static struct omap_hwmod_addr_space omap44xx_slimbus1_addrs[] =3D {
+=09{
+=09=09.pa_start=09=3D 0x4012c000,
+=09=09.pa_end=09=09=3D 0x4012c3ff,
+=09=09.flags=09=09=3D ADDR_TYPE_RT
+=09},
+=09{ }
+};
+
+/* l4_abe -> slimbus1 */
+static struct omap_hwmod_ocp_if omap44xx_l4_abe__slimbus1 =3D {
+=09.master=09=09=3D &omap44xx_l4_abe_hwmod,
+=09.slave=09=09=3D &omap44xx_slimbus1_hwmod,
+=09.clk=09=09=3D "ocp_abe_iclk",
+=09.addr=09=09=3D omap44xx_slimbus1_addrs,
+=09.user=09=09=3D OCP_USER_MPU,
+};
+
+static struct omap_hwmod_addr_space omap44xx_slimbus1_dma_addrs[] =3D {
+=09{
+=09=09.pa_start=09=3D 0x4902c000,
+=09=09.pa_end=09=09=3D 0x4902c3ff,
+=09=09.flags=09=09=3D ADDR_TYPE_RT
+=09},
+=09{ }
+};
+
+/* l4_abe -> slimbus1 (dma) */
+static struct omap_hwmod_ocp_if omap44xx_l4_abe__slimbus1_dma =3D {
+=09.master=09=09=3D &omap44xx_l4_abe_hwmod,
+=09.slave=09=09=3D &omap44xx_slimbus1_hwmod,
+=09.clk=09=09=3D "ocp_abe_iclk",
+=09.addr=09=09=3D omap44xx_slimbus1_dma_addrs,
+=09.user=09=09=3D OCP_USER_SDMA,
+};
+
+/* slimbus1 slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_slimbus1_slaves[] =3D {
+=09&omap44xx_l4_abe__slimbus1,
+=09&omap44xx_l4_abe__slimbus1_dma,
+};
+
+static struct omap_hwmod_opt_clk slimbus1_opt_clks[] =3D {
+=09{ .role =3D "fclk_1", .clk =3D "slimbus1_fclk_1" },
+=09{ .role =3D "fclk_0", .clk =3D "slimbus1_fclk_0" },
+=09{ .role =3D "fclk_2", .clk =3D "slimbus1_fclk_2" },
+=09{ .role =3D "slimbus_clk", .clk =3D "slimbus1_slimbus_clk" },
+};
+
+static struct omap_hwmod omap44xx_slimbus1_hwmod =3D {
+=09.name=09=09=3D "slimbus1",
+=09.class=09=09=3D &omap44xx_slimbus_hwmod_class,
+=09.clkdm_name=09=3D "abe_clkdm",
+=09.mpu_irqs=09=3D omap44xx_slimbus1_irqs,
+=09.sdma_reqs=09=3D omap44xx_slimbus1_sdma_reqs,
+=09.prcm =3D {
+=09=09.omap4 =3D {
+=09=09=09.clkctrl_offs =3D OMAP4_CM1_ABE_SLIMBUS_CLKCTRL_OFFSET,
+=09=09=09.context_offs =3D OMAP4_RM_ABE_SLIMBUS_CONTEXT_OFFSET,
+=09=09=09.modulemode   =3D MODULEMODE_SWCTRL,
+=09=09},
+=09},
+=09.opt_clks=09=3D slimbus1_opt_clks,
+=09.opt_clks_cnt=09=3D ARRAY_SIZE(slimbus1_opt_clks),
+=09.slaves=09=09=3D omap44xx_slimbus1_slaves,
+=09.slaves_cnt=09=3D ARRAY_SIZE(omap44xx_slimbus1_slaves),
+};
+
+/* slimbus2 */
+static struct omap_hwmod omap44xx_slimbus2_hwmod;
+static struct omap_hwmod_irq_info omap44xx_slimbus2_irqs[] =3D {
+=09{ .irq =3D 98 + OMAP44XX_IRQ_GIC_START },
+=09{ .irq =3D -1 }
+};
+
+static struct omap_hwmod_dma_info omap44xx_slimbus2_sdma_reqs[] =3D {
+=09{ .name =3D "tx0", .dma_req =3D 92 + OMAP44XX_DMA_REQ_START },
+=09{ .name =3D "tx1", .dma_req =3D 93 + OMAP44XX_DMA_REQ_START },
+=09{ .name =3D "tx2", .dma_req =3D 94 + OMAP44XX_DMA_REQ_START },
+=09{ .name =3D "tx3", .dma_req =3D 95 + OMAP44XX_DMA_REQ_START },
+=09{ .name =3D "rx0", .dma_req =3D 96 + OMAP44XX_DMA_REQ_START },
+=09{ .name =3D "rx1", .dma_req =3D 97 + OMAP44XX_DMA_REQ_START },
+=09{ .name =3D "rx2", .dma_req =3D 98 + OMAP44XX_DMA_REQ_START },
+=09{ .name =3D "rx3", .dma_req =3D 99 + OMAP44XX_DMA_REQ_START },
+=09{ .dma_req =3D -1 }
+};
+
+static struct omap_hwmod_addr_space omap44xx_slimbus2_addrs[] =3D {
+=09{
+=09=09.pa_start=09=3D 0x48076000,
+=09=09.pa_end=09=09=3D 0x480763ff,
+=09=09.flags=09=09=3D ADDR_TYPE_RT
+=09},
+=09{ }
+};
+
+/* l4_per -> slimbus2 */
+static struct omap_hwmod_ocp_if omap44xx_l4_per__slimbus2 =3D {
+=09.master=09=09=3D &omap44xx_l4_per_hwmod,
+=09.slave=09=09=3D &omap44xx_slimbus2_hwmod,
+=09.clk=09=09=3D "l4_div_ck",
+=09.addr=09=09=3D omap44xx_slimbus2_addrs,
+=09.user=09=09=3D OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* slimbus2 slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_slimbus2_slaves[] =3D {
+=09&omap44xx_l4_per__slimbus2,
+};
+
+static struct omap_hwmod_opt_clk slimbus2_opt_clks[] =3D {
+=09{ .role =3D "fclk_1", .clk =3D "slimbus2_fclk_1" },
+=09{ .role =3D "fclk_0", .clk =3D "slimbus2_fclk_0" },
+=09{ .role =3D "slimbus_clk", .clk =3D "slimbus2_slimbus_clk" },
+};
+
+static struct omap_hwmod omap44xx_slimbus2_hwmod =3D {
+=09.name=09=09=3D "slimbus2",
+=09.class=09=09=3D &omap44xx_slimbus_hwmod_class,
+=09.clkdm_name=09=3D "l4_per_clkdm",
+=09.mpu_irqs=09=3D omap44xx_slimbus2_irqs,
+=09.sdma_reqs=09=3D omap44xx_slimbus2_sdma_reqs,
+=09.prcm =3D {
+=09=09.omap4 =3D {
+=09=09=09.clkctrl_offs =3D OMAP4_CM_L4PER_SLIMBUS2_CLKCTRL_OFFSET,
+=09=09=09.context_offs =3D OMAP4_RM_L4PER_SLIMBUS2_CONTEXT_OFFSET,
+=09=09=09.modulemode   =3D MODULEMODE_SWCTRL,
+=09=09},
+=09},
+=09.opt_clks=09=3D slimbus2_opt_clks,
+=09.opt_clks_cnt=09=3D ARRAY_SIZE(slimbus2_opt_clks),
+=09.slaves=09=09=3D omap44xx_slimbus2_slaves,
+=09.slaves_cnt=09=3D ARRAY_SIZE(omap44xx_slimbus2_slaves),
+};
+
+/*
  * 'smartreflex' class
  * smartreflex module (monitor silicon performance and outputs a measure o=
f
  * performance error)
@@ -5504,6 +5677,10 @@ static __initdata struct omap_hwmod *omap44xx_hwmods=
[] =3D {
 =09/* mpu class */
 =09&omap44xx_mpu_hwmod,
=20
+=09/* slimbus class */
+=09&omap44xx_slimbus1_hwmod,
+=09&omap44xx_slimbus2_hwmod,
+
 =09/* smartreflex class */
 =09&omap44xx_smartreflex_core_hwmod,
 =09&omap44xx_smartreflex_iva_hwmod,
--155748971-824831313-1327520810=:5324--
