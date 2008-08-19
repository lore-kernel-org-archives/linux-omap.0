From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 07/16] ARM: OMAP2: Add clkdm_get_pwrdm()
Date: Tue, 19 Aug 2008 18:29:54 +0100
Message-ID: <20080819172953.GD17034@flint.arm.linux.org.uk>
References: <1212804762-18413-1-git-send-email-tony@atomide.com> <1212804762-18413-2-git-send-email-tony@atomide.com> <1212804762-18413-3-git-send-email-tony@atomide.com> <1212804762-18413-4-git-send-email-tony@atomide.com> <1212804762-18413-5-git-send-email-tony@atomide.com> <1212804762-18413-6-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41667 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753206AbYHSRaF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Aug 2008 13:30:05 -0400
Content-Disposition: inline
In-Reply-To: <1212804762-18413-6-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Fri, Jun 06, 2008 at 07:12:33PM -0700, Tony Lindgren wrote:
> From: Paul Walmsley <paul@pwsan.com>
> 
> Add clkdm_get_pwrdm() to the clockdomain code.  It will return a
> pointer to the powerdomain struct that the clockdomain is contained
> within.  Used by the PM code.
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

This patch should have been merged into the patch creating clockdomain.c
before it was sent upstream.  It's clearly a function which was missed
out of Paul's original patch.

There's no requirement to ensure that every bit of microscopic history
behind the development of a feature is preserved into the mainline
kernel tree - it's actually preferred that it isn't.

Another reason for doing so is to cut down on the amount of reviewing
that has to be done upstream.  Given the amount of churn in OMAP land,
reducing compressing changes _sanely_ should be a priority.

> diff --git a/include/asm-arm/arch-omap/clockdomain.h b/include/asm-arm/arch-omap/clockdomain.h
> index d2a4551..e71fee4 100644
> --- a/include/asm-arm/arch-omap/clockdomain.h
> +++ b/include/asm-arm/arch-omap/clockdomain.h
> @@ -94,6 +94,9 @@ struct clockdomain *clkdm_lookup(const char *name);
>  int clkdm_for_each(int (*fn)(struct clockdomain *clkdm));
>  struct powerdomain *clkdm_get_pwrdm(struct clockdomain *clkdm);
>  
> +int clkdm_for_each(int (*fn)(struct clockdomain *clkdm));
> +struct powerdomain *clkdm_get_pwrdm(struct clockdomain *clkdm);
> +

These prototypes are already there, so this isn't required.
