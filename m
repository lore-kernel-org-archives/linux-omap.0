From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 3/3] ARM: OMAP2: omap4-sdp: remove unneeded gpios from
 dss-common
Date: Fri, 25 Oct 2013 13:25:12 +0300
Message-ID: <526A4708.7010309@ti.com>
References: <1382695658-18757-1-git-send-email-tomi.valkeinen@ti.com> <1382695658-18757-3-git-send-email-tomi.valkeinen@ti.com> <526A4585.30403@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="ESBi37184ngVKc1H5iFb75V0I2F2sPB1Q"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56557 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753123Ab3JYKZk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Oct 2013 06:25:40 -0400
In-Reply-To: <526A4585.30403@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, Archit Taneja <archit@ti.com>

--ESBi37184ngVKc1H5iFb75V0I2F2sPB1Q
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 25/10/13 13:18, Nishanth Menon wrote:

>>  void __init omap_4430sdp_display_init_of(void)
>>  {
>> -	int r;
>> -
>> -	r =3D gpio_request_one(DISPLAY_SEL_GPIO, GPIOF_OUT_INIT_HIGH,
>> -			"display_sel");
>> -	if (r)
>> -		pr_err("%s: Could not get display_sel GPIO\n", __func__);
>> -
>> -	r =3D gpio_request_one(DLP_POWER_ON_GPIO, GPIOF_OUT_INIT_LOW,
>> -		"DLP POWER ON");
>> -	if (r)
>> -		pr_err("%s: Could not get DLP POWER ON GPIO\n", __func__);
>> -
>>  	omap_display_init(&sdp4430_dss_data);
>> =20
>>  	platform_device_register(&sdp4430_lcd_device);
>>
> would you not be depending on the weak IO pull done using mux to drive
> these GPIO pins since the GPIO is not requested and held?

Yes. Is that not enough?

> Could we not use Documentation/devicetree/bindings/gpio/gpio.txt
> binding to map to the right GPIO and drive it using the GPIO module?

Hmm, what do you mean?

I do mux the pins to gpios, but there's nothing in the kernel that would
use those gpios. That's why we had the hack above, but I'd love to get
rid of it.

Can I set the pins to GPIO mode, and set the GPIO to high/low in the .dts=
?

If things were perfect, we probably would have a driver for the "switch"
part. I have no idea what kind of driver that would be, though, so at
the moment we've just gone with the use-LCD2-by-default route.

 Tomi



--ESBi37184ngVKc1H5iFb75V0I2F2sPB1Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSakcLAAoJEPo9qoy8lh71naEP/R76vqbSm2vEIp+npTt0I9W3
5r5e4L6MzyQBtST+lpWFXP9yPwbDFKSxlmjZkwfuPG/MvGiMXr0SMBPUC0qL2E9W
/4DwzfPtWqQOplubsAgh8Pk6E5jXwwhfZZY4foeughyeDTbCWtsjhn8jjowMpg2M
hAgPw3OQV+2LR0r4rx8zpZLPpbT7nS4I58QVv7EPPix3pQZjqqf+G2ab+NF9bvug
a85tXEWpPAI1rFj0gF8j/fGG1RXg9p7+qBaOZzcq1ayig7mtJudrD3t+ezJugh7/
+NnV9squ7i8htYT+mRo8aqjqIVGi6Tu2CI3+VquG9wUt3uSWLDbFG/6w8SxS7yQ4
3LvYNQRvp9eYG8Z9kRQMS0gy4zWuKZmstbJJpy7M2hqAt8WdG6jmTdhlG8aqCfbx
XJY5JhlBmVeI9y7mJUP/MeeGIgA0EmOmbd6gJSUglJLSL222eAyRn6QSxvU1+3QN
N1RKxVEW0oJ+ynChcerN8uY3rdpqtXhgQWvGtHsZHkVsfdZxmoskzqjZ72Z3Pu30
MkAE/eWYKBW+5Ac8RnuLKkjXeqB27wPovIln0kqsWRQf+TVi8lqVeEVLwd3A+Xpv
XiIevtX5dh8Qs9EBdrdNKRv5cTjxXCeWWROrokYlXUO+ynYGTiqscTD1jH9ySFZS
3QuhjHLbA42Q2h7r4qhp
=8Bix
-----END PGP SIGNATURE-----

--ESBi37184ngVKc1H5iFb75V0I2F2sPB1Q--
