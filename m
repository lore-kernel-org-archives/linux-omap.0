From: "Girish S G" <girishsg@ti.com>
Subject: RE: [PATCH 01/17] PM: fix suspend control for IVA2
Date: Fri, 16 Oct 2009 12:16:13 -0500
Message-ID: <004e01ca4e84$5d0aa9f0$3d1018ac@am.dhcp.ti.com>
References: <> <1255690150-16853-1-git-send-email-tero.kristo@nokia.com> <1255690150-16853-2-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49604 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751071AbZJPRQP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Oct 2009 13:16:15 -0400
In-Reply-To: <1255690150-16853-2-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Tero Kristo' <tero.kristo@nokia.com>, linux-omap@vger.kernel.org



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Tero
> Kristo
> 
> From: Tero Kristo <tero.kristo@nokia.com>
> 
> IVA2 controls its target power state individually, thus suspend should not
> touch IVA2. Without this patch DSP suspend always fails.
> 
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
> Acked-by: Ameya Palande <ameya.palande@nokia.com>
> ---
>  arch/arm/mach-omap2/pm34xx.c |    9 ++++++++-
>  1 files changed, 8 insertions(+), 1 deletions(-)
> 
>  static struct prm_setup_vc prm_setup = {
>  	.clksetup = 0xff,
> @@ -676,6 +676,12 @@ static int omap3_pm_suspend(void)
>  		pwrst->saved_state = pwrdm_read_next_pwrst(pwrst->pwrdm);
>  	/* Set ones wanted by suspend */
>  	list_for_each_entry(pwrst, &pwrst_list, node) {
> +		/* Special handling for IVA2, just use current sleep state */
> +		if (pwrst->pwrdm == iva2_pwrdm) {
> +			state = pwrdm_read_pwrst(pwrst->pwrdm);
> +			if (state < PWRDM_POWER_ON)
> +				pwrst->next_state = state;
> +		}

Agree, IVA2 pwrdm is handled autonomously by bridge. I think this needs some additional change to remove all the redundant
configuration of iva pwdm. There are some inconsistencies like, 
	- Say enable_off_mode is disabled. Before doing system wide suspend if DSP hibernates then IVA2 will be put to OFF. In that
case we have IVA2 going to OFF and other domains in RET. This might not be an issue, but it's bad from sytem PM framework integrity
perspective.
	- enable_off_mode->omap3_pm_off_mode_enable will also touch IVA2 power domain next state. This we don't want to do if dsp
bridge is already taking care of IVA2.

IMO, we need to have some mechanism wherein if bridge PM takes care of IVA then PM framework should not configure the IVA
powerstate. It should only do if bridge PM is disabled.


-Girish

  


