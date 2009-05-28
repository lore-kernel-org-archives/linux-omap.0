From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 02/13] OMAP2/3: PM: push core PM code from linux-omap
Date: Thu, 28 May 2009 16:48:23 +0100
Message-ID: <20090528154823.GD20736@n2100.arm.linux.org.uk>
References: <1242861576-13008-1-git-send-email-khilman@deeprootsystems.com> <1242861576-13008-2-git-send-email-khilman@deeprootsystems.com> <1242861576-13008-3-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:33979 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754945AbZE1Psd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 May 2009 11:48:33 -0400
Content-Disposition: inline
In-Reply-To: <1242861576-13008-3-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Wed, May 20, 2009 at 04:19:25PM -0700, Kevin Hilman wrote:
> This patch is to sync the core linux-omap PM code with mainline.  This
> code has evolved and been used for a while the linux-omap tree, but
> the attempt here is to finally get this into mainline.

Hmm..

> +static int __init omap_pm_init(void)
>  {
> -	return 0;
> +	int error = -1;
> +
> +	if (cpu_is_omap24xx())
> +		error = omap2_pm_init();
> +	if (cpu_is_omap34xx())
> +		error = omap3_pm_init();

Experience with PXA has shown that this tends to be the wrong way up
of doing things.  It seems to be much better to have the SoC specific
code call the SoC generic code instead.

So, eg, omap2_pm_init() becomes:

static int omap2_pm_init(void)
{
	if (!cpu_is_omap24xx())
		return -ENODEV;

	... omap24xx initialisation ...

	return omap_pm_init();
}
late_initcall(omap2_pm_init);

(and, since this is always built-in, there's no point doing cleanup if
omap_pm_init() fails - you're not going to be able to re-run that
initialization again.)

