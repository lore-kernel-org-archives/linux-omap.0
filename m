From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: [PATCH 3/5] OMAP4: clocks: Update clock tree for ES2
Date: Wed, 22 Sep 2010 12:52:30 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003C21EE42A@dbde02.ent.ti.com>
References: <1284641906-24231-1-git-send-email-rnayak@ti.com>
 <1284641906-24231-2-git-send-email-rnayak@ti.com>
 <1284641906-24231-3-git-send-email-rnayak@ti.com>
 <1284641906-24231-4-git-send-email-rnayak@ti.com>
 <alpine.DEB.2.00.1009212300560.21002@utopia.booyaka.com>
 <0680EC522D0CC943BC586913CF3768C003C21EE417@dbde02.ent.ti.com>
 <alpine.DEB.2.00.1009220113480.21002@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34643 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113Ab0IVHWh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Sep 2010 03:22:37 -0400
In-Reply-To: <alpine.DEB.2.00.1009220113480.21002@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

Hi Paul,

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Wednesday, September 22, 2010 12:46 PM
> To: Nayak, Rajendra
> Cc: linux-omap@vger.kernel.org; Cousson, Benoit; Kevin Hilman
> Subject: RE: [PATCH 3/5] OMAP4: clocks: Update clock tree for ES2
>=20
> Hi Rajendra,
>=20
> On Wed, 22 Sep 2010, Nayak, Rajendra wrote:
>=20
> > > -----Original Message-----
> > > From: Paul Walmsley [mailto:paul@pwsan.com]
> > > Sent: Wednesday, September 22, 2010 10:34 AM
> > >
> > > The clock tree resulting from this patch doesn't match the output=
 from
> > > the current OMAP4 clock autogen script.  Seems like it should.  C=
ould you
> > > help me understand that?
> >
> > I guess that's mainly because of fixes in the autogen scripts, the =
patches for which
> > have not yet made it to the list.
>=20
> OK, thanks, I think I see what's going on.  Patch queued for 2.6.37, =
but
> hopefully you and Beno=EEt can review the final set of OMAP4 clock pa=
tches,
> since I had to resolve conflicts by hand.  Also it is very important =
to
> make sure that what we've got in the mainline tree matches exactly wh=
at is
> coming out of the autogenerator...

I agree, we'll get the scripts and the header in sync very soon by post=
ing most of the
pending fixes.

Regards,
Rajendra
=20
>=20
>=20
> - Paul
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
