From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH 0/4] 34xx spurious interrupts unravelling
Date: Fri, 31 Oct 2008 23:01:42 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE89671620369885CC0@dlee02.ent.ti.com>
References: <1225480873-30835-1-git-send-email-tony@atomide.com>
 <200810311307.15154.david-b@pacbell.net>
 <20081031203529.GB28924@atomide.com> <200810311459.04687.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40519 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750707AbYKAEBv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 1 Nov 2008 00:01:51 -0400
In-Reply-To: <200810311459.04687.david-b@pacbell.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>, Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> owner@vger.kernel.org] On Behalf Of David Brownell
> Sent: Friday, October 31, 2008 4:59 PM

> As in, issue those dma cache updates, then write to the
> DMA or peripheral controller registers ... and the key data
> was still in the write buffers when those writes completed!
> That's quite unusual; possibly related to memory controller
> bugs in that silicon revision.

For the next series of ARMv7 Cortex's this is all being projected to require much more strictness in access ordering and use of barriers.

There have been some cautions about newer write buffer policies which try and keep data instead of flushing it. Today even if you miss some drain in a small amount of time it will happen.  That may not be the case always.

Regards,
Richard W.

