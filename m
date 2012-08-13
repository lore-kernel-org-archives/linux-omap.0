From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] omap: dmtimers: Fix locking issue in
 omap_dm_timer_request*()
Date: Mon, 13 Aug 2012 06:24:11 -0700
Message-ID: <20120813132411.GY11011@atomide.com>
References: <1344768334-1969-1-git-send-email-timo.t.kokkonen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:27286 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752258Ab2HMNYP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Aug 2012 09:24:15 -0400
Content-Disposition: inline
In-Reply-To: <1344768334-1969-1-git-send-email-timo.t.kokkonen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Timo Kokkonen <timo.t.kokkonen@iki.fi>
Cc: linux-omap@vger.kernel.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>

* Timo Kokkonen <timo.t.kokkonen@iki.fi> [120812 03:46]:
> Calling omap_dm_timer_prepare while the spinlock is held is not
> allowed as sleeping functions are called later on during the
> preparation (namely within clk_get()).
> 
> dm_timer_lock is only required for protecting the
> omap_timer_list. After the timer is marked as reserved, the lock is no
> longer needed and should be freed.

Thanks applying into fixes.

Tony
