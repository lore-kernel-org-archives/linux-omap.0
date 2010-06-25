From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 7/8] OMAP: PM: Allowing an early init of pm debugfs driver.
Date: Fri, 25 Jun 2010 15:55:52 -0700
Message-ID: <87wrtmbu2v.fsf@deeprootsystems.com>
References: <1275150748-15386-1-git-send-email-thara@ti.com>
	<1275150748-15386-2-git-send-email-thara@ti.com>
	<1275150748-15386-3-git-send-email-thara@ti.com>
	<1275150748-15386-4-git-send-email-thara@ti.com>
	<1275150748-15386-5-git-send-email-thara@ti.com>
	<1275150748-15386-6-git-send-email-thara@ti.com>
	<1275150748-15386-7-git-send-email-thara@ti.com>
	<1275150748-15386-8-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:41843 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753Ab0FYWzy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Jun 2010 18:55:54 -0400
Received: by pwj8 with SMTP id 8so2564517pwj.19
        for <linux-omap@vger.kernel.org>; Fri, 25 Jun 2010 15:55:54 -0700 (PDT)
In-Reply-To: <1275150748-15386-8-git-send-email-thara@ti.com> (Thara
	Gopinath's message of "Sat, 29 May 2010 22:02:27 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com

Thara Gopinath <thara@ti.com> writes:

> This patch changes the pm_db_init from arch initcall to a postcore
> initcall. With arch initcall, it is impossible for pm driver that
> gets initialized prior to this driver to use one of the
> pm debug fs entries during its init. Making it a postcore initcall
> ensures that this drver gets initialized early on before any pm
> drivers.
>
> Signed-off-by: Thara Gopinath <thara@ti.com>
> ---
>  arch/arm/mach-omap2/pm-debug.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
> index 4280006..b239c16 100644
> --- a/arch/arm/mach-omap2/pm-debug.c
> +++ b/arch/arm/mach-omap2/pm-debug.c
> @@ -611,6 +611,6 @@ static int __init pm_dbg_init(void)
>  
>  	return 0;
>  }
> -arch_initcall(pm_dbg_init);
> +postcore_initcall(pm_dbg_init);

There's already a 'pm_dbg_init_done' flag in this code being used for
that purpose.  That  should be re-used instead.

Kevin
