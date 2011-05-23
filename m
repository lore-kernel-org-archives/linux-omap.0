From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] Fix generic irq chip
Date: Mon, 23 May 2011 08:20:03 -0700
Message-ID: <877h9h30m4.fsf@ti.com>
References: <20110520220510.GC30675@n2100.arm.linux.org.uk>
	<87lixx34ue.fsf@ti.com>
	<20110523150120.GA15153@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:58391 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752758Ab1EWPUQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 May 2011 11:20:16 -0400
Received: by mail-pw0-f48.google.com with SMTP id 16so3712556pwi.7
        for <linux-omap@vger.kernel.org>; Mon, 23 May 2011 08:20:06 -0700 (PDT)
In-Reply-To: <20110523150120.GA15153@n2100.arm.linux.org.uk> (Russell King's
	message of "Mon, 23 May 2011 16:01:20 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Lennert Buytenhek <kernel@wantstofly.org>, Nicolas Pitre <nico@fluxnic.net>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, davinci-linux-open-source@linux.davincidsp.com, linux-omap@vger.kernel.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Mon, May 23, 2011 at 06:48:41AM -0700, Kevin Hilman wrote:
>> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
>> 
>> > As a result of c42321c (genirq: Make generic irq chip depend on
>> > CONFIG_GENERIC_IRQ_CHIP), we now need those platforms using this in
>> > my tree to select this symbol.
>> >
>> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>> > --
>> > Please send acks ASAP.  Thanks to Mark for pointing this out with a patch
>> > for Samsung.
>> 
>> Acked-by: Kevin Hilman <khilman@ti.com>
>
> Thanks, but does that cover Davinci or OMAP?

Both, but since Sekhar (DaVinci co-maintainer) ack'd already for
davinci, I was mainly adding my ack for OMAP.

Kevin
