From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: [PATCH v4 09/11] ARM: dts: AM33XX: Add PWMSS device tree nodes
Date: Thu, 22 Nov 2012 22:08:57 +0100
Message-ID: <20121122210857.GH16716@avionic-0098.adnet.avionic-design.de>
References: <1353503469-18634-1-git-send-email-avinashphilip@ti.com>
 <1353503469-18634-10-git-send-email-avinashphilip@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3465954901668879389=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1353503469-18634-10-git-send-email-avinashphilip-l0cyMroinI0@public.gmane.org>
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
To: "Philip, Avinash" <avinashphilip-l0cyMroinI0@public.gmane.org>
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gururaja.hebbar-l0cyMroinI0@public.gmane.org, vaibhav.bedia-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--===============3465954901668879389==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8/pVXlBMPtxfSuJG"
Content-Disposition: inline


--8/pVXlBMPtxfSuJG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 21, 2012 at 06:41:06PM +0530, Philip, Avinash wrote:
> Add PWMSS device tree nodes in relation with ECAP & EHRPWM DT nodes to
> AM33XX SoC family. Also populates device tree nodes for ECAP & EHRPWM by
> adding necessary properties like pwm-cells, base reg & set disabled as
> status.
>=20
> Signed-off-by: Philip, Avinash <avinashphilip-l0cyMroinI0@public.gmane.org>
> ---
> Changes since v2:
> 	- ranges property populated to handle child devices address range
>=20
> :100644 100644 20a3f29... 4393161... M	arch/arm/boot/dts/am33xx.dtsi
>  arch/arm/boot/dts/am33xx.dtsi |   84 +++++++++++++++++++++++++++++++++++=
++++++
>  1 files changed, 84 insertions(+), 0 deletions(-)

Looks good to me,

Reviewed-by: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>

--8/pVXlBMPtxfSuJG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQrpRpAAoJEN0jrNd/PrOhEvwP/3Fxsbbdh+3U/XaMi+df3SPu
v+FhtZMtoL/7nUkhk9VOUpbnmokcx+Cgl8D7ApHEgnWvp90Y4HaJNEk9xxgNevKc
YvNrtg+6zL2Yx4gZIOdQDHXEMiBNBBfmeXFwUwmZUxjz/1HgqY0o1j+bm9GBsbD5
RCi8NT+f9pw/QdKK7/nWvl++6ZHRG6eVW5l0Z+usN5XAFQJxYOh5XsoDVF+JkZ5q
yJrkx8jXuc2xvPH/NIcSsTILs74/mvle3pBv6LaeIT4HN/3ac6M3a4LfljNqO2ZP
g1arIfSeI4cqpptEekCFDvUoDS2H7pV18DbN/s/2rICt2r2nmQIJGArVe1sH9Hrs
PCANVlyOtINYxk95oYhMNIEBDiOmuphcat8YGMhr19YSeBSqtZa0hHV43mc52ZTz
2GB68u6i/SSkLpJTOKWDr5Mw8BOSCBJruONyyUPQBXIEBsTDF7o6WZdZK9lnU2JE
r7kFCTQiUItktg2d89AgZ3BCStkRL7Z4mFpFFNWfVmPL8AQZTVJUOk3WE/sIxhP3
PRge095DGL0sYLrY1OLrp7AANO7OVAodpnN5v2ADrbNefJrkEE4creGFeWhLSou3
gZHzmXsqbIMaYkTYE74ZIhtZRe0zSDy/RTQqHkZajnrrzvnwBYYYEUpA95nmZbSi
JXxlxKYPglzfMop+FQD3
=/RVl
-----END PGP SIGNATURE-----

--8/pVXlBMPtxfSuJG--

--===============3465954901668879389==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============3465954901668879389==--
