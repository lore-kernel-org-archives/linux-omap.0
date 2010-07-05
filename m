From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 1/8] omap3 flash: rename board-sdp-flash.c to be use
 by other boards
Date: Mon, 5 Jul 2010 15:23:12 +0300
Message-ID: <20100705122310.GU15951@atomide.com>
References: <s-ghorai@ti.com>
 <1276688400-4812-1-git-send-email-s-ghorai@ti.com>
 <1276688400-4812-2-git-send-email-s-ghorai@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61597 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753182Ab0GEMXT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Jul 2010 08:23:19 -0400
Content-Disposition: inline
In-Reply-To: <1276688400-4812-2-git-send-email-s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sukumar Ghorai <s-ghorai@ti.com>
Cc: linux-omap@vger.kernel.org

* Sukumar Ghorai <s-ghorai@ti.com> [100616 14:34]:
> rename board-sdp-flash.c(board-flash.c) and board-sdp.h(board-flash.h) to
> used by other board e.g. zoom
> 
> Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
> ---
>  arch/arm/mach-omap2/Makefile                   |    2 +-
>  arch/arm/mach-omap2/board-3430sdp.c            |   16 ++-
>  arch/arm/mach-omap2/board-flash.c              |  253 ++++++++++++++++++++++
>  arch/arm/mach-omap2/board-sdp-flash.c          |  267 ------------------------
>  arch/arm/mach-omap2/include/mach/board-flash.h |   28 +++
>  arch/arm/mach-omap2/include/mach/board-sdp.h   |   21 --
>  6 files changed, 296 insertions(+), 291 deletions(-)
>  create mode 100755 arch/arm/mach-omap2/board-flash.c
>  delete mode 100755 arch/arm/mach-omap2/board-sdp-flash.c
>  create mode 100644 arch/arm/mach-omap2/include/mach/board-flash.h
>  delete mode 100644 arch/arm/mach-omap2/include/mach/board-sdp.h

Looks like this one won't apply:

patching file arch/arm/mach-omap2/board-sdp-flash.c
Hunk #1 FAILED at 1.
File arch/arm/mach-omap2/board-sdp-flash.c is not empty after patch, as expected

Regards,

Tony
