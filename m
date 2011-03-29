From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 05/10] omap2+: Use dmtimer macros for clockevent
Date: Tue, 29 Mar 2011 10:16:59 -0700
Message-ID: <20110329171659.GJ4016@atomide.com>
References: <20110328221501.4046.41079.stgit@baageli.muru.com>
 <20110328222140.4046.91213.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63299 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991Ab1C2RRA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Mar 2011 13:17:00 -0400
Content-Disposition: inline
In-Reply-To: <20110328222140.4046.91213.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [110328 15:19]:
> 
> Note that omap_dmtimer_init_one can eventually be moved to
> omap2+ specific dmtimer.c.

Actually after this series we'll have just timer.c, will
remove this comment.

Tony
