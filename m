From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH 2/2] i2c: i2c-omap: Call request_irq with IRQF_DISABLED
Date: Thu, 12 Mar 2009 10:04:49 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162037B7642CC@dlee02.ent.ti.com>
References: <cover.1236345858.git.Ext-Ari.Kauppi@nokia.com>
	 <7d7e7dd1a4c64c732a21bdfcf2bd42556be708c3.1236345858.git.Ext-Ari.Kauppi@nokia.com>
	 <20090310005222.GE19758@fluff.org.uk>
	 <alpine.DEB.2.00.0903111741270.26959@utopia.booyaka.com>
	 <alpine.DEB.2.00.0903111803170.26959@utopia.booyaka.com>
	 <1236839178.6478.40.camel@kauppi-desktop>
	 <alpine.DEB.2.00.0903120041020.26959@utopia.booyaka.com>
	 <1236844467.6478.103.camel@kauppi-desktop>
	 <alpine.DEB.2.00.0903120356230.26959@utopia.booyaka.com>
 <1236857625.6478.163.camel@kauppi-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45146 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753135AbZCLPFd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 11:05:33 -0400
In-Reply-To: <1236857625.6478.163.camel@kauppi-desktop>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kauppi Ari (EXT-Ixonos/Oulu)" <ext-ari.kauppi@nokia.com>, ext Paul Walmsley <paul@pwsan.com>
Cc: Ben Dooks <ben@fluff.org.uk>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>


> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Kauppi Ari (EXT-Ixonos/Oulu)
> Sent: Thursday, March 12, 2009 6:34 AM

> > > 3) Apply Richard's patch. All spurious interrupts for IRQ 56 are gone
> > > but frequency of others increase.

The bugs fixed in my patch are function violation bugs. The TRM clearly requires the changes I made. In of themselves they don't have anything to do with spurious interrupts. Though if the FSM is messed up, there is no telling what will happen for interrupts.

In our reference code and code other customers are using. Applying fixes resulted in I2C flakiness going away.

> Boot count: 6628
>       1 write for irq 12
>       1 write for irq 25
>       1 write for irq 33
>      10 write for irq 37
>   29532 write for irq 56
>      12 write for irq 67
>       1 write for irq 71
>     281 write for irq 73
>     114 write for irq 83
>     407 write for irq 86
>
> I have also heard that with other use cases irq 17 and 21 should be in
> the list, too. The single ones from 12,25,33,71 are probably just
> one-offs and should not be taken too seriously, 37/67 are corner cases
> but 73/83/86 are definitely valid measurements.

If you apply the bus posting patch I sent a while back they will likely all go away. There are a number of subtle effects posting and resulting bursting will have on register ranges.

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg08363.html

It is quite noble that people want to experience and hunt down subtle system wide errors for a potential small performance gain. I'm tired of the weeks if not months of cumulative time wasted here. It would be more fun to play with a broken alpha version of gcc and look for subtle errors. I might eventually get some benefit.

Regards,
Richard W.

