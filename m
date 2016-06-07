From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: Nokia N900: musb is in wrong state after boot
Date: Tue, 7 Jun 2016 14:50:44 +0200
Message-ID: <20160607125044.GI29844@pali>
References: <201601091616.04193@pali>
 <3690314.8jDXSUDcRZ@saturn>
 <20160121192113.GM19432@atomide.com>
 <201601231357.32629@pali>
 <20160529103824.GM29844@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160529103824.GM29844@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: joerg Reisenweber <joerg@openmoko.org>, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

On Sunday 29 May 2016 12:38:24 Pali Roh=C3=A1r wrote:
> > From fd67b58e3538c0732750ecad915cde736da099dc Mon Sep 17 00:00:00 2=
001
> > From: =3D?UTF-8?q?Pali=3D20Roh=3DC3=3DA1r?=3D <pali.rohar@gmail.com=
>
> > Date: Sat, 9 Jan 2016 16:57:59 +0100
> > Subject: [PATCH] musb: debugfs: Add support in testmode for forcing=
 host mode
> >  together with speed
> >=20
> > ---
> >  drivers/usb/musb/musb_debugfs.c |   44 +++++++++++++++++++++++++--=
------------
> >  1 file changed, 28 insertions(+), 16 deletions(-)
> >=20
> > diff --git a/drivers/usb/musb/musb_debugfs.c b/drivers/usb/musb/mus=
b_debugfs.c
> > index 9b22d94..62c13a2 100644
> > --- a/drivers/usb/musb/musb_debugfs.c
> > +++ b/drivers/usb/musb/musb_debugfs.c
> > @@ -147,28 +147,34 @@ static int musb_test_mode_show(struct seq_fil=
e *s, void *unused)
> > =20
> >  	test =3D musb_readb(musb->mregs, MUSB_TESTMODE);
> > =20
> > -	if (test & MUSB_TEST_FORCE_HOST)
> > +	if (test & (MUSB_TEST_FORCE_HOST | MUSB_TEST_FORCE_FS))
> > +		seq_printf(s, "force host full-speed\n");
> > +
> > +	else if (test & (MUSB_TEST_FORCE_HOST | MUSB_TEST_FORCE_HS))
> > +		seq_printf(s, "force host high-speed\n");
> > +
> > +	else if (test & MUSB_TEST_FORCE_HOST)
> >  		seq_printf(s, "force host\n");
> > =20
> > -	if (test & MUSB_TEST_FIFO_ACCESS)
> > +	else if (test & MUSB_TEST_FIFO_ACCESS)
> >  		seq_printf(s, "fifo access\n");
> > =20
> > -	if (test & MUSB_TEST_FORCE_FS)
> > +	else if (test & MUSB_TEST_FORCE_FS)
> >  		seq_printf(s, "force full-speed\n");
> > =20
> > -	if (test & MUSB_TEST_FORCE_HS)
> > +	else if (test & MUSB_TEST_FORCE_HS)
> >  		seq_printf(s, "force high-speed\n");
> > =20
> > -	if (test & MUSB_TEST_PACKET)
> > +	else if (test & MUSB_TEST_PACKET)
> >  		seq_printf(s, "test packet\n");
> > =20
> > -	if (test & MUSB_TEST_K)
> > +	else if (test & MUSB_TEST_K)
> >  		seq_printf(s, "test K\n");
> > =20
> > -	if (test & MUSB_TEST_J)
> > +	else if (test & MUSB_TEST_J)
> >  		seq_printf(s, "test J\n");
> > =20
> > -	if (test & MUSB_TEST_SE0_NAK)
> > +	else if (test & MUSB_TEST_SE0_NAK)
> >  		seq_printf(s, "test SE0 NAK\n");
> > =20
> >  	return 0;
> > @@ -206,30 +212,36 @@ static ssize_t musb_test_mode_write(struct fi=
le *file,
> >  	if (copy_from_user(buf, ubuf, min_t(size_t, sizeof(buf) - 1, coun=
t)))
> >  		return -EFAULT;
> > =20
> > -	if (strstarts(buf, "force host"))
> > +	if (strstarts(buf, "force host full-speed"))
> > +		test =3D MUSB_TEST_FORCE_HOST | MUSB_TEST_FORCE_FS;
> > +
> > +	else if (strstarts(buf, "force host high-speed"))
> > +		test =3D MUSB_TEST_FORCE_HOST | MUSB_TEST_FORCE_HS;
> > +
> > +	else if (strstarts(buf, "force host"))
> >  		test =3D MUSB_TEST_FORCE_HOST;
> > =20
> > -	if (strstarts(buf, "fifo access"))
> > +	else if (strstarts(buf, "fifo access"))
> >  		test =3D MUSB_TEST_FIFO_ACCESS;
> > =20
> > -	if (strstarts(buf, "force full-speed"))
> > +	else if (strstarts(buf, "force full-speed"))
> >  		test =3D MUSB_TEST_FORCE_FS;
> > =20
> > -	if (strstarts(buf, "force high-speed"))
> > +	else if (strstarts(buf, "force high-speed"))
> >  		test =3D MUSB_TEST_FORCE_HS;
> > =20
> > -	if (strstarts(buf, "test packet")) {
> > +	else if (strstarts(buf, "test packet")) {
> >  		test =3D MUSB_TEST_PACKET;
> >  		musb_load_testpacket(musb);
> >  	}
> > =20
> > -	if (strstarts(buf, "test K"))
> > +	else if (strstarts(buf, "test K"))
> >  		test =3D MUSB_TEST_K;
> > =20
> > -	if (strstarts(buf, "test J"))
> > +	else if (strstarts(buf, "test J"))
> >  		test =3D MUSB_TEST_J;
> > =20
> > -	if (strstarts(buf, "test SE0 NAK"))
> > +	else if (strstarts(buf, "test SE0 NAK"))
> >  		test =3D MUSB_TEST_SE0_NAK;
> > =20
> >  	musb_writeb(musb->mregs, MUSB_TESTMODE, test);
> > --=20
> > 1.7.9.5
> >=20
>=20
> Tony, what do you think about that patch?
>=20

Tony, PING

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
