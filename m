From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] i2c: omap: don't save a value only needed for
 read-clearing
Date: Thu, 15 Nov 2012 14:51:46 +0200
Message-ID: <20121115124956.GA7390@arwen.pp.htv.fi>
References: <1352913666-11022-1-git-send-email-wolfram@the-dreams.de>
 <20121114183739.GA30212@arwen.pp.htv.fi>
 <20121114185033.GB26955@pengutronix.de>
 <CAM=Q2cuRBK4SG9HfcV+L7Yfwv4kv8rTOXzrnUbjfE+-c7JNoNA@mail.gmail.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LyciRD1jyfeSSjG0"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAM=Q2cuRBK4SG9HfcV+L7Yfwv4kv8rTOXzrnUbjfE+-c7JNoNA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Wolfram Sang <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--LyciRD1jyfeSSjG0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 15, 2012 at 03:34:10PM +0530, Shubhrajyoti Datta wrote:
> On Thu, Nov 15, 2012 at 12:20 AM, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wr=
ote:
> >
> >> > This makes one of my code analyzers happy and makes me a part of the
> >>
> >> anything open source which we could all be using ? :-)
> >
> > 'my' as in 'one of those I am using'. It was cppcheck which found that
> > flaw. Its use for kernel code is limited, but it does find one or the
> > other thing.
>=20
> sparse did not complain though.
> So it seems it helps to run multiple static tools:-)

or sending a patch to sparse ;-)

--=20
balbi

--LyciRD1jyfeSSjG0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQpOViAAoJEIaOsuA1yqREgu8QAISBiiILXfHLNRT5IGZUi/Gr
1hCF2uU7/XKufqBQBB6IxbcFy4f3v72SMK2g6M+UxoMzOb9Cmvcz7Lf8gSlX/Hv6
UqaDhYoS2TI7toqLWIw87BBzji1Yld6k9vVpU5BPksDUMEfj3jjahSB1nkx0DuDh
lHdYTm8Ui3Q8ci0HTY4iR0ca+aD2ZV6TYkloCmX4k9Jx+GzYgmBmluXdUJLWijYB
6r8NqkZQDzqmmf23liIrRi8SX5pHUDG2Jgf6DqTEcpXQV0y182eLvQCPr8zw9YbC
2Z7KAOIOkCEcdJjhzfmQtP9xzHfPTrcJ5s1NJkkvrWPqYiUNb4QlrqOLumQpj4jF
EawvjpwBU396utWhfknBIPM4a3EV4zbyLp+B1dlWPald5565oCUTas2R1whaOJXc
wO8iquckdv5Yl3Trox0ABM9FF45Cx5hsKmK31hi5vwtVSDKLKTZyvodSGx1cjjvV
UuGJeC4leXfpC2hCQKAve2HjnMyyS2DeAQKy1J+4450HTk9D6T2jR6fc79HpgQVo
hn1jQ+8y3M8CcR7mIq2mVGfADZvV+rqt3c05UG/J+lktssZTrH5qXRIoFRzKM5Ne
TlZbwLIARRE4/MrsY+aPBo+H4zcf+B5rm2FizJLTjWcvTTQim7yvFbDQb5spb76I
G60x2j/q/2ZzbfOURyTS
=gkQa
-----END PGP SIGNATURE-----

--LyciRD1jyfeSSjG0--
