From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH v3 0/2] Device tree support for TWL regulators
Date: Mon, 27 Feb 2012 14:53:45 +0000
Message-ID: <20120227145345.GJ3191@opensource.wolfsonmicro.com>
References: <1330338961-31765-1-git-send-email-rnayak@ti.com>
	<4F4B73C8.8070807@ti.com> <4F4B7798.6000300@ti.com>
	<20120227134112.GB3191@opensource.wolfsonmicro.com>
	<4F4B8A85.7060603@ti.com>
	<20120227140356.GF3191@opensource.wolfsonmicro.com>
	<4F4B9166.7020909@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8494180855658223523=="
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <4F4B9166.7020909-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lrg-l0cyMroinI0@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--===============8494180855658223523==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CD/aTaZybdUisKIc"
Content-Disposition: inline


--CD/aTaZybdUisKIc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 27, 2012 at 03:21:26PM +0100, Cousson, Benoit wrote:

> Mmm, it is written in Rajendra's changelog:

> "-2- All common regulator nodes for twl4030 and twl6030 are
> now defined in the twl4030.dtsi and twl6030.dtsi instead of

Oh, it's buried at the end of a rather verbose inter-patch changelog,
that's not exactly visible :(

> The good point is that a missing or broken DTS will indeed not break
> the build, it will just not boot the platform properly. But that
> still an important dependency to me.

If adding device tree support breaks existing platforms something is
going wrong, while you're pulling things together device tree might not
work until all the support makes it in but the old non-DT code should
continue to function.

> >There's also more than that, there's also at least Tero submitting some
> >other stuff separately (and his stuff won't play with DT...) and I think
> >Peter also.  It really fees like there's a bunch of people working on
> >different things without talking to each other here.

> That's the problem with MFD devices that are doing everything from
> audio to power including the coffee...

Well, in this case everyone's only working on the regulator stuff, or at
least only overlapping on that.

The twl drivers aren't helping here - the structure is *very* non-standard
and seems to make updates more fiddly than they should be as you're not
just adding stuff to tables.  Every update seems to need explicit code
and per-change data adding which is making life harder.  If things
looked more standard from a code point of view it'd probably reduce the
pain a lot.

--CD/aTaZybdUisKIc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPS5iOAAoJEBus8iNuMP3dVZoP/ips+5GHUCZRaYe3EV5rS4qH
QVJf4yJgoqMWriTGXDnfv3AWmYmLyBgpQpQEjlKRxBChIknBd7m9jTp4Hlk/Or+u
Qg07xE1Hit9iZtkJLSliiQYHOE1c1uIO+vuqoFNdXCT7HVALsNE+/T97ij2BlA+5
ZnZWDoJKVA0oDVT/I97URALcGdETHEVjtfj95X8bQU62At9Ji8MkaCihIXy18Q61
LQs/nqcApPwFQ6AvMGV0zWX/JkEn7lyFTWhk2Too2tzEr6iOcMKgdX8ZdAQoS2bd
khB+SIm+xavebm18WSQmP96OZ1rH5/GnklxVoJc5narNbB2+TUqumeiscwtbeLTw
Lmp/2nQMtFgllIoY5BHjOF4nkFOSnclD7ECnbZo6Yy1aaAzCfwk0yUE760MX9CnJ
74eg1sdFAi6Ud8QvxrRjEJd+KPBhFEufZfFS7GNnFJfVZkNhJ8asa/zcj6rENaMe
xdP4F0binC47CaVzRak5KeWLAEvPvba0BEvlCQqPLLCoMbAfj5Qa4cf70mDRRCzX
Z8eAfDEp4uyYMBnvMmiJAhJl4AJXjdxudSReuzNNMs81vVqpmfXFp6KVzIVZs5Nm
2l6nbNUVLVqEpjuqeorDMgeAFlEewB9RdeD7XHnVbf4i4D+0XhUm4+3m95RK1E/K
EqvgMOoGnPZMsJld/UZU
=rkNE
-----END PGP SIGNATURE-----

--CD/aTaZybdUisKIc--


--===============8494180855658223523==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linaro-dev mailing list
linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
http://lists.linaro.org/mailman/listinfo/linaro-dev

--===============8494180855658223523==--
