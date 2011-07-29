From: Todd Poynor <toddpoynor@google.com>
Subject: Re: [PATCH 07/13] OMAP PM: early init of the pwrdms states
Date: Fri, 29 Jul 2011 01:08:20 -0700
Message-ID: <20110729080820.GB26959@google.com>
References: <1311841821-10252-1-git-send-email-j-pihet@ti.com>
 <1311841821-10252-8-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:27471 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751930Ab1G2IIy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Jul 2011 04:08:54 -0400
Content-Disposition: inline
In-Reply-To: <1311841821-10252-8-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Magnus Damm <magnus.damm@gmail.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, markgross@thegnar.org, broonie@opensource.wolfsonmicro.com, Jean Pihet <j-pihet@ti.com>, rnayak@ti.com

On Thu, Jul 28, 2011 at 10:30:14AM +0200, jean.pihet@newoldbits.com wrote:
> From: Jean Pihet <j-pihet@ti.com>
> 
> The powerdomains next states are initialized in pwrdms_setup as a
> late_initcall. Because the PM QoS devices constraint can be requested
> early in the boot sequence, the power domains next states can be
> overwritten by pwrdms_setup.
> 
> This patch fixes it by initializing the power domains next states
> early at boot, so that the constraints can be applied.
> Later in the pwrdms_setup function the currently programmed
> next states are re-used as next state values.
> 
> Applies to OMAP3 and OMAP4.
> 
> Tested on OMAP3 Beagleboard and OMAP4 Pandaboard in RET/OFF using
> wake-up latency constraints on MPU, CORE and PER.
> 
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> ---
...
> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
> index 9af0847..63c3e7a 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -108,6 +108,9 @@ static int _pwrdm_register(struct powerdomain *pwrdm)
>  	pwrdm->state = pwrdm_read_pwrst(pwrdm);
>  	pwrdm->state_counter[pwrdm->state] = 1;
>  
> +	/* Early init of the next power state */
> +	pwrdm_set_next_pwrst(pwrdm, PWRDM_POWER_RET);
> +

Wanted to check that it's OK to initialize the next state of a power
domain to RETENTION early in the boot sequence.  I believe patches
have been previously discussed that set the state to ON to ensure the
domain doesn't go to a lower state, and possibly lose context, before
the PM subsystem is setup to handle it?  Not sure, thought maybe worth
a doublecheck.


Todd

