From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v7 4/9] usb: phy: twl4030: twl4030 shouldn't be
 subsys_initcall
Date: Tue, 18 Jun 2013 12:43:00 +0300
Message-ID: <20130618094300.GS5461@arwen.pp.htv.fi>
References: <1371113039-5784-1-git-send-email-kishon@ti.com>
 <1371113039-5784-5-git-send-email-kishon@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4045409394630274693=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1371113039-5784-5-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: mchehab-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, cesarb-PWySMVKUnqmsTnJN9+BGXg@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, sylvester.nawrocki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--===============4045409394630274693==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R0KbGFzrRdaLlFh/"
Content-Disposition: inline

--R0KbGFzrRdaLlFh/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2013 at 02:13:54PM +0530, Kishon Vijay Abraham I wrote:
> Changed the inticall from subsys_initcall to module_init for
> twl4030-usb.
>=20
> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>

not part of the series, should be sent separately. I'll queue this one
for v3.12 once v3.11-rc1 is tagged.

--=20
balbi

--R0KbGFzrRdaLlFh/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRwCukAAoJEIaOsuA1yqREaicP/2WvVLB/REUqZXTCmlm76T1R
PjqaZ+/0KujXXMBXjRJia07jVmOyL3S/wliLqDWyve6Xr5QIKpai3rWAyLknoEH0
pU6X8FO0AH/LoMZEdNJ/M6dBNISSYSh/VGitKlFXTrP5T7oCjF6Bre7n7CtIEu5g
RzV8rEAbc4JjFQjejETgDgqfnhmq8OhA1fmuY7ScVoJInRykz+K3rf4Tujxt3JMb
M/IO15hrswpOJM3QiQMDUgEEudsmndaoW3JjFsNGIEJR7ePFSeYMilTqgw/sw7lI
n8jxM3q8UfDsFkNZ7C0ZyhpJG85H4n4jMMN8qNun9HjGkYQkpYmjqHKiRWaFlVon
pVzgUPAjWNxwbosXdU0K/gYyWpTeQl4MshF6lSA9ZkdcdzD7PNoUlXk+eD2z0kjw
AuyaWQ1DaRX3DfsNLtJ4UPiSQO8vITZGg4EiF3LyduDS+QoY2kd8qwQU/D9HDBiX
m6ukYHUT04+luz7Rl2wM680yDZT6RIPc4pJD/N+0xp56wRn52xNLilgssIpuFIBY
qhzZ2MLrjxwjWlu4552UbUbn67QhbQlCSbCMzzHSt17yGY9tiq3CrmvKffgTfgsb
WKpvv7xnbk6Yca4PZ8pLOvEF6p8T4DAY+KEQGyRvSMlJd65UqtPzDkDxxdARc8RT
QBrL8nyqajaJCGYSy8Zu
=b73G
-----END PGP SIGNATURE-----

--R0KbGFzrRdaLlFh/--

--===============4045409394630274693==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============4045409394630274693==--
