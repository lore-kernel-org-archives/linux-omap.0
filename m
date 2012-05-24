From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP: PM: Lock clocks list while generating
 summary
Date: Thu, 24 May 2012 01:43:56 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1205240143440.2572@utopia.booyaka.com>
References: <1337363799-22085-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58006 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752970Ab2EXHn5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 May 2012 03:43:57 -0400
In-Reply-To: <1337363799-22085-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Todd Poynor <toddpoynor@google.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, 18 May 2012, Nishanth Menon wrote:

> From: Todd Poynor <toddpoynor@google.com>
> 
> commit a53025724052b2b1edbc982a4a248784638f563d
> (OMAP: Add debugfs node to show the summary of all clocks)
> 
> Introduced clock summary, however, we are interested in seeing
> snapshot of the clock state, not in dynamically changing clock
> configurations as the data provided by clock summary will then be
> useless for debugging configuration issues. So, hold the common lock
> when dumping the clock summary.
> 
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: linux-omap@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> 
> [nm@ti.com: added commit message]
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Todd Poynor <toddpoynor@google.com>

Thanks, queued for 3.5-rc.


- Paul
