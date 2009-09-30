From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: PM: Enable GPIO module-level wakeups
Date: Wed, 30 Sep 2009 11:20:51 -0700
Message-ID: <636c5030909301120l623ffac2v8b8469745cf90c40@mail.gmail.com>
References: <1252597988-23561-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f194.google.com ([209.85.216.194]:52890 "EHLO
	mail-px0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754289AbZI3SUr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Sep 2009 14:20:47 -0400
Received: by pxi32 with SMTP id 32so5692640pxi.4
        for <linux-omap@vger.kernel.org>; Wed, 30 Sep 2009 11:20:51 -0700 (PDT)
In-Reply-To: <1252597988-23561-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Mike Chan <mikechan@google.com>, rschultz@google.com

On Thu, Sep 10, 2009 at 8:53 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Currently, only GPIOs in the wakeup domain (GPIOs in bank 0) are
> enabled as wakups. =A0This patch also enables GPIOs in the PER
> powerdomain (banks 2-6) to be used as possible wakeup sources.
>
> In addition, this patch ensures that all GPIO wakeups can wakeup
> the MPU using the PM_MPUGRPSEL_<pwrdm> registers.
>
> NOTE: this doesn't enable the individual GPIOs as wakeups, this simpl=
y
> enables the per-bank wakeups at the powerdomain level.
>
> This problem was discovered by Mike Chan when preventing the CORE
> powerdomain from going into retention/off. =A0When CORE was allowed t=
o
> hit retention, GPIO wakeups via IO pad were working fine, but when
> CORE remained on, GPIO module-level wakeups were not working properly=
=2E
>
> To test, prevent CORE from going inactive/retention/off, thus
> preventing the IO chain from being armed:
>
> =A0# echo 3 > /debug/pm_debug/core_pwrdm/suspend
>
> This ensures that GPIO wakeups happen via module-level wakeups and
> not via IO pad.
>
> Tested on 3430SDP using the touchscreen GPIO (gpio 2, in WKUP)
> Tested on Zoom2 using the QUART interrup GPIO =A0(gpio 102, in PER)
>
> Also, c.f. OMAP PM wiki for troubleshooting GPIO wakeup issues:
> http://elinux.org/OMAP_Power_Management
>
> Reported-by: Mike Chan <mikechan@google.com>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

Pushing to PM branch and queeing for 2.6.32 fixes.

Kevin

> ---
> =A0arch/arm/mach-omap2/pm34xx.c | =A0 10 ++++++++++
> =A01 files changed, 10 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34x=
x.c
> index 3d62b06..8166118 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -918,6 +918,16 @@ static void __init prcm_setup_regs(void)
> =A0 =A0 =A0 =A0prm_write_mod_reg(OMAP3430_IO_EN | OMAP3430_WKUP_EN,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OCP_MOD, OMAP3_PRM=
_IRQENABLE_MPU_OFFSET);
>
> + =A0 =A0 =A0 /* Enable GPIO wakeups in PER */
> + =A0 =A0 =A0 prm_write_mod_reg(OMAP3430_EN_GPIO2 | OMAP3430_EN_GPIO3=
 |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP3430_EN_GPIO4 |=
 OMAP3430_EN_GPIO5 |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP3430_EN_GPIO6, =
OMAP3430_PER_MOD, PM_WKEN);
> + =A0 =A0 =A0 /* and allow them to wake up MPU */
> + =A0 =A0 =A0 prm_write_mod_reg(OMAP3430_GRPSEL_GPIO2 | OMAP3430_EN_G=
PIO3 |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP3430_GRPSEL_GPI=
O4 | OMAP3430_EN_GPIO5 |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP3430_GRPSEL_GPI=
O6,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP3430_PER_MOD, O=
MAP3430_PM_MPUGRPSEL);
> +
> =A0 =A0 =A0 =A0/* Don't attach IVA interrupts */
> =A0 =A0 =A0 =A0prm_write_mod_reg(0, WKUP_MOD, OMAP3430_PM_IVAGRPSEL);
> =A0 =A0 =A0 =A0prm_write_mod_reg(0, CORE_MOD, OMAP3430_PM_IVAGRPSEL1)=
;
> --
> 1.6.4
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
