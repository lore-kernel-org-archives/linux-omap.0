From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: [PATCH 1/5] OMAP4: PM: Update PRCM register bitshits and masks
 for ES2
Date: Wed, 22 Sep 2010 12:13:17 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003C21EE40F@dbde02.ent.ti.com>
References: <1284641906-24231-1-git-send-email-rnayak@ti.com>
 <1284641906-24231-2-git-send-email-rnayak@ti.com>
 <alpine.DEB.2.00.1009220014340.21002@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39098 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751919Ab0IVGnY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Sep 2010 02:43:24 -0400
In-Reply-To: <alpine.DEB.2.00.1009220014340.21002@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>



> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Wednesday, September 22, 2010 11:47 AM
> To: Nayak, Rajendra
> Cc: linux-omap@vger.kernel.org; Cousson, Benoit; Kevin Hilman
> Subject: Re: [PATCH 1/5] OMAP4: PM: Update PRCM register bitshits and=
 masks for
> ES2
>=20
> Hi Rajendra
>=20
> On Thu, 16 Sep 2010, Rajendra Nayak wrote:
>=20
> > This patch updates the PRM and CM register bitshifts and masks
> > for OMAP4430 ES2.0.
> >
> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> > Signed-off-by: Beno=C3=AEt Cousson <b-cousson@ti.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Cc: Kevin Hilman <khilman@deeprootsystems.com>
>=20
> Thanks, queued for 2.6.37 (with the UTF-8 fix in the patch descriptio=
n).
>=20
> One other note:
>=20
> >  #define OMAP4430_IDLEST_MASK					BITFIELD(16,
> 17)
>=20
> We should really get rid of all these 'BITFIELD' defines, and just re=
place
> them with simple bitshifts.  Care to spin a patch to do that during t=
he
> 2.6.38 timeframe?

Sure, there's already a patch for this which I guess Benoit should be p=
osting pretty soon.

>=20
>=20
> - Paul
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
