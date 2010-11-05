From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 0/3] Various code improvements for IGEP v2 board.
Date: Fri, 5 Nov 2010 14:49:17 -0700
Message-ID: <20101105214917.GZ9264@atomide.com>
References: <1287852540-4951-1-git-send-email-eballetbo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50854 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752616Ab0KEVte (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Nov 2010 17:49:34 -0400
Content-Disposition: inline
In-Reply-To: <1287852540-4951-1-git-send-email-eballetbo@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Enric Balletbo i Serra <eballetbo@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com

* Enric Balletbo i Serra <eballetbo@gmail.com> [101023 09:40]:
> 
> Hello,
> 
> The comments of this post also apply to IGEP v2 board (thanks Laurent)
> 
>   http://www.mail-archive.com/linux-omap@vger.kernel.org/msg36402.html
> 
> Changes since v1:
>  - Split patch in a serie.
>  - [1/3] onenand_setup = NULL, is a static variable, removed from code.
> 
> This patch apply on top of tmlind/omap-for-linux branch.
> 
> $ git diff --stat tmlind/omap-for-linus 
>  arch/arm/mach-omap2/board-igep0020.c |   35 ++++++++++-----------------------
>  1 files changed, 11 insertions(+), 24 deletions(-)

Thanks, I'll queue these for 2.6.38 merge window.

Regards,

Tony
