From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: Fix for Zero sized arch/arm/mach-integrator/clock.h on	distclean
Date: Fri, 20 Feb 2009 10:23:58 -0600
Message-ID: <A24693684029E5489D1D202277BE894420B1A373@dlee02.ent.ti.com>
References: <20090220161814.GK7414@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51409 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751505AbZBTQYy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Feb 2009 11:24:54 -0500
In-Reply-To: <20090220161814.GK7414@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Tony Lindgren
> Sent: Friday, February 20, 2009 10:18 AM
> To: Aguirre Rodriguez, Sergio Alberto
> Cc: linux-omap@vger.kernel.org
> Subject: Re: Fix for Zero sized arch/arm/mach-integrator/clock.h on
> distclean
> 
> * Aguirre Rodriguez, Sergio Alberto <saaguirre@ti.com> [090126 15:14]:
> > Hi Tony,
> >
> > I noticed that when doing distclean on the tree, I keep receiving a
> changed file when I request a distclean:
> 
> Sorry for the delay in replying.. Looks like this is no longer a problem.

... That's ok.

This problem was present a month ago, so pulling from mainline fixed this.

> 
> Regards,
> 
> Tony
> 
> 
> > saaguirre@x0091359-linux:~/linux-omap-2.6$ git status
> > # On branch camera-submit-6-nokiafixes
> > # Changed but not updated:
> > #   (use "git add/rm <file>..." to update what will be committed)
> > #
> > #       deleted:    arch/arm/mach-integrator/clock.h
> > #
> > no changes added to commit (use "git add" and/or "git commit -a")
> >
> > I noticed that this is because a zero sized file existed in mainline,
> instead of being adequately deleted.
> >
> > But I also noticed that there is a fix for this already by Andrew Price:
> >
> > http://marc.info/?l=linux-kernel&m=123134235028543&w=2
> >
> > Is it possible to pull this fix into the l-o tree?
> >
> > Thanks and regards,
> > Sergio
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

