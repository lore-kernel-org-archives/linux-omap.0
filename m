From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC 4/5] usb: dwc3-exynos: enable async suspend/resume
Date: Wed, 18 Dec 2013 10:07:36 -0600
Message-ID: <20131218160736.GD4970@saruman.home>
References: <1387363174-25942-1-git-send-email-yuvaraj.cd@samsung.com>
 <1387363174-25942-4-git-send-email-yuvaraj.cd@samsung.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1344540164359493099=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1387363174-25942-4-git-send-email-yuvaraj.cd@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>
Cc: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>, kgene.kim@samsung.com, sarah.a.sharp@linux.intel.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, joshi@samsung.com, balbi@ti.com, linux-kernel@vger.kernel.org, Andrew Bresticker <abrestic@chromium.org>, linux-samsung-soc@vger.kernel.org, stern@rowland.harvard.edu, gautam.vivek@samsung.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============1344540164359493099==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SNIs70sCzqvszXB4"
Content-Disposition: inline

--SNIs70sCzqvszXB4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2013 at 04:09:33PM +0530, Yuvaraj Kumar C D wrote:
> From: Andrew Bresticker <abrestic@chromium.org>
>=20
> In addition to enabling async suspend/resume on the xhci-plat device,
> we must enable it for the dwc3-exynos platform device in order to make
> the full USB stack resume asynchronously.  Like the xhci-plat, ehci-s5p,
> and ohci-exynos drivers, there are no outside dependencies which would
> make resuming the dwc3-exynos driver asynchronously unsafe.
>=20
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> Reviewed-by: Julius Werner <jwerner@chromium.org>
> Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
> ---
>  drivers/usb/dwc3/dwc3-exynos.c |    2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exyno=
s.c
> index 8b20c70..57431b7 100644
> --- a/drivers/usb/dwc3/dwc3-exynos.c
> +++ b/drivers/usb/dwc3/dwc3-exynos.c
> @@ -155,6 +155,8 @@ static int dwc3_exynos_probe(struct platform_device *=
pdev)
>  		goto err2;
>  	}
> =20
> +	device_enable_async_suspend(dev);

sure that clk_disable() in your ->suspend() callback will cause no
issues at all ?

--=20
balbi

--SNIs70sCzqvszXB4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSschIAAoJEIaOsuA1yqREYusQAJfVrxxgIcgYQH6bGbXJwFFw
tq2PyAV1NOPY7pyIAKkovhsObwYQmWbYwCw21sBFR4pDoWmZOS6ev/qkTFJiKRGn
ChG0YCUg/X24kUlxdMK6m6wJ4p2WEOssG4jneRvDLwFmY6d2aSVj7qipaX+JgzFH
Nan28Ho6nbxAwLq22gi8BKVm0Eb9j37HYnsB51AY5wAnPNefRPvgNE83ItUoczhy
37LXrLFw/EQ+qvZ0n1CwMvS04+XqX+VZP5VVI9Ab/b0VV8HuMuKGy6HjFQ42HuIe
09zXUh5CtGtzx7LhnAO1EpB3qN0+XOpFyhuApdAwPooINnR9iL/IO/crgd6h1+kG
MOTaHuJSbnuXXY2sM+jwvk381xZ6ITvCQWnESrD5G3hLZgvuvHmT+UE3AbBOksGB
cKXhHANqrxvbY+F4AxejSySpckpydNiqmn0nAaXojZdghZ4l9Lq9OvG/qzMKVq8w
KwV4W1YHio3pcXL6Q3rMJxGfhKcIvuWJxxTZBNEyHH6onF591EYPjprKi7pdYYYF
ZQ0h7DBW+nEg3g5I3tPyrfrsjKrfbeEnCTZoKASB76vENH+qUwVmYEPEzGmXNUAW
uDsJo85WD/6tQWZU5UMuw+nwSQGr/e1YmQWrSgQ196sdG4kts/RH2uaniNNJlf2R
RXHzNF4Qd5mV6BkdyROx
=f4Pp
-----END PGP SIGNATURE-----

--SNIs70sCzqvszXB4--


--===============1344540164359493099==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1344540164359493099==--
