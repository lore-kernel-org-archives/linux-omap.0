From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: Re: [PATCH v3 5/5] OMAP: mailbox: add notification support for
 multiple readers
Date: Fri, 19 Nov 2010 06:29:39 -0600
Message-ID: <AANLkTinVf8--zmGa7svapcVpEp2BPXf33DtdruLtoJx5@mail.gmail.com>
References: <1290107742-16760-1-git-send-email-h-kanigeri2@ti.com>
	<1290107742-16760-6-git-send-email-h-kanigeri2@ti.com>
	<20101119085007.GK6446@legolas.emea.dhcp.ti.com>
	<AANLkTimSxGZufLk1RzQuBSg2vBF1p9BXFP8abVZVoLFs@mail.gmail.com>
	<20101119120938.GN2329@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:34692 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753735Ab0KSM3k convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Nov 2010 07:29:40 -0500
Received: by mail-qy0-f172.google.com with SMTP id 8so746725qyk.3
        for <linux-omap@vger.kernel.org>; Fri, 19 Nov 2010 04:29:40 -0800 (PST)
In-Reply-To: <20101119120938.GN2329@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Fernando Guzman Lugo <x0095840@ti.com>

=46elipe,

>
>> I think handling of per-message callback should be handled at one
>> level above mailbox, like in IPC modules such as dspbridge,
>> syslink..etc.
>
> then you'll have duplication of functionality :-)
>
yes in mailbox :). One solution doesn't fit all and this should be
handled at IPC driver.

>> Mailbox module should be free of any protocols and should take care =
of
>
> it's not a protocol that I'm proposing. It's just one way to give
> mailbox users a more async API.
>
>> just writing to the mailbox fifo and delivering the message to the
>> interested listener(s).
>
> exactly. Only to the interested listener. With your patch, you'll be
> delivering the message to all listeners and listeners have to check i=
f
> that particular message belongs to them.
>
>>> What will happen is that every user will have to check if every mes=
sage
>>> belongs to them based on the notifications.
>>>
>>> Imagine a hypothetical situation where you have 100 users each with=
 100
>>> messages. You will have 100 * 100 (10.000)
>>> "does-this-message-belongs-to-me" checks.
>>>
>>
>> Ideally one shouldn't design their IPC this way. They should have a
>> IPC driver and the knowledge of notification to multiple users shoul=
d
>> be routed from there.
>
> only if the message is interesting for N listeners. But if each
> listeners will have its own message towards the other side of the lin=
k,
> then mailbox should only give the result to one listener.
>
>> What my patch is addressing is ensure that the users of mailbox don'=
t
>> mess with the mailbox's internal pointer, and also provide the
>> flexibility of multiple listeners. Designers of IPC should make thei=
r
>> own judgment whether to use the flexibility option based on their us=
e
>> cases.
> but with your patch, you are delivering the same message to all
> listeners. You give the oportunity even for some attacks. I could fid=
dle
> with other listeners' message just by attaching a notifier_block and
> checking what's the content of every message.

IMHO, an kernel API have a scope to be misused if the Users misuse it,
and I think the users of the Kernel APIs should know what they are
doing before using an API.

>
>>> Rather than doing it this way, I would, as the easiest path, add a
>>> "callback" parameter to omap_mbox_request_send() and then, internal=
ly,
>>> allocate a e.g. struct omap_mbox_request and add that to a list of
>>> pending
>>> messages. Something like:
>>>
>>> struct omap_mbox_request {
>>> =A0 =A0 =A0 =A0struct omap_mbox =A0 =A0 =A0 =A0*mbox;
>>> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (*comple=
te)(void *context);
>>> =A0 =A0 =A0 =A0void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*context=
;
>>> =A0 =A0 =A0 =A0void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*buf;
>>> =A0 =A0 =A0 =A0unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0len;
>>> =A0 =A0 =A0 =A0struct list_head =A0 =A0 =A0 =A0list;
>>> };
>>>
>>> [...]
>>>
>>> int omap_mbox_request_send(struct omap_mbox *mbox, mbox_msg_t msg, =
int
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(*complete)(void *context), void *co=
ntext, gfp_t flags)
>>> {
>>> =A0 =A0 =A0 =A0struct omap_mbox_queue =A0*mq =3D mbox->txq;
>>> =A0 =A0 =A0 =A0struct omap_mbox_request =A0 =A0 =A0 =A0*req;
>>> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D =
0;
>>> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 len;
>>>
>>> =A0 =A0 =A0 =A0req =3D kzalloc(sizeof(*req), flags);
>>> =A0 =A0 =A0 =A0if (!req) {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0[...]
>>> =A0 =A0 =A0 =A0}
>>>
>>> =A0 =A0 =A0 =A0memcpy(req->buf, &msg, sizeof(msg));
>>> =A0 =A0 =A0 =A0req->len =3D sizeof(msg));
>>> =A0 =A0 =A0 =A0req->mbox =3D msg;
>>> =A0 =A0 =A0 =A0req->complete =3D complete;
>>> =A0 =A0 =A0 =A0req->context =3D context;
>>> =A0 =A0 =A0 =A0INIT_LIST_HEAD(&req->list);
>>>
>>> =A0 =A0 =A0 =A0list_add_tail(&req->list, &mq->req_list);
>>>
>>> =A0 =A0 =A0 =A0/* kick the tasklet here */
>>>
>>> =A0 =A0 =A0 =A0return 0;
>>> }
>>>
>>> then on your tasklet, you simply iterate over the list and start se=
nding
>>> one by one and calling callback when it completes. You would be giv=
ing

How do you know that a response is received for a particular sender ?
By reading mailbox payload or by reading some shared memory ? I think
this itself would constitute building up protocol in mailbox driver.

>>> your users a more asynchronous API and you wouldn't need this notif=
ier
>>> which, IMO, isn't a good solution at all.
>>>
>>
>> Your ideas are good. But this type of intelligence is already inbuil=
t
>> in IPC drivers such as dspbridge and syslink. And I think mailbox
>> driver should be free of protocols.
>
> Like I said before, this is not a protocol. And if both dspbridge and
> syslink have the same kind of thing, don't you think it's a duplicati=
on?
> Don't you, also, think common features should be done at framework
> levels ? Since we don't have an IPC framework, we consider the mailbo=
x
> driver a framework for using the OMAP mailbox, then the API I propose=
d
> is just one way to address the problem you described. There's nothing
> like a protocol here.

I fully agree with you about common framework, and the proposed
solution for the common IPC framework is Syslink. This was discussed
during the recent LPC meeting to come up with a common IPC framework
that is currently missing in Kernel.
I can share with you the details if you are interested.

>
> In any case, you are the one taking care of those drivers and it's yo=
ur
> call how to handle multiple users, but keep in mind you'll be allowin=
g
> anyone to see all messages that are going through mailbox just by
> attaching a notifier block :-) If that's ok for you, if you don't see
> any troubles with that, go for it. If you also don't see any troubles
> with having hundreds of users each with hundreds of messages and you
> notifying all of them about all messages as a problem, go for it :-p

As I said if some one does that then it is a misuse on their part :).
The messages should be routed through IPC driver. And let's not forget
the main motivation of this patch as well.


Thank you,
Best regards,
Hari Kanigeri
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
