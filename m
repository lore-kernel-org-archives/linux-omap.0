From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RESEND PATCH 0/3] ARM: OMAP2+: Remove remaining unused legacy
 code
Date: Wed, 19 Mar 2014 09:05:13 -0700
Message-ID: <20140319160513.GC12934@atomide.com>
References: <1395209295-24399-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55000 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965600AbaCSQF0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Mar 2014 12:05:26 -0400
Content-Disposition: inline
In-Reply-To: <1395209295-24399-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Russell King <linux@arm.linux.org.uk>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Javier Martinez Canillas <javier.martinez@collabora.co.uk> [140318 23:12]:
> Once OMAP2+ board files are removed, there is unused code that was only used
> by legacy platform code and can be removed.
> 
> This patch-set depends on the series:
> 
> [PATCH 00/12] Drop omap3 board files and make mach-omap2 boot in DT only mode [0]
> 
> and is composed of the following patches:
> 
> [RESEND PATCH 1/3] ARM: OMAP2+: Remove legacy smsc911x and smc91x
> [RESEND PATCH 2/3] ARM: OMAP2+: Remove unnecesary include in GPMC
> [RESEND PATCH 3/3] ARM: OMAP2+: Remove legacy board-flash.c
> 
> Tony,
> 
> I don't know what is your new schedule for board files removal but in case it is
> 3.16, I forward ported this patch-set on top of 3.14-rc7 and fixed some conflicts.

Thanks, I'll also rebase my changes in omap-for-v3.14/omap3-board-removal
at some point. Probably a good target is v3.16 if the DSS changes go
in. Then we just need displays enabled for omap3 and pandora supported
to drop the legacy data AFAIK.

Regards,

Tony
 
> [0]: http://marc.info/?t=138542504600001&r=1&w=2
> 
