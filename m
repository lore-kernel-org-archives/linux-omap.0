From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: Re: [PATCH v3 5/5] OMAP: mailbox: add notification support for
 multiple readers
Date: Fri, 19 Nov 2010 22:01:35 -0600
Message-ID: <AANLkTi=OH1y=Q39yqd5m+PXEvM1pX6p_SmH_HFYDHHsK@mail.gmail.com>
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
	<1290208036.15533.24.camel@eowin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:47082 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756584Ab0KTEBg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Nov 2010 23:01:36 -0500
Received: by mail-vw0-f47.google.com with SMTP id 6so515577vws.6
        for <linux-omap@vger.kernel.org>; Fri, 19 Nov 2010 20:01:35 -0800 (PST)
In-Reply-To: <1290208036.15533.24.camel@eowin>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: balbi@ti.com, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Fernando Guzman Lugo <x0095840@ti.com>

Felipe,

On Fri, Nov 19, 2010 at 5:07 PM, Felipe Balbi <me@felipebalbi.com> wrote:
> Hi Hari,
>
> On Fri, 2010-11-19 at 08:44 -0600, Kanigeri, Hari wrote:
>> Not really :). Please let me know if if I am wrong, what you
>> addressing is getting the confirmation that a message is sent and what
>> I am addressing with the patch is that a response is received from
>> M3/DSP.
>
> You got it wrong. My proposal addresses the same what you say, but in a
> different and, IMO, better fashion. There's no need to add a blocking
> notifier which you can't be sure when that'll be scheduled.

hmm, it is called in the work queue context after a mailbox interrupt
is received. Blocking notifier just calls all the registered
callbacks, and in this case only one callback is registered so it is
same as today where a function pointer in mailbox is set to callback
function.

> Have you
> measured possible worst case scenario of this patch ? What's the latency
> added by the blocking notifier ?

Of course :), profiling was done before releasing this code and no
difference observed with or without blocking notifier. All the OMAP4
use cases are exercising this code. Just curious , are you doubting
the blocking notifier mechanism ?

> Imagine user cpu is highly busy, and it
> takes a long time to call the blocking notifier, is that acceptable ?

The mailbox rx interrupt schedules the RX work queue, from where the
blocking Notifier is called to notify the interested clients of the
response.
In previous implementation, the work queue was calling the callback
that was registered by setting the mailbox's internal function
pointer, and the only change I did is to change the function pointer
to Notifier call so that the users don't muck with the driver's
internal pointer. Latency wise there is no difference between calling
the function directly or through blocking Notifier, since blocking
notifier mechanism just calls the registered callbacks.

>
>> > Then you kick the transfers which will:
>> >
>> > request = list_first_entry(mbox->req_list);
>> > setup_correct_registers();
>> > enable_irq();
>> > kick_transfer();
>>
>> Writing to the mailbox fifo delivers the message to other side, and if
>> the fifo is full the messages are queued up in mbox kfifo, which are
>> then deliverd in the order they are received.
>
> isn't that the same as what I suggested ? Messages are queued in the
> ordered they are received and sent to BIOS at the same order.
>
This is already handled with the Kfifo implementation in the mailbox driver.

>> I don't see a use case where the senders need to know that their
>> message is actually written to mbox fifo, if there is one we can look
>> into it.
>
> I never said there's such usecase :-)

I agree :), was just asking to get the confirmation since we are miles apart ;)

>
>> That's not true. Even if BIOS doesn't respond to a request, you could
>> still keep sending the messages.
>
> but then when do you consider a message "completed" ? When it gets sent
> or when you receive a response from BIOS ?

The application after exercising the mailbox put,  for him the message
is sent out, and will/will not wait on the asynchronous response from
M3/DSP, which could happen at any later time. And in some cases, he
might not even expect a response. But as I mentioned earlier this kind
of intelligence whether to wait/not wait will be in the IPC driver and
not in the low level driver such as mailbox.

Thank you,
Best regards,
Hari Kanigeri
