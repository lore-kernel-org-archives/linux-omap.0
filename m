From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP1: unnecessary timer interrupt handler code?
Date: Tue, 10 May 2011 19:31:18 +0100
Message-ID: <20110510183118.GA5336@n2100.arm.linux.org.uk>
References: <20110508162800.GM27807@n2100.arm.linux.org.uk> <20110509060332.GV27860@atomide.com> <87y62e4u7h.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:57063 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784Ab1EJSba (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 May 2011 14:31:30 -0400
Content-Disposition: inline
In-Reply-To: <87y62e4u7h.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Tue, May 10, 2011 at 02:26:57PM +0200, Kevin Hilman wrote:
> Tony Lindgren <tony@atomide.com> writes:
> 
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [110508 19:24]:
> >> MPU timer 2 is used on OMAP1 for the clock source and scheduler clock.
> >> It registers an interrupt, which counts the number of overflows of
> >> this timer.  However, this counter is only referenced by the interrupt
> >> handler.
> >> 
> >> So, it seems that the following code serves very little purpose.  Can
> >> it be simply deleted?
> >
> > Seems safe to me. This is probably some left over legacy code
> > from long time ago.
> 
> Yes, I believe this is left over legacy code and can be removed.
> 
> Russell, feel free to remove it, or let me know if you want a patch from
> me.  If you do it, feel free add
> 
> Acked-by: Kevin Hilman <khilman@ti.com>

Thanks, added the ack to the patch.  (See the series I posted this morning).
