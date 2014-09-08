From: Tony Lindgren <tony@atomide.com>
Subject: Re: [BUG(?)] Kconfig warning when selecting ARCH_OMAP1
Date: Mon, 8 Sep 2014 08:35:53 -0700
Message-ID: <20140908153552.GD3238@atomide.com>
References: <CA+B2V-+GLEiRcJqVA4=2GX5iY1cWjDd4vWdumD_9ALpxuspg9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:20976 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752748AbaIHPf5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Sep 2014 11:35:57 -0400
Content-Disposition: inline
In-Reply-To: <CA+B2V-+GLEiRcJqVA4=2GX5iY1cWjDd4vWdumD_9ALpxuspg9Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andreas Ruprecht <rupran@einserver.de>
Cc: Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org

* Andreas Ruprecht <rupran@einserver.de> [140907 11:39]:
> Hi all,
> 
> I found the following inconsistency in the Kconfig dependencies for
> ARCH_OMAP1 during my research, and as I don't know the exact requirements
> for the OMAP configuration (and how the dependencies could be restructured
> to get rid of the warning), I figured you might be able to help me out.
> 
> When selecting ARCH_OMAP1 as the system type, Kconfig issues a warning:
> "warning: (ARCH_OMAP1) selects ARCH_OMAP which has unmet direct
> dependencies (ARCH_MULTI_V6 || ARCH_MULTI_V7)"
> 
> When I investigated this further, I found the reason to be as follows:
> - ARCH_OMAP1 selects ARCH_OMAP
> - ARCH_OMAP depends on ARCH_MULTI_V6 || ARCH_MULTI_V7
> - ARCH_MULTI_V{6,7} depend on ARCH_MULTIPLATFORM
> - ARCH_MULTIPLATFORM is in the same choice (System Type -> ARM system type)
> as ARCH_OMAP1, and thus the two can never be enabled at the same time.
> 
> Might there be an easy way to resolve this inconsistency by restructuring
> the Kconfig dependencies?

Probably to move the config ARCH_OMAP to plat-omap/Kconfig. Suggested fix
being discussed in the "[PATCH] ARM: omap: fix Kconfig warning" thread FYI.

Regards,

Tony
