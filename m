From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [pm-wip/uart][PATCH 0/6]: Serial HWMOD updation and cleanup.
Date: Thu, 27 May 2010 14:05:43 -0700
Message-ID: <87typtgimw.fsf@deeprootsystems.com>
References: <47398.192.168.10.88.1274362670.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:60819 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756937Ab0E0VFr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 May 2010 17:05:47 -0400
Received: by pwi7 with SMTP id 7so246183pwi.19
        for <linux-omap@vger.kernel.org>; Thu, 27 May 2010 14:05:46 -0700 (PDT)
In-Reply-To: <47398.192.168.10.88.1274362670.squirrel@dbdmail.itg.ti.com> (Govindraj R.'s message of "Thu\, 20 May 2010 19\:07\:50 +0530 \(IST\)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org

Hi Govindraj,

"Govindraj.R" <govindraj.raja@ti.com> writes:

> Patch series is based on remotes/origin/pm-wip/govindraj
> branch from Kevin's PM tree.
>
> Patches are tested with 3430SDP.
> Have updated 2420/2430 hwmod data files
> it would be great if some one can test the same.

OK, I've updated pm-wip/uart to include most of this series as well as
some of the other fixes I posted yesterday to get things working on
OMAP2.

> Govindraj.R (6):
>   Serial: Clean up set_uart_globals.
>   Serial: Add UART4 hwmod data.
>   Serial: Modify OMAP3 hwmod data file with uart data.
>   Serial: Add UART hwmod data for 2420.
>   Serial: Add UART hwmod data for 2430.
>   Serial: Update UART HWMOD layer.

I've kept patch 1 as is, but changed the subject slightly.

Patches 2, 4 and 5 I've folded into the patch that added hwmod data
for OMAP3.

Patch 6 I folded into the initial UART conversion patch and also
changed the authorship for that patch to you, since you've done most
of that work.

Patch 3, I've dropped as that shouldn't be needed after you switch
to platform_get_resource_byname().

Please update your omap-serial driver on top of the new pm-wip/uart
branch and then we'll be basically ready for upstream.

Kevin

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
