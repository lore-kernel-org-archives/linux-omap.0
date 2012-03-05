From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP2+: omap_device: call all suspend, resume
 callbacks when OMAP_DEVICE_NO_IDLE_ON_SUSPEND is set
Date: Mon, 5 Mar 2012 14:15:01 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1203051414340.1430@utopia.booyaka.com>
References: <alpine.DEB.2.00.1203031314050.10611@utopia.booyaka.com> <877gyzoyyk.fsf@ti.com> <alpine.DEB.2.00.1203051312390.1430@utopia.booyaka.com> <20120305205233.GT12083@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48907 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752574Ab2CEVPC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Mar 2012 16:15:02 -0500
In-Reply-To: <20120305205233.GT12083@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, John Stultz <johnstul@us.ibm.com>, Andy Green <andy.green@linaro.org>

On Mon, 5 Mar 2012, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [120305 11:44]:
> > On Mon, 5 Mar 2012, Kevin Hilman wrote:
> > 
> > > Tony, this fix is needed for v3.3.
> > 
> > Of course, I don't have any objection to this patch going into the v3.3-rc 
> > kernels.  But given that some maintainers seem to be pushing back against 
> > late -rc patches, this one could probably be delayed to 3.4 if required.  
> > no_console_suspend is a debugging-only option and bugs involving it are 
> > unlikely to affect most users.
> 
> I'm fine with your queueing it for v3.4 merge window.

Just chatted with Kevin, he's going to take this one for 3.4 with some 
other omap_device patches he's got queued.


- Paul
