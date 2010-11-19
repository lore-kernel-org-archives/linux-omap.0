From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: Re: [PATCH v3 5/5] OMAP: mailbox: add notification support for
 multiple readers
Date: Fri, 19 Nov 2010 05:50:19 -0600
Message-ID: <AANLkTimSxGZufLk1RzQuBSg2vBF1p9BXFP8abVZVoLFs@mail.gmail.com>
References: <1290107742-16760-1-git-send-email-h-kanigeri2@ti.com>
	<1290107742-16760-6-git-send-email-h-kanigeri2@ti.com>
	<20101119085007.GK6446@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:41184 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753693Ab0KSLuV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Nov 2010 06:50:21 -0500
Received: by mail-qy0-f180.google.com with SMTP id 8so59492qyk.18
        for <linux-omap@vger.kernel.org>; Fri, 19 Nov 2010 03:50:20 -0800 (PST)
In-Reply-To: <20101119085007.GK6446@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Fernando Guzman Lugo <x0095840@ti.com>

=46elipe,

On Fri, Nov 19, 2010 at 2:50 AM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Thu, Nov 18, 2010 at 01:15:42PM -0600, Hari Kanigeri wrote:
>>
>> In the current mailbox driver, the mailbox internal pointer for
>> callback can be directly manipulated by the Users, so a second
>> User can easily corrupt the first user's callback pointer.
>> The initial effort to correct this issue can be referred here:
>> https://patchwork.kernel.org/patch/107520/
>>
>> Along with fixing the above stated issue, this patch =A0adds the
>> flexibility option to register notifications from
>> multiple readers to the events received on a mailbox instance.
>> The discussion regarding this can be referred here.
>> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg30671.html
>>
>> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
>> Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
>
> Personally, I don't like this patch. I think it's much better to have=
 a
> per-message callback then a "global" notification which all users wil=
l
> listen to.
>

Thanks for your comments :).
I think handling of per-message callback should be handled at one
level above mailbox, like in IPC modules such as dspbridge,
syslink..etc.
Mailbox module should be free of any protocols and should take care of
just writing to the mailbox fifo and delivering the message to the
interested listener(s).


> What will happen is that every user will have to check if every messa=
ge
> belongs to them based on the notifications.
>
> Imagine a hypothetical situation where you have 100 users each with 1=
00
> messages. You will have 100 * 100 (10.000)
> "does-this-message-belongs-to-me" checks.
>

Ideally one shouldn't design their IPC this way. They should have a
IPC driver and the knowledge of notification to multiple users should
be routed from there.

What my patch is addressing is ensure that the users of mailbox don't
mess with the mailbox's internal pointer, and also provide the
flexibility of multiple listeners. Designers of IPC should make their
own judgment whether to use the flexibility option based on their use
cases.

> Rather than doing it this way, I would, as the easiest path, add a
> "callback" parameter to omap_mbox_request_send() and then, internally=
,
> allocate a e.g. struct omap_mbox_request and add that to a list of pe=
nding
> messages. Something like:
>
> struct omap_mbox_request {
> =A0 =A0 =A0 =A0struct omap_mbox =A0 =A0 =A0 =A0*mbox;
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (*complete=
)(void *context);
> =A0 =A0 =A0 =A0void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*context;
> =A0 =A0 =A0 =A0void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*buf;
> =A0 =A0 =A0 =A0unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0len;
> =A0 =A0 =A0 =A0struct list_head =A0 =A0 =A0 =A0list;
> };
>
> [...]
>
> int omap_mbox_request_send(struct omap_mbox *mbox, mbox_msg_t msg, in=
t
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(*complete)(void *context), void *cont=
ext, gfp_t flags)
> {
> =A0 =A0 =A0 =A0struct omap_mbox_queue =A0*mq =3D mbox->txq;
> =A0 =A0 =A0 =A0struct omap_mbox_request =A0 =A0 =A0 =A0*req;
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 0;
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 len;
>
> =A0 =A0 =A0 =A0req =3D kzalloc(sizeof(*req), flags);
> =A0 =A0 =A0 =A0if (!req) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0[...]
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0memcpy(req->buf, &msg, sizeof(msg));
> =A0 =A0 =A0 =A0req->len =3D sizeof(msg));
> =A0 =A0 =A0 =A0req->mbox =3D msg;
> =A0 =A0 =A0 =A0req->complete =3D complete;
> =A0 =A0 =A0 =A0req->context =3D context;
> =A0 =A0 =A0 =A0INIT_LIST_HEAD(&req->list);
>
> =A0 =A0 =A0 =A0list_add_tail(&req->list, &mq->req_list);
>
> =A0 =A0 =A0 =A0/* kick the tasklet here */
>
> =A0 =A0 =A0 =A0return 0;
> }
>
> then on your tasklet, you simply iterate over the list and start send=
ing
> one by one and calling callback when it completes. You would be givin=
g
> your users a more asynchronous API and you wouldn't need this notifie=
r
> which, IMO, isn't a good solution at all.
>

Your ideas are good. But this type of intelligence is already inbuilt
in IPC drivers such as dspbridge and syslink. And I think mailbox
driver should be free of protocols.

Thank you,
Best regards,
Hari
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
