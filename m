From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/5] omap3: Introduce CompuLab CM-T3517 module.
Date: Thu, 16 Sep 2010 10:53:18 -0700
Message-ID: <20100916175317.GF29610@atomide.com>
References: <1284627281-26059-1-git-send-email-grinberg@compulab.co.il>
 <1284627281-26059-2-git-send-email-grinberg@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63742 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753556Ab0IPRxX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Sep 2010 13:53:23 -0400
Content-Disposition: inline
In-Reply-To: <1284627281-26059-2-git-send-email-grinberg@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Igor Grinberg <grinberg@compulab.co.il> [100916 01:46]:
> Add basic suppot, enable uart and led.
> 
> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
> ---
>  arch/arm/mach-omap2/Kconfig          |    7 ++
>  arch/arm/mach-omap2/Makefile         |    1 +
>  arch/arm/mach-omap2/board-cm-t3517.c |  109 ++++++++++++++++++++++++++++++++++
>  3 files changed, 117 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/board-cm-t3517.c

Looks like you're missing the debug uart entry for
arch/arm/plat-omap/include/plat/uncompress.h?

You can test this by enabling DEBUG_LL and EARLY_PRINTK
in your .config, then pass earlyprintk in the kernel
cmdline. Might become handy for debugging the early
init process for your board.

Regards,

Tony
