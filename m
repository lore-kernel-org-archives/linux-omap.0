From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC 0/2] join omap4panda and pcm049
Date: Mon, 18 Jul 2011 01:42:59 -0700
Message-ID: <20110718084259.GY5783@atomide.com>
References: <20110715105558.GT5783@atomide.com>
 <1310746014-13293-1-git-send-email-j.weitzel@phytec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:61750 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752479Ab1GRInC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jul 2011 04:43:02 -0400
Content-Disposition: inline
In-Reply-To: <1310746014-13293-1-git-send-email-j.weitzel@phytec.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jan Weitzel <j.weitzel@phytec.de>
Cc: linux-omap@vger.kernel.org

* Jan Weitzel <j.weitzel@phytec.de> [110715 09:01]:
> First try to join both boards. Only compile testet.
> basis for discusson
> 
> Jan Weitzel (2):
>   omap4: board-omap4panda: prepare for join
>   omap4: board-omap4panda: join Phytec phyCORE-OMAP4
> 
>  arch/arm/mach-omap2/Kconfig                  |    6 +
>  arch/arm/mach-omap2/board-omap4panda.c       |  817 +++++++++++++++++++-------
>  arch/arm/plat-omap/include/plat/uncompress.h |    1 +
>  3 files changed, 616 insertions(+), 208 deletions(-)

Thanks for working on this. To me it seems that it might
be more readable to have board-panda-common.c file instead
of having everything in one file.

Then from the board specific files you could just call
panda_common_init(&omap4_panda_config).

Regards,

Tony
