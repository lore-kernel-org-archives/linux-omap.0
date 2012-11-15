From: Felipe Balbi <balbi@ti.com>
Subject: Re: GCC 4.7 stops to compile the current git kernel
Date: Thu, 15 Nov 2012 15:25:05 +0200
Message-ID: <20121115132505.GD7390@arwen.pp.htv.fi>
References: <k82pkb$sba$1@ger.gmane.org>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xA/XKXTdy9G3iaIz"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52034 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767722Ab2KONb0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Nov 2012 08:31:26 -0500
Content-Disposition: inline
In-Reply-To: <k82pkb$sba$1@ger.gmane.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Mazanov <i.mazanov@gmail.com>
Cc: linux-omap@vger.kernel.org

--xA/XKXTdy9G3iaIz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 15, 2012 at 05:11:14PM +0400, Igor Mazanov wrote:
> Hello,
>=20
> After a conversion to common clock framework GCC 4.7 stops to compile
> the current kernel with the following error:
>=20
>   CC      arch/arm/mach-omap2/clockdomain.o
> In file included from arch/arm/mach-omap2/clockdomain.c:25:0:
> arch/arm/mach-omap2/clockdomain.c: In function 'clkdm_clk_disable':
> include/linux/clk-provider.h:338:12: error: inlining failed in call
> to always_inline '__clk_get_enable_count': function body not
> available
> arch/arm/mach-omap2/clockdomain.c:1001:28: error: called from here
> make[1]: *** [arch/arm/mach-omap2/clockdomain.o] Error 1
> make: *** [arch/arm/mach-omap2] Error 2
>=20
> This change helps:
>=20
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index c127315..f9f5e9e 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -335,8 +335,8 @@ const char *__clk_get_name(struct clk *clk);
>  struct clk_hw *__clk_get_hw(struct clk *clk);
>  u8 __clk_get_num_parents(struct clk *clk);
>  struct clk *__clk_get_parent(struct clk *clk);
> -inline int __clk_get_enable_count(struct clk *clk);
> -inline int __clk_get_prepare_count(struct clk *clk);
> +int __clk_get_enable_count(struct clk *clk);
> +int __clk_get_prepare_count(struct clk *clk);
>  unsigned long __clk_get_rate(struct clk *clk);
>  unsigned long __clk_get_flags(struct clk *clk);
>  int __clk_is_enabled(struct clk *clk);

care to send as a proper patch and Ccing proper lists and developers ?
scripts/get_maintainer.pl will help you figure the audience ;-)

--=20
balbi

--xA/XKXTdy9G3iaIz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQpO0xAAoJEIaOsuA1yqRE3tsP/3EhBCdqZRX8WyHgpGQu+bL7
aoDnwHgNVmZh3c4CmodMRL+4vRy847n9I3ytl8Lkas3O7a6ocy32DJrDvZuqhoNR
cqwhTbjOM3WBgaWrJmdf2tZ1oo/8ovuqryJqQzvg5+T90VvbCGEyOstqshhdsdfu
bJDsEmP6Qx38FGo3lH/jEndyidTDmnoEX3vz1j0Aouskm4oEnMvRSFVheIzBPMxz
4z/UR7xKyS7D77oIltB91QXWZQZGSF4vJ5oFjaWfihKLuiuOQA1tTvEd1IXtQoLb
4U0jEm+kiDyM9tm3ZF0sz4+r+qs6t0CAz2z0Qmvcoag5+wnGlNnnlX2nQ6VUQf8Y
28g4eOfQIdC9/MjEp9d4mqV+MqsgskrxxgIDH+mbQFDa/Phg41ZyiKTagW6yn/fi
JmPV+mGrUvids0s5eVonovPyDLGAi8T61ZrX3SGP3HCdgvxZEJb1uK8hFcUP15BH
TWmUvQHXEdwbauXneLhbCxQgOFfEgRnbr4mQAjWoe1B3fhlthGFPX9jUaEBzp8CX
3TLwOFwgDJSKtmoMYMvjmhRbgSLCQsYU/3IaTW7lDib4yvceGkEIWS3m82EpHylJ
qs5pNj+qUbe14wLAhR86pCYs/VGuXqhcTve3qVl5jo7tvLxPqM3nOw1GGT6LJ1qL
QM29a2FmUPUb6B18LT83
=0WXD
-----END PGP SIGNATURE-----

--xA/XKXTdy9G3iaIz--
