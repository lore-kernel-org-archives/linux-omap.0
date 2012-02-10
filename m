From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: OMAP: Get rid of reset for system timer
Date: Fri, 10 Feb 2012 11:18:13 -0800
Message-ID: <20120210191813.GU1426@atomide.com>
References: <1328191435-18652-1-git-send-email-santosh.shilimkar@ti.com>
 <1328191435-18652-2-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:22187 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753Ab2BJTSQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Feb 2012 14:18:16 -0500
Content-Disposition: inline
In-Reply-To: <1328191435-18652-2-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

* Santosh Shilimkar <santosh.shilimkar@ti.com> [120202 05:33]:
> From: Rajendra Nayak <rnayak@ti.com>
> 
> hwmod setup already does a reset and sets the OCP sysconfig
> registers appropriately. Avoid doing a reset again and overriding
> the OCP sysconfig settings in the system timer init code.

If we want this queued as a fix, it should also describe what
actually breaks? Timer? PM?

If this is regression, then it should also have the usuual
commit 123abc (blah blah blah) caused blah blah..

Regards,

Tony
