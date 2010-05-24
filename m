From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [pm-wip/uart][PATCH 0/6]: Serial HWMOD updation and cleanup.
Date: Mon, 24 May 2010 07:17:04 -0700
Message-ID: <87pr0le65b.fsf@deeprootsystems.com>
References: <47398.192.168.10.88.1274362670.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f189.google.com ([209.85.222.189]:56341 "EHLO
	mail-pz0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915Ab0EXORI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 May 2010 10:17:08 -0400
Received: by pzk27 with SMTP id 27so1757608pzk.2
        for <linux-omap@vger.kernel.org>; Mon, 24 May 2010 07:17:07 -0700 (PDT)
In-Reply-To: <47398.192.168.10.88.1274362670.squirrel@dbdmail.itg.ti.com> (Govindraj R.'s message of "Thu\, 20 May 2010 19\:07\:50 +0530 \(IST\)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org

"Govindraj.R" <govindraj.raja@ti.com> writes:

> Patch series is based on remotes/origin/pm-wip/govindraj
> branch from Kevin's PM tree.
>
> Patches are tested with 3430SDP.
> Have updated 2420/2430 hwmod data files
> it would be great if some one can test the same.

Hi Govindraj,

This series looks great.  I've added it to pm-wip/uart for broader testing,
but there were a couple minor issues I pointed out.

Feel free to send fixes on top of pm-wip/uart and I will merge/fold them
in.

FYI, the way I am testing is taking pm-wip/uart and merging with
current PM branch and testing using omap3_defconfig.

Kevin

> Govindraj.R (6):
>   Serial: Clean up set_uart_globals.
>   Serial: Add UART4 hwmod data.
>   Serial: Modify OMAP3 hwmod data file with uart data.
>   Serial: Add UART hwmod data for 2420.
>   Serial: Add UART hwmod data for 2430.
>   Serial: Update UART HWMOD layer.
>
>  arch/arm/mach-omap2/omap_hwmod_2420_data.c |  184 ++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/omap_hwmod_2430_data.c |  184 ++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   66 +++++++++-
>  arch/arm/mach-omap2/prcm-common.h          |    2 +
>  arch/arm/mach-omap2/serial.c               |   38 +++----
>  arch/arm/plat-omap/common.c                |   17 ---
>  arch/arm/plat-omap/include/plat/common.h   |    1 -
>  arch/arm/plat-omap/include/plat/dma.h      |    2 +
>  arch/arm/plat-omap/include/plat/irqs.h     |    2 +
>  9 files changed, 449 insertions(+), 47 deletions(-)
