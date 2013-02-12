From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: RE: [PATCH] ARM: OMAP: Clock: Remove CK_* flags
Date: Tue, 12 Feb 2013 10:22:20 +0000
Message-ID: <DC88CAD03C0052499C1907B327FC63229B98DD@DBDE01.ent.ti.com>
References: <1359966525-7603-1-git-send-email-j-keerthy@ti.com>
 <alpine.DEB.2.00.1302080248550.8539@utopia.booyaka.com>
 <DC88CAD03C0052499C1907B327FC63229B92FF@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1302081805450.28008@utopia.booyaka.com>
 <alpine.DEB.2.00.1302081855370.28008@utopia.booyaka.com>
  <DC88CAD03C0052499C1907B327FC63229B966E@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1302111538430.8260@utopia.booyaka.com>
 <DC88CAD03C0052499C1907B327FC63229B989B@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1302120638580.14983@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59690 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755459Ab3BLKWb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Feb 2013 05:22:31 -0500
In-Reply-To: <alpine.DEB.2.00.1302120638580.14983@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Paul,

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Tuesday, February 12, 2013 12:09 PM
> To: J, KEERTHY
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: RE: [PATCH] ARM: OMAP: Clock: Remove CK_* flags
>=20
> On Tue, 12 Feb 2013, J, KEERTHY wrote:
>=20
> > > -----Original Message-----
> > > From: Paul Walmsley [mailto:paul@pwsan.com]
> > > Sent: Monday, February 11, 2013 9:10 PM
> > > To: J, KEERTHY
> > > Cc: linux-omap@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org
> > > Subject: RE: [PATCH] ARM: OMAP: Clock: Remove CK_* flags
> > >
> > > On Mon, 11 Feb 2013, J, KEERTHY wrote:
> > >
> > > > Can I pull the other patches and rebase this patch on top of
> them?
> > > > I need the branch where I can pull the other clock related
> patches.
> > > > I will rebase this patch on top, Verify the PM suspend on
> OMAP4460
> > > > And post it.
> > >
> > > It's based on Tony's omap-for-v3.9/pm branch.
> > >
> >
> > I am on the above branch. I am not seeing retention with/without th=
e
> patch.
>=20
> Sounds like you get to do some bisecting :-)
>=20

Heh :-). It narrowed down to this patch:

commit 17b7e7d33530e2bbd3bdc90f4db09b91cfdde2bb
Author: Paul Walmsley <paul@pwsan.com>
Date:   Sat Jan 26 00:48:54 2013 -0700

    ARM: OMAP4: clock/hwmod data: start to remove some IP block control=
 "clocks"
   =20
    Remove some leaf "clocks" that are actually IP block idle control
    points, since these should now be handled by the hwmod code.
   =20
    There are still a few types of MODULEMODE clocks that need to be
    cleaned up:
   =20
    - those still in use by driver or integration code
   =20
    - those in DEFINE_CLK_OMAP_MUX_GATE() blocks; the gate portion of
      these should be removed
   =20
    A similar process may also be possible on OMAP2/3.
   =20
    Signed-off-by: Paul Walmsley <paul@pwsan.com>
    Cc: Beno=EEt Cousson <b-cousson@ti.com>
    Cc: Mike Turquette <mturquette@linaro.org>

>=20
> - Paul

Regards,
Keerthy
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
