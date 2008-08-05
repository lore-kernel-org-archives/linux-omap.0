From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] Implement powerdomain off on state counters
Date: Tue, 5 Aug 2008 17:20:17 +0300
Message-ID: <20080805142017.GR7193@atomide.com>
References: <1216904434-7545-1-git-send-email-peter.de-schrijver@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58261 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752955AbYHEOUU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Aug 2008 10:20:20 -0400
Content-Disposition: inline
In-Reply-To: <1216904434-7545-1-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

* Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com> [080724 16:00]:
> This patchset implement counters to count the number of off to on state transitions in a powerdomain. These counters will be made available to
> drivers in a later patchset to allow them to make a better informed decision wether to restore the hardware registers or not.
> 
> Peter 'p2' De Schrijver (3):
>   Power off on state counter debugging
>   Power off on state counter infrastructure
>   Add hooks for counting off on power transitions

We should merge these into Paul's powerdomain patches against mainline
tree and post them again for more comments to LKML, linux-arm-kernel
and linux-pm.

Tony


>  arch/arm/mach-omap2/Makefile                  |    2 +-
>  arch/arm/mach-omap2/clockdomain.c             |   10 +++++
>  arch/arm/mach-omap2/off-state-counter-debug.c |   50 +++++++++++++++++++++++++
>  arch/arm/mach-omap2/pm34xx.c                  |    6 ++-
>  arch/arm/mach-omap2/powerdomain.c             |   48 +++++++++++++++++++++++-
>  include/asm-arm/arch-omap/powerdomain.h       |    9 ++++-
>  6 files changed, 120 insertions(+), 5 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/off-state-counter-debug.c
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
