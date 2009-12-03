From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH v3 0/4] OMAP: McBSP: Use register cache
Date: Thu, 3 Dec 2009 11:35:37 +0200
Message-ID: <200912031135.37985.peter.ujfalusi@nokia.com>
References: <200912010410.10129.jkrzyszt@tis.icnet.pl> <20091203094905.4c4fec7b.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:23133 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753725AbZLCJgh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 04:36:37 -0500
In-Reply-To: <20091203094905.4c4fec7b.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Jarkko Nikula <jhnikula@gmail.com>
Cc: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello,

On Thursday 03 December 2009 09:49:05 ext Jarkko Nikula wrote:
> On Tue, 1 Dec 2009 04:10:07 +0100
>=20
> Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:
> > Change the way McBSP registers are maintained: store values written=
 to
> > the device in a cache in order to  make use of those cached values =
when
> > convenient.
> >
> > This could help for developing the McBSP context save/restore featu=
res,
> > as well as solve the problem of possible register corruption experi=
enced
> > on OMAP1510 based Amstrad Delta board, at least.
> >
> > Janusz Krzysztofik (4):
> > 	OMAP: McBSP: Use macros for all register read/write operations
> > 	OMAP: McBSP: Prepare register read/write macros API for caching
> > 	OMAP: McBSP: Introduce caching in register write operations
> > 	OMAP: McBSP: Use cache when modifying individual register bits
> >
> >  arch/arm/plat-omap/include/plat/mcbsp.h |    5
> >  arch/arm/plat-omap/mcbsp.c              |  397
> > ++++++++++++++++++++++++--------------------------- 2 files changed=
, 198
> > insertions(+), 204 deletions(-)
>=20
> Looks good to me and audio works fine with the Beagle. One minor
> comment to the patch 3.

Sorry, but I have totally missed the discussion about this in l-o..
It looks good for me as well, the only comment I have is the same as Ja=
rkko for=20
patch 3.
I was about to give it a try, but since Jarkko already tested it on Bea=
gle, I'm=20
OK with this series (with the comment for patch 3).

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
