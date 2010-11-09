From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] combine zoom board-files
Date: Mon, 8 Nov 2010 16:58:47 -0800
Message-ID: <20101109005847.GY9264@atomide.com>
References: <1289199375-9001-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:64899 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752778Ab0KIA64 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Nov 2010 19:58:56 -0500
Content-Disposition: inline
In-Reply-To: <1289199375-9001-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Anand Gadiyar <gadiyar@ti.com>

* Felipe Balbi <balbi@ti.com> [101107 22:45]:
> Those boards are so similar they don't deserve
> separate board files.
> 
> Felipe Balbi (2):
>   arm: omap: combine zoom2 and zoom3 board-files
>   arm: omap: zoom: substitute gpio number with symbolic name
> 
>  arch/arm/mach-omap2/Makefile                       |    4 +-
>  .../arm/mach-omap2/{board-zoom3.c => board-zoom.c} |  104 ++++++++++-------
>  arch/arm/mach-omap2/board-zoom2.c                  |  117 --------------------
>  3 files changed, 64 insertions(+), 161 deletions(-)
>  rename arch/arm/mach-omap2/{board-zoom3.c => board-zoom.c} (75%)
>  delete mode 100644 arch/arm/mach-omap2/board-zoom2.c

Thanks, queuing both for 2.6.38 merge window.

Tony
