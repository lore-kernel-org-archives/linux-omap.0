From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH 00/18] omap platform data and board updates for 2.6.35
 merge window
Date: Mon, 10 May 2010 10:57:34 +0300
Message-ID: <1273478254.2305.10.camel@tubuntu.research.nokia.com>
References: <20100505192957.21568.19569.stgit@baageli.muru.com>
	 <5555D7E5-3848-4915-A7B0-1CD1732E1C69@student.utwente.nl>
	 <20100505210926.GE29604@atomide.com>
	 <1273131758.1978.125.camel@tubuntu.research.nokia.com>
	 <20100506154430.GM29604@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:18406 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755398Ab0EJH6O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 May 2010 03:58:14 -0400
In-Reply-To: <20100506154430.GM29604@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: Koen Kooi <koen@dominion.thruhere.net>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

On Thu, 2010-05-06 at 17:44 +0200, ext Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@nokia.com> [100506 00:38]:
> > On Wed, 2010-05-05 at 23:09 +0200, ext Tony Lindgren wrote:
> > > * Koen Kooi <koen@dominion.thruhere.net> [100505 13:16]:
> > > > Tony,
> > > > 
> > > > Any chance of https://patchwork.kernel.org/patch/94049/ going in as well? Tomi has acked it already.
> > > 
> > > That one looks good to me, but I thought Tomi is going to
> > > queue all the DSS board-*.c patches somewhere.
> > 
> > I thought we agreed that board file changes go through linux-omap after
> > I've acked them, to reduce the possibility of conflicts.
> > 
> > But yes, I can add it to my tree. I'll send it back to you if we start
> > to get conflicts =).
> 
> Great. It's best that Tomi queues the DSS board file changes.
> 
> BTW, I have not picked or marked any of the DSS board file changes
> in patchwork, I think there are several of them sitting there.
> 
> Tomi, if something conflicts, you can do a git branch for me to
> pull for the DSS board file changes.
> 
> Note that the arch/arm/*omap*/ DSS changes still need to be posted
> to also linux-arm-kernel for review before they can be merged.

I have been sending the patches to linux-omap and linux-fbdev. Is
linux-arm-kernel also required in addition to those two lists?

 Tomi


