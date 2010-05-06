From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/18] omap platform data and board updates for 2.6.35
 merge window
Date: Thu, 6 May 2010 08:44:30 -0700
Message-ID: <20100506154430.GM29604@atomide.com>
References: <20100505192957.21568.19569.stgit@baageli.muru.com>
 <5555D7E5-3848-4915-A7B0-1CD1732E1C69@student.utwente.nl>
 <20100505210926.GE29604@atomide.com>
 <1273131758.1978.125.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:52864 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932192Ab0EFPod (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 May 2010 11:44:33 -0400
Content-Disposition: inline
In-Reply-To: <1273131758.1978.125.camel@tubuntu.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: Koen Kooi <koen@dominion.thruhere.net>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

* Tomi Valkeinen <tomi.valkeinen@nokia.com> [100506 00:38]:
> On Wed, 2010-05-05 at 23:09 +0200, ext Tony Lindgren wrote:
> > * Koen Kooi <koen@dominion.thruhere.net> [100505 13:16]:
> > > Tony,
> > > 
> > > Any chance of https://patchwork.kernel.org/patch/94049/ going in as well? Tomi has acked it already.
> > 
> > That one looks good to me, but I thought Tomi is going to
> > queue all the DSS board-*.c patches somewhere.
> 
> I thought we agreed that board file changes go through linux-omap after
> I've acked them, to reduce the possibility of conflicts.
> 
> But yes, I can add it to my tree. I'll send it back to you if we start
> to get conflicts =).

Great. It's best that Tomi queues the DSS board file changes.

BTW, I have not picked or marked any of the DSS board file changes
in patchwork, I think there are several of them sitting there.

Tomi, if something conflicts, you can do a git branch for me to
pull for the DSS board file changes.

Note that the arch/arm/*omap*/ DSS changes still need to be posted
to also linux-arm-kernel for review before they can be merged.

Regards,

Tony
