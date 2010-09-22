From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 3/5] OMAP4: clocks: Update clock tree for ES2
Date: Wed, 22 Sep 2010 01:15:52 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1009220113480.21002@utopia.booyaka.com>
References: <1284641906-24231-1-git-send-email-rnayak@ti.com> <1284641906-24231-2-git-send-email-rnayak@ti.com> <1284641906-24231-3-git-send-email-rnayak@ti.com> <1284641906-24231-4-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1009212300560.21002@utopia.booyaka.com>
 <0680EC522D0CC943BC586913CF3768C003C21EE417@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-764810600-1285139752=:21002"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58861 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113Ab0IVHPx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Sep 2010 03:15:53 -0400
In-Reply-To: <0680EC522D0CC943BC586913CF3768C003C21EE417@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-764810600-1285139752=:21002
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Rajendra,

On Wed, 22 Sep 2010, Nayak, Rajendra wrote:

> > -----Original Message-----
> > From: Paul Walmsley [mailto:paul@pwsan.com]
> > Sent: Wednesday, September 22, 2010 10:34 AM
> >=20
> > The clock tree resulting from this patch doesn't match the output from
> > the current OMAP4 clock autogen script.  Seems like it should.  Could y=
ou
> > help me understand that?
>=20
> I guess that's mainly because of fixes in the autogen scripts, the patche=
s for which=20
> have not yet made it to the list.

OK, thanks, I think I see what's going on.  Patch queued for 2.6.37, but=20
hopefully you and Beno=EEt can review the final set of OMAP4 clock patches,=
=20
since I had to resolve conflicts by hand.  Also it is very important to=20
make sure that what we've got in the mainline tree matches exactly what is=
=20
coming out of the autogenerator...


- Paul
--155748971-764810600-1285139752=:21002--
