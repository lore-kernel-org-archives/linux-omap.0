From: Maxime Petazzoni <mpetazzoni@mvista.com>
Subject: Re: [PATCH] OMAP3: Zoom2: provide default MTD partitions
Date: Thu, 27 Aug 2009 16:06:18 +0200
Message-ID: <20090827140617.GA30917@mvista.com>
References: <1251374386-6733-1-git-send-email-mpetazzoni@mvista.com>
 <FCCFB4CDC6E5564B9182F639FC35608702F9A44CDF@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:57048 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752605AbZH0OIR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Aug 2009 10:08:17 -0400
Content-Disposition: inline
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702F9A44CDF@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "Singh, Vimal" <IMCEAEX-_O=TI_OU=BD_cn=Recipients_cn=x0094262@dlee86.itg.ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Rix, Tom" <trix@ti.com>


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi,

* Pandita, Vikram <vikram.pandita@ti.com> [2009-08-27 19:16:27]:

> Why?
> 
> I know of an implementation by Vimal Singh that introduces a common
> flash file for Zoom1 and Zoom2.
> There is reuse of code there.

Thanks for your comments.

There are indeed other implentations around using a common flash file
for Zoom1 and Zoom2 boards. I didn't know of this specific
implementation by Vimal Singh, but we use something very similar
internally.

Since linux-omap didn't had any MTD partitions definitions for either
boards, I decided to go for the smallest change: only partitions for
Zoom2.

> Please discuss and get a converged approach on handling NAND
> partitions on Zoom1 and Zoom2.

Agreed. We should use a common file for Zoom1 and Zoom2 flash, with
Zoom2 specific partition sizes. But I'm not sure I deserve the right to
propose Vimal Singh's patch (by the way, why hasn't it been merged in
the linux-omap tree?). How should we proceed then?

> Also the Systerm/User/Cache partition definitions are more from Android perspective.
> 
> Given that each system may have a different NAND partition requirement, 
> have you looked at bootargs passing the MTD partition info: Eg: 
> 
> mtdparts=omap2-nand.0:512k@0(xloader),\
> 1536k@512k(bootloader),\
> 29m@2m(kernel),\
> 160m@32m(system),\
> 32m@192m(userdata),\
> 32m@224m(cache)

Yes, I am aware of the mtdparts command line arguments, which works
great. I think a "default", sensible partition layout for the Zoom2
would be nice though.

- Maxime

-- 
Maxime Petazzoni
Linux kernel & software dev
MontaVista Software, Inc

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkqWktkACgkQ7KsOe4Pmrg28zwCdHvKdX9NDgWVoUOx6Mc8kA6+7
rx8An1NMQg5aEUHrEgGBZM/1YoFTvQtz
=4L+0
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
