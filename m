From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: Guidelines to move mach-omap2/gpmc to drivers/memory-controller
Date: Tue, 19 Feb 2013 21:36:12 -0300
Message-ID: <20130220003611.GA4688@myrna.SFIH.local>
References: <20130215165840.GB2442@localhost>
 <alpine.DEB.2.00.1302151952410.19565@utopia.booyaka.com>
 <511E95A8.2090709@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:45601 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932809Ab3BTAef (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Feb 2013 19:34:35 -0500
Content-Disposition: inline
In-Reply-To: <511E95A8.2090709@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org

Hi Jon,

On Fri, Feb 15, 2013 at 02:08:08PM -0600, Jon Hunter wrote:
>=20
> On 02/15/2013 01:53 PM, Paul Walmsley wrote:
> > Hi,
> >=20
> > On Fri, 15 Feb 2013, Ezequiel Garcia wrote:
> >=20
> >> I imagine one of the biggest issues is GPMC's dependency on
> >> hwmod code. Can anyone shed some light on how to handle this?
> >=20
> > What dependency is this?  I'm not aware of any GPMC dependency to h=
wmod;=20
> > there shouldn't be any.
>=20
> If Ezequiel is referring to the code in omap_gpmc_init() that is look=
ing
> up the hwmod struct for gpmc, then this not a dependency. This functi=
on
> should remain in mach-omap2/gpmc.c and not be moved into drivers/.

Yes, I was referring to that code.

> Eventually once we have migrated to DT, this function will be removed
> altogether.
>

Mmm, I see. So I might try to move GPMC and friends to drivers/memory
keeping the hwmod code inside mach-omap2.

I already did a few tests and I **think** that with a little luck=20
we can have a not-so-intrusive patch that moves GPMC.

@Jon: Do you think it's worth the effort?=20

--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
