From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v5 4/7] arm: omap4: hwmod: introduce emu hwmod
Date: Fri, 18 Nov 2011 13:58:20 +0100
Message-ID: <4EC6566C.70202@ti.com>
References: <1319467559-5518-1-git-send-email-ming.lei@canonical.com> <1319467559-5518-5-git-send-email-ming.lei@canonical.com> <alpine.DEB.2.00.1111080750130.10451@utopia.booyaka.com> <CACVXFVMSJUT2Ac+bWetrLpbyOs6PqY+npNHsbvHipEVZ0gWdgQ@mail.gmail.com> <alpine.DEB.2.00.1111100152430.4195@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55408 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751083Ab1KRM6o (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Nov 2011 07:58:44 -0500
In-Reply-To: <alpine.DEB.2.00.1111100152430.4195@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux@arm.linux.org.uk, will.deacon@arm.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, khilman@deeprootsystems.com

Hi Ming Lei,

Sorry, for the delay, it took me some time to gather the exhaustive dat=
a for that block.=20

On 11/10/2011 10:02 AM, Paul Walmsley wrote:
> Hello Ming Lei,
>=20
> just a few quick comments for now -
>=20
> On Wed, 9 Nov 2011, Ming Lei wrote:
>=20
>> On Tue, Nov 8, 2011 at 11:26 PM, Paul Walmsley<paul@pwsan.com>  wrot=
e:
>>
>>>> +static struct omap_hwmod_irq_info omap44xx_emu_irqs[] =3D {
>>>> +     { .name =3D "cti0", .irq =3D 1 + OMAP44XX_IRQ_GIC_START },
>>>> +     { .name =3D "cti1", .irq =3D 2 + OMAP44XX_IRQ_GIC_START },
>>>> +     { .irq =3D -1 }
>>>> +};
>>>
>>> Are you sure these are part of the emulation IP?  We already have t=
hose
>>
>> I am not sure, I just figure out one way to make omap4 pmu work. Sin=
ce there
>> are few descriptions in TRM about it, it is a hacking based on [1], =
:-)
>>
>>> IRQs in the MPU hwmod, see omap44xx_mpu_irqs[] in the same file.
>>
>> I just see it, but looks like the "mpu" hwmod isn't populated as oma=
p_device,
>> so the CTI irqs aren't requested now.
>=20
> Okay.  Maybe you can probably add some code in mach-omap2/devices.c t=
o
> build an omap_device for this for right now?  I am not 100% sure whet=
her
> those cti0/1 interrupts should be associated with the MPU or with the
> DEBUGSS but Beno=EEt might be able to answer this.
>=20
>> Also, current arm perf code don't handle three IRQs(one pl310 irq an=
d
>> two CTI irq) inside one device correctly.
>=20
> To fix this, that ARM perf code should either be using
> platform_get_irq_byname(), or the hwmod hardware data will need to be
> rearranged to meet the arbitrary ordering requirement.  I'd suggest
> pinging Will on this issue to see what he wants to do.
>=20
>> So any suggestion about CTI IRQs connecting to which hwmod, so that =
they can
>> be found by pmu driver?
>>
>>>> +/*emu hwmod*/
>>>> +static struct omap_hwmod omap44xx_emu_hwmod =3D {
>>>> +     .name           =3D "emu",
>>>> +     .class          =3D&omap44xx_emu_hwmod_class,
>>>> +     .clkdm_name     =3D "emu_sys_clkdm",
>>>> +     .prcm =3D {
>>>> +             .omap4 =3D {
>>>> +                     .clkctrl_offs =3D OMAP4_CM_EMU_CLKSTCTRL_OFF=
SET,
>>>
>>> This doesn't look right either: EMU is a clockdomain, not an IP blo=
ck.
>>
>> I defined the 'emu' hwmod to control the clock state transition of t=
he EMU
>> clock domain by writing to CLKTRCTRL.CM_EMU_CLKSTCTRL with standard
>> hwmod interface(_enable / _idle). Is there any other neat way to do =
it?
>=20
> So the clockdomain is already defined in
> mach-omap2/clockdomains44xx_data.c and there's code to control it - s=
ee
> for example clkdm_enable_idle().  But this code should not be called
> directly by any device driver code or driver integration code.  The t=
hing
> to do here is to ask Beno=EEt to release the hwmod data for the DEBUG=
SS
> hwmod, then someone will need to write an MFD driver for that which
> exposes the PMU address space to the PMU platform driver.

=46ollowing that discussion, here is the patch to expose debugss hwmod.

I have moved the CTIs irq from MPU to debugss and exposed all the inter=
nals IP that are part of the OMAP debug subsystem.

Since the DEBUGSS cannot be accessed at boot time if the l3_main_3 and =
the l3_instr interconnects are not enable, you will have some warnings.

[    0.416992] omap_hwmod: debugss: softreset failed (waited 10000 usec=
)
[    0.426727] omap_hwmod: debugss: _wait_target_disable failed

Just let me know if you have any issue with that patch.

Please note that will will need the fix "ARM: OMAP: hwmod: Fix the addr=
 space, irq, dma count APIs" to avoid hwmod core messing up with the re=
sources.

I've just posted a pull request for Tony to get it for -rc3.
http://comments.gmane.org/gmane.linux.ports.arm.kernel/140458

I pushed these two patches on a branch based on mainline for your conve=
nience.

git://gitorious.org/omap-pm/linux.git wip-emu/debuss_hwmod

Regards,
Benoit=20

---
=46rom: Benoit Cousson <b-cousson@ti.com>
Date: Fri, 18 Nov 2011 11:42:12 +0100
Subject: [PATCH] ARM: OMAP4: hwmod data: Add support for the debug modu=
les

The OMAP4 DEBUG subsystem contains all the IPs used for emulation,
included the ones from the CortexA9 MPU.
Expose the individual modules base address.

Re-map the CTIs IRQs from MPU to DEBUGSS.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Ming Lei <ming.lei@canonical.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  177 ++++++++++++++++++++=
+++++++-
 1 files changed, 174 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach=
-omap2/omap_hwmod_44xx_data.c
index 7695e5d..6cf21ee 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -47,6 +47,7 @@
=20
 /* Backward references (IPs with Bus Master capability) */
 static struct omap_hwmod omap44xx_aess_hwmod;
+static struct omap_hwmod omap44xx_debugss_hwmod;
 static struct omap_hwmod omap44xx_dma_system_hwmod;
 static struct omap_hwmod omap44xx_dmm_hwmod;
 static struct omap_hwmod omap44xx_dsp_hwmod;
@@ -337,6 +338,14 @@ static struct omap_hwmod omap44xx_l3_main_1_hwmod =
=3D {
 };
=20
 /* l3_main_2 */
+/* debugss -> l3_main_2 */
+static struct omap_hwmod_ocp_if omap44xx_debugss__l3_main_2 =3D {
+	.master		=3D &omap44xx_debugss_hwmod,
+	.slave		=3D &omap44xx_l3_main_2_hwmod,
+	.clk		=3D "dbgclk_mux_ck",
+	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* dma_system -> l3_main_2 */
 static struct omap_hwmod_ocp_if omap44xx_dma_system__l3_main_2 =3D {
 	.master		=3D &omap44xx_dma_system_hwmod,
@@ -686,7 +695,6 @@ static struct omap_hwmod omap44xx_mpu_private_hwmod=
 =3D {
  *  ctrl_module_pad_core
  *  ctrl_module_pad_wkup
  *  ctrl_module_wkup
- *  debugss
  *  efuse_ctrl_cust
  *  efuse_ctrl_std
  *  elm
@@ -908,6 +916,168 @@ static struct omap_hwmod omap44xx_counter_32k_hwm=
od =3D {
 };
=20
 /*
+ * 'debugss' class
+ * debug and emulation sub system
+ */
+
+static struct omap_hwmod_class_sysconfig omap44xx_debugss_sysc =3D {
+	.rev_offs	=3D 0x0000,
+	.sysc_offs	=3D 0x0010,
+	.syss_offs	=3D 0x0014,
+	.sysc_flags	=3D (SYSC_HAS_SOFTRESET | SYSS_HAS_RESET_STATUS),
+	.sysc_fields	=3D &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap44xx_debugss_hwmod_class =3D {
+	.name	=3D "debugss",
+	.sysc	=3D &omap44xx_debugss_sysc,
+};
+
+/* debugss */
+static struct omap_hwmod_irq_info omap44xx_debugss_irqs[] =3D {
+	{ .name =3D "cti0", .irq =3D 1 + OMAP44XX_IRQ_GIC_START },
+	{ .name =3D "cti1", .irq =3D 2 + OMAP44XX_IRQ_GIC_START },
+	{ .irq =3D -1 }
+};
+
+/* debugss master ports */
+static struct omap_hwmod_ocp_if *omap44xx_debugss_masters[] =3D {
+	&omap44xx_debugss__l3_main_2,
+};
+
+static struct omap_hwmod_addr_space omap44xx_debugss_addrs[] =3D {
+	{
+		.name		=3D "mipi_stm_add_sp_0",
+		.pa_start	=3D 0x54000000,
+		.pa_end		=3D 0x540fffff,
+	},
+	{
+		.name		=3D "mipi_stm_add_sp_1",
+		.pa_start	=3D 0x54100000,
+		.pa_end		=3D 0x5413ffff,
+	},
+	{
+		.name		=3D "mpu_c0_debug",
+		.pa_start	=3D 0x54140000,
+		.pa_end		=3D 0x54141fff,
+	},
+	{
+		.name		=3D "mpu_c1_debug",
+		.pa_start	=3D 0x54142000,
+		.pa_end		=3D 0x54143fff,
+	},
+	{
+		.name		=3D "cti0_mpu",
+		.pa_start	=3D 0x54148000,
+		.pa_end		=3D 0x54148fff,
+	},
+	{
+		.name		=3D "cti1_mpu",
+		.pa_start	=3D 0x54149000,
+		.pa_end		=3D 0x54149fff,
+	},
+	{
+		.name		=3D "ptm0_mpu",
+		.pa_start	=3D 0x5414c000,
+		.pa_end		=3D 0x5414cfff,
+	},
+	{
+		.name		=3D "ptm1_mpu",
+		.pa_start	=3D 0x5414d000,
+		.pa_end		=3D 0x5414dfff,
+	},
+	{
+		.name		=3D "tf_mpu",
+		.pa_start	=3D 0x54158000,
+		.pa_end		=3D 0x54158fff,
+	},
+	{
+		.name		=3D "dap_pc_mpu",
+		.pa_start	=3D 0x54159000,
+		.pa_end		=3D 0x54159fff,
+	},
+	{
+		.name		=3D "apb_bridge_a_ctrl_time_out",
+		.pa_start	=3D 0x5415f000,
+		.pa_end		=3D 0x5415ffff,
+	},
+	{
+		.name		=3D "drm",
+		.pa_start	=3D 0x54160000,
+		.pa_end		=3D 0x54160fff,
+	},
+	{
+		.name		=3D "mipi_stm",
+		.pa_start	=3D 0x54161000,
+		.pa_end		=3D 0x54161fff,
+		.flags		=3D ADDR_TYPE_RT
+	},
+	{
+		.name		=3D "csetb",
+		.pa_start	=3D 0x54162000,
+		.pa_end		=3D 0x54162fff,
+	},
+	{
+		.name		=3D "cstpiu",
+		.pa_start	=3D 0x54163000,
+		.pa_end		=3D 0x54163fff,
+	},
+	{
+		.name		=3D "cstf1",
+		.pa_start	=3D 0x54164000,
+		.pa_end		=3D 0x54164fff,
+	},
+	{
+		.name		=3D "cstf2",
+		.pa_start	=3D 0x54165000,
+		.pa_end		=3D 0x54165fff,
+	},
+	{
+		.name		=3D "l4_cfg_emu_conf_regs",
+		.pa_start	=3D 0x54167000,
+		.pa_end		=3D 0x54167fff,
+	},
+	{
+		.name		=3D "l3_instr_emu_conf_regs",
+		.pa_start	=3D 0x54180000,
+		.pa_end		=3D 0x54180fff,
+	},
+	{ }
+};
+
+/* l3_instr -> debugss */
+static struct omap_hwmod_ocp_if omap44xx_l3_instr__debugss =3D {
+	.master		=3D &omap44xx_l3_instr_hwmod,
+	.slave		=3D &omap44xx_debugss_hwmod,
+	.clk		=3D "l3_div_ck",
+	.addr		=3D omap44xx_debugss_addrs,
+	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* debugss slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_debugss_slaves[] =3D {
+	&omap44xx_l3_instr__debugss,
+};
+
+static struct omap_hwmod omap44xx_debugss_hwmod =3D {
+	.name		=3D "debugss",
+	.class		=3D &omap44xx_debugss_hwmod_class,
+	.clkdm_name	=3D "emu_sys_clkdm",
+	.mpu_irqs	=3D omap44xx_debugss_irqs,
+	.main_clk	=3D "trace_clk_div_ck",
+	.prcm =3D {
+		.omap4 =3D {
+			.clkctrl_offs =3D OMAP4_CM_EMU_DEBUGSS_CLKCTRL_OFFSET,
+			.context_offs =3D OMAP4_RM_EMU_DEBUGSS_CONTEXT_OFFSET,
+		},
+	},
+	.slaves		=3D omap44xx_debugss_slaves,
+	.slaves_cnt	=3D ARRAY_SIZE(omap44xx_debugss_slaves),
+	.masters	=3D omap44xx_debugss_masters,
+	.masters_cnt	=3D ARRAY_SIZE(omap44xx_debugss_masters),
+};
+
+/*
  * 'dma' class
  * dma controller for data exchange between memory to memory (i.e. int=
ernal or
  * external memory) and gp peripherals to memory or memory to gp perip=
herals
@@ -3902,8 +4072,6 @@ static struct omap_hwmod_class omap44xx_mpu_hwmod=
_class =3D {
 /* mpu */
 static struct omap_hwmod_irq_info omap44xx_mpu_irqs[] =3D {
 	{ .name =3D "pl310", .irq =3D 0 + OMAP44XX_IRQ_GIC_START },
-	{ .name =3D "cti0", .irq =3D 1 + OMAP44XX_IRQ_GIC_START },
-	{ .name =3D "cti1", .irq =3D 2 + OMAP44XX_IRQ_GIC_START },
 	{ .irq =3D -1 }
 };
=20
@@ -5308,6 +5476,9 @@ static __initdata struct omap_hwmod *omap44xx_hwm=
ods[] =3D {
 	/* counter class */
 /*	&omap44xx_counter_32k_hwmod, */
=20
+	/* debugss class */
+	&omap44xx_debugss_hwmod,
+
 	/* dma class */
 	&omap44xx_dma_system_hwmod,
=20
--=20
1.7.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
