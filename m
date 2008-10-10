From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/3] Add PM debug counters on top of PM counters
Date: Fri, 10 Oct 2008 13:23:26 +0300
Message-ID: <87wsggzr35.fsf@deeprootsystems.com>
References: <1223386396-29560-1-git-send-email-peter.de-schrijver@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:53814 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752493AbYJJKXi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Oct 2008 06:23:38 -0400
Received: by ug-out-1314.google.com with SMTP id k3so1247402ugf.37
        for <linux-omap@vger.kernel.org>; Fri, 10 Oct 2008 03:23:36 -0700 (PDT)
In-Reply-To: <1223386396-29560-1-git-send-email-peter.de-schrijver@nokia.com> (Peter De Schrijver's message of "Tue\,  7 Oct 2008 16\:33\:13 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

"Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com> writes:

> This patch provides the PM debug counters and time feature on top of
> the PM counters. Patch based on pm-1 branch + PM counters patch.

Peter,

Can you refresh these against l-o master + PM counters patch?  Also,
it would be helpful to have a more thorough desciption of each patch.

Thanks,

Kevin

> Peter 'p2' De Schrijver (3):
>   Add closures to clkdm_for_each
>   Add pm-debug counters
>   Hook into powerdomain code
>
>  arch/arm/mach-omap2/clockdomain.c             |   31 +-----
>  arch/arm/mach-omap2/pm-debug.c                |  153 ++++++++++++-------------
>  arch/arm/mach-omap2/pm.h                      |   19 +---
>  arch/arm/mach-omap2/pm24xx.c                  |    2 +-
>  arch/arm/mach-omap2/pm34xx.c                  |   13 +--
>  arch/arm/mach-omap2/powerdomain.c             |   95 +++-------------
>  arch/arm/plat-omap/include/mach/clockdomain.h |    3 +-
>  arch/arm/plat-omap/include/mach/powerdomain.h |   14 ++-
>  8 files changed, 114 insertions(+), 216 deletions(-)
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
