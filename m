From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] OMAP3 PM: preformance enhancements
Date: Wed, 27 Jun 2012 04:55:39 -0700
Message-ID: <20120627115538.GE3483@atomide.com>
References: <87obo6dz15.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59369 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753514Ab2F0Lzm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jun 2012 07:55:42 -0400
Content-Disposition: inline
In-Reply-To: <87obo6dz15.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Jean Pihet <jean.pihet@newoldbits.com>

* Kevin Hilman <khilman@ti.com> [120626 05:47]:
> Tony,
> 
> Please pull the following PM/performance enhancements for v3.6.  I
> recently rebased it on your devel-pm branch to avoid some conflicts
> with the IO chain stuff recently merged from Paul.
> 
> This series had the goal of improving the responsiveness of the
> shallowest idle states.  Several reports came in that even when only
> hitting the shallowest idle states, there was a significant performance
> hit.  This series addresses the major sources of latency in the
> shallowest idle states.

OK, pulling into devel-pm.

Tony
