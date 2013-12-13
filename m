From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2 1/7] usb: dwc3: keystone: add basic PM support
Date: Thu, 12 Dec 2013 18:43:37 -0600
Message-ID: <20131213004337.GA31622@saruman.home>
References: <20131212214306.GS1939@saruman.home>
 <1386884755-12366-1-git-send-email-balbi@ti.com>
 <52AA54E4.5000606@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7925730510994812129=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <52AA54E4.5000606@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: kgene.kim@samsung.com, w-kwok2@ti.com, Linux USB Mailing List <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, linux-samsung-soc@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

--===============7925730510994812129==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline

--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2013 at 07:29:24PM -0500, Santosh Shilimkar wrote:
> On Thursday 12 December 2013 04:45 PM, Felipe Balbi wrote:
> > A bare-minimum PM implementation which will
> > server as building block for more complex
> s/server/serve ;-)

hah! :-) will fix in my branch.

> > PM implementation in the future.
> >=20
> > At the least will not leave clocks on unnecessarily
> > when e.g.  a user write mem to /sys/power/state.
> >=20
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> >=20
> > improve error path a little bit.
> >=20
> We will test this out. Thanks for the
> patch Felipe.

thanks.

--=20
balbi

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSqlg5AAoJEIaOsuA1yqRE+fAP/i2RxpvgdyheMjCsssmyaADO
Gb+PY9x1ZPQsoAUuX72erdEfdTF27uJoSKOrxVIjEO23Ahn5CB3/5XxAxo5xPHeM
KiXXp6loqprlvMwNs56Fb1HRNR26PGJ6hYIPZ4KFEm2s9VJAdCbmMKjUIYoIZZSb
dAyo3RO/2nikVADJqltpXpDuXuksOuLzZ/2k3S3f0HLBCiGphR3ZWBh7vwmgWOgp
OmrpZbEaOd2YgrLOAqhO3JX2S6S3sokjEkssDiC/Ge52MFNNBazj2SfaEey+X7LX
35HnoV1pY6Qg6dOA+ONUUgZPo2iOWEkko/1gBXy5PiB9fhAkCzMCPTNNQaSHfOTK
8pOo9me+IstU3HriGnIgytmSZ5EqyXDS38v7LodGi4D5yrCisfcKtxaiOjUjtpad
CNyjA6AEgfaYNtE5+lVd+8VPRzFHo/6cgmCt+WRjzacevHJgG8uVQxBThAI5uiud
WaiQPZStDFxNwmqKiHhgfm/b2RZxLMZeB87MpfeEm53Dop+wmIoqQD0Hq193nfe+
Ho2AOS11SqsgyRRmAc7uF2XKQlDR3fT2OM2/6EzdNvmooz+zXZsVOd42atVfMtgy
NEJuPmf/rJtTxpNNELCpTBf0YQKNVshNijgK7knbAwvElfaWYNPOeRa8Uig9W+Sp
o2lvEE9TYDtNcMLyEZK+
=GDcV
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--


--===============7925730510994812129==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7925730510994812129==--
