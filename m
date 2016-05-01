From: Sebastian Reichel <sre@kernel.org>
Subject: Re: Nokia N900 retention mode in v4.6, camera buttons fun
Date: Sun, 1 May 2016 17:48:56 +0200
Message-ID: <20160501154855.GA24970@earth>
References: <20160411093023.GC11814@amd>
 <20160411094130.GA5753@amd>
 <20160411211026.GH5995@atomide.com>
 <20160412121658.GA32486@amd>
 <20160412123013.GA12296@amd>
 <20160412163055.GP5995@atomide.com>
 <20160417175539.GA502@amd>
 <20160421130450.GQ29406@pali>
 <20160429200559.GA16598@earth>
 <20160501085236.GA14243@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160501085236.GA14243@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Tony Lindgren <tony@atomide.com>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, Tomi Valkeinen <tomi.valkeinen@ti.com>
List-Id: linux-omap@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, May 01, 2016 at 10:52:36AM +0200, Pavel Machek wrote:
> On Fri 2016-04-29 22:06:00, Sebastian Reichel wrote:
> > On Thu, Apr 21, 2016 at 03:04:50PM +0200, Pali Roh=E1r wrote:
> > > > CONFIG_HSI breaks power management completely, so power management
> > > > with modem will be another topic. =20
> > >=20
> > > Sebastian, any idea why power management does not work for HSI?
> >=20
> > I wasn't aware, that pm_runtime_irq_safe() basically breaks runtime
> > PM until Tony's fix for musb (even though it's logical when thinking
> > about it). Currently omap-ssi and omap-ssi-port make use of
> > pm_runtime_irq_safe().
> >=20
> > Since pm_runtime_get_sync/pm_runtime_put_sync is called from
> > tasklets in omap-ssi (and omap-ssi-port) it cannot be simply
> > removed. So fixing PM for the ssi controller requires reworking
> > the driver in a non trivial way.
>=20
> I see latest series, and it also talks about frequency scaling. But I
> guess it is not going to fix this issue?

No, this is independent of the runtime PM problems. I also worked
on runtime PM/idling yesterday and pm_runtime_irq_safe is the main
culprit for breaking it (not the only one, though). It's not yet
finished though

-- Sebastian

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXJiVjAAoJENju1/PIO/qa5vEP/1IXm7Zk/jvOFiAupC5AfOJa
3pXIadicgzj2WEiSt8W6sUM82JLRVYmOCxjvBHn5JufjwXPcHWCU0WmyQH2F7dLs
rRIzy4ZgI83eB3s0oSyY3Q/EirSdVLaxDrJIQYG4mXwL2z3zo20SC26BLtKW0k6w
VDvcu37xuVQbR8AOhiG/FjKicuTcA/hWwQQlqPzf8WjlHhDifPFt09EiSxPGd4aB
7Q2+Kfy9ebxp2Mxo3A/nUmYQFKXLnxbXZ8+t2MsFLMhuq5micBVMJNLoFWi+sBKl
nWV6URf89fAJrt+AfpBb5KiWUyOZqa0CW1wYFf25RA4BSQy5UsCMAFlEBt5Mp4D9
5pgDuLIH8uzE25Z1cVR/6m6LzRf0si3jsmOx2A9R26LoF1BSUFuLuJhgj3XaxyXX
EY9LZajY3oNFr7oufAwHBm8Gq2lx3yjEeMGgbrElBmxFoTPrAxvmej4vapeXXuZZ
YP6FR89/RODofSB0vVK5hqrhLEEe2fMSV76oWFXitrlxLpbWOz+Gj5UTXoKvEXCG
hZngNfxLQ93Tu94fMhKcWiVrbgSOLUKF+VCfzBjI33TpklQMjOtW/7qmmn+LqlgG
ajmLzXmtdLmP3iXQJqBpKqUSWAwvfgib+1PYWqzqPSjZqdRB4rDV169Xma8Vl+kt
14k5cHn3bBtr73fQpchY
=eLV8
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
