From: David Brownell <david-b@pacbell.net>
Subject: Re: Idle picture for those interested.
Date: Fri, 04 Apr 2008 15:07:02 -0700
Message-ID: <20080404220702.5232DCC0DF@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <87abkv9917.fsf@paris.hilman.org>
 <3B6D69C3A9EBCA4BA5DA60D91302742903F14825@dlee13.ent.ti.com>
 <3B6D69C3A9EBCA4BA5DA60D91302742903F14855@dlee13.ent.ti.com>
 <200804041356.40567.david-b@pacbell.net>
 <3B6D69C3A9EBCA4BA5DA60D91302742903F14923@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp118.sbc.mail.sp1.yahoo.com ([69.147.64.91]:39457 "HELO
	smtp118.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752144AbYDDWF4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Apr 2008 18:05:56 -0400
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D91302742903F14923@dlee13.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: r-woodruff2@ti.com
Cc: linux-omap@vger.kernel.org

> > I've not calibrated to verify but that seems to be what the picture is
> > showing so there is some chance the time base is off.  All the
> > instruction
> > trace is there to walk it if necessary.  There have been some comments
> > about NO_HZ adding some overhead from those who measure MHz around
> > here for things like MP3 load models.  I hadn't looked very closely.
>
> One question might be is if the timekeeping could be deferred until
> after you have serviced the IRQ.  Is there a reason to make the ISR wait
> for housekeeping?

If the system is in NO_HZ mode, the "jiffies" value could be invalid.
Some IRQ handlers need it to be valid.

- Dave

