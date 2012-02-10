From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] ARM: OMAP4: Move the barrier memboclk_steal() as
 part of reserve callback
Date: Fri, 10 Feb 2012 11:19:26 -0800
Message-ID: <20120210191926.GV1426@atomide.com>
References: <1328191435-18652-1-git-send-email-santosh.shilimkar@ti.com>
 <1328191435-18652-3-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:23015 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753Ab2BJTT2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Feb 2012 14:19:28 -0500
Content-Disposition: inline
In-Reply-To: <1328191435-18652-3-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [120202 05:33]:
> arm_memblock_steal() is not suppose to be used outside ->reserve callback.
> OMAP barrier errata code was using it outside reserve callback and hence
> it was broken.
> 
> Move the allocation as part of ->reserve callback to fix the it.

Please update this to mention again commit that changed things
around for arm_memblock_steal() so it's clear why this is needed
as a fix.

Regards,

Tony
