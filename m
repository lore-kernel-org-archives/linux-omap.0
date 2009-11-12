From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/3] Update CPU idle parameter passing
Date: Wed, 11 Nov 2009 16:28:10 -0800
Message-ID: <87k4xwwpr9.fsf@deeprootsystems.com>
References: <1256805020-7402-1-git-send-email-kalle.jokiniemi@digia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:38862 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759740AbZKLA2H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Nov 2009 19:28:07 -0500
Received: by pwi3 with SMTP id 3so1006538pwi.21
        for <linux-omap@vger.kernel.org>; Wed, 11 Nov 2009 16:28:12 -0800 (PST)
In-Reply-To: <1256805020-7402-1-git-send-email-kalle.jokiniemi@digia.com> (Kalle Jokiniemi's message of "Thu\, 29 Oct 2009 10\:30\:17 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Cc: linux-omap@vger.kernel.org, rnayak@ti.com, jouni.hogander@nokia.com

Kalle Jokiniemi <kalle.jokiniemi@digia.com> writes:

> Hi Kevin,
>
> Made some patches to enable setting RX-51 cpu idle parameters
> as we use them. Added "valid" field passing to cpuidle_params
> in the process.
>
> Tested on RX-51. Applies on top of linux-omap/pm branch.
>
> Kalle Jokiniemi (3):
>       OMAP:PM: Fix non-cpu idle builds using omap3_pm_init_cpuidle
>       OMAP3: Add valid field into C-state parameter passing
>       OMAP: RX-51: Pass cpu idle parameters

Thanks, applying this series to PM branch.

Kevin

> kajokini@ubuntu:~/work/linux-open/linux-omap$ git diff --stat HEAD~3..HEAD
>  arch/arm/mach-omap2/board-3430sdp.c |   14 ++++++------
>  arch/arm/mach-omap2/board-rx51.c    |   18 +++++++++++++++++
>  arch/arm/mach-omap2/cpuidle34xx.c   |   37 +++++++++++++++++++++-------------
>  arch/arm/mach-omap2/pm.h            |    8 +++++++
>  4 files changed, 56 insertions(+), 21 deletions(-)
