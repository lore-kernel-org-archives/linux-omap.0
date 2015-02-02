From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v13 3/6] clk: Make clk API return per-user struct clk
 instances
Date: Mon, 2 Feb 2015 15:11:28 -0800
Message-ID: <20150202231127.GI9418@atomide.com>
References: <1422011024-32283-1-git-send-email-tomeu.vizoso@collabora.com>
 <1422011024-32283-4-git-send-email-tomeu.vizoso@collabora.com>
 <20150201212432.22722.70917@quantum>
 <54CFD0B1.2000003@ti.com>
 <20150202204402.GG9418@atomide.com>
 <20150202224809.421.95878@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.ore.mailhop.org ([54.68.34.165]:47973 "EHLO
	smtp1.ore.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752203AbbBBXOY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Feb 2015 18:14:24 -0500
Content-Disposition: inline
In-Reply-To: <20150202224809.421.95878@quantum>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: Tero Kristo <t-kristo@ti.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Mike Turquette <mturquette@linaro.org> [150202 14:51]:
> Quoting Tony Lindgren (2015-02-02 12:44:02)
> > 
> > Thanks Tero, looks like your fix fixes all the issues I'm seeing with
> > commit 59cf3fcf9baf. That is noisy dmesg, dpll_abe_ck not locking
> > on 4430sdp, and off-idle not working for omap3.
> > 
> > I could not get the patch to apply, below is what I applied manually.
> > 
> > Mike, If possible, maybe fold this into 59cf3fcf9baf? It applies with
> > some fuzz on that too. And inn that case, please feel also to add the
> > following for Tomeu's patch:
> > 
> > Tested-by: Tony Lindgren <tony@atomide.com>
> 
> Done and done. Things look good in my testing. I've pushed another
> branch out to the mirrors and hopefully the autobuild/autoboot testing
> will give us the green light.

Thanks I just checked that your updated branch works for me now.
 
> This implementation can be revisited probably after 3.19 comes out if
> Tero doesn't like using clk_hw directly, or if we provide a better
> interface.

Sounds like what Tero is saying also relates to knowing if the parent
clock is in bypass mode or not in addition to the parent rate.

Regards,

Tony
