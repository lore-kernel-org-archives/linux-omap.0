From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH] ARM: OMAP: avoid NULL pointer dereference when no PMIC
 is configured
Date: Mon, 19 Dec 2011 10:10:11 +0200
Message-ID: <4EEEF163.7030608@compulab.co.il>
References: <1324235628-26439-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:55770
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752498Ab1LSIKU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Dec 2011 03:10:20 -0500
In-Reply-To: <1324235628-26439-1-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>

Hi Daniel,

On 12/18/11 21:13, Daniel Mack wrote:
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> Cc: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/vp.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/vp.c b/arch/arm/mach-omap2/vp.c
> index 66bd700..5407173 100644
> --- a/arch/arm/mach-omap2/vp.c
> +++ b/arch/arm/mach-omap2/vp.c
> @@ -41,6 +41,11 @@ void __init omap_vp_init(struct voltagedomain *voltdm)
>  	u32 val, sys_clk_rate, timeout, waittime;
>  	u32 vddmin, vddmax, vstepmin, vstepmax;
>  
> +	if (!voltdm->pmic) {
> +		pr_err("%s: No PMIC configured.\n", __func__, voltdm->name);

You are passing two parameters to pr_err(), but use only one...
Also, I don't know if this is the right thing to do here,
so Cc'ed Paul and Kevin.

> +		return;
> +	}
> +
>  	if (!voltdm->read || !voltdm->write) {
>  		pr_err("%s: No read/write API for accessing vdd_%s regs\n",
>  			__func__, voltdm->name);

-- 
Regards,
Igor.
