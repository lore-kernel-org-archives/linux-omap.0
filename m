From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP3: hwmod data fixes for 3.2-rc
Date: Fri, 16 Dec 2011 11:46:59 -0800
Message-ID: <20111216194659.GG32251@atomide.com>
References: <alpine.DEB.2.00.1112160120040.12660@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:47349 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752217Ab1LPTrC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Dec 2011 14:47:02 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1112160120040.12660@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [111215 23:49]:
> Hi Tony,
> 
> The following changes since commit dc47ce90c3a822cd7c9e9339fe4d5f61dcb26b50:
> 
>   Linux 3.2-rc5 (2011-12-09 15:09:32 -0800)
> 
> are available in the git repository at:
>   git://git.pwsan.com/linux-2.6 hwmod_data_fixes_3.2rc
> 
> Aaro Koskinen (1):
>       ARM: OMAP: hwmod data: fix the panic on Nokia RM-680 during boot
> 
> Felipe Contreras (1):
>       ARM: OMAP: hwmod data: fix iva and mailbox hwmods for OMAP 3
> 
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   18 +++++++++++++-----
>  1 files changed, 13 insertions(+), 5 deletions(-)

The rm-680 issue would be "features that never worked" type fix
for a rare development board until it supports N9 also. I think
we can live with that one until v3.3 merge window considering
how long it's been around.

The hwmod warning we should be also to deal with considering
we don't even have CONFIG_OMAP_MBOX_FWK currently enabled.

So pulling into fixes-non-critical-part2.

Regards,

Tony
