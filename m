From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 04/10] omap: Make a subset of dmtimer functions into
 inline functions
Date: Tue, 29 Mar 2011 10:58:39 -0700
Message-ID: <20110329175839.GN4016@atomide.com>
References: <20110328221501.4046.41079.stgit@baageli.muru.com>
 <20110328222137.4046.32363.stgit@baageli.muru.com>
 <87y63xx1b9.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:33664 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751782Ab1C2R6n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Mar 2011 13:58:43 -0400
Content-Disposition: inline
In-Reply-To: <87y63xx1b9.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Kevin Hilman <khilman@ti.com> [110329 10:48]:
> 
> The reset code is an example of something that will not be able to be
> shared between a system timer driver and a real device driver.  In the
> real driver, the reset (as well as smart-idle, autoidle, wakeup
> capability, etc.) will all be handled by the hwmod.
> 
> With a hwmod conversion, the system timer will have to have
> duplicate/alternate compared to the real timer.

Well the hwmod is already there also for system timer, so that should
not be a problem. See the init_one function in the next patch in the
series.
 
> Ideally, what we need is a way for the system timer to be early_init
> only.  When the real driver is available, it switches to that.  This
> could probably be done pretty easily by using the 'rating' field of the
> clockevent so when the "real" timer driver becomes available with a
> higher rating, the clockevent code would switch to it.

I don't think this is needed. When the dmtimer driver code initializes
it just picks up the already initialized struct omap_dm_timer entries
but does not reset them. At that point the struct dev entry can be
created, but from system timer point of view nothing changes.

Regards,

Tony
