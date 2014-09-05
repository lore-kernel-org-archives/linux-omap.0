From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v6 1/3] usb: dwc3: add ST dwc3 glue layer to manage dwc3
 HC
Date: Fri, 5 Sep 2014 10:47:01 -0500
Message-ID: <20140905154700.GE24449@saruman.home>
References: <1409931392-22340-1-git-send-email-peter.griffin@linaro.org>
 <1409931392-22340-2-git-send-email-peter.griffin@linaro.org>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VdOwlNaOFKGAtAAV"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1409931392-22340-2-git-send-email-peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, maxime.coquelin-qxv4g6HH51o@public.gmane.org, patrice.chotard-qxv4g6HH51o@public.gmane.org, srinivas.kandagatla-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, peppe.cavallaro-qxv4g6HH51o@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--VdOwlNaOFKGAtAAV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 05, 2014 at 04:36:30PM +0100, Peter Griffin wrote:
> +static int st_dwc3_remove_child(struct device *dev, void *c)
> +{
> +	struct platform_device *pdev =3D to_platform_device(dev);
> +
> +	of_device_unregister(pdev);
> +
> +	return 0;
> +}
> +
> +static int st_dwc3_remove(struct platform_device *pdev)
> +{
> +	struct st_dwc3 *dwc3_data =3D platform_get_drvdata(pdev);
> +
> +	device_for_each_child(&pdev->dev, NULL, st_dwc3_remove_child);

same as before, of_platform_depopulate(). I can fix this one myself this
time.

--=20
balbi

--VdOwlNaOFKGAtAAV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUCdr0AAoJEIaOsuA1yqREyvAP/2XzSmWXusr9Z4vccu9UKdEO
HyN/HGFAcIzXevRVsh73xmi3LnZdyGWJJQoxHy3MiMJC18FaAJEb0HKblAfuYwld
yVPZLkYa/xnnQ/ru6rf15hXSLVVIDNmoAvLwVPKCAfAG+yBwUcd2rbOM4QVZHR5+
3iyP8aXJxb4shaGyopV3/k1ZrWrXJXizy8sDgI209xQi7yHmUObAHyN04DBhpO/2
bzj3Dbn7e61Z2AHBUxxpbSd5ewpG7viKlIEaehyEnNHCXgs+adEdeFD/CEsx3T06
uSzjwdBIJmzW03dMwAMzjxab18KxHh4JbDUAyo51SITNTTSqaXHKqhLqh/bx/THs
7YECetoskIGH3jvg0ZK48JCSzEDatzab/i7+Zj59jgYP7stoE3+kvTYzDP+o/+DD
Rwfn41WAUqwMYooa04rCjVjHqf2OO7zRteODJ7Vy5uSgFCRwxxFhxnY7y4B5DsXi
t0HlzXUBjDeLasG+KTS7ygFGUPUMbkP6IKuNZyox2IXczznbygRiG6+jo37Jx/zJ
l3CIxTzNBTXscY0Nn124bfOFxqsbOexHRFpA7Bur+umWXJUaBkC9RofZW9C+/eK6
zCCZKhRwl+WUAbJuRT4wgpqRwwssR+vcVwF8GFGdK4tBr6FAfvFzW8vDz+cZTLdb
juyyy070QMxMleRBr17k
=1CKY
-----END PGP SIGNATURE-----

--VdOwlNaOFKGAtAAV--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
