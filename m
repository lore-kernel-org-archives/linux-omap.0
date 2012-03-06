From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv4 1/6] ARM: OMAP3 PM: correct enable/disable of daisy io
 chain
Date: Mon, 5 Mar 2012 21:13:15 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1203052103440.6649@utopia.booyaka.com>
References: <1330701475-22576-1-git-send-email-t-kristo@ti.com> <1330701475-22576-2-git-send-email-t-kristo@ti.com> <alpine.DEB.2.00.1203051953580.6649@utopia.booyaka.com> <4F558A42.1020503@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54489 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964934Ab2CFENR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Mar 2012 23:13:17 -0500
In-Reply-To: <4F558A42.1020503@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>, dnilesh@ti.com
Cc: Mohan V <mohanv@ti.com>, Vishwanath BS <vishwanath.bs@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org

Hi Rajendra

(thanks for adding in Nilesh, added him again here)

On Tue, 6 Mar 2012, Rajendra Nayak wrote:

> Yes, thats my understanding too, again based on taking to people like
> Nilesh, because the documentation just doesn't mention this clearly.
> The 4430 TRM is a tad bit better like you said.
> 
> I guess your confusion of IO wakeups working with EN_IO_CHAIN set to '0'
> is also probably coming from the fact that the bit itself is called
> *EN_IO_CHAIN* which is a completely *wrong* name for the bit, as
> compared to what it does.
> That bit is actually used to send a WUCLK pulse through the chain, so
> you set it to '1' and wait for it to propagate through the chain, then
> you set it to '0' and again wait for it to propagate through.

Okay.  So to confirm: EN_IO_CHAIN doesn't enable a continuous clock, it 
just controls the WUCLKIN line directly?

> The control to enable/disable is at 2 levels, a global switch which is
> 'EN_IO' in case of OMAP3 and the one at the individual pad level.

Do you happen to know what EN_IO/GLOBAL_WUEN does?  For example, if it's 
0, will the I/O chain not latch in wakeup events occuring on the pads?  
Or does it just cause the PRCM to ignore any PRCM wakeups coming from the 
I/O chain?  (Or something else, heh)

> You can also read this thread which has some more explanation based on
> my understanding of how this works
> http://www.spinics.net/lists/linux-serial/msg04480.html

I've been reading that post; it's been quite helpful.


- Paul
