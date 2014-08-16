From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 5/7] net: cpsw: Add am33xx MACID readout
Date: Sat, 16 Aug 2014 11:53:18 -0500
Message-ID: <20140816165316.GB2858@katana>
References: <1408202315-20006-1-git-send-email-mpa@pengutronix.de>
 <1408202315-20006-6-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cvVnyQ+4j833TQvp"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:34883 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751563AbaHPQyS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 16 Aug 2014 12:54:18 -0400
Content-Disposition: inline
In-Reply-To: <1408202315-20006-6-git-send-email-mpa@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Steven Rostedt <rostedt@goodmis.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de


--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +	mac_addr[5] = (macid_lo >> 8) & 0xff;
> +	mac_addr[4] = macid_lo & 0xff;
> +	mac_addr[3] = (macid_hi >> 24) & 0xff;
> +	mac_addr[2] = (macid_hi >> 16) & 0xff;
> +	mac_addr[1] = (macid_hi >> 8) & 0xff;
> +	mac_addr[0] = macid_hi & 0xff;

That looks twisted, but I assume that you tested it is correct.


--cvVnyQ+4j833TQvp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT74x8AAoJEBQN5MwUoCm2AKYP/3kkXziwaXuBCeyyjT1G9zgR
0HNglOeLpPBm5ml8QJMiCv1ihBM1rD5kU9fS8O768X0xKKi0eAMkMoHyCAL/12qH
e/pqwEG9RJq1whUO6KW0fRjV/Wv/pTjrnjk0icAz83juDDyy/7/zZlRYh+xWQuXo
zripJxojf5XBKC6G+FnVmKIzl5TppF9kSdAx7Li49JL/i/uAFGZpdFzlF2CzDoRj
2KJJ5jNlRlGmoLn6In8Ouc8GTfL4d8BZ4IH0brekBSYJC7f6m+IJShA+vGcW5XET
yDQapz5XoNEjVI3zqeTyxuIp4Oxd4F7UakKq+73O+SG+jOtwqbRf0v6Ejj9IGjDV
K6Edd88wdUzNjQYP1/cB+NVfxr7rmaI4zdqnMcBZPBSV0IUILoJlZTvu/KY7VdHR
5YUQ1R183jZMZ9Wbw9UxibN0M7c81ZfteYswd7Is5iLjISEf4viWfoWb6IFZHIKQ
cntcCEMZxboXbj655WhrPQtgIunRv6fGds64aPjzG/53ZQ+F2LZb1bZeiMrzrFLw
1bdlO16Bofhw1igsIHQ9h45bi/xJTMQ3t5j8GaqP140LTw3qcb+xIBsKENM+KQrS
PtD/7XaNc3NedossUY6Y0Pxr+pNW+jY89IyXYMHpUSsMeqw5vbBDV4Ggz3JADZQi
hAgVpJQd1zqSdnfYM5+F
=gFoN
-----END PGP SIGNATURE-----

--cvVnyQ+4j833TQvp--
