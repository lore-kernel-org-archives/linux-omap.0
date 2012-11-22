From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: [PATCH v4 05/11] pwm: pwm-tiecap: pinctrl support
Date: Thu, 22 Nov 2012 21:59:44 +0100
Message-ID: <20121122205944.GC16716@avionic-0098.adnet.avionic-design.de>
References: <1353503469-18634-1-git-send-email-avinashphilip@ti.com>
 <1353503469-18634-6-git-send-email-avinashphilip@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2949048770465158418=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1353503469-18634-6-git-send-email-avinashphilip-l0cyMroinI0@public.gmane.org>
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


--===============2949048770465158418==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Izn7cH1Com+I3R9J"
Content-Disposition: inline


--Izn7cH1Com+I3R9J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 21, 2012 at 06:41:02PM +0530, Philip, Avinash wrote:
[...]
> +	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
> +	if (IS_ERR(pinctrl))
> +		dev_warn(&pdev->dev, "failed to configure pins from driver\n");

I think we already discussed this, but shouldn't this be a fatal error?

Thierry

--Izn7cH1Com+I3R9J
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQrpJAAAoJEN0jrNd/PrOhWpwP/iUHHBVkmCk5Chr1iJN2CCjy
hr2gF3YlBQpHpyyvH9+rqtkRzJ0+7iPvq8gaM3pQoW67lgrD5H7nHxqfCqdxghV2
8ARiatAsfiWHAhHi/O9uNCkJ+NZv9YyPaPsrkJvaSie+O14HEAM5kiHtDOpFDkkd
STfXFUHIgMtajNMo4MnjON8FTr7dLv4/RmXVymeUskopkpYoD/hvpqlg1ivEz0M6
UKbbPZ6Z6iiLp5wwGYBEN8dhHA7uHqjFmRfu4dDdD8tKwMLxCVN6EA539VawWmeU
x2gjBbE2Vi5REBt8G+gDkJqCcSB46Xqzg7beZSb7C96bPuxFcI1cWZKzGnjCeyfM
pACqZFHbci8+9hqWYkhAJ3PnCfXn9asR5UMfiwVUxRG7v6LaHPzh4dYpNeW2bDGB
E2RCC2AeFKJ5SqsmM/YOQROHS88RDAFBaXYjly4kPj7Z9dNI+pgoPMVJg3B+tpMI
Ob9NNyYXP+NNOedGrBYdNhnj8Z+51aYMtKAG/KWYyga4U+1JkHEmIQ2BpAfemh/u
WMNqWVSFA/y8hf2AT3PH9Vq0GgfpqfOrOIKZLnwdIAeIl9uEDwp0phDMGkB6Nnwg
ckGRHEo3oQfMzACNUjuXO2vX0TOIig8+rFrThqotrGP+z3wTZNpjevkC1JUImJp4
9veop7y+AI0mSrvAqmru
=7YdN
-----END PGP SIGNATURE-----

--Izn7cH1Com+I3R9J--

--===============2949048770465158418==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============2949048770465158418==--
