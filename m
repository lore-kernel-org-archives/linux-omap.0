From: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Subject: Re: Nokia N900: musb is in wrong state after boot
Date: Thu, 9 Jun 2016 15:58:56 -0500
Message-ID: <20160609205856.GC2167@uda0271908>
References: <201601091616.04193@pali>
 <3690314.8jDXSUDcRZ@saturn>
 <20160121192113.GM19432@atomide.com>
 <201601231357.32629@pali>
 <20160529103824.GM29844@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160529103824.GM29844@pali>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, joerg Reisenweber <joerg-4Bgg8jF3iZdg9hUCZPvPmw@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Sun, May 29, 2016 at 12:38:24PM +0200, Pali Roh=E1r wrote:
> > Hello, attached patch for musb debugfs adds option to force both=20
> > hostmode with speed. It is just example, I tested only compilation.
> >=20
> > Something like that will be needed for usb host mode on Nokia N900.
> >=20
> > --=20
> > Pali Roh=E1r
> > pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
>=20
> > From fd67b58e3538c0732750ecad915cde736da099dc Mon Sep 17 00:00:00 2=
001
> > From: =3D?UTF-8?q?Pali=3D20Roh=3DC3=3DA1r?=3D <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org=
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

Based on the musb ug, force_host bit is allowed to be set along with
force_hs or force_fs bit. So please resend this patch with subject
changed to the following, and I will take it. The current suject makes
is sound like a new feature rather than a bugfix.

"usb: musb: debugfs: allow forcing host mode together with speed in tes=
tmode"

But I am not sure how this will fix n900 host mode problem, since
testmode is not used in normal operation.

Regards,
-Bin.

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
