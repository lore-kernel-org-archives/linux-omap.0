From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: id: Add missing break statement in
 omap3xxx_check_revision
Date: Thu, 26 Jan 2012 16:25:43 -0800
Message-ID: <20120127002543.GG29812@atomide.com>
References: <1327305407-19914-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:46985 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751581Ab2A0AZr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jan 2012 19:25:47 -0500
Content-Disposition: inline
In-Reply-To: <1327305407-19914-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, hemantp@ti.com, linux-arm-kernel@lists.infradead.org

* Vaibhav Hiremath <hvaibhav@ti.com> [120122 23:26]:
> Add missing break statement in the function omap3xxx_check_revision.
> 
> The commit id 4390f5b2cb1f56 [ARM: OMAP: TI814X: Add cpu type macros
> and detection support], removed the 'break' statement from the function
> omap3xxx_check_revision(), resulting into wrong omap/cpu_revision
> initialization for AM335x devices.

Looks like this is already fixed, can you please verify with
v3.3-rc1?

Regards,

Tony
 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/id.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index 325e12e..32cf203 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -395,6 +395,7 @@ void __init omap3xxx_check_revision(void)
>  	case 0xb944:
>  		omap_revision = AM335X_REV_ES1_0;
>  		cpu_rev = "1.0";
> +		break;
>  	case 0xb8f2:
>  		switch (rev) {
>  		case 0:
> --
> 1.7.0.4
> 
