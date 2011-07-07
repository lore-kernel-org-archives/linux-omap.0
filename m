From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v3 00/13] OMAP4: Add modulemode support to hwmod
 framework
Date: Thu, 7 Jul 2011 02:17:48 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107070205010.30028@utopia.booyaka.com>
References: <1309554558-19819-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44849 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754613Ab1GGIRt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jul 2011 04:17:49 -0400
In-Reply-To: <1309554558-19819-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, 1 Jul 2011, Benoit Cousson wrote:

> Here is the series that finally add the management of the modulemode
> directly from hwmod fmwk instead of using a fake clock node to represent
> the IP.
> 
> This v2 update is fixing a couple of regressions I introduced in the first
> release.
> 
> A second series will clean most of the remaining data from the clock data
> file. Before that I have to rebase Rajendra's series to control the
> clockdomain from the hwmod framework, otherwise the modules will
> not be enabled properly since their clockdomain will not be changed
> to SW_SUP during enable.
> 
> The series is based on for_3.1/3_hwmod_fixes and tested
> on OMAP4430 ES2.1 + SDP. It should not affect OMAP2 & 3, but some testing
> are definitively needed.

Okay.  So I've changed this series to be based on v3.0-rc6, so it can be 
considered independently of cleanups, as is my understanding of what Tony 
wants.  As mentioned before, I've also dropped some code that breaks on 
OMAP2/3.  Some of Todd's comments have been addressed.  Also, functions in 
cminst*.c now have 'cminst' in their name, to conform to the rest of the 
functions in those files.  Not sure how I missed that the first time.

The updated series has been queued for 3.1 at 
git://git.pwsan.com/linux-2.6 in the 'omap4_hwmod_modulemode_a_3.1' 
branch.


- Paul
