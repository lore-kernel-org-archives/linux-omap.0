From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] ARM: use const and __initconst for smp_operations
Date: Tue, 24 Nov 2015 16:40:49 +0100
Message-ID: <20151124154049.GA32623@ulmo.nvidia.com>
References: <1447551593-22246-1-git-send-email-yamada.masahiro@socionext.com>
 <1447551593-22246-3-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8505908979858842268=="
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1447551593-22246-3-git-send-email-yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Emilio =?utf-8?B?TMOzcGV6?= <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Wei Xu <xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, Maxime Ripard <maxime.ripard@free-electrons.>
List-Id: linux-omap@vger.kernel.org


--===============8505908979858842268==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2015 at 10:39:53AM +0900, Masahiro Yamada wrote:
> These smp_operations structures are not over-written, so add "const"
> qualifier and replace __initdata with __initconst.
>=20
> Also, add "static" where it is possible.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
> Acked-by: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> Acked-by: Moritz Fischer <moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org>
> ---
[...]
>  arch/arm/mach-tegra/common.h         | 2 +-
>  arch/arm/mach-tegra/platsmp.c        | 2 +-

Acked-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWVIT/AAoJEN0jrNd/PrOhRnYP/i6/hNApdqrv56KiDAwhCGFb
w91nOo4JOdnuOhfe9fydZVofhGiGytj9Lc6Cv9duwu7FgkhdPh/37df2QUTh7+uv
5Z80pQ5mLlXjUJbwKb2PrIwehHtYpKudJrNkZkIc4JKW5+uiUs6vcP1JQ7sDTTLr
+KImtYAHvfS66K0iqJ/esuoOs3SqW2TMwfE91oa5GSxk5GVoqYIsmkymYBPpIsrg
oBLzfZ5QjDmKmQRz8hX79YU8GcpaFNkVbPNhZTHlZcSjhJH9RPHwJz01i1sBX/Hu
++/RE3/xLTeWwfCnamDozC/+Yx74ddTG7XbWpqdzMRr9CwHOcLcxEBPTAjCl6MSZ
TdZojeiYl9kqoK12Jjez6cUnxfkzsV5B1jimXZr36s4KEf1pZIBRAY2RZglWPsp7
9gWRcCJLNJRITArznUCDaqAFuo8LMS+ghSt0xLt7pYQTGEmXZwkBrcw5m5XwOE7W
Wofr2RwL8OBu05/XcXM2prswg3lRKxb9wC288z4laKkgKIlqD8aCFn+d2QW0maTd
HJXJsc+vBLOPiZoGdG/6492QPoOJmhup7Td/yhHo0gs44DWQPjDYlWuuHJbt/ZFg
ENn4NyvaQwfTFVLvFSc8zFy7CYo50iG3JM4YQRr6D+7YvIXpN2/tl2yj9gHmg4CX
rSq5Oa/jEgmxjEc3642g
=1xJy
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--


--===============8505908979858842268==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-mediatek mailing list
Linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-mediatek

--===============8505908979858842268==--
