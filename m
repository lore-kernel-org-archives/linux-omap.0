From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] omap: pm: Fix overflow when doing powerdomain deps lookups.
Date: Tue, 11 Aug 2009 07:38:39 -0700
Message-ID: <87tz0e76vk.fsf@deeprootsystems.com>
References: <1249956052-21893-1-git-send-email-mike@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.171]:47466 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754821AbZHKOik (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Aug 2009 10:38:40 -0400
Received: by wf-out-1314.google.com with SMTP id 26so1399777wfd.4
        for <linux-omap@vger.kernel.org>; Tue, 11 Aug 2009 07:38:41 -0700 (PDT)
In-Reply-To: <1249956052-21893-1-git-send-email-mike@android.com> (Mike Chan's message of "Mon\, 10 Aug 2009 19\:00\:52 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Chan <mike@android.com>
Cc: linux-omap@vger.kernel.org

Mike Chan <mike@android.com> writes:

> Signed-off-by: Mike Chan <mike@android.com>
> ---
>  arch/arm/mach-omap2/powerdomain.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
> index 0334609..6077629 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -90,7 +90,7 @@ static struct powerdomain *_pwrdm_deps_lookup(struct powerdomain *pwrdm,
>  	if (!pwrdm || !deps || !omap_chip_is(pwrdm->omap_chip))
>  		return ERR_PTR(-EINVAL);
>  
> -	for (pd = deps; pd; pd++) {
> +	for (pd = deps; pd->pwrdm_name; pd++) {

Maybe should be:

	for (pd = deps; pd && pd->pwrdm_name; pd++) {

?

>  
>  		if (!omap_chip_is(pd->omap_chip))
>  			continue;

Also, a descriptive changelog would be helpful here describing the
conditions where you saw overflow etc.

Kevin
