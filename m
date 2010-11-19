From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 08/13] OMAP3: PM: Deny MPU idle while saving secure RAM
Date: Fri, 19 Nov 2010 09:08:57 -0800
Message-ID: <87eiahckba.fsf@deeprootsystems.com>
References: <1290131698-6194-1-git-send-email-nm@ti.com>
	<1290131698-6194-9-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:33138 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753301Ab0KSRJC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Nov 2010 12:09:02 -0500
Received: by yxf34 with SMTP id 34so2824697yxf.19
        for <linux-omap@vger.kernel.org>; Fri, 19 Nov 2010 09:09:01 -0800 (PST)
In-Reply-To: <1290131698-6194-9-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Thu, 18 Nov 2010 19:54:53 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Jean Pihet <jean.pihet@newoldbits.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Tony <tony@atomide.com>

Nishanth Menon <nm@ti.com> writes:

> From: Eduardo Valentin <eduardo.valentin@nokia.com>
>
> Deny MPU idle before save secure ram and allow it after save secure RAM.
> We want to deny MPU going to low power state because, there is a short
> time window where a wakeup event would happen around the time the MPU
> is going to idle. Since the first thing ROM code does after WFI is to
> read INTCPS register, we could reach a situation where the INTCPS is
> in idle, but the read is sent to it. That would produce a data abord
> during the save of secure ram, which will hang the system. we need
> to prevent clock transitions as well during this timeframe.

This changelog needs to be a bit clearer about exacly why MPU would be
going to a low power state during a secure-mode call.  IIUC, it's
because the ROM code might do a WFI.  Since it's completely
non-intuitive (and broken, at least to me) that the ROM code would do a
WFI, this should be stated explicitly in the changelog, and probably in
the code too. 

Also, this approach only solves this problem for this particular
secure-mode call.  Presumably there are other secure-mode calls that
might WFI as well, and will have the same problem. As I'm not familiar
with secure ROM or PPAs, so I don't know if this is true or not.  If it
is, then somethen more general should be done.

Also, do we care about other powerdomains (besides MPU) going idle
during a secure mode call?

Because of those issues, some other proposals have been floated for this
problem.  In particular, explicitly setting some of the powerdomain next
states (at least MPU & CORE) to ON when we're not in the normal idle
path so that would also prevent this problem.

I guess we need some more details on which secure mode calls can trigger
this problem.  If this is an isolated case, I'm OK with this fix.  If
it's more general, I'd like to see a more general fix.

Kevin

> [nm@ti.com: rebased to 2.6.37-rc2, used omap2_clkdm_deny_idle for
> clock prevention]
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
> ---
>  arch/arm/mach-omap2/pm34xx.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 7877f74..f520b38 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -194,15 +194,19 @@ int __init omap3_secure_copy_data_set(struct omap3_secure_copy_data *data)
>  static void omap3_save_secure_ram_context(u32 target_mpu_state)
>  {
>  	if (!secure_ram_saved && omap_type() != OMAP2_DEVICE_TYPE_GP) {
> +		struct clockdomain *clkd = mpu_pwrdm->pwrdm_clkdms[0];
> +
>  		/*
>  		 * MPU next state must be set to POWER_ON temporarily,
>  		 * otherwise the WFI executed inside the ROM code
>  		 * will hang the system.
>  		 */
>  		pwrdm_set_next_pwrst(mpu_pwrdm, PWRDM_POWER_ON);
> +		omap2_clkdm_deny_idle(clkd);
>  		secure_ram_save_status = _omap_save_secure_sram((u32 *)
>  				(omap3_secure_ram_storage));
>  		pwrdm_set_next_pwrst(mpu_pwrdm, target_mpu_state);
> +		omap2_clkdm_allow_idle(clkd);
>  		if (!secure_copy_data.save_every_cycle)
>  			secure_ram_saved = 1;
>  	}
