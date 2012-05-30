From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCHv2 19/19] ARM: OMAP4: powerdomain: update mpu / core off
 counters during device off
Date: Wed, 30 May 2012 16:08:25 -0500
Message-ID: <CAOMWX4fV_UEOuUi3M0yT5QfyunAw7Gf85LoXOP2DquQzv=rB6w@mail.gmail.com>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com> <1336990730-26892-20-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:55157 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751859Ab2E3VIs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 May 2012 17:08:48 -0400
Received: by werm13 with SMTP id m13so191143wer.29
        for <linux-omap@vger.kernel.org>; Wed, 30 May 2012 14:08:45 -0700 (PDT)
In-Reply-To: <1336990730-26892-20-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

On Mon, May 14, 2012 at 5:18 AM, Tero Kristo <t-kristo@ti.com> wrote:
> Currently device off does not have any counters / timers of its own
> and it is impossible to track the time spent in this state. In device
> off, MPU / CORE powerdomains enter OSWR, so normally the RETENTION
> state times / counts are increased during device off.
>
> This patch adds a new field to the powerdomain struct for context los=
s
> register, which is checked during pwrdm_post_transition to see if
> a device off type context loss has happened. If this is the case,
> the counters + timers for OFF state are touched instead of RETENTION.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
> =A0arch/arm/mach-omap2/omap-mpuss-lowpower.c =A0 | =A0 =A01 -
> =A0arch/arm/mach-omap2/powerdomain.c =A0 =A0 =A0 =A0 =A0 | =A0 =A09 +=
++++++++
> =A0arch/arm/mach-omap2/powerdomain.h =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +=
+
> =A0arch/arm/mach-omap2/powerdomains44xx_data.c | =A0 =A02 ++
> =A0arch/arm/mach-omap2/prm44xx.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 15=
 +++++++++++++++
> =A0arch/arm/mach-omap2/prm44xx.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A0=
2 ++
> =A06 files changed, 30 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mac=
h-omap2/omap-mpuss-lowpower.c
> index 1f06f97..f187025 100644
> --- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> +++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> @@ -404,7 +404,6 @@ int omap4_enter_lowpower(unsigned int cpu, unsign=
ed int power_state)
> =A0 =A0 =A0 =A0if (omap4_device_prev_state_off()) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap4_dpll_resume_off();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap4_cm_resume_off();
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap4_device_clear_prev_off_state();

We should probably delete the function in it's entirety - not just the
call - the original implementation just clears L3 and this
implementation seems superior.

> =A0 =A0 =A0 =A0}
>
> =A0sar_save_failed:
> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/=
powerdomain.c
> index 96ad3dbe..f13bb2c 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -156,6 +156,15 @@ static int _pwrdm_state_switch(struct powerdomai=
n *pwrdm, int flag)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0case PWRDM_STATE_PREV:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0prev =3D pwrdm_read_prev_pwrst(pwrdm);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* If powerdomain has context offset =
defined, check if
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* the domain has lost context (i.e. =
entered off)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pwrdm->context_offs)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (omap4_pwrdm_lost_co=
ntext_rff(pwrdm->prcm_offs,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pwrdm->context_offs))

We should wrap this under pwrdm_lost_context(pwrdm)
pwrdm_lost_context should call the arch_pwrdm->lost_context_rff as
needed? the rest of the powerdomain.c does not use OMAP4 specific
APIs.


> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 prev =3D=
 PWRDM_POWER_OFF;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (pwrdm->state !=3D prev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pwrdm->state_counter[p=
rev]++;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (prev =3D=3D PWRDM_POWER_RET)
> diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/=
powerdomain.h
> index 0d72a8a..a427645 100644
> --- a/arch/arm/mach-omap2/powerdomain.h
> +++ b/arch/arm/mach-omap2/powerdomain.h
> @@ -82,6 +82,7 @@ struct powerdomain;
> =A0* @name: Powerdomain name
> =A0* @voltdm: voltagedomain containing this powerdomain
> =A0* @prcm_offs: the address offset from CM_BASE/PRM_BASE
> + * @context_offs: the address offset for the CONTEXT register
> =A0* @prcm_partition: (OMAP4 only) the PRCM partition ID containing @=
prcm_offs
> =A0* @pwrsts: Possible powerdomain power states
> =A0* @pwrsts_logic_ret: Possible logic power states when pwrdm in RET=
ENTION
> @@ -106,6 +107,7 @@ struct powerdomain {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct voltagedomain *ptr;
> =A0 =A0 =A0 =A0} voltdm;
> =A0 =A0 =A0 =A0const s16 prcm_offs;
> + =A0 =A0 =A0 const s16 context_offs;
> =A0 =A0 =A0 =A0const u8 pwrsts;
> =A0 =A0 =A0 =A0const u8 pwrsts_logic_ret;
> =A0 =A0 =A0 =A0const u8 flags;
> diff --git a/arch/arm/mach-omap2/powerdomains44xx_data.c b/arch/arm/m=
ach-omap2/powerdomains44xx_data.c
> index d8701ce..c4de02f 100644
> --- a/arch/arm/mach-omap2/powerdomains44xx_data.c
> +++ b/arch/arm/mach-omap2/powerdomains44xx_data.c
> @@ -36,6 +36,7 @@ static struct powerdomain core_44xx_pwrdm =3D {
> =A0 =A0 =A0 =A0.voltdm =A0 =A0 =A0 =A0 =A0 =3D { .name =3D "core" },
> =A0 =A0 =A0 =A0.prcm_offs =A0 =A0 =A0 =A0=3D OMAP4430_PRM_CORE_INST,
> =A0 =A0 =A0 =A0.prcm_partition =A0 =3D OMAP4430_PRM_PARTITION,
> + =A0 =A0 =A0 .context_offs =A0 =A0 =3D OMAP4_RM_L3_1_L3_1_CONTEXT_OF=
=46SET,
> =A0 =A0 =A0 =A0.pwrsts =A0 =A0 =A0 =A0 =A0 =3D PWRSTS_RET_ON,
> =A0 =A0 =A0 =A0.pwrsts_logic_ret =3D PWRSTS_OFF_RET,
> =A0 =A0 =A0 =A0.banks =A0 =A0 =A0 =A0 =A0 =A0=3D 5,
> @@ -205,6 +206,7 @@ static struct powerdomain mpu_44xx_pwrdm =3D {
> =A0 =A0 =A0 =A0.voltdm =A0 =A0 =A0 =A0 =A0 =3D { .name =3D "mpu" },
> =A0 =A0 =A0 =A0.prcm_offs =A0 =A0 =A0 =A0=3D OMAP4430_PRM_MPU_INST,
> =A0 =A0 =A0 =A0.prcm_partition =A0 =3D OMAP4430_PRM_PARTITION,
> + =A0 =A0 =A0 .context_offs =A0 =A0 =3D OMAP4_RM_MPU_MPU_CONTEXT_OFFS=
ET,
> =A0 =A0 =A0 =A0.pwrsts =A0 =A0 =A0 =A0 =A0 =3D PWRSTS_RET_ON,
> =A0 =A0 =A0 =A0.pwrsts_logic_ret =3D PWRSTS_OFF_RET,
> =A0 =A0 =A0 =A0.banks =A0 =A0 =A0 =A0 =A0 =A0=3D 3,

Why are we not populating the rest of the CONTEXT_OFFSET registers?

> diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm4=
4xx.c
> index 86c6c6b..de9132f 100644
> --- a/arch/arm/mach-omap2/prm44xx.c
> +++ b/arch/arm/mach-omap2/prm44xx.c
> @@ -289,6 +289,21 @@ static void __init omap44xx_prm_enable_io_wakeup=
(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP4_PRM_IO_PMCTRL_OF=
=46SET);
> =A0}
>
> +bool omap4_pwrdm_lost_context_rff(s16 inst, s16 offset)
> +{
> + =A0 =A0 =A0 u32 val;
> +
> + =A0 =A0 =A0 val =3D omap4_prminst_read_inst_reg(OMAP4430_PRM_PARTIT=
ION, inst, offset);
> +
> + =A0 =A0 =A0 if (val & OMAP4430_LOSTCONTEXT_RFF_MASK) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap4_prminst_write_inst_reg(val, OMAP4=
430_PRM_PARTITION, inst,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0offset);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return true;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return false;
> +}
> +

could move to powerdomain4xx.c?

> =A0/**
> =A0* omap4_device_set_state_off() - setup device off state
> =A0* @enable: =A0 =A0set to off or not.
> diff --git a/arch/arm/mach-omap2/prm44xx.h b/arch/arm/mach-omap2/prm4=
4xx.h
> index ee72ae6..fa76d9c 100644
> --- a/arch/arm/mach-omap2/prm44xx.h
> +++ b/arch/arm/mach-omap2/prm44xx.h
> @@ -771,6 +771,8 @@ extern void omap44xx_prm_ocp_barrier(void);
> =A0extern void omap44xx_prm_save_and_clear_irqen(u32 *saved_mask);
> =A0extern void omap44xx_prm_restore_irqen(u32 *saved_mask);
>
> +extern bool omap4_pwrdm_lost_context_rff(s16 inst, s16 offset);
we dont need to do this if we use arch_pwrdm->
> +
> =A0# endif
>
> =A0#endif

---
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
