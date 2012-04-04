From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP: clock: fix race in disable all clocks
Date: Wed, 4 Apr 2012 09:22:58 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204040922140.8000@utopia.booyaka.com>
References: <1331835871-13328-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37481 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756379Ab2DDPW7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Apr 2012 11:22:59 -0400
In-Reply-To: <1331835871-13328-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, Todd Poynor <toddpoynor@google.com>

cc Todd

On Thu, 15 Mar 2012, Nishanth Menon wrote:

> clk_disable_unused is invoked when CONFIG_OMAP_RESET_CLOCKS=y.
> Since clk_disable_unused is called as lateinitcall, there can
> be more than a few workqueues executing off secondary CPU(s).
> The current code does the following:
> a) checks if clk is unused
> b) holds lock
> c) disables clk
> d) unlocks
> 
> Between (a) and (b) being executed on CPU0, It is possible to
> have a driver executing on CPU1 which could do a get_sync->clk_get
> (and increase the use_count) of the clock which was just about
> to be disabled by clk_disable_unused.
> 
> We ensure instead that the entire list traversal is protected by
> the lock allowing for parent child clock traversal which could be
> potentially be done by runtime operations to be safe as well.
> 
> Reported-by: Todd Poynor <toddpoynor@google.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> To confirm this in reality happens, I setup a trap as follows:
>   @@ -450,6 +450,8 @@ static int __init clk_disable_unused(void)
>   			continue;
>   
>   		spin_lock_irqsave(&clockfw_lock, flags);
>  +		WARN(ck->usecount, "XXXX->RACECONDITION FOR CLOCK %s\n",
>  +			ck->name);
>   		arch_clock->clk_disable_unused(ck);
>   		spin_unlock_irqrestore(&clockfw_lock, flags);
>   	}
> Resultant log: http://pastebin.pandaboard.org/index.php/view/66400792

Thanks Nishanth & Todd, queued for 3.4-rc.


- Paul
