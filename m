From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: [PATCH v4 06/11] pwm: pwm-tiehrpwm: Add device-tree binding
 support for EHRPWM driver
Date: Thu, 22 Nov 2012 22:03:47 +0100
Message-ID: <20121122210347.GD16716@avionic-0098.adnet.avionic-design.de>
References: <1353503469-18634-1-git-send-email-avinashphilip@ti.com>
 <1353503469-18634-7-git-send-email-avinashphilip@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8939614951874410768=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1353503469-18634-7-git-send-email-avinashphilip-l0cyMroinI0@public.gmane.org>
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
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gururaja.hebbar-l0cyMroinI0@public.gmane.org, vaibhav.bedia-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--===============8939614951874410768==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HWvPVVuAAfuRc6SZ"
Content-Disposition: inline


--HWvPVVuAAfuRc6SZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 21, 2012 at 06:41:03PM +0530, Philip, Avinash wrote:
[...]
> +static const struct of_device_id ehrpwm_of_match[] = {
> +	{
> +		.compatible	= "ti,am33xx-ehrpwm",
> +	},

Same comment as for patch 4.

> @@ -437,16 +451,41 @@ static int __devinit ehrpwm_pwm_probe(struct platform_device *pdev)
>  		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
>  		return ret;
>  	}
> -

I think this blank line actually improves readability so it can stay in.

Thierry

--HWvPVVuAAfuRc6SZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQrpMzAAoJEN0jrNd/PrOhl3oP/2Jx3yD88Exbso/HABJVePgr
nGF9Jfft8ZAUDlDXMbbLmoB/SHD6EgqwiMoDXqlbTnzDaJJK57TX175k1rdUZuYV
aiJhdD6P2E+ED1t0l9OBwBZ3xGnfW7kMlg7ERySvEMyH/tsvAt1IskbfeDkrEKUu
n6uTlG0xxdMZyHYgIMP8xAAHjKTni0O/yh4Hi6FX4DEcEJ0W2bKa4tcTEBG/bmav
lKRvOxwR0uCro5I+wLabtDgFOwEeZ8PoK6wOrw53CsLE//t46n1oev/yD4l1E9//
/g0S42M2UTJ1jzCP2UrZJedIlUiEsS8A7iArylKHEWQvBgT9AhqmuHeQtHxGvrBW
1ehFGIE/D8nUCtauetVCnqq9xjmEautHyHVLP4xTkxVzgCfboT6+IcKt1ThUecgv
DH/BXGtpwcpUg50h4IPvGyYac85GY1F3ldsBu4U+8fQmYauskn6OUzIpKdIa4GRm
t8XQa3ed5O+Te/ed5kAIh1JXd73yfGDAV2hQhTbo9L5XyRMFRcKhJw31HUkIHJwx
2QpXQo0GyNHZfMd8aznDvdsMA5nZi0pBa34CfjAhbUMSs23+4EltsSL1svVgMXeK
w9VT46ZcSZWdz5s/AvBrq2eGGWbWXPVqvC+NeVFkIKJugIIOThm5U6uFFEeAe3bH
iJLrZc+Xrjc6F7JzXqia
=u8/p
-----END PGP SIGNATURE-----

--HWvPVVuAAfuRc6SZ--

--===============8939614951874410768==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============8939614951874410768==--
