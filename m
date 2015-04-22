From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] omap: i2c: Add calls for pinctrl state select
Date: Wed, 22 Apr 2015 12:28:30 +0200
Message-ID: <20150422102830.GA1523@katana>
References: <1429283277-28161-1-git-send-email-pascal.huerst@gmail.com>
 <20150422081240.GH1511@katana>
 <553760D4.4020506@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:35928 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750716AbbDVK2i (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Apr 2015 06:28:38 -0400
Content-Disposition: inline
In-Reply-To: <553760D4.4020506@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pascal Huerst <pascal.huerst@gmail.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> You are right, the include is missing. I just reapplied the patch,
> compiled and interestingly enough, I don't get any compile errors. (?)

I assume you have a different kernel config where something is enabled
which includes the pinctrl-stuff in another include which is included
by these drivers. Although, my .config was arm-allyesconfig. Can you
send yours?


--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVN3fOAAoJEBQN5MwUoCm26CgP/3C88YyXkji3yPht00spcril
o9w1DyW14K5xOVszHwSbn4o8H8TRrcfd6U3pooPil1bNm8q5/GBpFuDdIy1eFuxr
vvhTjrSmPWI7mexQFeOA4/8mYMUr3X6lH9np4y2l3kk70+qvri8fioniuJLtpvJ5
pRuMhRaCL6fw2/BnJfuHFaiug33Ml+bhB/tni9GxYe0SLobpxcXS/5AtvRbMxJkw
xU7E1Wo7WKQuJnXbYwAV/+XCxx52yfv7tA7MGlqSCxUaxYSQ4/nFFhQLpGzsnWvG
RUkUDMQXBkcj92ckH4+rLgp9ka7ddZVDrsOn713XrqfhW375ShF/EXWIw8wdJV0j
cyFMEQ58btSpxEG9e2y2S/8lnK6Ls+mlFRukMWcwFAKk1ujbS0aIT7QirpHOjqY/
4OkBc0f+bvq1pP4+hahm687I36SnwhaWrHYc+wBdcVG5ve9zxiTC/Ll6i7tnVfPR
syIFfqWwbhOo2+TQPMxp5oxQF0EkrEp5nTeX/hahGQDk9+cpme2JaBw9JRANgO4t
POF605M74ss5mmYR1VWmBbNXoXFDROCF1vIZZxX+qEhKQT7LAnqUtoL5LOUggm+4
wTb5HPG3QYT8W0S/+SOy8LH5QLsluCZoMumv7Xb9t5UC9aOs6IBpYU6zxUiUkTwN
KGXuN1+H6y/tmLrRaSzr
=Axmy
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
