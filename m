From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: [PATCH 3/5] OMAP4: clocks: Update clock tree for ES2
Date: Wed, 22 Sep 2010 12:27:53 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003C21EE417@dbde02.ent.ti.com>
References: <1284641906-24231-1-git-send-email-rnayak@ti.com>
 <1284641906-24231-2-git-send-email-rnayak@ti.com>
 <1284641906-24231-3-git-send-email-rnayak@ti.com>
 <1284641906-24231-4-git-send-email-rnayak@ti.com>
 <alpine.DEB.2.00.1009212300560.21002@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44818 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750765Ab0IVG6B convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Sep 2010 02:58:01 -0400
In-Reply-To: <alpine.DEB.2.00.1009212300560.21002@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

Hi Paul,

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Wednesday, September 22, 2010 10:34 AM
> To: Nayak, Rajendra
> Cc: linux-omap@vger.kernel.org; Cousson, Benoit; Kevin Hilman
> Subject: Re: [PATCH 3/5] OMAP4: clocks: Update clock tree for ES2
>=20
> Hello Rajendra, Beno=EEt,
>=20
> On Thu, 16 Sep 2010, Rajendra Nayak wrote:
>=20
> > This patch updates the clock tree with all the
> > changes in OMAP4430 ES2.
> >
> > clock nodes added
> > -1- tie_low_clock_ck
> > -2- abe_dpll_bypass_clk_mux_ck
> >
> > clock nodes deleted
> > -1- dpll_sys_ref_clk
> > -2- per_sgx_fclk
> > -3- usbphyocp2scp_ick
> >
> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> > Signed-off-by: Beno=C3=AEt Cousson <b-cousson@ti.com>
>=20
> UTF-8 problem again here...
>=20
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Cc: Kevin Hilman <khilman@deeprootsystems.com>
>=20
> The clock tree resulting from this patch doesn't match the output fro=
m
> the current OMAP4 clock autogen script.  Seems like it should.  Could=
 you
> help me understand that?

I guess that's mainly because of fixes in the autogen scripts, the patc=
hes for which=20
have not yet made it to the list.

Regards,
Rajendra
 =20
>=20
>=20
> thanks
>=20
> - Paul
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
