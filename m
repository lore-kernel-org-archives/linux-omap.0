From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH 0/4] 34xx spurious interrupts unravelling
Date: Sat, 1 Nov 2008 07:57:29 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE89671620369885CDB@dlee02.ent.ti.com>
References: <1225480873-30835-1-git-send-email-tony@atomide.com>
 <200810311459.04687.david-b@pacbell.net>
 <13B9B4C6EF24D648824FF11BE89671620369885CC0@dlee02.ent.ti.com>
 <200810312308.36522.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48567 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401AbYKAM5i convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 1 Nov 2008 08:57:38 -0400
In-Reply-To: <200810312308.36522.david-b@pacbell.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> From: David Brownell [mailto:david-b@pacbell.net]
> Sent: Saturday, November 01, 2008 1:09 AM

> > For the next series of ARMv7 Cortex's this is all being projected
> > to require much more strictness in access ordering and use of barriers.
>
> Any particular kind of barriers?  barrier() is compiler advice,
> and gets the most use in Linux ... but <asm/system.h> reminds
> me that V7 has isb/dsb/dmb instructions, and V6 can do them too.
> (Now I'll have to go look at what they do again...)
>
> That case needed a dsb analogue (on armv5, flush write buffer).

In doc's and training material there are examples of sequences which need care.  As they are not our doc's I can't publicly share them. They will start showing up over time as hardware becomes more real. Single core is more aggressive and the dual core variants compound issues.

>From a given CPU's point of few it is free to do many things to normal memory behind your back as long at the time you access it (from a single CPU point of view) the value is correct.  This requires strict care to be 100% safe in coordinating with DMA to normal memories.

For A8 today many aspects of this are less relevant as implementation won't do it all yet.

Regards,
Richard W.

