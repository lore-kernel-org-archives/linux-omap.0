From: =?iso-8859-1?Q?S=F8ren_Steen_Christensen?=
	<sorenschristensen@stofanet.dk>
Subject: RE: GPMC address signals gpmc_a11 to gpmc_a26
Date: Wed, 25 Feb 2009 19:46:05 +0100
Message-ID: <002501c99779$50d1bf10$f2753d30$@dk>
References: <8DB4EBB8-F339-43DC-B7EF-208CB77BC8A3@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx02.stofanet.dk ([212.10.10.12]:37258 "EHLO mx02.stofanet.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754158AbZBYTGA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Feb 2009 14:06:00 -0500
In-Reply-To: <8DB4EBB8-F339-43DC-B7EF-208CB77BC8A3@mac.com>
Content-Language: da
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Elvis Dowson' <elvis.dowson@mac.com>, 'Linux OMAP Users' <linux-omap@vger.kernel.org>
Cc: =?iso-8859-1?Q?'S=F8ren_Steen_Christensen'?= <sorenschristensen@stofanet.dk>

> Hi,
> 	Can someone tell me why gpmc_a11 to gpmc_a26 signals are
> missing from
> initial pages for the CBB package specification, in the OMAP3515/03
> Applications Processor document (Rev. C)?
>=20
> If you go down to page 91 of the same document, it lists gpmc_a11 to
> gpmc_a26.
>=20
> Are the address lines multiplexed somehow for the TI OMAP GPMC,
> because if you look at the following table, the pin numbers are the
> same for a couple of them, e.g AC16 for gpmc_a3, gpmc_a19. I can't
> seem to find a pattern here.
>=20
> Best regards,
>=20
> Elvis


Hi Elvis,

The GPMC is an address/data-multiplexed bus sharing the lower 16 addres=
s
lines between address and data.
I admit, that the naming in the Datasheet might be a bit misleading, bu=
t the
way it should be read is like:

GPMC_dxx is the 16 data lines for data

GPMC_dxx is the lower 16 address lines for address
GPMC_a1 is address line 17
GPMC_a2 address line 18
GPMC_a3 address line 19 - and so forth

This as well explains why you though that address lines 3 and 19 could =
be
multiplexed :-)

Best regards
  S=F8ren


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
