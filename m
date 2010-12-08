From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 00/14] OMAP: PRCM/powerdomain/clockdomain patches for
 2.6.38, part one
Date: Tue, 7 Dec 2010 23:20:20 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012072320030.13430@utopia.booyaka.com>
References: <20101207012242.3708.45451.stgit@twilight.localdomain> <87wrnli0ep.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37221 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753243Ab0LHGUX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Dec 2010 01:20:23 -0500
In-Reply-To: <87wrnli0ep.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Tue, 7 Dec 2010, Kevin Hilman wrote:

> Paul Walmsley <paul@pwsan.com> writes:
> 
> > This patch series, intended for 2.6.38:
> 
> [...]
> 
> > Kevin, I'd appreciate review and acks, if appropriate, on the patches
> > that touch code that you maintain.  
> 
> Reviewed-by: Kevin Hilman <khilman@deeprootsystems.com>
> Tested-by: Kevin Hilman <khilman@deeprootsystems.com>
> 
> I did some PM testing of this series on 34xx/n900 and 35xx/beagle using
> retention idle & sususpend and off-idle and suspend.
> 
> For testing with other PM features that are targetted for 2.6.38, I've
> included it as part of my pm-core branch (which also includes your
> previous hwmod series and the watchdog series, among other things.)

Thanks for testing, Kevin, I'll update the patches accordingly.


- Paul
