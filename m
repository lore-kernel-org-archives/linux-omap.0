From: Richard Cochran <richardcochran@gmail.com>
Subject: Re: Fwd: [PATCH 2/5] ARM: OMAP3+: hwmod: Add AM33XX HWMOD data for
 davinci_mdio
Date: Thu, 18 Oct 2012 20:27:32 +0200
Message-ID: <20121018182732.GC2350@netboy.at.omicron.at>
References: <20121017181354.GA2412@netboy.at.omicron.at>
 <alpine.DEB.2.00.1210172337170.30902@utopia.booyaka.com>
 <20121017235045.GB30550@atomide.com>
 <20121018030654.GE2867@netboy.at.omicron.at>
 <alpine.DEB.2.00.1210180313360.6893@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:42099 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752080Ab2JRS1n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Oct 2012 14:27:43 -0400
Received: by mail-wi0-f178.google.com with SMTP id hr7so2443207wib.1
        for <linux-omap@vger.kernel.org>; Thu, 18 Oct 2012 11:27:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1210180313360.6893@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mugunthan V N <mugunthanvnm@ti.com>

On Thu, Oct 18, 2012 at 03:46:15AM +0000, Paul Walmsley wrote:
> 
> It doesn't necessarily mean that the driver is usable in that kernel 
> release.

Well, it should. We have staging for half-baked stuff.

> Either way, the patch is likely to make it into the mainline kernel.  
> It's just that it will probably take a few weeks longer than you might 
> like.

I don't mind waiting for a driver that is held off because of missing
background support.

I *do* mind if y'all go merging all kinds of code that has never been
tested. Those who submit and their reviewers should ensure that the
code is actually working. Before buying hardware or starting projects,
I often check what is in mainline. I expect that mainline has been at
least minimally tested.

Maybe that is just me, or maybe people working on the ARM tree have
different expectations.

Thanks,
Richard
