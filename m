From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: RFD: OMAP PRCM register access holding up PM branch submissions
Date: Thu, 12 Mar 2009 08:25:55 -0700
Message-ID: <87hc1y930c.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f167.google.com ([209.85.217.167]:42582 "EHLO
	mail-gx0-f167.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753293AbZCLP0p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 11:26:45 -0400
Received: by gxk11 with SMTP id 11so1110312gxk.13
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 08:26:42 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

Russell, Paul,

As we discussed a bit in the OMAP clocks thread, there is not yet a
decision on the best way to access the PRCM registers.  I'd like to
get some discussion going so I can begin submissions of the rest of
the OMAP PM core code.

We currently have two methods for PRCM register access

1) direct access using __raw_[read|write] and OMAP_PRM_REGADDR() #defines

2) "MOD + offset" access using prm_[read|write|rmw]_*

The current code (in Russell's omap-clks3) branch is kind of a hybrid
with lots of usages of both methods, and Paul's patch (A 09) which
converted everything to (2) has been rejected.  However, I'm still not
entirely clear whether the objection was because you're opposed to the
'MOD + offset' approach in general, or just the way it was done in
this patch.

So, what is the path forward?  If you are not opposed to moving to the
'MOD + offset' approach in principle, I propose we just make a new
attempt at converting to it.  If you're opposed to it all together, we
need to start some discussion.  Russell, you seem to have suggested
you had some ideas[1].  Would you mind posting your ideas for
discussion, not necessarily patches, but just rough ideas to start
discussions.

Until we get some decision on this, it is impossible to move forward
with submissions of the rest of the OMAP PM code.

Thanks,

Kevin

[1] http://marc.info/?l=linux-omap&m=123609877205834&w=2
