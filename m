From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH v2 1/6] SoC Camera: add driver for OMAP1 camera interface
Date: Thu, 23 Sep 2010 15:33:54 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1009231514000.23561@axis700.grange>
References: <201009110317.54899.jkrzyszt@tis.icnet.pl>
 <201009110321.25852.jkrzyszt@tis.icnet.pl> <Pine.LNX.4.64.1009211639410.11896@axis700.grange>
 <201009222013.58035.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:59885 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1752091Ab0IWNdm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Sep 2010 09:33:42 -0400
In-Reply-To: <201009222013.58035.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Discussion of the Amstrad E3 emailer hardware/software <e3-hacking@earth.li>

On Wed, 22 Sep 2010, Janusz Krzysztofik wrote:

> Wednesday 22 September 2010 01:23:22 Guennadi Liakhovetski napisa=C5=82=
(a):
> > On Sat, 11 Sep 2010, Janusz Krzysztofik wrote:
> > > +
> > > +	vb =3D &buf->vb;
> > > +	if (waitqueue_active(&vb->done)) {
> > > +		if (!pcdev->ready && result !=3D VIDEOBUF_ERROR)
> > > +			/*
> > > +			 * No next buffer has been entered into the DMA
> > > +			 * programming register set on time, so best we can do
> > > +			 * is stopping the capture before last DMA block,
> > > +			 * whether our CONTIG mode whole buffer or its last
> > > +			 * sgbuf in SG mode, gets overwritten by next frame.
> > > +			 */
> >
> > Hm, why do you think it's a good idea? This specific buffer complet=
ed
> > successfully, but you want to fail it just because the next buffer =
is
> > missing? Any specific reason for this?=20
>=20
> Maybe my comment is not clear enough, but the below suspend_capture()=
 doesn't=20
> indicate any failure on a frame just captured. It only prevents the f=
rame=20
> from being overwritten by the already autoreinitialized DMA engine, p=
ointing=20
> back to the same buffer once again.
>=20
> > Besides, you seem to also be=20
> > considering the possibility of your ->ready =3D=3D NULL, but the qu=
eue
> > non-empty, in which case you just take the next buffer from the que=
ue and
> > continue with it. Why error out in this case?=20
>=20
> pcdev->ready =3D=3D NULL means no buffer was available when it was ti=
me to put it=20
> into the DMA programming register set.

But how? Buffers are added onto the list in omap1_videobuf_queue() unde=
r=20
spin_lock_irqsave(); and there you also check ->ready and fill it in. I=
n=20
your completion you set ->ready =3D NULL, but then also call=20
prepare_next_vb() to get the next buffer from the list - if there are a=
ny,=20
so, how can it be NULL with a non-empty list?

> As a result, a next DMA transfer has=20
> just been autoreinitialized with the same buffer parameters as before=
=2E To=20
> protect the buffer from being overwriten unintentionally, we have to =
stop the=20
> DMA transfer as soon as possible, hopefully before the sensor starts =
sending=20
> out next frame data.
>=20
> If a new buffer has been queued meanwhile, best we can do is stopping=
=20
> everything, programming the DMA with the new buffer, and setting up f=
or a new=20
> transfer hardware auto startup on nearest frame start, be it the next=
 one if=20
> we are lucky enough, or one after the next if we are too slow.
>=20
> > And even if also the queue=20
> > is empty - still not sure, why.
>=20
> I hope the above explanation clarifies why.
>=20
> I'll try to rework the above comment to be more clear, OK? Any hints?

> > > linux-2.6.36-rc3.orig/include/media/omap1_camera.h	2010-09-03
> > > 22:34:02.000000000 +0200 +++
> > > linux-2.6.36-rc3/include/media/omap1_camera.h	2010-09-08
> > > 23:41:12.000000000 +0200 @@ -0,0 +1,35 @@
> > > +/*
> > > + * Header for V4L2 SoC Camera driver for OMAP1 Camera Interface
> > > + *
> > > + * Copyright (C) 2010, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl=
>
> > > + *
> > > + * This program is free software; you can redistribute it and/or=
 modify
> > > + * it under the terms of the GNU General Public License version =
2 as
> > > + * published by the Free Software Foundation.
> > > + */
> > > +
> > > +#ifndef __MEDIA_OMAP1_CAMERA_H_
> > > +#define __MEDIA_OMAP1_CAMERA_H_
> > > +
> > > +#include <linux/bitops.h>
> > > +
> > > +#define OMAP1_CAMERA_IOSIZE		0x1c
> > > +
> > > +enum omap1_cam_vb_mode {
> > > +	CONTIG =3D 0,
> > > +	SG,
> > > +};
> >
> > See above - are these needed here?
> >
> > > +
> > > +#define OMAP1_CAMERA_MIN_BUF_COUNT(x)	((x) =3D=3D CONTIG ? 3 : 2=
)
> >
> > ditto
>=20
> I moved them both over to the header file because I was using the=20
> OMAP1_CAMERA_MIN_BUF_COUNT(CONTIG) macro once from the platform code =
in order=20
> to calculate the buffer size when calling the then NAKed=20
> dma_preallocate_coherent_memory(). Now I could put them back into the=
 driver=20
> code, but if we ever get back to the concept of preallocating a conti=
gnuos=20
> piece of memory from the platform init code, we might need them back =
here, so=20
> maybe I should rather keep them, only rename the two enum values usin=
g a=20
> distinct name space. What do you think is better for now?

Yeah, up to you, I'd say, but if you decide to keep them in the header,=
=20
please, use a namespace.

I'm satisfied with your answers to the rest of my questions / comments:=
)

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
