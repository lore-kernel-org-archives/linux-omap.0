From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH v3 5/5] OMAP: mailbox: add notification support for
 multiple readers
Date: Fri, 19 Nov 2010 16:25:36 +0200
Message-ID: <1290176736.15533.17.camel@eowin>
References: <1290107742-16760-1-git-send-email-h-kanigeri2@ti.com>
	 <1290107742-16760-6-git-send-email-h-kanigeri2@ti.com>
	 <20101119085007.GK6446@legolas.emea.dhcp.ti.com>
	 <AANLkTimSxGZufLk1RzQuBSg2vBF1p9BXFP8abVZVoLFs@mail.gmail.com>
	 <20101119120938.GN2329@legolas.emea.dhcp.ti.com>
	 <AANLkTinVf8--zmGa7svapcVpEp2BPXf33DtdruLtoJx5@mail.gmail.com>
	 <20101119125353.GB5818@legolas.emea.dhcp.ti.com>
	 <AANLkTi=VoUixouRAz-a+y9Jf6z94OtLe9UzWjnod743s@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:36870 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108Ab0KSOZR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Nov 2010 09:25:17 -0500
In-Reply-To: <AANLkTi=VoUixouRAz-a+y9Jf6z94OtLe9UzWjnod743s@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: balbi@ti.com, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Fernando Guzman Lugo <x0095840@ti.com>

Hi, (at home already),

On Fri, 2010-11-19 at 07:57 -0600, Kanigeri, Hari wrote:
> > think of it as FIFO. So the first completed message is the first in your
> > list of requests. Ain't that easy ? :-)
> 
> Actually it isn't that easy ;) because there is no guarantee that the
> completed message is the first one in the list of requests.
> Responses could be asynchronous and we cannot depend on serialized
> handling of requests on BIOS...even in some cases you might not even
> get a response for particular request in which case you have to handle
> that in IPC module.

you did not get what I said then.

users will queue a request, which is simply a list_add_tail() to the
mailbox's request list.

Then you kick the transfers which will:

request = list_first_entry(mbox->req_list);
setup_correct_registers();
enable_irq();
kick_transfer();

return;

then on IRQ handler, when the message is completed you do:

request = list_first_entry(mbox->req_list);
list_del(request->list);

/* unlock */
request->complete();
/* lock again */

you will always one message at a time, so you know that when you get the
IRQ, the first message on your list is what was just completed.

> eg: Process A sends a message to M3 core to kick off some translation
> in some codec, the thread handling this request running on BIOS would
> kick off the translation and wait for the completion before sending
> the response. In the mean time BIOS will be handling other requests
> coming to it, and shouldn't be blocked until the completion of first
> request.

why you're involving BIOS here ? mailbox should not have to know what's
on the other side. All it needs to know is how to get the message to the
other side, no matter _what_ it is.

So until BIOS sends the response, you would not start another transfer
on mailbox neither you would any IRQ, right ?

> > Still it doesn't the fact that currently you allow for that. There are
> > malware writers everywhere. But hey, it would be cool to have mailbox
> > appear on securityfocus.com :-p
> >
> 
> Agree about malware writers. Add PM interfaces as well to the list as
> one can misuse them as well ;)

for PM interfaces it's a bit more difficult and you cannot tamper with
another device's PM (well, after all are converted to hwmod, that is)
and on top of that, the biggest trouble you will run into, is your
battery dying quickly. With mailbox you have actual useful data coming
back and forth, no ?

-- 
balbi

