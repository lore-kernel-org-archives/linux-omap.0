From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/3] OMAP: use generic DPI panel driver in board files
Date: Tue, 16 Nov 2010 12:41:04 -0800
Message-ID: <20101116204104.GH9264@atomide.com>
References: <1289881031-21354-1-git-send-email-bryan.wu@canonical.com>
 <1289881031-21354-3-git-send-email-bryan.wu@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:57185 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754409Ab0KPUlP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Nov 2010 15:41:15 -0500
Content-Disposition: inline
In-Reply-To: <1289881031-21354-3-git-send-email-bryan.wu@canonical.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bryan Wu <bryan.wu@canonical.com>
Cc: tomi.valkeinen@nokia.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gadiyar@ti.com

* Bryan Wu <bryan.wu@canonical.com> [101115 20:08]:
> Still keep sharp_ls_panel, since the sharp_ls_panel driver contains blacklight
> control driver code which will be moved out later. Then we can use generic DPI
> driver for sharp_ls_panel.
> 
> Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
> ---
>  arch/arm/mach-omap2/board-3430sdp.c      |   12 +++++++++---
>  arch/arm/mach-omap2/board-am3517evm.c    |   23 +++++++++++++++++------
>  arch/arm/mach-omap2/board-cm-t35.c       |   23 +++++++++++++++++------
>  arch/arm/mach-omap2/board-devkit8000.c   |   26 ++++++++++++++++++--------
>  arch/arm/mach-omap2/board-igep0020.c     |   12 +++++++++---
>  arch/arm/mach-omap2/board-omap3beagle.c  |   12 +++++++++---
>  arch/arm/mach-omap2/board-omap3evm.c     |   12 +++++++++---
>  arch/arm/mach-omap2/board-omap3stalker.c |   23 +++++++++++++++++------
>  8 files changed, 105 insertions(+), 38 deletions(-)

Here's my ack for these changes once Tomi is happy with the
series:

Acked-by: Tony Lindgren <tony@atomide.com>
