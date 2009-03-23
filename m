From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 00/09] OMAP3 clock: Clock rate change notifiers
Date: Mon, 23 Mar 2009 00:47:13 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0903230045130.4676@utopia.booyaka.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02FAF6EF1D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54418 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754086AbZCWGrP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Mar 2009 02:47:15 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02FAF6EF1D@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, paul@pwsan.com

Hi Rajendra,

On Fri, 20 Mar 2009, Nayak, Rajendra wrote:

> This patch set reverts some patches from Paul Walmsley to add the clock
> notification infrastucture for OMAP3, and adds new patches from him on top, which
> have only been circulating internally.
> These patches are posted as they are needed for the patch set to remove virtual
> clock nodes that will follow.
> 
> These patches are based on the pm-2.6.28 branch from Kevin's pm tree.

Thanks for posting these.  These aren't ready for merging yet since 
they don't contain some of the fixes discussed over the past few weeks.
I'll repost an updated version of these later today.


- Paul
