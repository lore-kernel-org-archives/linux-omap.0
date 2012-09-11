From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 05/17] ARM: OMAP2+: Remove hardcoded twl4030 gpio_base,
 irq_base and irq_end
Date: Tue, 11 Sep 2012 08:51:08 +0300
Message-ID: <20120911055106.GA17865@arwen.pp.htv.fi>
References: <20120911052934.29637.9190.stgit@muffinssi.local>
 <20120911053052.29637.74323.stgit@muffinssi.local>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog138.obsmtp.com ([74.125.149.19]:40716 "EHLO
	na3sys009aog138.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753877Ab2IKFzj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Sep 2012 01:55:39 -0400
Received: by eekc1 with SMTP id c1so75518eek.1
        for <linux-omap@vger.kernel.org>; Mon, 10 Sep 2012 22:55:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120911053052.29637.74323.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@secretlab.ca>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Linus Walleij <linus.walleij@linaro.org>, linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 10, 2012 at 10:30:53PM -0700, Tony Lindgren wrote:
> We can't use hardcoded interrupts for SPARSE_IRQ, and can replace
> the hardcoded gpio_base with twl_gpiochip.base after it's been
> allocated.

not related to $SUBJECT, but ideally we would also have SPARSE_GPIO
kinda thing to avoid this sort of issues. I have tried starting that
work, but ran out of steam/time...

--=20
balbi

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQTtFKAAoJEIaOsuA1yqREVHoQAJyK8RyUTKXsrbYQD0wuYwZ2
t2COFWSa1AuBrI5zsKafHi+bFhxlWGEua1F2Gk3cCbCfm6h9AD4alP/eSaY2KaKE
mYLFxragIwvhAqaO4qNDa08JYgUHMVe3QurIbcWnAEft55VtDIjCKpE4LksWqpAe
cBkQuOa/jQ2Fftwes4kFj5u85S1UdyTqHS83yIEdtzJe3jJYoEwE4JTTAmhwBxwQ
pqPmumaRQJ88SucML2XCRA6MnIcOX432/+I2eg1Tt/QV1BQSbCzp4HoaZ5Pkk1SG
YWQqPBGjwXVcN684V/YjlOqPXEFhU0C3XkvzogxWhzQoxHB8tMTXSqqSsxDf2r6r
kZYVqcq/nROd64HX3pckfAnWMFgedt817A+HyOsoCXbaQnHGFuoLMbraFxKMzkWE
Fvl9PkueY8imNGYZGbXJBgm+a0m7T9lz4iZq1gWjgTnJBGn9c/lbLrYhzO6wwr7f
AHHoAkCRDydZ5YfQhtrAquGVCNjdx/dpnthJGluQhx+Dy4G0asFQQz3tfApup9Mq
6Gu5+0Ap7DxDW38cxRJGfgCtdcKAQnyT3dqMZ7M2PVO5fAY1419Phskq9IgIZCPh
AJONubuZOThal5MORGac/xCPEcdM8CMMaPQIeDIkJGQbaHMfFo4Utlk60+P4LhAo
imUh6qPlEDqUCxPA9JfY
=J8OA
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
