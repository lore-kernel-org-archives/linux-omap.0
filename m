From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3]OMAP:GPTIMER:1ms tick generation correction
Date: Wed, 7 Jul 2010 15:43:28 +0300
Message-ID: <20100707124327.GU1920@atomide.com>
References: <20100707115946.GM1920@atomide.com>
 <502992.73818.qm@web180316.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63297 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754680Ab0GGMni (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jul 2010 08:43:38 -0400
Content-Disposition: inline
In-Reply-To: <502992.73818.qm@web180316.mail.gq1.yahoo.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>, linux-omap@vger.kernel.org, R Sricharan <r.sricharan@ti.com>

* David Brownell <david-b@pacbell.net> [100707 15:26]:
> 
> --- On Wed, 7/7/10, Tony Lindgren <tony@atomide.com> wrote:
> 
> 
> > Or can we somehow calculate this drift once during init?
> 
> If it's set up in the gentime framework, yes; very
> standard.  AT91 is one model (they all have
> 32K clocks used to generate the system tick).

OK thats good to hear.

Tony 
