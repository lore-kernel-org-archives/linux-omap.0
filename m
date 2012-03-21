From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH v7 1/3] Documentation: common clk API
Date: Wed, 21 Mar 2012 19:56:56 +0000
Message-ID: <20120321195656.GN3226@opensource.wolfsonmicro.com>
References: <4F6A2042.9030302@codeaurora.org>
	<20120321190741.GL3226@opensource.wolfsonmicro.com>
	<20120321193304.GO9859@atomide.com>
	<4F6A2EF5.3010008@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3906276266073709180=="
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <4F6A2EF5.3010008-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Saravana Kannan <skannan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Nicolas Pitre <nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Jeremy Kerr <jeremy.kerr-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--===============3906276266073709180==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Rzq/nSLlHy1djmXS"
Content-Disposition: inline


--Rzq/nSLlHy1djmXS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 21, 2012 at 12:41:41PM -0700, Saravana Kannan wrote:
> On 03/21/2012 12:33 PM, Tony Lindgren wrote:
> >* Mark Brown<broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>  [120321 12:11]:

> >>These aren't new APIs, the clock API has been around since forever.

> I disagree. When I say clock API, I mean the actual functions and
> their semantics. Not the existence of a header file.

> The meaning of clk_enable/disable has been changed and they won't
> work without calling clk_prepare/unprepare. So, these are definitely
> new APIs. If it weren't new APIs, then none of the general drivers
> would need to change.

clk_prepare() and clk_unprepare() are already there for any clk.h user
and are stubbed in no matter what, they're really not a meaningful
barrier here.

--Rzq/nSLlHy1djmXS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPajJsAAoJEBus8iNuMP3deHAP/1y36//PZAWnihTtgIjiK9EJ
T1YxJlZ2R/RAOmVzhbaDJZdPdt781dOFwo1WwgIrc9W4vdvM86sSrtuZrRpVbMfg
qlBDI8oMP7EfRr1bC/n1ncXKXoz4v0uf42tTobdIkuFauPxt99GZetCKGxGKGl0h
GsoZO0HTKXYeb9XG6HDmmi0aS5f7NAszDM/t/f4voKS2ctgDO8s1WaUa+dUTiMq3
0BHUI2dOTBYRHoFS1MKjGs/8RU4xqPA1DXx0M4tK8shqu4cfA6pozUBk2qd6LGM7
ut1xoi1DgOamSNicG7CDuLOUzmH0d7bkl8xSOTZCj9C2NsT8AGOuOKHIEDxV/vxG
djcMFzazO5SZYFO9dMbUE9ZBE21pB2WzYWr38cHZFO12gaxnJ0JSF57yXtuTOpyF
x4L1TvatWiZqEVDQaFkuofC5cu+zeM4nZjmVjAbFPK0+GAgWBAnSQXOc60rXpauo
p2tT3ULAXS+nZrxcyMEkkgxTMeDwFROdQ8ZH7R7PiSGl2zN48v3yYn/BKDaYta3f
/6RthPG25j+iTBg+BRY8tXXJSFZ0QAkbhlbf3M3JGUZhRbsPhVDwm6kdZ6dW4pnj
CDXWciBfrPXc6uchOKB8K49qnpO+2oI8p8iJuzAMo6x+/UvWLfA9Az/lO9sg6ATd
Zw9kVSRc4wwq0mGWy4zx
=nqVW
-----END PGP SIGNATURE-----

--Rzq/nSLlHy1djmXS--


--===============3906276266073709180==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linaro-dev mailing list
linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
http://lists.linaro.org/mailman/listinfo/linaro-dev

--===============3906276266073709180==--
