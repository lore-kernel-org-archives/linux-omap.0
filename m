From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv10 04/14] omap: prm: add support for suspend prepare
 and finish callbacks
Date: Mon, 12 Dec 2011 11:57:42 +0200
Message-ID: <1323683862.31914.23.camel@sokoban>
References: <1323440857-385-1-git-send-email-t-kristo@ti.com>
	 <1323440857-385-5-git-send-email-t-kristo@ti.com>  <87aa71l52c.fsf@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46697 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751386Ab1LLJ5q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Dec 2011 04:57:46 -0500
In-Reply-To: <87aa71l52c.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com

On Fri, 2011-12-09 at 15:04 -0800, Kevin Hilman wrote:
> Tero Kristo <t-kristo@ti.com> writes:
> 
> > These are needed because runtime PM is disabled during suspend, and
> > it is bad if we get interrupts from the PRCM chain handler during it.
> > This patch masks all the PRCM interrupt events, but does not ack them,
> > if an interrupt is received during suspend. Once suspend->finish
> > is called, all the masked events will be re-enabled, which causes
> > immediate PRCM interrupt and handles the postponed event.
> >
> > The suspend prepare and complete  callbacks will be called from pm34xx.c /
> > pm44xx.c files in the following patches.
> 
> You might just update this changelog to clarify why you're using the the
> driver-specific prepare & complete terminology whereas this code is
> using begin/finish hooks as part of platform_pm_ops.
> 
> IOW, state that this will soon be becoming a real driver, so you're
> using the driver terminology.
> 
> Also note that subject uses prepare & finish instead of prepare & complete.

Yea this changelog is outdated, will fix.

-Tero

