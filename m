From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [GIT PULL] ARM: OMAP2+: Generic cleanups for 3.10
Date: Wed, 27 Mar 2013 20:09:34 +0000
Message-ID: <448912EABC71F84BBCADFD3C67C4BE52784FD7@DBDE01.ent.ti.com>
References: <1363768789-17929-1-git-send-email-santosh.shilimkar@ti.com>
 <20130327180321.GB10155@atomide.com>
 <5153431E.60007@ti.com>,<20130327195839.GF10155@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43154 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753960Ab3C0UJm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Mar 2013 16:09:42 -0400
In-Reply-To: <20130327195839.GF10155@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Sorry for top posting ...
I will pick the ack and update commit log to prepare new pull request
for you. 

Regards,
Santosh
________________________________________
From: Tony Lindgren [tony@atomide.com]
Sent: Thursday, March 28, 2013 1:28 AM
To: Shilimkar, Santosh
Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
Subject: Re: [GIT PULL] ARM: OMAP2+: Generic cleanups for 3.10

* Santosh Shilimkar <santosh.shilimkar@ti.com> [130327 12:08]:
> On Wednesday 27 March 2013 11:33 PM, Tony Lindgren wrote:
> > * Santosh Shilimkar <santosh.shilimkar@ti.com> [130320 01:42]:
> >> Tony,
> >>
> >> Here is the pull request for various OMAP cleanups and fixes which are posted
> >> earlier on the list. It contains OMAP4 smp cleanup, removal of unwanted static
> >> deps from OMAP4, RAM offset consolidation and fiq tuple cleanup.
> >>
> >>
> >> The following changes since commit a937536b868b8369b98967929045f1df54234323:
> >>
> >>   Linux 3.9-rc3 (2013-03-17 15:59:32 -0700)
> >>
> >> are available in the git repository at:
> >>
> >>   git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux.git for_3.10/omap_generic_cleanup
> >>
> >> for you to fetch changes up to 37e1f64c3bc2b3455a9688de8527a341847b3ad9:
> >>
> >>   ARM: OMAP4: Fix the init code to have OMAP4460 errata available in DT build (2013-03-19 12:57:30 +0530)
> >
> > Thanks pulled this into omap-for-v3.10/cleanup.
> >
> Thanks Tony !!

Hmm looks like Kevin had some good comments and acks, can you
please update and send a new pull req? I'll set up cleanup-v2 branch
when those are available.

Regards,

Tony
