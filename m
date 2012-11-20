From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 270/493] arm: remove use of __devinit
Date: Tue, 20 Nov 2012 15:47:17 +0900
Message-ID: <20121120064715.GO10560@opensource.wolfsonmicro.com>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-270-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GPOl6LAGMgeiWDic"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:43168 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751379Ab2KTGr3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Nov 2012 01:47:29 -0500
Content-Disposition: inline
In-Reply-To: <1353349642-3677-270-git-send-email-wfp5p@virginia.edu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bill Pemberton <wfp5p@virginia.edu>
Cc: gregkh@linuxfoundation.org, Kevin Hilman <khilman@ti.com>, Andrew Lunn <andrew@lunn.ch>, Kukjin Kim <kgene.kim@samsung.com>, Eric Miao <eric.y.miao@gmail.com>, Jason Cooper <jason@lakedaemon.net>, Tony Lindgren <tony@atomide.com>, linux-arm-msm@vger.kernel.org, Barry Song <baohua.song@csr.com>, Will Deacon <will.deacon@arm.com>, patches@opensource.wolfsonmicro.com, Haojian Zhuang <haojian.zhuang@gmail.com>, Bryan Huntsman <bryanh@codeaurora.org>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>, Daniel Walker <dwalker@fifo99.com>, linux-tegra@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, David Brown <davidb@codeaurora.org>, linux-omap@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>


--GPOl6LAGMgeiWDic
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 19, 2012 at 01:23:39PM -0500, Bill Pemberton wrote:
> CONFIG_HOTPLUG is going away as an option so __devinit is no longer
> needed.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

--GPOl6LAGMgeiWDic
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQqydpAAoJELSic+t+oim9QBgP/2b6jLtJBDcETxaH6p8Y6gXt
5LeY06fU1ozPrjqWYNIoXmWT/eU4BMRY/twzLVutZn4dpufzHJHoCWHxtZENYgeq
V6j42H6RtaUIG+9lZlQ2bG8u9a3lADzaIDymLX1braws11Osw442DC7C2hrAQ1Zy
EYjOsPEfjehC7L5sG95Th0DoezMZobsIkfom0TwcdvUwMWTgZQtEscmo24e+YlqI
jYbyxgz1ew2ibhI/WxwOOvrGvHe30dn32YuWCiW6u7GmQT4k4LS3ZJE6w2OPeMWs
hKQ3uWrN36Zd1WYOI/ngpol8k2N9vcOmLolXxNFMtI7dHeJyLB1Cao8VPwgqcI1b
UIc98+WQh+Vx+eu4bBf+spXEyX177TWQeAHhVxyg7GXHKYmgsNMWIvtQmLzygHPB
ldL4KWbdzTq3MehPkFawkFA/k5sPMpD5N/CT8czHAt/gAiUz39JfUgs2Kx7lTPYU
e5XvjPf6MmJJekkgkQ8pXBm2D78zbUOfadEop6xS/xvb+NJ/Vg63VrnkmB3TKBTJ
M0Nuq0hR8GZdlR4BS+Rd++s7+8tv/4P51hzhtxolLjPoDIMl6rznp/eLTh3fMEtM
zREq8bELlv7ZDEC5MNEpWi70r94lFfSKLU3AJmVleFkn+o5LazF4XgqfXUncIVEc
HXFTmx4dWjijsqq9406q
=ysdL
-----END PGP SIGNATURE-----

--GPOl6LAGMgeiWDic--
