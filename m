From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/10] OMAP clock/powerdomain/SDRC patches for
	post-2.6.30
Date: Thu, 18 Jun 2009 08:48:47 +0300
Message-ID: <20090618054845.GC8482@atomide.com>
References: <20090526220517.25381.75976.stgit@localhost.localdomain> <alpine.DEB.2.00.0906090110580.32281@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60263 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753120AbZFRHtJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Jun 2009 03:49:09 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0906090110580.32281@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [090609 10:14]:
> Hello Russell,
> 
> On Tue, 26 May 2009, Paul Walmsley wrote:
> 
> > here is the next set of OMAP clock patches for review for the
> > post-2.6.30 merge window.  They apply on top of the previous set
> > ("OMAP clock/SDRC patches on v2.6.30-rc5").  If you're happy with
> > these patches, Tony will queue them up into his for-next branch.
> > 
> > This series completes basic support for OMAP3 CORE DVFS.  A few other
> > minor bugs are fixed by the off-by-one patch and the GPIO debounce
> > clock patch.
> 
> Any comments on these patches?

Paul, can you please post a git pull request for Russell on these?
I think these should still go in if possible.

Russell, if you think it's too late, I'll pile them up into omap
for-next branch.

Regards,

Tony
