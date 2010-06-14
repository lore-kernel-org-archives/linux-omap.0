From: "Sapiens, Rene" <rene.sapiens@ti.com>
Subject: RE: [PATCH v3 4/4] omap: mailbox: convert block api to kfifo
Date: Mon, 14 Jun 2010 12:44:06 -0500
Message-ID: <D2943F03B81C9C458E44DFB213905E02B64BFD53@dlee04.ent.ti.com>
References: <AANLkTik1OCrni_1Ao0d1qUenn7IAxUaTcQvXU3osjha9@mail.gmail.com>
	<20100609.080728.260086205.Hiroshi.DOYU@nokia.com>
	<AANLkTinixlUAjtwFZmGIkio4H0Gzy1Moww2ssoLBKQWr@mail.gmail.com>
 <20100614.115804.260111776.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38397 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750831Ab0FNRoO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Jun 2010 13:44:14 -0400
In-Reply-To: <20100614.115804.260111776.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "Guzman Lugo, Fernando" <fernando.lugo@ti.com>, "ohad@wizery.com" <ohad@wizery.com>
Cc: "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Hiroshi

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Hiroshi DOYU
> Sent: Monday, June 14, 2010 3:58 AM
> To: Guzman Lugo, Fernando; ohad@wizery.com
> Cc: Chitriki Rudramuni, Deepak; Ramirez Luna, Omar; Kanigeri, Hari; l=
inux-
> omap@vger.kernel.org
> Subject: Re: [PATCH v3 4/4] omap: mailbox: convert block api to kfifo
>=20
> Hi Ohad,
>=20
> From: ext Ohad Ben-Cohen <ohad@wizery.com>
> Subject: Re: [PATCH v3 4/4] omap: mailbox: convert block api to kfifo
> Date: Mon, 14 Jun 2010 01:52:16 +0200
>=20
> > On Wed, Jun 9, 2010 at 12:07 AM, Hiroshi DOYU <Hiroshi.DOYU@nokia.c=
om>
> wrote:
> >> diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-
> omap/mailbox.c
> >> index 87e0cde..1b79b32 100644
> >> --- a/arch/arm/plat-omap/mailbox.c
> >> +++ b/arch/arm/plat-omap/mailbox.c
> >> @@ -188,7 +188,7 @@ static void __mbox_rx_interrupt(struct omap_mb=
ox
> *mbox)
> >> =A0 =A0 =A0 =A0/* no more messages in the fifo. clear IRQ source. =
*/
> >> =A0 =A0 =A0 =A0ack_mbox_irq(mbox, IRQ_RX);
> >> =A0nomem:
> >> - =A0 =A0 =A0 queue_work(mboxd, &mbox->rxq->work);
> >> + =A0 =A0 =A0 mbox->callback(mbox);
> >> =A0}
> >
> > I like this !
> >
> > It will allow us to easily plug in new IPC mechanisms in the future=
=2E
>=20
> Agree.
>=20
> > (btw, if we do this, and also introduce omap_mbox_msg_send_sync, do=
 we
> > still need a mailbox queuing mechanism at all ? :)
>=20
> I think that "queuing"(can be called as S/W fifo/buffer?) is basicall=
y
> necessary it can compensate the shortage of H/W fifo slots under high
> load or emergency case. It has only 4 slots. I guess that, DSP usuall=
y
> responds quickly and 4 H/W slots may be enough, but it might be
> safer/more robust to avoid the assumption which depends on other
> entity/DSP. From latecy perspective, "s/w fifo" + "tasklet" would be
> enough short.
>=20
> omap_mbox_msg_send_sync() can handle the case for a special message,
> like PM, which has to respond at the higher priority than the normal
> ones.
>=20
> > Having said that, this is not going to solve the lockdep warning
> > reported by Deepak - that was caused because of dspbridge's sending
> > context (and not because of the receiving context). To eliminate th=
at
>=20
> Does dspbridge really need its own defered work for sending mailbox
> messages?
>=20
> For me, the problem here is the unneccesary duplication of tasklet, o=
r
> can be said, the unnecessary use of tasklet for _sending_ mailbox
> messages in dspbridge.
>=20
> http://marc.info/?l=3Dlinux-omap&m=3D127601655325416&w=3D2
>=20
> I thought that bridge_msg_put()/bridge_msg_get() can use omap mbox
> APIs directly, with getting rid of its use of its own defered
> work/tasklet as pointed out in the above link. Fernando?
>=20

Actually the intention of that deferred work is not to send the Mbox me=
ssages. Bridge shares a section of physical memory with the DSP and com=
munication is established through this one. Messages (not mailbox messa=
ges) coming from users go into bridge_msg_put(), those are more signifi=
cant messages containing more arguments that are understandable by a DS=
P task. If the Shared memory(SHM) is occupied by a previous message, me=
ssages are queued inside bridge_msg_put() and the tasklet to send them =
is scheduled (so that we don't loose any) due that there can only be a =
single message going out and one coming back at a time in this Shared m=
emory. The usage of the Mailbox messages is to notify to the DSP (actua=
lly to interrupt it and make it go to check the SHM) that there is a me=
ssage with more information in that shared memory. The tasklet is neede=
d to serialize the upper communication that is done in the SHM level an=
d every time that we want to send out a message previously queued we ne=
ed to interrupt the DSP (use the Mailbox messages).

On the other hand PM messages are sent directly by using the Mailbox me=
ssages where we directly call omap_mbox_msg_send().

> For recieving, its defered work(tasklet) can be trigered directly in
> the above proposed callback, that callback can triger its own
> workqueue if necessary, then. I think that, for recieving, some PM
> command may has to be sent back immedieately inside of
> tasklet. omap_mbox_msg_send_sync() may handle this case.
>=20
> What do you think?
>=20
> > issue, I prefer fixing dspbridge to use work queues rather than usi=
ng
> > spin_lock_bh in omap_mbox_msg_send. Disabling system bottom halves
> > just to send a mbox msg sounds unjustified (unless bridge really ne=
eds
> > to use tasklets instead of work queues, which I slightly doubt). Wh=
at
> > do you think ?
>=20
> I think that workqueue is only necessary when it has to sleep,
> otherwise tasklet is prefered. For _sending_ a message inside of
> dspbridge, I haven't found any reasonable reason to use any defered
> work(softirq, tasklet, workqueue) so far.
>=20
> > Speaking of mailbox I'd like to address some issues that are code
> related:
> >
> > * Let's add mailbox API to set the callback pointer (it feels wrong=
 to
> > let users directly manipulate the mbox structure).
> >
> > * We can also safely move the callback field to the main mbox
> > structure, since it has no usage in the TX mq; it's pretty global t=
o
> > the whole mbox.
> >
> > * Let's make sure no one accidentally registers two receivers on th=
e
> > same time (which would result in one overwriting the other's callba=
ck
> > field).
>=20
> I'd like to allow mutiple listners in some way, as the flexibility of
> mailbox functionalty.
>=20
> > * mbox_configured is a global variable and that breaks support of
> > multiple concurrent mailbox instances. Let's move this logic into t=
he
> > instance of mbox.
> >
> > * If we make sure there are no two user of the same mailbox instanc=
e
> > (see 3rd *), we can eliminate mbox_configured and its locking (not
> > that doesn't mean there can't be two concurrent sending contexts, i=
t
> > just means they are somewhat related, they have a common receiver,
> > which was registered using only a single call to get).
> >
> > Something like this, pls tell me what you think:
>=20
> For the above 5 proposals, excpet the multiple listeners issue, they
> seems ok.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
