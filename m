From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Idle picture for those interested.
Date: Fri, 4 Apr 2008 16:45:55 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D91302742903F14911@dlee13.ent.ti.com>
References: <87abkv9917.fsf@paris.hilman.org> <3B6D69C3A9EBCA4BA5DA60D91302742903F14825@dlee13.ent.ti.com> <3B6D69C3A9EBCA4BA5DA60D91302742903F14855@dlee13.ent.ti.com> <200804041356.40567.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60798 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751476AbYDDVqG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Apr 2008 17:46:06 -0400
Content-class: urn:content-classes:message
In-Reply-To: <200804041356.40567.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

> Presumably this is from the CPU trace port, OMAP3 with NO_HZ.

Yes. Just using git-latest kernel and NO_HZ.  You can get the same data
on OMAP2 also through ETM.

I don't see much profiling on the 'live' tree here.  Internal trees at
TI generally get looked at more critically.  It might be interesting to
compare.

> Do I read this right:  18 usec tick processing overhead after
> receiving an IRQ, before even getting to the generic OMAP GPIO
> irq logic (which then has to dispatch to the real IRQ handler)?
> Over 5 usec just for updating jiffies64 ...

I've not calibrated to verify but that seems to be what the picture is
showing so there is some chance the time base is off.  All the
instruction trace is there to walk it if necessary.  There have been
some comments about NO_HZ adding some overhead from those who measure
MHz around here for things like MP3 load models.  I hadn't looked very
closely.

I suppose this might be an ether interrupt.  If it were just a timer
interrupt it shouldn't need to make its way to the GPIO handler.

Trace does give a unique view into the system which is hard to get
otherwise.

Regards,
Richard W.

