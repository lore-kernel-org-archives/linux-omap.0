From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Idle picture for those interested.
Date: Fri, 4 Apr 2008 16:56:39 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D91302742903F14923@dlee13.ent.ti.com>
References: <87abkv9917.fsf@paris.hilman.org> <3B6D69C3A9EBCA4BA5DA60D91302742903F14825@dlee13.ent.ti.com> <3B6D69C3A9EBCA4BA5DA60D91302742903F14855@dlee13.ent.ti.com> <200804041356.40567.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:32953 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751631AbYDDV4r convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Apr 2008 17:56:47 -0400
Content-class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

> I've not calibrated to verify but that seems to be what the picture is
> showing so there is some chance the time base is off.  All the
instruction
> trace is there to walk it if necessary.  There have been some comments
> about NO_HZ adding some overhead from those who measure MHz around
here
> for things like MP3 load models.  I hadn't looked very closely.

One question might be is if the timekeeping could be deferred until
after you have serviced the IRQ.  Is there a reason to make the ISR wait
for housekeeping?

Regards,
Richard W.
