From: Paul Walmsley <paul@pwsan.com>
Subject: Re: The current clock44xx_data.c, after applying recent patches
Date: Wed, 22 Sep 2010 09:35:28 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1009220934230.21002@utopia.booyaka.com>
References: <alpine.DEB.2.00.1009220130550.21002@utopia.booyaka.com> <4C9A21A5.4040905@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-961466876-1285169728=:21002"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36452 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755182Ab0IVPf3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Sep 2010 11:35:29 -0400
In-Reply-To: <4C9A21A5.4040905@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-961466876-1285169728=:21002
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 22 Sep 2010, Cousson, Benoit wrote:

> On 9/22/2010 9:33 AM, Paul Walmsley wrote:
> >=20
> > Hi Beno=EEt, Rajendra,
> >=20
> > Here's the clock44xx_data.c that I ended up with, after applying the
> > recent patches.  It seems to compare well with the autogenerator output=
,
> > but maybe you might find some important diffs.
>=20
> I checked the diff with the autogen, and found 2 new issues due to some
> changes introduce in ES2. I had to fix the script to handle these tricky
> cases.
>=20
> There is one conflict with the USIM optional clock module that is named
> usim_fclk which is also the name of its parent clock :-(
>=20
> The other one is due to the module that generate the USB PHY clock.
> They changed the position of the clock node register from the ocp2scp to =
the
> cm_always_on module. I fixed that as well.
>=20
> None of these clock nodes are used today, because the USB is still not hw=
mod
> adapted.
>=20
> I'll send you the fix right now.

Excellent, thanks Beno=EEt.


- Paul
--155748971-961466876-1285169728=:21002--
