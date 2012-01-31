From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] ARM: OMAP3+: PM debug: fix the use of debugfs_create_* API
Date: Tue, 31 Jan 2012 09:44:10 -0800
Message-ID: <87ehufojh1.fsf@ti.com>
References: <1328008819-1110-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:57004 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752351Ab2AaRoO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 Jan 2012 12:44:14 -0500
Received: by vcbfl13 with SMTP id fl13so271821vcb.7
        for <linux-omap@vger.kernel.org>; Tue, 31 Jan 2012 09:44:12 -0800 (PST)
In-Reply-To: <1328008819-1110-1-git-send-email-j-pihet@ti.com> (Jean Pihet's
	message of "Tue, 31 Jan 2012 12:20:19 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>, Jean Pihet <j-pihet@ti.com>

Jean Pihet <jean.pihet@newoldbits.com> writes:

> The debugfs_create_* API returns a NULL ptr in case of problem.
> Fix the PM debug code to take this into account.
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> ---
>  arch/arm/mach-omap2/pm-debug.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
> index 4411163..e5bf367 100644
> --- a/arch/arm/mach-omap2/pm-debug.c
> +++ b/arch/arm/mach-omap2/pm-debug.c
> @@ -264,8 +264,8 @@ static int __init pm_dbg_init(void)
>  		return 0;
>  
>  	d = debugfs_create_dir("pm_debug", NULL);
> -	if (IS_ERR(d))
> -		return PTR_ERR(d);
> +	if (!d)

I think this should be IS_ERR_OR_NULL() because this function can also
return ERR_PTR(-ENODEV).  (Yes, only when debugfs is not enabled, but
it's still more correct.)

Kevin

> +		return -ENOMEM;
>  	(void) debugfs_create_file("count", S_IRUGO,
>  		d, (void *)DEBUG_FILE_COUNTERS, &debug_fops);
