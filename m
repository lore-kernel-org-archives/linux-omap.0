From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: PM: remove a junk print
Date: Thu, 09 Jul 2009 06:38:54 -0700
Message-ID: <87tz1myo0h.fsf@deeprootsystems.com>
References: <1247145913-12639-1-git-send-email-Artem.Bityutskiy@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f175.google.com ([209.85.222.175]:53719 "EHLO
	mail-pz0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760147AbZGINi6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jul 2009 09:38:58 -0400
Received: by pzk5 with SMTP id 5so119549pzk.33
        for <linux-omap@vger.kernel.org>; Thu, 09 Jul 2009 06:38:57 -0700 (PDT)
In-Reply-To: <1247145913-12639-1-git-send-email-Artem.Bityutskiy@nokia.com> (Artem Bityutskiy's message of "Thu\,  9 Jul 2009 16\:25\:13 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
Cc: linux-omap@vger.kernel.org

Artem Bityutskiy <Artem.Bityutskiy@nokia.com> writes:

> The pm_dbg_init() print does not look like something useful, probably
> just a leftover. Kill it.

Indeed.

Pushed to PM branch.

Kevin

> Signed-off-by: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
> ---
> [The previous git-send-email attempt crewed up the subject, re-sending]
>
>  arch/arm/mach-omap2/pm-debug.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
> index 2768510..33cc6b9 100644
> --- a/arch/arm/mach-omap2/pm-debug.c
> +++ b/arch/arm/mach-omap2/pm-debug.c
> @@ -526,8 +526,6 @@ static int __init pm_dbg_init(void)
>  	struct dentry *d;
>  	char name[2];
>  
> -	printk(KERN_INFO "pm_dbg_init()\n");
> -
>  	d = debugfs_create_dir("pm_debug", NULL);
>  	if (IS_ERR(d))
>  		return PTR_ERR(d);
> -- 
> 1.6.0.6
