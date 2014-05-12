From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/11] ARM: OMAP: OMAP5 & AM43x DSS
Date: Mon, 12 May 2014 07:36:05 -0700
Message-ID: <20140512143604.GB31772@atomide.com>
References: <1399636579-8062-1-git-send-email-tomi.valkeinen@ti.com>
 <5370CBD5.3060107@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:18966 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758627AbaELOgJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 May 2014 10:36:09 -0400
Content-Disposition: inline
In-Reply-To: <5370CBD5.3060107@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>, Archit Taneja <archit@ti.com>, Tero Kristo <t-kristo@ti.com>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [140512 06:26]:
> Hi Tony,
> 
> On 09/05/14 14:56, Tomi Valkeinen wrote:
> > Hi,
> > 
> > Here are arch/arm/ patches to add display support for OMAP5 and AM43x.
> > 
> > I have these in my tree, in a branch I will send to Tony for merging. Most of
> > these patches have already been around the lists, but I wanted to send them one
> > more time to verify that all looks right and everybody is fine with them.
> 
> I have pushed these to:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git 3.16/omap
>
> If you're fine with these, I think we can consider that branch stable.
> There are probably still a few display related .dts changed for the
> board coming up, but I'll add those on top of the current commits.

Please coordinate things with Paul and Tero so you at least have proper
acks for the hwmod and and clock patches. In general we really want to
queue hwmod and clock changes separately as those can easily mess up things
in a bad way like we've already seen with overlapping hwmod entries in
the .dts files.

Also, I'm wondering why we still have .clk and .opt_clks entries in the
hwmod data for am43xx and omap5 which are both device tree based with
all the clocks coming from .dts files?

> I also have pushed OMAP5 and AM43xx related OMAPDSS patches to my
> for-next branch, so with "3.16/omap" branch and linux-next, the omap5
> and am43xx displays should be functional.

The panel parts look OK to me no problem.
 
> How do you want to handle getting the 3.16/omap branch to linux-next?
> Will you take "ownership" of the branch, and push it to linux-next?

Ideally we'd have small topic branches of clock changes, hwmod changes
and .dts changes that we can all merge in as needed.

Regards,

Tony
