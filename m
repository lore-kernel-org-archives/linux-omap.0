From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v3 5/5] OMAP: mailbox: add notification support for
 multiple readers
Date: Fri, 19 Nov 2010 14:09:38 +0200
Message-ID: <20101119120938.GN2329@legolas.emea.dhcp.ti.com>
References: <1290107742-16760-1-git-send-email-h-kanigeri2@ti.com>
 <1290107742-16760-6-git-send-email-h-kanigeri2@ti.com>
 <20101119085007.GK6446@legolas.emea.dhcp.ti.com>
 <AANLkTimSxGZufLk1RzQuBSg2vBF1p9BXFP8abVZVoLFs@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:42036 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753662Ab0KSMJb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Nov 2010 07:09:31 -0500
Received: by gyf3 with SMTP id 3so2701313gyf.34
        for <linux-omap@vger.kernel.org>; Fri, 19 Nov 2010 04:09:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTimSxGZufLk1RzQuBSg2vBF1p9BXFP8abVZVoLFs@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: balbi@ti.com, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Fernando Guzman Lugo <x0095840@ti.com>

On Fri, Nov 19, 2010 at 05:50:19AM -0600, Kanigeri, Hari wrote:
>Thanks for your comments :).

np.

>I think handling of per-message callback should be handled at one
>level above mailbox, like in IPC modules such as dspbridge,
>syslink..etc.

then you'll have duplication of functionality :-)

>Mailbox module should be free of any protocols and should take care of

it's not a protocol that I'm proposing. It's just one way to give
mailbox users a more async API.

>just writing to the mailbox fifo and delivering the message to the
>interested listener(s).

exactly. Only to the interested listener. With your patch, you'll be
delivering the message to all listeners and listeners have to check if
that particular message belongs to them.

>> What will happen is that every user will have to check if every mess=
age
>> belongs to them based on the notifications.
>>
>> Imagine a hypothetical situation where you have 100 users each with =
100
>> messages. You will have 100 * 100 (10.000)
>> "does-this-message-belongs-to-me" checks.
>>
>
>Ideally one shouldn't design their IPC this way. They should have a
>IPC driver and the knowledge of notification to multiple users should
>be routed from there.

only if the message is interesting for N listeners. But if each
listeners will have its own message towards the other side of the link,
then mailbox should only give the result to one listener.

>What my patch is addressing is ensure that the users of mailbox don't
>mess with the mailbox's internal pointer, and also provide the
>flexibility of multiple listeners. Designers of IPC should make their
>own judgment whether to use the flexibility option based on their use
>cases.

but with your patch, you are delivering the same message to all
listeners. You give the oportunity even for some attacks. I could fiddl=
e
with other listeners' message just by attaching a notifier_block and
checking what's the content of every message.

>> Rather than doing it this way, I would, as the easiest path, add a
>> "callback" parameter to omap_mbox_request_send() and then, internall=
y,
>> allocate a e.g. struct omap_mbox_request and add that to a list of p=
ending
>> messages. Something like:
>>
>> struct omap_mbox_request {
>> =A0 =A0 =A0 =A0struct omap_mbox =A0 =A0 =A0 =A0*mbox;
>> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (*complet=
e)(void *context);
>> =A0 =A0 =A0 =A0void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*context;
>> =A0 =A0 =A0 =A0void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*buf;
>> =A0 =A0 =A0 =A0unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0len;
>> =A0 =A0 =A0 =A0struct list_head =A0 =A0 =A0 =A0list;
>> };
>>
>> [...]
>>
>> int omap_mbox_request_send(struct omap_mbox *mbox, mbox_msg_t msg, i=
nt
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(*complete)(void *context), void *con=
text, gfp_t flags)
>> {
>> =A0 =A0 =A0 =A0struct omap_mbox_queue =A0*mq =3D mbox->txq;
>> =A0 =A0 =A0 =A0struct omap_mbox_request =A0 =A0 =A0 =A0*req;
>> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 0=
;
>> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 len;
>>
>> =A0 =A0 =A0 =A0req =3D kzalloc(sizeof(*req), flags);
>> =A0 =A0 =A0 =A0if (!req) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0[...]
>> =A0 =A0 =A0 =A0}
>>
>> =A0 =A0 =A0 =A0memcpy(req->buf, &msg, sizeof(msg));
>> =A0 =A0 =A0 =A0req->len =3D sizeof(msg));
>> =A0 =A0 =A0 =A0req->mbox =3D msg;
>> =A0 =A0 =A0 =A0req->complete =3D complete;
>> =A0 =A0 =A0 =A0req->context =3D context;
>> =A0 =A0 =A0 =A0INIT_LIST_HEAD(&req->list);
>>
>> =A0 =A0 =A0 =A0list_add_tail(&req->list, &mq->req_list);
>>
>> =A0 =A0 =A0 =A0/* kick the tasklet here */
>>
>> =A0 =A0 =A0 =A0return 0;
>> }
>>
>> then on your tasklet, you simply iterate over the list and start sen=
ding
>> one by one and calling callback when it completes. You would be givi=
ng
>> your users a more asynchronous API and you wouldn't need this notifi=
er
>> which, IMO, isn't a good solution at all.
>>
>
>Your ideas are good. But this type of intelligence is already inbuilt
>in IPC drivers such as dspbridge and syslink. And I think mailbox
>driver should be free of protocols.

Like I said before, this is not a protocol. And if both dspbridge and
syslink have the same kind of thing, don't you think it's a duplication=
?
Don't you, also, think common features should be done at framework
levels ? Since we don't have an IPC framework, we consider the mailbox
driver a framework for using the OMAP mailbox, then the API I proposed
is just one way to address the problem you described. There's nothing
like a protocol here.

In any case, you are the one taking care of those drivers and it's your
call how to handle multiple users, but keep in mind you'll be allowing
anyone to see all messages that are going through mailbox just by
attaching a notifier block :-) If that's ok for you, if you don't see
any troubles with that, go for it. If you also don't see any troubles
with having hundreds of users each with hundreds of messages and you
notifying all of them about all messages as a problem, go for it :-p

--=20
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
