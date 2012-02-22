From: Tony Lindgren <tony@atomide.com>
Subject: Re: Latest OMAP randconfig build error
Date: Wed, 22 Feb 2012 09:58:22 -0800
Message-ID: <20120222175822.GV18185@atomide.com>
References: <20120222085130.GE22675@n2100.arm.linux.org.uk>
 <CAK=WgbYxJyLoYs6vcj0dhSSAFX3vHqZAOHcr9t3+xEAh4ZPBNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:34703 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023Ab2BVR60 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Feb 2012 12:58:26 -0500
Content-Disposition: inline
In-Reply-To: <CAK=WgbYxJyLoYs6vcj0dhSSAFX3vHqZAOHcr9t3+xEAh4ZPBNA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, "Anna, Suman" <s-anna@ti.com>

* Ohad Ben-Cohen <ohad@wizery.com> [120222 01:30]:
> + Tony, Suman
> 
> On Wed, Feb 22, 2012 at 10:51 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > arch/arm/mach-omap2/mailbox.c: In function 'omap2_mbox_probe':
> > arch/arm/mach-omap2/mailbox.c:354: error: 'omap2_mboxes' undeclared (first use in this function)
> > arch/arm/mach-omap2/mailbox.c:354: error: (Each undeclared identifier is reported only once
> > arch/arm/mach-omap2/mailbox.c:354: error: for each function it appears in.)
> 
> The below should trivially solve this, but I wonder if there was any
> other merit in explicitly using CONFIG_SOC_OMAP2420 there (any
> different between 2420 and 2430 in that respect ?).
> 
> diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
> index 609ea2d..e61d275 100644
> --- a/arch/arm/mach-omap2/mailbox.c
> +++ b/arch/arm/mach-omap2/mailbox.c
> @@ -258,7 +258,7 @@ struct omap_mbox mbox_dsp_info = {
>  struct omap_mbox *omap3_mboxes[] = { &mbox_dsp_info, NULL };
>  #endif
> 
> -#if defined(CONFIG_SOC_OMAP2420)
> +#if defined(CONFIG_ARCH_OMAP2)
>  /* IVA */
>  static struct omap_mbox2_priv omap2_mbox_iva_priv = {
>  	.tx_fifo = {

2430 is like omap3 for the mailbox. So the code we have seems
wrong trying to initialize it like 2420 mailbox. So we either
need a new entry for omap2430_mboxes[], or should just bail
out from the probe for 2430 for the fix.

Regards,

Tony
