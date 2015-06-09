From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC PATCH] usb: dwc3: ep0: Fix mem corruption on OUT transfers
 of more than 512 bytes
Date: Tue, 9 Jun 2015 13:24:32 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1506091320160.1324-100000@iolanthe.rowland.org>
References: <557710CE.5050304@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:38725 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753059AbbFIRYd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Jun 2015 13:24:33 -0400
In-Reply-To: <557710CE.5050304@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>, Felipe Balbi <balbi@ti.com>, gregkh@linuxfoundation.org, linux-omap@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org

On Tue, 9 Jun 2015, Kishon Vijay Abraham I wrote:

> > But with a bounce buffer that's only 512 bytes long, you can never send
> > an entire packet's worth of data.  If the bounce buffer is 1024 bytes
> 
> for control endpoint, 512 bytes should be sufficient to send entire packet right?

Yes, you're right.  I had confused control endpoints with bulk 
endpoints, where the maxpacket size is 1024.  Sorry for the mistake.

> > then you can send the entire first packet.  When that's done, you can
> > send the second packet.  And so on.  It wouldn't be quite as fast, but
> > for ep0 that shouldn't matter.
> 
> right! this is a variant of what I tried to implement in chained TRB [1]. 
> $subject tries just to avoid memory corruption instead of actually trying to 
> receive all the data.

Okay.  If you take the $SUBJECT approach, I think it would be better
for an URB submission to fail than for the host controller to send only
part of the data.

Alan Stern

