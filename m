From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [RFC PATCH v1 1/7] omap4: introduce fdif(face detect module) hwmod
Date: Tue, 13 Dec 2011 10:42:58 +0800
Message-ID: <CACVXFVM4gNwK90oiCx7c-rascT9n4zd-oCQLZvMXMbXT=37obg@mail.gmail.com>
References: <1322817178-8931-1-git-send-email-ming.lei@canonical.com>
	<1322817178-8931-2-git-send-email-ming.lei@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:51563 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751106Ab1LMCnB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Dec 2011 21:43:01 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46])
	by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_ARCFOUR_SHA1:16)
	(Exim 4.71)
	(envelope-from <ming.lei@canonical.com>)
	id 1RaIKZ-0003sm-Gf
	for linux-omap@vger.kernel.org; Tue, 13 Dec 2011 02:42:59 +0000
Received: by yhr47 with SMTP id 47so44227yhr.19
        for <linux-omap@vger.kernel.org>; Mon, 12 Dec 2011 18:42:58 -0800 (PST)
In-Reply-To: <1322817178-8931-2-git-send-email-ming.lei@canonical.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ming Lei <ming.lei@canonical.com>

Hi guys,

Gentle ping on this patch, :-)

thanks,
--
Ming Lei

On Fri, Dec 2, 2011 at 5:12 PM, Ming Lei <ming.lei@canonical.com> wrote=
:
> Signed-off-by: Ming Lei <ming.lei@canonical.com>
> ---
> =A0arch/arm/mach-omap2/omap_hwmod_44xx_data.c | =A0 81 ++++++++++++++=
++++++++++++++
> =A01 files changed, 81 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/ma=
ch-omap2/omap_hwmod_44xx_data.c
> index 6cf21ee..30db754 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -53,6 +53,7 @@ static struct omap_hwmod omap44xx_dmm_hwmod;
> =A0static struct omap_hwmod omap44xx_dsp_hwmod;
> =A0static struct omap_hwmod omap44xx_dss_hwmod;
> =A0static struct omap_hwmod omap44xx_emif_fw_hwmod;
> +static struct omap_hwmod omap44xx_fdif_hwmod;
> =A0static struct omap_hwmod omap44xx_hsi_hwmod;
> =A0static struct omap_hwmod omap44xx_ipu_hwmod;
> =A0static struct omap_hwmod omap44xx_iss_hwmod;
> @@ -354,6 +355,14 @@ static struct omap_hwmod_ocp_if omap44xx_dma_sys=
tem__l3_main_2 =3D {
> =A0 =A0 =A0 =A0.user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER_=
SDMA,
> =A0};
>
> +/* fdif -> l3_main_2 */
> +static struct omap_hwmod_ocp_if omap44xx_fdif__l3_main_2 =3D {
> + =A0 =A0 =A0 .master =A0 =A0 =A0 =A0 =3D &omap44xx_fdif_hwmod,
> + =A0 =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D &omap44xx_l3_main_2_hwmod=
,
> + =A0 =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "l3_div_ck",
> + =A0 =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER_S=
DMA,
> +};
> +
> =A0/* hsi -> l3_main_2 */
> =A0static struct omap_hwmod_ocp_if omap44xx_hsi__l3_main_2 =3D {
> =A0 =A0 =A0 =A0.master =A0 =A0 =A0 =A0 =3D &omap44xx_hsi_hwmod,
> @@ -5444,6 +5453,75 @@ static struct omap_hwmod omap44xx_wd_timer3_hw=
mod =3D {
> =A0 =A0 =A0 =A0.slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap44xx_wd_timer3_=
slaves),
> =A0};
>
> +/* 'fdif' class */
> +static struct omap_hwmod_class_sysconfig omap44xx_fdif_sysc =3D {
> + =A0 =A0 =A0 .rev_offs =A0 =A0 =A0 =3D 0x0000,
> + =A0 =A0 =A0 .sysc_offs =A0 =A0 =A0=3D 0x0010,
> + =A0 =A0 =A0 .sysc_flags =A0 =A0 =3D (SYSC_HAS_MIDLEMODE | SYSC_HAS_=
RESET_STATUS |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SYSC_HAS_SIDLEMO=
DE | SYSC_HAS_SOFTRESET),
> + =A0 =A0 =A0 .idlemodes =A0 =A0 =A0=3D (SIDLE_FORCE | SIDLE_NO | SID=
LE_SMART |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MSTANDBY_FORCE |=
 MSTANDBY_NO |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MSTANDBY_SMART),
> + =A0 =A0 =A0 .sysc_fields =A0 =A0=3D &omap_hwmod_sysc_type2,
> +};
> +
> +static struct omap_hwmod_class omap44xx_fdif_hwmod_class =3D {
> + =A0 =A0 =A0 .name =A0 =3D "fdif",
> + =A0 =A0 =A0 .sysc =A0 =3D &omap44xx_fdif_sysc,
> +};
> +
> +/*fdif*/
> +static struct omap_hwmod_addr_space omap44xx_fdif_addrs[] =3D {
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x4a10a000,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x4a10afff,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_TYPE=
_RT
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 { }
> +};
> +
> +/* l4_cfg -> fdif */
> +static struct omap_hwmod_ocp_if omap44xx_l4_cfg__fdif =3D {
> + =A0 =A0 =A0 .master =A0 =A0 =A0 =A0 =3D &omap44xx_l4_cfg_hwmod,
> + =A0 =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D &omap44xx_fdif_hwmod,
> + =A0 =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "l4_div_ck",
> + =A0 =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap44xx_fdif_addrs,
> + =A0 =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER_S=
DMA,
> +};
> +
> +/* fdif slave ports */
> +static struct omap_hwmod_ocp_if *omap44xx_fdif_slaves[] =3D {
> + =A0 =A0 =A0 &omap44xx_l4_cfg__fdif,
> +};
> +static struct omap_hwmod_irq_info omap44xx_fdif_irqs[] =3D {
> + =A0 =A0 =A0 { .irq =3D 69 + OMAP44XX_IRQ_GIC_START },
> + =A0 =A0 =A0 { .irq =3D -1 }
> +};
> +
> +/* fdif master ports */
> +static struct omap_hwmod_ocp_if *omap44xx_fdif_masters[] =3D {
> + =A0 =A0 =A0 &omap44xx_fdif__l3_main_2,
> +};
> +
> +static struct omap_hwmod omap44xx_fdif_hwmod =3D {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "fdif",
> + =A0 =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D &omap44xx_fdif_hwmod_clas=
s,
> + =A0 =A0 =A0 .clkdm_name =A0 =A0 =3D "iss_clkdm",
> + =A0 =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D omap44xx_fdif_irqs,
> + =A0 =A0 =A0 .main_clk =A0 =A0 =A0 =3D "fdif_fck",
> + =A0 =A0 =A0 .prcm =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .omap4 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .clkctrl_offs =3D OMAP4=
_CM_CAM_FDIF_CLKCTRL_OFFSET,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .context_offs =3D OMAP4=
_RM_CAM_FDIF_CONTEXT_OFFSET,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .modulemode =A0 =3D MOD=
ULEMODE_SWCTRL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap44xx_fdif_slaves,
> + =A0 =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap44xx_fdif_slaves=
),
> + =A0 =A0 =A0 .masters =A0 =A0 =A0 =A0=3D omap44xx_fdif_masters,
> + =A0 =A0 =A0 .masters_cnt =A0 =A0=3D ARRAY_SIZE(omap44xx_fdif_master=
s),
> +};
> +
> =A0static __initdata struct omap_hwmod *omap44xx_hwmods[] =3D {
>
> =A0 =A0 =A0 =A0/* dmm class */
> @@ -5593,6 +5671,9 @@ static __initdata struct omap_hwmod *omap44xx_h=
wmods[] =3D {
> =A0 =A0 =A0 =A0&omap44xx_wd_timer2_hwmod,
> =A0 =A0 =A0 =A0&omap44xx_wd_timer3_hwmod,
>
> + =A0 =A0 =A0 /* fdif class */
> + =A0 =A0 =A0 &omap44xx_fdif_hwmod,
> +
> =A0 =A0 =A0 =A0NULL,
> =A0};

thanks,
--
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
