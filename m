From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v16 10/12] OMAP: dmtimer: extend spinlock in request
 functions
Date: Wed, 21 Sep 2011 17:42:44 -0700
Message-ID: <20110922004243.GL2937@atomide.com>
References: <1316518227-28116-1-git-send-email-tarun.kanti@ti.com>
 <1316518227-28116-11-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:63587 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751331Ab1IVAmq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Sep 2011 20:42:46 -0400
Content-Disposition: inline
In-Reply-To: <1316518227-28116-11-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org

* Tarun Kanti DebBarma <tarun.kanti@ti.com> [110920 03:57]:
> The request functions now verify the success of omap_dm_timer_prepare() call
> after a timer is acquired. If *_prepare() fails then we have to release the
> timer. In order to avoid race condition during this time, include *_prepare()
> within lock.

This I've folded into patch 5.

Tony
