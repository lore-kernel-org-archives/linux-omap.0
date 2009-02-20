From: Tony Lindgren <tony@atomide.com>
Subject: Re: Fix for Zero sized arch/arm/mach-integrator/clock.h on
	distclean
Date: Fri, 20 Feb 2009 08:18:14 -0800
Message-ID: <20090220161814.GK7414@atomide.com>
References: <A24693684029E5489D1D202277BE8944202A97C1@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:60860 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752923AbZBTQSW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Feb 2009 11:18:22 -0500
Content-Disposition: inline
In-Reply-To: <A24693684029E5489D1D202277BE8944202A97C1@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Aguirre Rodriguez, Sergio Alberto <saaguirre@ti.com> [090126 15:14]:
> Hi Tony,
> 
> I noticed that when doing distclean on the tree, I keep receiving a changed file when I request a distclean:

Sorry for the delay in replying.. Looks like this is no longer a problem.

Regards,

Tony


> saaguirre@x0091359-linux:~/linux-omap-2.6$ git status
> # On branch camera-submit-6-nokiafixes
> # Changed but not updated:
> #   (use "git add/rm <file>..." to update what will be committed)
> #
> #       deleted:    arch/arm/mach-integrator/clock.h
> #
> no changes added to commit (use "git add" and/or "git commit -a")
> 
> I noticed that this is because a zero sized file existed in mainline, instead of being adequately deleted.
> 
> But I also noticed that there is a fix for this already by Andrew Price:
> 
> http://marc.info/?l=linux-kernel&m=123134235028543&w=2
> 
> Is it possible to pull this fix into the l-o tree?
> 
> Thanks and regards,
> Sergio
