From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v5 4/7] arm: omap4: hwmod: introduce emu hwmod
Date: Sat, 26 Nov 2011 18:58:04 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1111261854340.6289@utopia.booyaka.com>
References: <1319467559-5518-1-git-send-email-ming.lei@canonical.com> <1319467559-5518-5-git-send-email-ming.lei@canonical.com> <alpine.DEB.2.00.1111080750130.10451@utopia.booyaka.com> <CACVXFVMSJUT2Ac+bWetrLpbyOs6PqY+npNHsbvHipEVZ0gWdgQ@mail.gmail.com>
 <alpine.DEB.2.00.1111100152430.4195@utopia.booyaka.com> <4EC6566C.70202@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-614043090-1322359084=:6289"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50765 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753603Ab1K0B6G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 26 Nov 2011 20:58:06 -0500
In-Reply-To: <4EC6566C.70202@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Ming Lei <ming.lei@canonical.com>, linux@arm.linux.org.uk, will.deacon@arm.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, khilman@deeprootsystems.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-614043090-1322359084=:6289
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Beno=EEt,

a question about this patch.

On Fri, 18 Nov 2011, Cousson, Benoit wrote:

> From: Benoit Cousson <b-cousson@ti.com>
> Date: Fri, 18 Nov 2011 11:42:12 +0100
> Subject: [PATCH] ARM: OMAP4: hwmod data: Add support for the debug module=
s
>=20
> The OMAP4 DEBUG subsystem contains all the IPs used for emulation,
> included the ones from the CortexA9 MPU.
> Expose the individual modules base address.
>=20
> Re-map the CTIs IRQs from MPU to DEBUGSS.
>=20
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Ming Lei <ming.lei@canonical.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  177 ++++++++++++++++++++++=
+++++-
>  1 files changed, 174 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-o=
map2/omap_hwmod_44xx_data.c
> index 7695e5d..6cf21ee 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -47,6 +47,7 @@
> =20
>  /* Backward references (IPs with Bus Master capability) */
>  static struct omap_hwmod omap44xx_aess_hwmod;
> +static struct omap_hwmod omap44xx_debugss_hwmod;
>  static struct omap_hwmod omap44xx_dma_system_hwmod;
>  static struct omap_hwmod omap44xx_dmm_hwmod;
>  static struct omap_hwmod omap44xx_dsp_hwmod;
> @@ -337,6 +338,14 @@ static struct omap_hwmod omap44xx_l3_main_1_hwmod =
=3D {
>  };
> =20
>  /* l3_main_2 */
> +/* debugss -> l3_main_2 */
> +static struct omap_hwmod_ocp_if omap44xx_debugss__l3_main_2 =3D {
> +=09.master=09=09=3D &omap44xx_debugss_hwmod,
> +=09.slave=09=09=3D &omap44xx_l3_main_2_hwmod,
> +=09.clk=09=09=3D "dbgclk_mux_ck",
> +=09.user=09=09=3D OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
>  /* dma_system -> l3_main_2 */
>  static struct omap_hwmod_ocp_if omap44xx_dma_system__l3_main_2 =3D {
>  =09.master=09=09=3D &omap44xx_dma_system_hwmod,
> @@ -686,7 +695,6 @@ static struct omap_hwmod omap44xx_mpu_private_hwmod =
=3D {
>   *  ctrl_module_pad_core
>   *  ctrl_module_pad_wkup
>   *  ctrl_module_wkup
> - *  debugss
>   *  efuse_ctrl_cust
>   *  efuse_ctrl_std
>   *  elm
> @@ -908,6 +916,168 @@ static struct omap_hwmod omap44xx_counter_32k_hwmod=
 =3D {
>  };
> =20
>  /*
> + * 'debugss' class
> + * debug and emulation sub system
> + */
> +
> +static struct omap_hwmod_class_sysconfig omap44xx_debugss_sysc =3D {
> +=09.rev_offs=09=3D 0x0000,
> +=09.sysc_offs=09=3D 0x0010,
> +=09.syss_offs=09=3D 0x0014,
> +=09.sysc_flags=09=3D (SYSC_HAS_SOFTRESET | SYSS_HAS_RESET_STATUS),
> +=09.sysc_fields=09=3D &omap_hwmod_sysc_type1,
> +};

This defines the OCP register offsets for the DEBUGSS, but ...

> +static struct omap_hwmod_class omap44xx_debugss_hwmod_class =3D {
> +=09.name=09=3D "debugss",
> +=09.sysc=09=3D &omap44xx_debugss_sysc,
> +};
> +
> +/* debugss */
> +static struct omap_hwmod_irq_info omap44xx_debugss_irqs[] =3D {
> +=09{ .name =3D "cti0", .irq =3D 1 + OMAP44XX_IRQ_GIC_START },
> +=09{ .name =3D "cti1", .irq =3D 2 + OMAP44XX_IRQ_GIC_START },
> +=09{ .irq =3D -1 }
> +};
> +
> +/* debugss master ports */
> +static struct omap_hwmod_ocp_if *omap44xx_debugss_masters[] =3D {
> +=09&omap44xx_debugss__l3_main_2,
> +};
> +
> +static struct omap_hwmod_addr_space omap44xx_debugss_addrs[] =3D {
> +=09{
> +=09=09.name=09=09=3D "mipi_stm_add_sp_0",
> +=09=09.pa_start=09=3D 0x54000000,
> +=09=09.pa_end=09=09=3D 0x540fffff,
> +=09},
> +=09{
> +=09=09.name=09=09=3D "mipi_stm_add_sp_1",
> +=09=09.pa_start=09=3D 0x54100000,
> +=09=09.pa_end=09=09=3D 0x5413ffff,
> +=09},
> +=09{
> +=09=09.name=09=09=3D "mpu_c0_debug",
> +=09=09.pa_start=09=3D 0x54140000,
> +=09=09.pa_end=09=09=3D 0x54141fff,
> +=09},
> +=09{
> +=09=09.name=09=09=3D "mpu_c1_debug",
> +=09=09.pa_start=09=3D 0x54142000,
> +=09=09.pa_end=09=09=3D 0x54143fff,
> +=09},
> +=09{
> +=09=09.name=09=09=3D "cti0_mpu",
> +=09=09.pa_start=09=3D 0x54148000,
> +=09=09.pa_end=09=09=3D 0x54148fff,
> +=09},
> +=09{
> +=09=09.name=09=09=3D "cti1_mpu",
> +=09=09.pa_start=09=3D 0x54149000,
> +=09=09.pa_end=09=09=3D 0x54149fff,
> +=09},
> +=09{
> +=09=09.name=09=09=3D "ptm0_mpu",
> +=09=09.pa_start=09=3D 0x5414c000,
> +=09=09.pa_end=09=09=3D 0x5414cfff,
> +=09},
> +=09{
> +=09=09.name=09=09=3D "ptm1_mpu",
> +=09=09.pa_start=09=3D 0x5414d000,
> +=09=09.pa_end=09=09=3D 0x5414dfff,
> +=09},
> +=09{
> +=09=09.name=09=09=3D "tf_mpu",
> +=09=09.pa_start=09=3D 0x54158000,
> +=09=09.pa_end=09=09=3D 0x54158fff,
> +=09},
> +=09{
> +=09=09.name=09=09=3D "dap_pc_mpu",
> +=09=09.pa_start=09=3D 0x54159000,
> +=09=09.pa_end=09=09=3D 0x54159fff,
> +=09},
> +=09{
> +=09=09.name=09=09=3D "apb_bridge_a_ctrl_time_out",
> +=09=09.pa_start=09=3D 0x5415f000,
> +=09=09.pa_end=09=09=3D 0x5415ffff,
> +=09},
> +=09{
> +=09=09.name=09=09=3D "drm",
> +=09=09.pa_start=09=3D 0x54160000,
> +=09=09.pa_end=09=09=3D 0x54160fff,
> +=09},
> +=09{
> +=09=09.name=09=09=3D "mipi_stm",
> +=09=09.pa_start=09=3D 0x54161000,
> +=09=09.pa_end=09=09=3D 0x54161fff,
> +=09=09.flags=09=09=3D ADDR_TYPE_RT
> +=09},
> +=09{
> +=09=09.name=09=09=3D "csetb",
> +=09=09.pa_start=09=3D 0x54162000,
> +=09=09.pa_end=09=09=3D 0x54162fff,
> +=09},
> +=09{
> +=09=09.name=09=09=3D "cstpiu",
> +=09=09.pa_start=09=3D 0x54163000,
> +=09=09.pa_end=09=09=3D 0x54163fff,
> +=09},
> +=09{
> +=09=09.name=09=09=3D "cstf1",
> +=09=09.pa_start=09=3D 0x54164000,
> +=09=09.pa_end=09=09=3D 0x54164fff,
> +=09},
> +=09{
> +=09=09.name=09=09=3D "cstf2",
> +=09=09.pa_start=09=3D 0x54165000,
> +=09=09.pa_end=09=09=3D 0x54165fff,
> +=09},
> +=09{
> +=09=09.name=09=09=3D "l4_cfg_emu_conf_regs",
> +=09=09.pa_start=09=3D 0x54167000,
> +=09=09.pa_end=09=09=3D 0x54167fff,
> +=09},
> +=09{
> +=09=09.name=09=09=3D "l3_instr_emu_conf_regs",
> +=09=09.pa_start=09=3D 0x54180000,
> +=09=09.pa_end=09=09=3D 0x54180fff,
> +=09},
> +=09{ }
> +};

=2E.. none of the address spaces above have the ADDR_TYPE_RT flag set.
Without this flag set, the hwmod code won't know where to access the OCP=20
registers.

From=20the basic documentation that I have here, it's not clear to me where=
=20
the SYSCONFIG registers are located?


- Paul
--155748971-614043090-1322359084=:6289--
