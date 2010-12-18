From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: remove dead wdt code in plat-omap/devices.c
Date: Fri, 17 Dec 2010 17:47:04 -0800
Message-ID: <20101218014703.GK5941@atomide.com>
References: <1291397216-24301-1-git-send-email-gadiyar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50153 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756779Ab0LRBrI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Dec 2010 20:47:08 -0500
Content-Disposition: inline
In-Reply-To: <1291397216-24301-1-git-send-email-gadiyar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Anand Gadiyar <gadiyar@ti.com> [101203 09:17]:
> Commit f2ce62312650 (OMAP: WDT: Split OMAP1 and OMAP2PLUS device
> registration) removed omap_init_wdt and related structures from
> plat-omap/devices.c. However a subsequent commit or merge
> seems to have reintroduced these by accident. The caller of
> omap_init_wdt was also removed by that commit, and this did
> not get restored. So we have the following build warning now:
> 
>   CC      arch/arm/plat-omap/devices.o
> arch/arm/plat-omap/devices.c:252: warning: 'omap_init_wdt' defined but not used
> 
> Fix this by removing this dead code.
> 
> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> ---
> Couldn't figure out which commit reintroduced this code - git blame
> only points to the original commits that added the code years ago.
> 
> I suspect it's the DSP bridge commits that got merged via staging.
> 
> If someone can debug this mystery for me, that'd be nice.

Thanks applying. Looks like it was added back by mismerge in
e4c5bf8e3dca827a1b3a6fac494eae8c74b7e1e7 (Merge 'staging-next'
into Linus's tree).

Tony
