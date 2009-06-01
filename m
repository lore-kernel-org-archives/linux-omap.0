From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: LDP support
Date: Mon, 1 Jun 2009 10:18:45 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162038DEAB999@dlee02.ent.ti.com>
References: <20090428220712.GF29277@n2100.arm.linux.org.uk>
 <20090428224237.GT22457@atomide.com>
 <20090531212449.GD25140@n2100.arm.linux.org.uk>
 <13B9B4C6EF24D648824FF11BE8967162038DEAB716@dlee02.ent.ti.com>
 <20090601074526.GB10590@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60478 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752267AbZFAPTB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Jun 2009 11:19:01 -0400
In-Reply-To: <20090601074526.GB10590@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Imre Deak <imre.deak@nokia.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>


> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Russell King - ARM Linux
> Sent: Monday, June 01, 2009 2:45 AM

> On Sun, May 31, 2009 at 07:24:19PM -0500, Woodruff, Richard wrote:
> > > 6. do ___NOT___ (underscored in triplicate and 500ft high letters) enable
> > >    ARM errata 460075 - it solidly prevents the kernel booting on LDP.
> > >    (it's taken many hours to debug that.)
> >
> > This is an r2p0 errata only.  It's not in earlier versions or in later cores.
>
> Yes.
>
> > Today there are only r1pX OMAP3s today.  In the future there will be r3px
> > also.
>
> That's something that TI may know, but it's almost impossible for developers
> to know because:
>
> (a) the OMAP3430 TRMs aren't available.

Yes it is publicly available in a few forms. Using google I was just able to find a few references.

For public 3430 look here:
http://focus.ti.com/pdfs/wtbu/SWPU114Q_PrelimFinal_EPDF_03_05_2009.pdf

The 35xx one is out there also (mostly the same) and easier to find.

The public TRM above has the ARM revision/patch version documented in section 3.1.2. The ARM core is r1p3 in OMAP3430-ES3.1 and r1p7 for OMAP3430-ES3.1.1.

Last time I looked in an ID register it seemed ok but I had inside information and may have missed something.

Your use of a run time check seemed good.

Thanks,
Richard W.

