From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 00/09] OMAP3 clock: Clock rate change notifiers
Date: Tue, 24 Mar 2009 03:24:05 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0903240323160.8255@utopia.booyaka.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02FAF6EF1D@dbde02.ent.ti.com> <alpine.DEB.2.00.0903230045130.4676@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41488 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753969AbZCXJYJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Mar 2009 05:24:09 -0400
In-Reply-To: <alpine.DEB.2.00.0903230045130.4676@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, 23 Mar 2009, Paul Walmsley wrote:

> On Fri, 20 Mar 2009, Nayak, Rajendra wrote:
> 
> > This patch set reverts some patches from Paul Walmsley to add the clock
> > notification infrastucture for OMAP3, and adds new patches from him on top, which
> > have only been circulating internally.
> > These patches are posted as they are needed for the patch set to remove virtual
> > clock nodes that will follow.
> > 
> > These patches are based on the pm-2.6.28 branch from Kevin's pm tree.
> 
> Thanks for posting these.  These aren't ready for merging yet since 
> they don't contain some of the fixes discussed over the past few weeks.
> I'll repost an updated version of these later today.

Will take another shot at this later today; I'd like to do some more 
testing on the parent change case before I post these.


- Paul
