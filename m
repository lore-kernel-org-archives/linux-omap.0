From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v8 1/8] drivers: phy: add generic PHY framework
Date: Tue, 25 Jun 2013 18:17:53 +0300
Message-ID: <20130625151753.GF21334@arwen.pp.htv.fi>
References: <1372139926-3719-1-git-send-email-kishon@ti.com>
 <1372139926-3719-2-git-send-email-kishon@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6547613847479886876=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1372139926-3719-2-git-send-email-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: mchehab@redhat.com, linux-doc@vger.kernel.org, tony@atomide.com, nsekhar@ti.com, swarren@nvidia.com, grant.likely@linaro.org, cesarb@cesarb.net, george.cherian@ti.com, arnd@arndb.de, devicetree-discuss@lists.ozlabs.org, rnayak@ti.com, rob.herring@calxeda.com, linux@arm.linux.org.uk, sylvester.nawrocki@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balajitk@ti.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, santosh.shilimkar@ti.com, rob@landley.net, benoit.cousson@linaro.org, akpm@linux-foundation.org, shawn.guo@linaro.org, davem@davemloft.net
List-Id: linux-omap@vger.kernel.org

--===============6547613847479886876==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nYySOmuH/HDX6pKp"
Content-Disposition: inline

--nYySOmuH/HDX6pKp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 25, 2013 at 11:28:39AM +0530, Kishon Vijay Abraham I wrote:
> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
> new file mode 100644
> index 0000000..7abf573
> --- /dev/null
> +++ b/include/linux/phy/phy.h

on this header, how about adding phy_set_drvdata() and phy_get_drvdata()
helpers ?

cheers

--=20
balbi

--nYySOmuH/HDX6pKp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRybShAAoJEIaOsuA1yqRE/hQQAJI0nMYwOYxaHQduvK9XCWrY
8i60KnCwLWvbpUeRucJ/ucNzAKtoSb//lnnUffGlZGi92QSr8hYuKFCu3P0k2KgX
N1gkZyaG4g6bIaBgse9zVphYRb0AWoSQbsOG621sSKM1beE9AaEV3NY9Nu2lILdA
zYfx/LoNU+PQ9HyTHjAHWgONZQjm4+z2ABhsw0EpM42/74N8hkmSi1tZELg9oN3u
VaZ0xJjeN6zj30y7+gEcp0vb9e7e3KUhMbt/WTL17VspjHucKlrWxD7/9k9spL/w
kuCKuRu3iaTZcD6oi98RlvhNCEj3HS9Jg8ASdn8BfmGInZj71bedSwMONyt/Hm2j
FVHQnxMC40ir+BkidFnJvwjbGAQc0d4S+108HfWa9uEvAQarZtr9Ul0puHDeqocI
Mlk3IZDhDXlgMLhvRn5zzqRmopxrp14H6tHhFcStvT2SatUb0RxreSXO7VJrStoP
O1N6kVB+9DGXn1xEVU8r7jSQPZzT0a2MLa8satfqV34CSKsu10aQQk2VRyRCEJcK
QCc5J3zqqPgwYFy+rKDDTkU53NjERCtV8MYtmwhtXPqyRIA5WsQQq26zdrF7Zp88
uaBR0ZUSM3cWd47rQmBnRmnEQFD7EFCeCL9Fe9X2ZBRNsS+b9V+Z5syNfr8IclJ8
G51h2hhdM300HPVYTlM0
=iDEU
-----END PGP SIGNATURE-----

--nYySOmuH/HDX6pKp--


--===============6547613847479886876==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6547613847479886876==--
