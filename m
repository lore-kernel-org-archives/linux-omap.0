From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] ARM: smp: Allow real broadcast device selection
 instead of always dummy
Date: Wed, 13 Mar 2013 16:18:12 +0000
Message-ID: <20130313161811.GF13483@e106331-lin.cambridge.arm.com>
References: <1363165608-13739-1-git-send-email-santosh.shilimkar@ti.com>
 <514046B6.9020005@ti.com>
 <20130313101641.GA13483@e106331-lin.cambridge.arm.com>
 <514061D1.20603@ti.com>
 <20130313122550.GD13483@e106331-lin.cambridge.arm.com>
 <51409EC3.5050905@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:50515 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932610Ab3CMQSl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Mar 2013 12:18:41 -0400
Content-Disposition: inline
In-Reply-To: <51409EC3.5050905@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>

On Wed, Mar 13, 2013 at 03:44:03PM +0000, Santosh Shilimkar wrote:
> On Wednesday 13 March 2013 05:55 PM, Mark Rutland wrote:
> > On Wed, Mar 13, 2013 at 11:24:01AM +0000, Santosh Shilimkar wrote:
> >> On Wednesday 13 March 2013 03:46 PM, Mark Rutland wrote:
> >>> Hi Santosh,
> 
> [..]
> 
> >>>
> >>> Is the problem that the dummy timer is being registered as the broadcast
> >>> source, or that it is selected as a local timer in preference of real timers?
> >>>
> >> Dummy timer is preferred over real broadcast timer.
> > 
> > Ok.

[...]

> > I do agree it'd be worth lowering the dummy timer's rating to ensure it doesn't
> > override a real timer elsewhere. 
> > 
> Yep. Can I add you acked-by tag then for $subject patch ?
> Would be good to get this one merged as well.

Sure. Though could you reword the commit message? The patch solves the more
general issue of a dummy being preferred over real hardware even outside of
choosing the broadcast device.

Acked-by: Mark Rutland <mark.rutland@arm.com>
