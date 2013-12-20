From: Sebastian Reichel <sre@ring0.de>
Subject: Re: [PATCHv12 00/49] ARM: TI SoC clock DT conversion
Date: Fri, 20 Dec 2013 21:10:48 +0100
Message-ID: <20131220201047.GA12085@earth.universe>
References: <1387557274-22583-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:41039 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751035Ab3LTULJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Dec 2013 15:11:09 -0500
Content-Disposition: inline
In-Reply-To: <1387557274-22583-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 20, 2013 at 06:34:19PM +0200, Tero Kristo wrote:
> Hopefully final post of this series. At least this is going to be the last
> post this year as I will be going to x-mas vacation and won't be back before
> Jan 2nd. This time I just sent the patches that have changes in them,
> the missing ones are exactly the same as in v11.

> Testing done:
> - omap3-beagle: boot, suspend/resume (ret), suspend/resume (off)
> - omap4-panda-es: boot, suspend/resume (ret)
> - omap5-uevm: boot
> - am335x-bone: boot
> - dra7-evm: boot

Booting the 3.13-rc4-dt-clks-v12 branch on my Nokia N900 works:

Tested-By: Sebastian Reichel <sre@debian.org>

-- Sebastian

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCAAGBQJStKRHAAoJENju1/PIO/qaq/wP/1t1Ana5LNcCXdO836HvFRFz
iGOZ7zlOpdgo4OzEc0LFDNHn9gHIk3tlSGA40RfSB5L0sUQ/J55BgxNoeWDkGiEa
VtYd/2xRe+n+BXd6Kq++VSAe19lnPc2UtbyMsWCeWvrHlLOsUpn/v/kE963V2TFG
gxTUxy1jmhawNOgcPEbJt+eyt/7/ptZbj+TFTp32umYiPLP5U4mvt+xlPXXHu+Ap
YlcIzSklUTc7LF76Jq6CQPF/S7D06n8g92U/NqHvdKaBvaFYJfpPwOJdSlF6N0th
nDk9S44zUKnFaBZwIi7SmV9tje/MTKZC2RMa7AqWUF7QOge0lEOLcIzkn+SUMCZa
7Frchi/fHCyBInrHSuvcJK2ZSbXmL1elxnHm8Hofhks0hFVuaD6EzNRog5KMp7W7
RLE/OXu3mShK22TnSNtWklr+fUbDLQQajgkO1+7s3LoGcwVYxQrNswe956ZOVOky
eBfzJCVQz9qhIJNnbxhVMgn9zSMNx05FYLK9F52O+1hB3XmYy9sVglN/3m1eKx0k
D2SfQtCnb/jwKU4wKaPEQPVyEMCiiL+/4p6+I6zyazCTwBsf0SJAfpOl1Lvb2iCG
3RS9VduGTX/jk6UvTeWRnmC+iZAZ/+ERpZOel0o3bCBs3JDk7RVfJHvPRPHnSo67
8c9PNWXd5j6LMM/JJJ8t
=Jr1B
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
