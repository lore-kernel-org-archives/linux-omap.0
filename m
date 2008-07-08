From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH 0/9] OMAP2/3 SDRC/clock: control CORE M2 divider, clean
 up SDRC
Date: Tue, 8 Jul 2008 18:55:40 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162035BD67456@dlee02.ent.ti.com>
References: <20080708025225.11646.55912.stgit@localhost.localdomain>
 <02aa01c8e0b4$5c09a450$68bf18ac@ent.ti.com>
 <alpine.DEB.1.00.0807081611500.12684@utopia.booyaka.com>
 <13B9B4C6EF24D648824FF11BE8967162035BD67429@dlee02.ent.ti.com>
 <alpine.DEB.1.00.0807081730590.12684@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55365 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754682AbYGHXzy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Jul 2008 19:55:54 -0400
In-Reply-To: <alpine.DEB.1.00.0807081730590.12684@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, 'Igor Stoppa' <igor.stoppa@nokia.com>

> > > > SRAM being mapped as cacheable could be a possible reason for
> this.
> >
> > Second this.
>
> Yeah, agreed that it needs to be done, but SRAM in CDP 12.17 is still
> marked cacheable too, right?  Did CORE M2 divider changes work in CDP
> 12.17?

No CDP has it marked strongly order for a while now.  Probably around 12.14 or 15.

Yes DVFS works without noticeable hitches on CDP SDP.  There was a transition period at the kernel jump it may have stopped but its working now. 12.19 is in pre-test.

> Also still curious why, if it's the cache line eviction issue, it only
> locks up on the low- to high-speed transition.

No answer.  It could be another issue.  Timing dependent?

Generally a high to low failure is either DDR'ish or an issue with low voltage operation.

If say your I2C failed to raise the voltage or you didn't program in enough setup time into volt control you might try and go fast with out having proper voltage yet.

With the MPU cache deadlock you could still attach with JTAG and assess the state of the system.

You at least can measure voltage at time of lock up.  Using observability you can even have a go at correlating it to the first accesses.

Regards,
Richard W.
