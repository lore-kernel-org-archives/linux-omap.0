From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] spi: omap2-mcspi: In case of dma errors fall back to pio
Date: Tue, 7 Aug 2012 15:21:26 +0300
Message-ID: <20120807122125.GY8468@arwen.pp.htv.fi>
References: <1343197229-15188-1-git-send-email-shubhrajyoti@ti.com>
 <20120807074740.GR11011@atomide.com>
 <5020FA2C.2020707@ti.com>
 <20120807120227.GA11011@atomide.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rmLdANEyqdgxlbgR"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:50093 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751690Ab2HGMZB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Aug 2012 08:25:01 -0400
Received: by lboi8 with SMTP id i8so67630lbo.33
        for <linux-omap@vger.kernel.org>; Tue, 07 Aug 2012 05:24:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120807120227.GA11011@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Shubhrajyoti <shubhrajyoti@ti.com>, spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org


--rmLdANEyqdgxlbgR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 07, 2012 at 05:02:27AM -0700, Tony Lindgren wrote:
> * Shubhrajyoti <shubhrajyoti@ti.com> [120807 04:21]:
> > On Tuesday 07 August 2012 01:17 PM, Tony Lindgren wrote:
> > >>  };
> > > Don't you need to check separately for rx and tx dma? There's a slight
> > > chance that you get a channel for one but not for the other..
> > In that case I treat it as non usable and fall back to pio.
>=20
> OK that should work too.
> =20
> > Are you suggesting that let one channel be dma and only the failed one =
pio?
>=20
> I guess both are doable. For reduced CPU load using DMA where possible
> of course is the best way to go.

indeed. if you can get DMA for TX but not for RX, then at least TX can
go via DMA ;-)

--=20
balbi

--rmLdANEyqdgxlbgR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQIQhFAAoJEIaOsuA1yqRE4zQP/2vYamY7tzdA8q5oSdbs2KZy
GHXKOobLMBVB18EnKyL4oSJy69q5kDkdDPpldknLoFzoTh7+ihuyMzUmtU1CY5th
ML7tYMgb1/PS4oxBctg3SGr3ZnsINp8q0Iv4p8QQuQPdqP5hp2WZJAiaaTwTFvAN
aX1OSeKsd1cr7WSW37Jb4/c3vWa4zoiLzoTNpxePXKlc6ahQ1/JZqZf7WQK3WW10
smh6bMR362P+BEV0LmNmEBDmrM3j7wSInwCieGlSn5mm7a0sADKVTWjhvKS2xlv1
/6KlPaH1LgPNPNj10tMFJgsY2tyRjDyXUI76pQiUtz2kmvC3jAGn6ASaOZxSr6f9
pDZJnSp1qC8HSzK0R5j3Hu9zuy9xIKeZnRE105r91kidpsmmjshzBwiAIpp+DOPS
27hVw5/MzoNs2Y2k+AFwzncUi8eKjQCZsU6Bun30NP8q6PoHhHLZ8gVGTPtPi3pn
z+aeWAttbQqIUlvBGvWvVDr/8PrGI6L0dSuqifpcoJxnSiWCQoMnZmj9Yr99xhJx
cSX44rJiTXCNwpxsPkyiNnvv7L7JbQKkVdV+LvaW78lDAfz2SkIUnxlHrnHCEz1/
+Ugl9AD0nVhbLkg2s9LeVp1p83PZ1uudCuvP1XvjLvLgqOz5MxAYlj6y0EMfEZ8i
dAt0NOOXy/pigCP01w2J
=TGT8
-----END PGP SIGNATURE-----

--rmLdANEyqdgxlbgR--
