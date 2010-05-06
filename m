From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH v3 0/4] omap: mailbox: cleanup & simplify
Date: Thu, 06 May 2010 08:20:57 +0300 (EEST)
Message-ID: <20100506.082057.216734447.Hiroshi.DOYU@nokia.com>
References: <1273073589-2485-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:37437 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870Ab0EFFVH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 May 2010 01:21:07 -0400
In-Reply-To: <1273073589-2485-1-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ohad@wizery.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, h-kanigeri2@ti.com

From: ext Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH v3 0/4] omap: mailbox: cleanup & simplify
Date: Wed, 5 May 2010 17:33:05 +0200

> This series includes comments from Hiroshi and Tony (thanks!).
> 
> Changes since v2:
> - add mbox_kfifo_size module parameter sanity checks
> - remove (un)likely macros from cold mailbox paths

Acked-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

> 
> Thanks,
> Ohad.
> 
> ---
> If you want, you can also reach me at < ohadb at ti dot com >.
> 
> Ohad Ben-Cohen (4):
>   omap: mailbox: convert rwlocks to spinlock
>   omap: mailbox cleanup: split MODULE_AUTHOR line
>   omap: mailbox: remove (un)likely macros from cold paths
>   omap: mailbox: convert block api to kfifo
> 
>  arch/arm/mach-omap2/mailbox.c             |    3 +-
>  arch/arm/plat-omap/Kconfig                |    9 ++
>  arch/arm/plat-omap/include/plat/mailbox.h |    4 +-
>  arch/arm/plat-omap/mailbox.c              |  155 ++++++++++++++---------------
>  4 files changed, 87 insertions(+), 84 deletions(-)
> 
