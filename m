From: Jean Pihet <jpihet@mvista.com>
Subject: Re: how to force IVA2 powerdomain OFF on boot
Date: Tue, 25 Nov 2008 11:30:00 +0100
Message-ID: <200811251130.01068.jpihet@mvista.com>
References: <8763mcr248.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_pO9KJoXCetpfbIE"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.158]:15605 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1752491AbYKYKaF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Nov 2008 05:30:05 -0500
In-Reply-To: <8763mcr248.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

--Boundary-00=_pO9KJoXCetpfbIE
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Kevin,

In fact the IVA2 needs to execute the WFI instruction for its domain to go 
into idle.

Fortunately the IVA2 ROM code has some provision to do it in certain cases. 
The trick is to reset the IVA2, configure IVA to boot in idle mode, then let 
it run.

The attached patch might help.

Regards,
Jean.

On Tuesday 25 November 2008 03:05:59 Kevin Hilman wrote:
> Hello,
>
> For some strange reason, some bootloaders (like u-boot on Beagle) seem
> to power up the DSP/IVA2 during boot.  This of course will prevent
> full-chip retention until the IVA is put into retention.
>
> On several boards I've tested the PM branch, after kernel boot the
> unused domains (like SGX, DSS, CAM, IVA2) are all in RET since the
> init code sets next states to retention.  This is working except if
> the bootloader has powered up the IVA2.
>
> I'm trying to figure out why the IVA2 isn't going into RET, even when
> iva2_fck is disabled during boot as part of the 'reset unused clocks'
> feature.
>
> I'm now trying to force the IVA2 into RET/OFF during boot by following
> 'Figure 14-46: IVA2 Power Down' in the TRM (see patch[1] below), but
> that is not working.  IVA2 still stays ON.
>
> Any ideas?
>
> Kevin
>
>
> [1] This is an attempt to implement Figure 14-46, and then
> the 'reset unused clocks' will disable iva2_fck an finish the procedure.
>
> khilman@vence:~/work/kernel/omap/dev$ git diff
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 804b3ac..5ef7cf8 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -591,6 +591,24 @@ int __init omap3_pm_init(void)
>
>  	(void) clkdm_for_each(clkdms_setup, NULL);
>
> +	{
> +		struct powerdomain *iva2_pwrdm;
> +		struct clockdomain *iva2_clkdm;
> +
> +		iva2_pwrdm = pwrdm_lookup("iva2_pwrdm");
> +		iva2_clkdm = clkdm_lookup("iva2_clkdm");
> +
> +		if (iva2_pwrdm && iva2_clkdm) {
> +			u32 pwrst;
> +
> +			pwrdm_set_next_pwrst(iva2_pwrdm, PWRDM_POWER_OFF);
> +			cm_write_mod_reg(0x1, OMAP3430_IVA2_MOD, CM_CLKSTCTRL);
> +			prm_write_mod_reg(0, OMAP3430_IVA2_MOD, PM_WKDEP);
> +			omap2_clkdm_sleep(iva2_clkdm);
> +		} else
> +			printk(KERN_ERR "KJH: Cannot reset IVA2\n");
> +	}
> +
>  	mpu_pwrdm = pwrdm_lookup("mpu_pwrdm");
>  	if (mpu_pwrdm == NULL) {
>  		printk(KERN_ERR "Failed to get mpu_pwrdm\n");
>
>
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--Boundary-00=_pO9KJoXCetpfbIE
Content-Type: text/x-diff;
  charset="iso 8859-15";
  name="0001-OMAP3-Force-IVA2-idle.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-OMAP3-Force-IVA2-idle.patch"

=46rom ee70db50f96681579019db54e2b89b837f34a916 Mon Sep 17 00:00:00 2001
=46rom: Andy Lowe <alowe@mvista.com>
Date: Wed, 8 Oct 2008 19:23:04 -0500
Subject: [PATCH] OMAP3: Force IVA2 idle

The OMAP processor can't suspend unless the IVA2 (dsp) domain is idle.
Transitioning the dsp into the idle state generally requires cooperation fr=
om
the dsp software.  However, in the case that the dsp is not being used, the
MPU must force the dsp into the idle state.  This patch forces the dsp into
the idle state when the prcm is initialized.

Signed-off-by: Andy Lowe <alowe@mvista.com>
=2D--
 arch/arm/mach-omap2/prcm_34xx.c |   42 ++++++++++++++++++++++++++---------=
=2D--
 1 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm_34xx.c b/arch/arm/mach-omap2/prcm_34x=
x.c
index 8e54d6c..f6a3f51 100644
=2D-- a/arch/arm/mach-omap2/prcm_34xx.c
+++ b/arch/arm/mach-omap2/prcm_34xx.c
@@ -4123,19 +4123,35 @@ int prcm_init(void)
 	}
 #endif
=20
=2D	if (is_sil_rev_equal_to(OMAP3430_REV_ES1_0) ||
=2D			is_sil_rev_equal_to(OMAP3430_REV_ES2_0)) {
=2D		/* Due to Errata 1.27, IVA2 will not go to ret/off*/
=2D		/* during bootup.We need to manually boot it to  */
=2D		/* idle mode This is only required during bootup and not for*/
=2D		/* subsequent transitions */
=2D		/* Configure IVA to boot in idle mode */
=2D		CONTROL_IVA2_BOOTMOD =3D 0x1;
=2D		/* Clear reset of IVA2*/
=2D		RM_RSTCTRL_IVA2 =3D 0x0;
=2D		/* Clear reset status */
=2D		RM_RSTST_IVA2 =3D 0xFFFFFFFF;
=2D	}
+	/* Due to Errata 1.27, IVA2 will not go to ret/off
+	 * during bootup.  We need to manually boot it to
+	 * idle mode.  This is only required during bootup and not for
+	 * subsequent transitions.
+	 *
+	 * Note: this is needed on all OMAP revisions to allow
+	 *  suspend/resume to work: IVA2 needs to execute WFI inst
+	 *  for the IVA2 to go in OFF mode
+	 */
+	if (prcm_set_domain_functional_clocks(DOM_IVA2, 0))
+		printk(KERN_ERR "prcm_set_domain_functional_clocks for IVA2 "
+			"failed.\n");
+	RM_RSTCTRL_IVA2 =3D 0xFFFF;	/* Reset IVA2 */
+	if (prcm_set_domain_functional_clocks(DOM_IVA2, 1))
+		printk(KERN_ERR "prcm_set_domain_functional_clocks for IVA2 "
+			"failed.\n");
+	CONTROL_IVA2_BOOTMOD =3D 0x1;	/* set boot mode to idle */
+	RM_RSTCTRL_IVA2 =3D 0x0;		/* unreset the DSP */
+	if (prcm_set_domain_functional_clocks(DOM_IVA2, 0))
+		printk(KERN_ERR "prcm_set_domain_functional_clocks for IVA2 "
+			"failed.\n");
+	RM_RSTCTRL_IVA2 =3D 0xFFFF;	/* Reset IVA2 */
+	if (prcm_force_power_domain_state(DOM_IVA2, PRCM_OFF))
+		printk(KERN_ERR "prcm_set_power_domain_state for IVA2 "
+			"failed.\n");
+	if (prcm_set_clock_domain_state(DOM_IVA2, PRCM_HWSUP_AUTO, PRCM_FALSE))
+		printk(KERN_ERR "prcm_set_clock_domain_state for IVA2 "
+			"failed.\n");
+
 #ifdef CONFIG_HW_SUP_TRANS
 	/* L3, L4 and D2D clock autogating */
 	CM_CLKSTCTRL_CORE =3D (CLK_D2D_HW_SUP_ENABLE | CLK_L4_HW_SUP_ENABLE |
=2D-=20
1.5.4.4.21.gc4a6c


--Boundary-00=_pO9KJoXCetpfbIE--
