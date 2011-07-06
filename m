From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 0/8] OMAP2+: hwmod framework fixes
Date: Wed, 6 Jul 2011 02:02:39 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107060201160.4217@utopia.booyaka.com>
References: <1309553647-14624-1-git-send-email-b-cousson@ti.com> <alpine.DEB.2.00.1107060129420.4217@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-359429710-1309939359=:4217"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48229 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093Ab1GFICk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jul 2011 04:02:40 -0400
In-Reply-To: <alpine.DEB.2.00.1107060129420.4217@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, Benoit Cousson <b-cousson@ti.com>
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-359429710-1309939359=:4217
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 6 Jul 2011, Paul Walmsley wrote:

> On Fri, 1 Jul 2011, Benoit Cousson wrote:
>=20
> > Here are the latest bug fixes done on the hwmod framework.
> > There are mainly around wakeup capability added in OMAP4.
> >=20
> > The series is based on for_3.1/2_prcm_files_cleanup and tested
> > on OMAP4430 ES2.1 + SDP.
> >=20
> > The patches are available here:
> > git://gitorious.org/omap-pm/linux.git for_3.1/3_hwmod_fixes
>=20
> Thanks, these all look good to me.  Tony, maybe you can pull these=20
> straight from Beno=EEt's branch?

Eh, never mind... I just realized that this branch is based on one of=20
his earlier branches.  So if you pull it, you'll get a bunch of other=20
stuff that shouldn't be part of this.

Tony, I'll pick these patches out into a separate topic branch and send a=
=20
new pull request.


- Paul
--155748971-359429710-1309939359=:4217--
