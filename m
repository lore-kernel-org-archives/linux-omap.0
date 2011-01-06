From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 1/5] omap2plus: clockdomain: Trivial fix for build
 break because of clktrctrl_mask
Date: Thu, 6 Jan 2011 11:02:02 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1101061059590.22048@utopia.booyaka.com>
References: <1294225024-21857-1-git-send-email-santosh.shilimkar@ti.com> <87fwt7z1p3.fsf@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:32812 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751510Ab1AFSCD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 13:02:03 -0500
In-Reply-To: <87fwt7z1p3.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On Wed, 5 Jan 2011, Kevin Hilman wrote:

> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> 
> > struct clockdomain member clktrctrl_mask is available for only for OMAP2
> > and OMAP3 architectures. Technially it is also used only for these archs
> > but this breaks the build with custom OMAP4 configuration.
> 
> I'll queue patches 3-5 for the 2.6.38-rc fixes cycle.
> 
> With Paul's ack, I can queue the others too, or Paul can decide to take
> them via his tree.  Paul can decide.

I've acked one and requested minor changes on the other, after which it 
can be acked by me.  You're welcome to take them at that point.  Just a 
request, maybe you can post a branch with just these patches in them; that 
way Rajendra and/or I can rebase his new clockdomain changes on it until 
-rc1 comes out.


- Paul
