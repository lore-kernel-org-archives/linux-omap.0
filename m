From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP3: clockdomain: fix accidental duplicate
 registration
Date: Mon, 16 Jul 2012 01:36:09 -0700
Message-ID: <20120716083609.GG6522@atomide.com>
References: <alpine.DEB.2.00.1207120448120.25585@utopia.booyaka.com>
 <87394wg97u.fsf@ti.com>
 <20120713064713.GI1122@atomide.com>
 <20120714085257.GB6522@atomide.com>
 <alpine.DEB.2.00.1207141150340.3876@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:20010 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752421Ab2GPIgO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Jul 2012 04:36:14 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1207141150340.3876@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>, Joe Woodward <jw@terrafix.co.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [120714 10:59]:
> On Sat, 14 Jul 2012, Tony Lindgren wrote:
>=20
> > The patch seems to produce a new warning against arm soc tree=20
> > next/cleanup branch:
> >=20
> > warning: =E2=80=98mpu_3xxx_clkdm=E2=80=99 defined but not used
> >=20
> > Paul, care to check if a change is needed for the arm soc tree
> > next/cleanup branch version of this patch?
>=20
> arm-soc next/cleanup branch doesn't include commit 16e5e2c4 ("ARM: OM=
AP=20
> AM35x: clockdomain data: Fix clockdomain dependencies").  So that pat=
ch=20
> won't apply there, and the copy of mach-omap2/clockdomains3xxx_data.c=
 in=20
> that branch is clean.

Hmm well it seems that we should apply this fix into arm-soc next/clean=
up
branch if that's where the mismerge happened? It seems the same mismerg=
e
is there even without 16e5e2c4?

You patch applies into arm-soc next/cleanup with fuzz:

patching file arch/arm/mach-omap2/clockdomain.c
patching file arch/arm/mach-omap2/clockdomain.h
Hunk #1 succeeded at 82 (offset -4 lines).
patching file arch/arm/mach-omap2/clockdomains3xxx_data.c
Hunk #1 succeeded at 347 with fuzz 2 (offset -107 lines).

So that's why I'm wondering if it needs some changes.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
