From: Daniel Stone <daniel.stone@nokia.com>
Subject: Re: [RFC] OMAP3: GPIO: Enable debounce clock only when debounce is
	enabled
Date: Fri, 12 Sep 2008 14:11:33 +0300
Message-ID: <20080912111133.GA7799@intune.research.nokia.com>
References: <1221216698-22327-1-git-send-email-jouni.hogander@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:54214 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752619AbYILLLl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Sep 2008 07:11:41 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8CBAmDj026725
	for <linux-omap@vger.kernel.org>; Fri, 12 Sep 2008 06:11:39 -0500
Content-Disposition: inline
In-Reply-To: <1221216698-22327-1-git-send-email-jouni.hogander@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Jouni Hogander <jouni.hogander@nokia.com>
Cc: linux-omap@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2008 at 01:51:38PM +0300, ext Jouni Hogander wrote:
> This patch changes gpio "driver" to enable debounce clock for
> gpio-bank only when debounce is enabled for some gpio in that bank.
>=20
> This patch obsoletes "PM: Dynamic GPIO clock handling" patch. Nasty
> side effect is that gpios in per domain aren't capable to generate
> wake-up if per domain is in sleep state. Anyway keeping dbcks enabled
> all the time isn't either good way to workaround this problem. For
> this we need to use iopad wake-up. Currently enabling iopad wakeup
> mechanism for gpio pads is left for bootloader or kernel (depending
> which one does the configuration)
>=20
> Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
> ---
>  arch/arm/plat-omap/gpio.c |   26 +++++++++++++++++---------
>  1 files changed, 17 insertions(+), 9 deletions(-)
>=20
> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> index 0e74103..da164d8 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c
> @@ -152,6 +152,9 @@ struct gpio_bank {
>  	u32 level_mask;
>  	spinlock_t lock;
>  	struct gpio_chip chip;
> +#if defined(CONFIG_ARCH_OMAP3)
> +	struct clk *dbck
                        ^
                        ;
> +#endif

Cheers,
Daniel

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkjKTmUACgkQ68xJuWtYYdUzcACfc2jN+yaduyFG0zbuxPNSELyZ
ZEUAn26sTHw3Z/c9BxysHuE5/JMYNkMi
=iUns
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
