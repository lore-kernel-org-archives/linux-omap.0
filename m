From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH v7 1/3] Documentation: common clk API
Date: Wed, 21 Mar 2012 20:10:16 +0000
Message-ID: <20120321201015.GP3226@opensource.wolfsonmicro.com>
References: <4F6A2042.9030302@codeaurora.org>
	<20120321190741.GL3226@opensource.wolfsonmicro.com>
	<20120321193304.GO9859@atomide.com>
	<4F6A2EF5.3010008@codeaurora.org>
	<20120321195656.GN3226@opensource.wolfsonmicro.com>
	<4F6A3446.9020809@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2400717655499987092=="
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <4F6A3446.9020809-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
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


--===============2400717655499987092==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YyxzkC/DtE3JUx8+"
Content-Disposition: inline


--YyxzkC/DtE3JUx8+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 21, 2012 at 01:04:22PM -0700, Saravana Kannan wrote:

> Sure, prepare/unprepare are already there in the .h file. But they
> are stubs and have no impact till we move to the common clock
> framework or platforms move to them with their own implementation
> (certainly not happening in upstream, so let's leave that part out
> of this discussion).

> So. IMO, for all practical purposes, common clk fwk forces the move
> to these new APIs and hence IMO forces the new APIs.

Sure, if you want to look at it from that point of view - anything
wanting to run on a platform which uses the generic API needs to use
them, but there's no blocker on the user from this (it can convert with
or without the platform it runs on) - but it's hardly a tough sell.

--YyxzkC/DtE3JUx8+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPajWeAAoJEBus8iNuMP3dr90P/iP3QwWct+huHt9NwLF6l52a
wqAgfS+yAkv46amrotklM19cmeq1PUOJDcqYam3FSRKJsxYHYxlSIMmo5JKSfNi4
gTctluIBaqzqeARGKrNyQQomv/Wr6HBJ8828f0cQZIXfp/ON4OHrUAs7uAwemnbN
CoIr0xAR7UFeUdHQOAXQtdgQY/XDb+hFRw6pt3yqbc9R7rAwdDG0P8b6iBVdBleU
GOrSnPldtK3FyMDlS0vebKoqP1uHq8AadQvkAV3JCxhbegg3LbamrQG+XmbVrF7p
M2vT8YbMdyivAOUMnLCyzNwyTbIAmuMPsbw/gxn75bx7iTmhO1J5N8J1Ciu6/s3R
l5/sCd62nUlis1VjO3CxXbZDvci/MiAxqrrUDocYDhWjrtMj1B4crzZeLSeGhm9D
l/1dABrwaoya/KWDQwRSaEy2pxy1rUD8gg8IQBtOZJ84mM7SdnNc/UrgImUOoh/a
HvrTm02TdMUu4Kn6LG0PxFhiZZhNj5IQJR30dxWS8G6hVFfvOnlGeAr9AV0r09hh
rgmefnvLREqVlejtwH5wjtAt2B0qCyjYMsnY0AmSlq+H0fiX41ASQlGlEvcBx5Ty
ulCsWv7gk2cHWTmLQTqp7bEqwlFZ9nJ75lqSJzY2eLnSHehe3HvSL9v8OF+z3lWb
JRne5dV5SJX8s8DYo0Pl
=om5a
-----END PGP SIGNATURE-----

--YyxzkC/DtE3JUx8+--


--===============2400717655499987092==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linaro-dev mailing list
linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
http://lists.linaro.org/mailman/listinfo/linaro-dev

--===============2400717655499987092==--
