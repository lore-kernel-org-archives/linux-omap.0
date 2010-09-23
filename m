From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH v2 1/6] SoC Camera: add driver for OMAP1 camera interface
Date: Thu, 23 Sep 2010 18:10:44 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1009231806190.23561@axis700.grange>
References: <201009110317.54899.jkrzyszt@tis.icnet.pl>
 <201009222013.58035.jkrzyszt@tis.icnet.pl> <Pine.LNX.4.64.1009231514000.23561@axis700.grange>
 <201009231651.36589.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:36448 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751411Ab0IWQKe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Sep 2010 12:10:34 -0400
In-Reply-To: <201009231651.36589.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Discussion of the Amstrad E3 emailer hardware/software <e3-hacking@earth.li>

On Thu, 23 Sep 2010, Janusz Krzysztofik wrote:

> Thursday 23 September 2010 15:33:54 Guennadi Liakhovetski napisa=C5=82=
(a):
> > On Wed, 22 Sep 2010, Janusz Krzysztofik wrote:
> > > Wednesday 22 September 2010 01:23:22 Guennadi Liakhovetski napisa=
=C5=82(a):
> > > > On Sat, 11 Sep 2010, Janusz Krzysztofik wrote:
> > > > > +
> > > > > +	vb =3D &buf->vb;
> > > > > +	if (waitqueue_active(&vb->done)) {
> > > > > +		if (!pcdev->ready && result !=3D VIDEOBUF_ERROR)
> > > > > +			/*
> > > > > +			 * No next buffer has been entered into the DMA
> > > > > +			 * programming register set on time, so best we can do
> > > > > +			 * is stopping the capture before last DMA block,
> > > > > +			 * whether our CONTIG mode whole buffer or its last
> > > > > +			 * sgbuf in SG mode, gets overwritten by next frame.
> > > > > +			 */
> > > >
> > > > Hm, why do you think it's a good idea? This specific buffer com=
pleted
> > > > successfully, but you want to fail it just because the next buf=
fer is
> > > > missing? Any specific reason for this?
> > >
> > > Maybe my comment is not clear enough, but the below suspend_captu=
re()
> > > doesn't indicate any failure on a frame just captured. It only pr=
events
> > > the frame from being overwritten by the already autoreinitialized=
 DMA
> > > engine, pointing back to the same buffer once again.
> > >
> > > > Besides, you seem to also be
> > > > considering the possibility of your ->ready =3D=3D NULL, but th=
e queue
> > > > non-empty, in which case you just take the next buffer from the=
 queue
> > > > and continue with it. Why error out in this case?
> > >
> > > pcdev->ready =3D=3D NULL means no buffer was available when it wa=
s time to
> > > put it into the DMA programming register set.
> >
> > But how? Buffers are added onto the list in omap1_videobuf_queue() =
under
> > spin_lock_irqsave(); and there you also check ->ready and fill it i=
n.=20
>=20
> Guennadi,
> Yes, but only if pcdev->active is NULL, ie. both DMA and FIFO are idl=
e, never=20
> if active:
>=20
> +	list_add_tail(&vb->queue, &pcdev->capture);
> +	vb->state =3D VIDEOBUF_QUEUED;
> +
> +	if (pcdev->active)
> +		return;
>=20
> Since the transfer of the DMA programming register set content to the=
 DMA=20
> working register set is done automatically by the DMA hardware, this =
can=20
> pretty well happen while I keep the lock here, so I can't be sure if =
it's not=20
> too late for entering new data into the programming register set. The=
n, I=20
> decided that this operation should be done only just after the DMA in=
terrupt=20
> occured, ie. the current DMA programming register set content has jus=
t been=20
> used and can be overwriten.
>=20
> I'll emphasize the above return; with a comment.

Ok

> > In=20
> > your completion you set ->ready =3D NULL, but then also call
> > prepare_next_vb() to get the next buffer from the list - if there a=
re any,
> > so, how can it be NULL with a non-empty list?
>=20
> It happens after the above mentioned prepare_next_vb() gets nothing f=
rom an=20
> empty queue, so nothing is entered into the DMA programming register =
set,=20
> only the last, just activated, buffer is processed, then=20
> omap1_videobuf_queue() puts a new buffer into the queue while the act=
ive=20
> buffer is still filled in, and finally the DMA ISR is called on this =
last=20
> active buffer completion.
>=20
> I hope this helps.

Let's assume it does:) You seem to really understand how this is workin=
g=20
and even be willing to document the driver, thus making it possibly the=
=20
best documented soc-camera related piece of software;)

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
=46reelance Open-Source Software Developer
http://www.open-technology.de/
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
