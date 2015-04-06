From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v4 6/6] power: twl4030_madc_battery: Add missing
 MODULE_ALIAS
Date: Mon, 6 Apr 2015 19:45:15 +0200
Message-ID: <20150406174515.GF18145@earth>
References: <1426022847-30912-1-git-send-email-marek@goldelico.com>
 <1426022847-30912-7-git-send-email-marek@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ChQOR20MqfxkMJg9"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40922 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751292AbbDFRpq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 6 Apr 2015 13:45:46 -0400
Content-Disposition: inline
In-Reply-To: <1426022847-30912-7-git-send-email-marek@goldelico.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marek Belisko <marek@goldelico.com>
Cc: bcousson@baylibre.com, tony@atomide.com, dbaryshkov@gmail.com, dwmw2@infradead.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, hns@goldelico.com


--ChQOR20MqfxkMJg9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Tue, Mar 10, 2015 at 10:27:27PM +0100, Marek Belisko wrote:
> Without MODULE_ALIAS twl4030_madc_battery won't get loaded
> automatically.

Thanks, pulled.

-- Sebastian

--ChQOR20MqfxkMJg9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVIsYrAAoJENju1/PIO/qa86cQAIIVO1XGLAFAM+RgIXlRYMpU
ue/SBF4/eW7M3MqLHnAhmZ+BklwE3d5ZXTxZwBjj0RHve6peKE0zLQ7f+Stp6m0E
baJs/fuaiGf0K9d+qTe4XFJdiRCPm1iEH0yR1pbsnoDbGutbdSgj/kyU4fRgBjzP
/14syUpQNIk1/wMYuvRl/j3LhlemVoMpWxHWgjfPnGfzM29gq5Bq73mkgMgqL6Hb
AQTgUvWNcgF9Svc2JtMTl4DkgK2D3vd863277Zk4w9psY7beJ4+qAejUkNvYkwOG
3PtcT0Xqutv0GCYsd3m2tro8X2ivI9bU4lxT3cQXjIi8Pu60VWGTyIoPOcmDkQOe
P+HtpxKoxUFYrna0VE4wsoc81JhzRGp/a8kjaVjEziwDNFd/NRSNk7rh7CTFfq7L
y9ApNf0ASfCQETrZFvZNbslP0Ag1ZeMn/FC5X+bwUm2BDyPnaJJP6fsVmC3iTG7y
EVsgL6PjQnahsifArQpfWY1ZKquYHwdu6RbPvsLrMxqJPr/FXJGmXfRmJ52l9+qc
LmgWd4VYD3z59p5Omb66seJNx8I64gl1chzDf3iyAo60tABxtEpKiq+30thGMyTL
7cwe6yTY5ZUDVqWK/KFLcbD9ESebF1Hl3R0FwmCjVhEOJurnEsW7KudMleW510Pe
U8lqgxPhbDUiu3WgV0C3
=9D7f
-----END PGP SIGNATURE-----

--ChQOR20MqfxkMJg9--
