From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: hwmod data: cleanup in preparation for
 link array removal
Date: Thu, 8 Mar 2012 18:16:33 -0800
Message-ID: <20120309021633.GE12083@atomide.com>
References: <alpine.DEB.2.00.1203072102150.21662@utopia.booyaka.com>
 <20120309014016.GC12083@atomide.com>
 <alpine.DEB.2.00.1203081851570.9551@utopia.booyaka.com>
 <alpine.DEB.2.00.1203081900500.26543@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:15772 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757812Ab2CICQf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 21:16:35 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1203081900500.26543@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [120308 18:07]:
> Hi
> 
> on second thought...
> 
> On Thu, 8 Mar 2012, Paul Walmsley wrote:
> 
> > On Thu, 8 Mar 2012, Tony Lindgren wrote:
> > 
> > > Got these now merged into l-o master, but ran into a merge
> > > conflict with already queued sr branch. Resolved it by using
> > > your version except left out vdd_name.
> > 
> > Definitely we want the vdd_name fields.  Other than that it looks okay.  
> 
> I guess that other SR series that you merged removed the vdd_name fields?

So it seems, commit cea6b942124683305280962969599fed36f0ea7e. Then
the interrupts we added there for smartreflex it seems.
 
> If so then yeah, we'd better leave those out.
> 
> This means that I'm going to have to rebase those big hwmod data changes 
> :-(
> 
> Can you send me a stable commit for that?

Bummer :( What we already have queued is the sr branch at commit
bb887688bccb48d94fa873f0f6cc7e7e3e4dc05e.

Regards,

Tony
