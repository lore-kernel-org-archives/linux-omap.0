From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 00/11] OMAP2+: clock: add clockfw autoidle for iclks,
 OMAP2xxx
Date: Wed, 16 Feb 2011 15:14:15 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1102161510410.29817@utopia.booyaka.com>
References: <20110216065030.22089.61217.stgit@twilight.localdomain> <b83b1717e83fc907a1caf589cc53badf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:59054 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039Ab1BPWOQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Feb 2011 17:14:16 -0500
In-Reply-To: <b83b1717e83fc907a1caf589cc53badf@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Rajendra

On Wed, 16 Feb 2011, Rajendra Nayak wrote:

> > -----Original Message-----
> > From: linux-arm-kernel-bounces@lists.infradead.org
> [mailto:linux-arm-kernel-bounces@lists.infradead.org] On Behalf
> > Of Paul Walmsley
> > Sent: Wednesday, February 16, 2011 12:23 PM
> >
> > This series also ensures that all clock autoidle is disabled during
> > boot and only re-enabled if CONFIG_PM is enabled.
> 
> This does not seem to be the case. Maybe something like the
> below patch is what is missing..

Thanks for the review, you are absolutely right.  Rather than the patch 
you sent, and since mach-omap2/pm.c is compiled in even if !CONFIG_PM, 
I'd propose a different approach.  Until we can sort out the 
CONFIG_PM/pm.c issue, probably it would make more sense to move the 
autoidle-enable as part of CONFIG_OMAP_RESET_CLOCKS.  Will send a patch in 
reply to the original thread.


- Paul
