From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv3 20/22] OMAP3: PM: VP force update method of voltage scaling
Date: Tue, 27 Apr 2010 09:23:20 -0700
Message-ID: <87zl0oq2yv.fsf@deeprootsystems.com>
References: <1271408597-3066-1-git-send-email-thara@ti.com>
	<1271408597-3066-2-git-send-email-thara@ti.com>
	<1271408597-3066-3-git-send-email-thara@ti.com>
	<1271408597-3066-4-git-send-email-thara@ti.com>
	<1271408597-3066-5-git-send-email-thara@ti.com>
	<1271408597-3066-6-git-send-email-thara@ti.com>
	<1271408597-3066-7-git-send-email-thara@ti.com>
	<1271408597-3066-8-git-send-email-thara@ti.com>
	<1271408597-3066-9-git-send-email-thara@ti.com>
	<1271408597-3066-10-git-send-email-thara@ti.com>
	<1271408597-3066-11-git-send-email-thara@ti.com>
	<1271408597-3066-12-git-send-email-thara@ti.com>
	<1271408597-3066-13-git-send-email-thara@ti.com>
	<1271408597-3066-14-git-send-email-thara@ti.com>
	<1271408597-3066-15-git-send-email-thara@ti.com>
	<1271408597-3066-16-git-send-email-thara@ti.com>
	<1271408597-3066-17-git-send-email-thara@ti.com>
	<1271408597-3066-18-git-send-email-thara@ti.com>
	<1271408597-3066-19-git-send-email-thara@ti.com>
	<1271408597-3066-20-git-send-email-thara@ti.com>
	<1271408597-3066-21-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f204.google.com ([209.85.222.204]:59793 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756281Ab0D0QXZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Apr 2010 12:23:25 -0400
Received: by pzk42 with SMTP id 42so9016109pzk.4
        for <linux-omap@vger.kernel.org>; Tue, 27 Apr 2010 09:23:24 -0700 (PDT)
In-Reply-To: <1271408597-3066-21-git-send-email-thara@ti.com> (Thara Gopinath's message of "Fri\, 16 Apr 2010 14\:33\:15 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com

Thara Gopinath <thara@ti.com> writes:

> This patch introduces VP force update method of voltage scaling
> and enables it by default. The older method of vc bypass is now
> configuratble through a menu config option. VP force update is the
> hardware recommended method of voltage scaling.
>
> Signed-off-by: Thara Gopinath <thara@ti.com>

Hi Thara,

Could you (re) test this along with my changes to the PRCM IRQ handler:

  https://patchwork.kernel.org/patch/95450/

I made a change (suggested by Mike Turquette) that affects how that
ISR clears PRCM interrupts.  Previously, it would possibly interfere
with events you're polling for here, but it may never have seen.

[...]

> diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
> index 8800369..473a953 100644
> --- a/arch/arm/mach-omap2/voltage.h
> +++ b/arch/arm/mach-omap2/voltage.h
> @@ -14,7 +14,10 @@
>  #define VDD1	0
>  #define VDD2	1
>  
> +#define VOLTSCALE_VPFORCEUPDATE		1
> +#define VOLTSCALE_VCBYPASS		2
>  
> +#define PRM_IRQSTATUS_REG_OFFSET	OMAP3_PRM_IRQSTATUS_MPU_OFFSET

Don't use another #define, just use OMAP3_PRM_IRQSTATUS_MPU_OFFSET in
code directly Please.

Kevin
