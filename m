From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 09.5/16] mmc: omap: Remove cpu_is_omap usage from the
 driver
Date: Tue, 16 Oct 2012 14:02:25 -0700
Message-ID: <20121016210225.GK15569@atomide.com>
References: <20121004213950.26676.21898.stgit@muffinssi.local>
 <20121004220454.26676.10131.stgit@muffinssi.local>
 <20121005180840.GN3874@atomide.com>
 <87ipaog4mp.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:41643 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751875Ab2JPVCc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Oct 2012 17:02:32 -0400
Content-Disposition: inline
In-Reply-To: <87ipaog4mp.fsf@octavius.laptop.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, Venkatraman S <svenkatr@ti.com>

* Chris Ball <cjb@laptop.org> [121005 11:24]:
> On Fri, Oct 05 2012, Tony Lindgren wrote:
> >
> > Chris, I can set up a minimal immutable branch with omap
> > header changes that you can also pull into MMC tree if these
> > two MMC patches look ackable to you.
> 
> Thanks, sounds good.

Chris, I've now pushed out branch omap-for-v3.8/cleanup-headers-mmc
based on -rc1. The branch is located at:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git

It contains two omap MMC related patches that you can also merge
into the MMC tree if needed as now include plat/mmc.h is gone for
omaps.

Regards,

Tony
