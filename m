From: David Brownell <david-b@pacbell.net>
Subject: Re: Preempt-RT on OMAP3?
Date: Mon, 6 Apr 2009 15:20:40 -0700
Message-ID: <200904061520.59391.david-b@pacbell.net>
References: <5a7b8b7b0904052025g74325484h66335606bebea5a3@mail.gmail.com> <200904060325.45758.david-b@pacbell.net> <5a7b8b7b0904061453m725eee67m4b74c73bbffeb994@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp125.sbc.mail.sp1.yahoo.com ([69.147.65.184]:33557 "HELO
	smtp125.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1759892AbZDFWVV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Apr 2009 18:21:21 -0400
In-Reply-To: <5a7b8b7b0904061453m725eee67m4b74c73bbffeb994@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hugo Vincent <hugo.vincent@gmail.com>
Cc: linux-omap@vger.kernel.org

On Monday 06 April 2009, Hugo Vincent wrote:
> 
> Here are some of the crashes I've seen. Warning - I'm new to -rt and
> to the linux-omap tree, so I'll apologize in advance if these are just
> a result of me missing something obvious.

Thanks, I'll take a look.


> Context: using USB-gadget ethernet (g_ether) over musb (configured as
> just peripheral, not OTG). Most of the time it works, but after a
> while, or when it encounters a large packet (e.g fping -b30000) it
> crashes like so (apparently something to do with receive DMA usage).
> Although the fping -b case is kindof pathological, I've seen the same
> crash when ssh/scping files across to the board, so it does occur in
> real usage.

RX DMA is troublesome with the MUSB code, and there are some bugfixes
pending which should affect it.  (Posted to linux-usb over the last
week or two.)

Do these problems show up with DMA disabled?

- Dave
 


