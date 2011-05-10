From: Kevin Hilman <khilman@ti.com>
Subject: Re: OMAP1: unnecessary timer interrupt handler code?
Date: Tue, 10 May 2011 14:26:57 +0200
Message-ID: <87y62e4u7h.fsf@ti.com>
References: <20110508162800.GM27807@n2100.arm.linux.org.uk>
	<20110509060332.GV27860@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:46792 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756198Ab1EJM1E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 May 2011 08:27:04 -0400
Received: by mail-fx0-f54.google.com with SMTP id 11so6209713fxm.41
        for <linux-omap@vger.kernel.org>; Tue, 10 May 2011 05:27:02 -0700 (PDT)
In-Reply-To: <20110509060332.GV27860@atomide.com> (Tony Lindgren's message of
	"Mon, 9 May 2011 09:03:35 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> * Russell King - ARM Linux <linux@arm.linux.org.uk> [110508 19:24]:
>> MPU timer 2 is used on OMAP1 for the clock source and scheduler clock.
>> It registers an interrupt, which counts the number of overflows of
>> this timer.  However, this counter is only referenced by the interrupt
>> handler.
>> 
>> So, it seems that the following code serves very little purpose.  Can
>> it be simply deleted?
>
> Seems safe to me. This is probably some left over legacy code
> from long time ago.

Yes, I believe this is left over legacy code and can be removed.

Russell, feel free to remove it, or let me know if you want a patch from
me.  If you do it, feel free add

Acked-by: Kevin Hilman <khilman@ti.com>



