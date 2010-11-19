From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH v3 5/5] OMAP: mailbox: add notification support for
 multiple readers
Date: Sat, 20 Nov 2010 01:07:16 +0200
Message-ID: <1290208036.15533.24.camel@eowin>
References: <1290107742-16760-1-git-send-email-h-kanigeri2@ti.com>
	 <1290107742-16760-6-git-send-email-h-kanigeri2@ti.com>
	 <20101119085007.GK6446@legolas.emea.dhcp.ti.com>
	 <AANLkTimSxGZufLk1RzQuBSg2vBF1p9BXFP8abVZVoLFs@mail.gmail.com>
	 <20101119120938.GN2329@legolas.emea.dhcp.ti.com>
	 <AANLkTinVf8--zmGa7svapcVpEp2BPXf33DtdruLtoJx5@mail.gmail.com>
	 <20101119125353.GB5818@legolas.emea.dhcp.ti.com>
	 <AANLkTi=VoUixouRAz-a+y9Jf6z94OtLe9UzWjnod743s@mail.gmail.com>
	 <1290176736.15533.17.camel@eowin>
	 <AANLkTi=EMBrb0eHZyzPen2DHGR4ARh1T8ojT7jOVQ67u@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:33744 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757447Ab0KSXG5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Nov 2010 18:06:57 -0500
In-Reply-To: <AANLkTi=EMBrb0eHZyzPen2DHGR4ARh1T8ojT7jOVQ67u@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: balbi@ti.com, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Fernando Guzman Lugo <x0095840@ti.com>

Hi Hari,

On Fri, 2010-11-19 at 08:44 -0600, Kanigeri, Hari wrote:
> Not really :). Please let me know if if I am wrong, what you
> addressing is getting the confirmation that a message is sent and what
> I am addressing with the patch is that a response is received from
> M3/DSP.

You got it wrong. My proposal addresses the same what you say, but in a
different and, IMO, better fashion. There's no need to add a blocking
notifier which you can't be sure when that'll be scheduled. Have you
measured possible worst case scenario of this patch ? What's the latency
added by the blocking notifier ? Imagine user cpu is highly busy, and it
takes a long time to call the blocking notifier, is that acceptable ?

> > Then you kick the transfers which will:
> >
> > request = list_first_entry(mbox->req_list);
> > setup_correct_registers();
> > enable_irq();
> > kick_transfer();
> 
> Writing to the mailbox fifo delivers the message to other side, and if
> the fifo is full the messages are queued up in mbox kfifo, which are
> then deliverd in the order they are received.

isn't that the same as what I suggested ? Messages are queued in the
ordered they are received and sent to BIOS at the same order.

> I don't see a use case where the senders need to know that their
> message is actually written to mbox fifo, if there is one we can look
> into it.

I never said there's such usecase :-)

> That's not true. Even if BIOS doesn't respond to a request, you could
> still keep sending the messages.

but then when do you consider a message "completed" ? When it gets sent
or when you receive a response from BIOS ?

-- 
balbi

