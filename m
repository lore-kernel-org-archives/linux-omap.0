From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 02/10] omap mailbox: add initial omap3 support
Date: Thu, 22 Jan 2009 08:10:00 +0200 (EET)
Message-ID: <20090122.081000.252607346.Hiroshi.DOYU@nokia.com>
References: <8F7AF80515AF0D4D93307E594F3CB40E207E78FB@dlee03.ent.ti.com>
	<20090122.004519.48985185.Hiroshi.DOYU@nokia.com>
	<3a2dabf50901212112p10bfd8e7sc31ea58b1c36bfb7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:20333 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754017AbZAVGKL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Jan 2009 01:10:11 -0500
In-Reply-To: <3a2dabf50901212112p10bfd8e7sc31ea58b1c36bfb7@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grgupta77@gmail.com
Cc: h-kanigeri2@ti.com, linux-omap@vger.kernel.org

Hi Ramesh,

From: "ext Ramesh Gupta Guntha" <grgupta77@gmail.com>
Subject: Re: [PATCH 02/10] omap mailbox: add initial omap3 support
Date: Thu, 22 Jan 2009 10:42:52 +0530

> Hi Hiroshi,
> 
> 
> On 1/22/09, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> wrote:
> > Hi Hari,
> >
> > From: "ext Kanigeri, Hari" <h-kanigeri2@ti.com>
> > Subject: RE: [PATCH 02/10] omap mailbox: add initial omap3 support
> > Date: Wed, 21 Jan 2009 14:02:05 -0600
> >
> > > Hi Doyu-san,
> > >
> > > Can we add the function to return number of messages in the mailbox ?
> >
> > Yes. I assume that you meant the number of h/w fifo.
> > It would be helpful if you explain the case where this API is used.
> 
> This is to make sure that mail box fifo is not full before trying to
> write a new message, if it is full for any reason, one can wait for a
> while until fifo is empty.

In the current mailbox implementation, the (request)queue is provided
in order to avoid the situation where client/user has to wait until
fifo is available. And then, a kernel thread tries to put each request
into h/w fifo. If h/w fifo is full, it tries later again.

So I think that there's no need for client side to care about the
availability of h/w fifo, but there's a case that s/w queue isn't
avaiable because of the lack of memory, then client has to sleep or
try again. This is quite unlikely, though.

     Hiroshi DOYU
