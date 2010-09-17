From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 01/14] ARM: mmu: Setup MT_MEMORY and
 MT_MEMORY_NONCACHED L1 entries
Date: Fri, 17 Sep 2010 09:41:32 -0700
Message-ID: <20100917164132.GC29610@atomide.com>
References: <1284716878-27667-1-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-2-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52589 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679Ab0IQQli (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Sep 2010 12:41:38 -0400
Content-Disposition: inline
In-Reply-To: <1284716878-27667-2-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [100917 02:40]:
> This patch populates the L1 entries for MT_MEMORY and MT_MEMORY_NONCACHED
> types so that at boot-up, we can map memories outside system memory
> at page level granularity
> 
> Previously the mapping was limiting to section level, which creates
> unnecessary addiotional mapping for which physical memory may not

Minor typo here, it should be "additional".

Tony
