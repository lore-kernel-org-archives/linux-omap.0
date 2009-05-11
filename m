From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/2] I2C: OMAP: spurious IRQ fixes
Date: Mon, 11 May 2009 01:29:18 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0905071529070.17514@utopia.booyaka.com>
References: <20090426042504.31316.68357.stgit@localhost.localdomain> <49F59D89.3030008@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51731 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752551AbZEKH3S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 May 2009 03:29:18 -0400
In-Reply-To: <49F59D89.3030008@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>

On Mon, 27 Apr 2009, Aaro Koskinen wrote:

> Paul Walmsley wrote:
> > It seems to work: under constant I2C load, no spurious IRQ messages
> > showed up after several hours of testing.  (Without these patches,
> > spurious IRQs usually show up in a few minutes.)  Some of the code has
> > also been cleaned up.
> > 
> > Any feedback on how this series works for others is appreciated.
> > 
> > Tested on N800, Beagle and 3430SDP.
> 
> With these patches I'm getting receive overruns quite easily on rx51 when
> doing large reads from TWL4030 RTC.

A brief update for anyone following along on the list: 

Aaro sent me a test-case.  It seems that the receive overruns only affect 
PM kernels.  They are caused by the MPU going to sleep while it waits for 
an I2C interrupt.  It turns out that the current driver causes receive 
overruns also; it just hides them.  The receive overruns are fairly 
straightforward to deal with by setting an MPU wakeup latency constraint 
during I2C operations.

So the plan now is to send two sets of patches.  One set will resolve the 
spurious IRQ problems.  The other will resolve the receive overrun 
issues and will be mostly against the PM branch.


- Paul
