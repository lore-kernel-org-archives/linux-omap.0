From: Felipe Balbi <balbi@ti.com>
Subject: Re: Function Profiler broken on today's linux-next
Date: Wed, 16 Jul 2014 13:41:52 -0500
Message-ID: <20140716184152.GM3016@saruman.home>
References: <20140716162328.GJ1365@saruman.home>
 <20140716122921.71b118a9@gandalf.local.home>
 <20140716164141.GA3016@saruman.home>
 <20140716132413.1ede8e1d@gandalf.local.home>
 <20140716182944.GK3016@saruman.home>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R92lf0Oi2sxyK3LA"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140716182944.GK3016@saruman.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, will.deacon@arm.com, mingo@redhat.com, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

--R92lf0Oi2sxyK3LA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 16, 2014 at 01:29:44PM -0500, Felipe Balbi wrote:
> On Wed, Jul 16, 2014 at 01:24:13PM -0400, Steven Rostedt wrote:
> > On Wed, 16 Jul 2014 11:41:42 -0500
> > Felipe Balbi <balbi@ti.com> wrote:
> >=20
> >=20
> > > .config attached. It's actually an ARM platform, I can help out with
> > > testing anything you need.
> >=20
> > In that case, can you see if it works under my repo?
> >=20
> > git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
> > branch: ftrace/core
>=20
> works fine, thanks. FWIW
>=20
> Tested-by: Felipe Balbi <balbi@ti.com>

Actually it seems like it's not counting time properly if I run my test
multiple times in a row:

# /root/testusb -t 1 -c 100000 -s 2048 -a
# head -3 trace_stat/function0
  Function                         Hit    Time                Avg          =
 s^2
  --------                         ---    ----                ---          =
 ---
  thread_interrupt               174876    166120839 us     949.935 us  304=
8498 us

# /root/testusb -t 1 -c 100000 -s 2048 -a
# head -3 trace_stat/function0
  Function                           Hit       Time                    Avg =
         s^2
  --------                           ---       ----                    --- =
         ---
  dwc3_thread_interrupt            286796    967267300 us         419054519=
9 us     3241109 us=20

# /root/testusb -t 1 -c 100000 -s 2048 -a
# head -3 trace_stat/function0
  Function                              Hit      Time                 Avg  =
             s^2
    --------                            ---       ----                 --- =
             ---
  dwc3_thread_interrupt               401346    642632072 us       1601.192=
 us     1194316 us=20

and so on...

--=20
balbi

--R92lf0Oi2sxyK3LA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTxsdwAAoJEIaOsuA1yqREe1IP/Amm7anoxfyJP1poBVSQXvHk
Mq0+w5HGk1hQvdIZASDoQw92X9LRgSByB0/fgupoeD1LkH/dXlMf05aON+YMd1p4
I0DCoug83fk/DYy4ymJRvw4q/5mTeQ0INF0a4CBKSu76FUMeW0h9R91ekxOyjBQd
9OeIIpa5If7Mq6jR1hqxCWmB8Ugt4oIGBv06iOIk5igRFa+DUVU8aSPzofoTUAgy
I94VaC9RM6WL+4vpnjd4MyR4ywYx52m//AQ6qe2gICr017hftGzK3j4Rv5LhBDaw
JxeTjuO3Zm50DF6IDOPoE3BSeuHn5KCwwrl+L/SNYrqSDnNWWTpUqvWeQ2SmJrCt
EIO45rYQUbNAByW8aaBEqq+dTPRKTJ9kslKEHUUrI2am8lYBdBfIh2G2OrZNAEaq
iSXxDN1BajpsssG3SD5a8A0/s6Dmreo2dbbsGYrWoCdtgRDQD7sYbRAAOU+t7XuI
N0LlOTtdrEYGx3Ess+ZJUN+zYZ+lzEA+BqMZeywr5R+Mt82K0Xgao6XOpkIXngaE
3ECkuEnmMaOd7rUV1TW8c4nkbOSChuyPEFwb7Ld7Yo5i79wVlgWVUjaILD6tg3z3
WG4pTCbU1UONez+gH6mLFs9JzFQnffbGWQaFq2d/Bi9l6/3nqR/AyzWpCLAgepdc
BGIEEPNQlpb1Myd3y9lG
=fYq6
-----END PGP SIGNATURE-----

--R92lf0Oi2sxyK3LA--
