From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: Re: [PATCH v3 5/5] OMAP: mailbox: add notification support for
 multiple readers
Date: Fri, 19 Nov 2010 08:44:38 -0600
Message-ID: <AANLkTi=EMBrb0eHZyzPen2DHGR4ARh1T8ojT7jOVQ67u@mail.gmail.com>
References: <1290107742-16760-1-git-send-email-h-kanigeri2@ti.com>
	<1290107742-16760-6-git-send-email-h-kanigeri2@ti.com>
	<20101119085007.GK6446@legolas.emea.dhcp.ti.com>
	<AANLkTimSxGZufLk1RzQuBSg2vBF1p9BXFP8abVZVoLFs@mail.gmail.com>
	<20101119120938.GN2329@legolas.emea.dhcp.ti.com>
	<AANLkTinVf8--zmGa7svapcVpEp2BPXf33DtdruLtoJx5@mail.gmail.com>
	<20101119125353.GB5818@legolas.emea.dhcp.ti.com>
	<AANLkTi=VoUixouRAz-a+y9Jf6z94OtLe9UzWjnod743s@mail.gmail.com>
	<1290176736.15533.17.camel@eowin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:44300 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753210Ab0KSOok (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Nov 2010 09:44:40 -0500
Received: by mail-vw0-f41.google.com with SMTP id 10so2311241vws.28
        for <linux-omap@vger.kernel.org>; Fri, 19 Nov 2010 06:44:40 -0800 (PST)
In-Reply-To: <1290176736.15533.17.camel@eowin>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: balbi@ti.com, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Fernando Guzman Lugo <x0095840@ti.com>

Felipe,


On Fri, Nov 19, 2010 at 8:25 AM, Felipe Balbi <me@felipebalbi.com> wrote:
> Hi, (at home already),
>
> On Fri, 2010-11-19 at 07:57 -0600, Kanigeri, Hari wrote:
>> > think of it as FIFO. So the first completed message is the first in your
>> > list of requests. Ain't that easy ? :-)
>>
>> Actually it isn't that easy ;) because there is no guarantee that the
>> completed message is the first one in the list of requests.
>> Responses could be asynchronous and we cannot depend on serialized
>> handling of requests on BIOS...even in some cases you might not even
>> get a response for particular request in which case you have to handle
>> that in IPC module.
>
> you did not get what I said then.

Not really :). Please let me know if if I am wrong, what you
addressing is getting the confirmation that a message is sent and what
I am addressing with the patch is that a response is received from
M3/DSP.

>
> Then you kick the transfers which will:
>
> request = list_first_entry(mbox->req_list);
> setup_correct_registers();
> enable_irq();
> kick_transfer();

Writing to the mailbox fifo delivers the message to other side, and if
the fifo is full the messages are queued up in mbox kfifo, which are
then deliverd in the order they are received.
I don't see a use case where the senders need to know that their
message is actually written to mbox fifo, if there is one we can look
into it.
You enable TX irq only when the mbox fifo is full.

>
> return;
>
> then on IRQ handler, when the message is completed you do:
>
> request = list_first_entry(mbox->req_list);
> list_del(request->list);
>
> /* unlock */
> request->complete();
> /* lock again */
>
> you will always one message at a time, so you know that when you get the
> IRQ, the first message on your list is what was just completed.
>
>> eg: Process A sends a message to M3 core to kick off some translation
>> in some codec, the thread handling this request running on BIOS would
>> kick off the translation and wait for the completion before sending
>> the response. In the mean time BIOS will be handling other requests
>> coming to it, and shouldn't be blocked until the completion of first
>> request.
>
> why you're involving BIOS here ? mailbox should not have to know what's
> on the other side. All it needs to know is how to get the message to the
> other side, no matter _what_ it is.
>
> So until BIOS sends the response, you would not start another transfer
> on mailbox neither you would any IRQ, right ?

That's not true. Even if BIOS doesn't respond to a request, you could
still keep sending the messages.


Thank you,
Best regards,
Hari Kanigeri
