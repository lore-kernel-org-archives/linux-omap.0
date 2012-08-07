From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] driver: misc: bmp085: remove "of_match_table" property.
Date: Tue, 7 Aug 2012 08:43:44 +0300
Message-ID: <20120807054342.GF8468@arwen.pp.htv.fi>
References: <1344245324-16704-1-git-send-email-sourav.poddar@ti.com>
 <20120806093033.GH17551@arwen.pp.htv.fi>
 <20120806154214.GC29272@sirena.org.uk>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8780684447437934006=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20120806154214.GC29272-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
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
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--===============8780684447437934006==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O98KdSgI27dgYlM5"
Content-Disposition: inline


--O98KdSgI27dgYlM5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 06, 2012 at 04:42:14PM +0100, Mark Brown wrote:
> On Mon, Aug 06, 2012 at 12:30:34PM +0300, Felipe Balbi wrote:
> > On Mon, Aug 06, 2012 at 02:58:44PM +0530, Sourav Poddar wrote:
> > > There is an automatic binding done for I2C devices in the of_i2c core
> > > code. So, DT will be able to bind to any I2C device using the
> > > already existing table: MODULE_DEVICE_TABLE(i2c, bmp085_id).
>=20
> > Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
>=20
> It's good practice to have an explict compatible string even if the
> default happens to work in order to avoid any name clashes.

of_i2c.c makes no use whatsoever of the compatible string. See that it
will build an i2c_boardinfo and register a new device. That compatible
string is just churn and has no use at all.

--=20
balbi

--O98KdSgI27dgYlM5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQIKsOAAoJEIaOsuA1yqREBLMQAJrDHny7JGVaR4QVbKuvklf2
pe89s2hCyLolbx4ecrgMskcLnN48zfKMaNm6e4lZSuLyFme46XUmlp2Axcd4iM/I
4xUZxc4mVVq0WoaTsljUywPoEXNMNJ/LlChCIdJVgwzGTYLWBd24JYIoceQo6eJ2
TKVsv8SZi4OTRBeZjqlUq8t+EdtfPkhBnWTUN83eFkSM6ZJiR0SX8pnQo2hzr5HW
tR3QrEgsj04lq+NLo3Px+K6HwCdPu0Zew3r7k169yvQTkz+ZdDB09RmaEuqgjd01
uhFmxr10XY+/rIMa6Yza0JsAgbPwCs1E1sEzVSRSvw5MT7djDA/CeKrUiirbFlL7
GHOI63hpDaCfYz1pVnWFdBHyh8OAdWfWtwIEEPTDE+BDoLgYhz2N/8JMMhWLbiXU
llfvw/GEXxenmaYtsUWpIEcGuYDlDeTsZZidSLDif4d3smxsHCOJJZzbjfYdLCfl
Iz96gzapr+DnOu8sXIf5c9AJtfdK0UbKenKE2ZRh0qWfIpAl3m98NP8r/OoSU+W3
9n6NwS6AsbMt/U6NYFgYPDzKOzzdq73Fpyzmc/FKsd5l1JNt//6uQTE7nGVtWzYG
TMnjF+COpnj7WhbjoDK3f2zbdSgw4xL/OR92yC6vabuXKM2IpQVRw3ugKxbwOkSO
OptlEkXXBansdzQYX6rJ
=gM5z
-----END PGP SIGNATURE-----

--O98KdSgI27dgYlM5--

--===============8780684447437934006==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============8780684447437934006==--
