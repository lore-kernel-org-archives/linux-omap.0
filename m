From: David Brownell <david-b@pacbell.net>
Subject: Re: FOR COMMENT: void __iomem * and similar casts are Bad News
Date: Wed, 3 Sep 2008 15:05:59 -0700
Message-ID: <200809031506.00261.david-b@pacbell.net>
References: <20080827220821.GE7227@flint.arm.linux.org.uk> <200809031418.44929.david-b@pacbell.net> <13B9B4C6EF24D648824FF11BE8967162036545FC7D@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:37895 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751140AbYICWGD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2008 18:06:03 -0400
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162036545FC7D@dlee02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

On Wednesday 03 September 2008, Woodruff, Richard wrote:
> > > ... [ big/inexpensive fixed mappings can be virtuous ... ]
> >
> > ... which is exactly why some linux/arch/... code makes sure iorema=
p()
> > can return fixed mappings instead of always requiring dynamic ones.
>=20
> That does sound like a nice consistent way to do it. =A0Which impleme=
ntation
> of this would you recommend looking at? =A0Do any ARMs you know of do=
 it today?=20

I was just calling attention to the possibility.  ISTR seeing
that AVR32 does that, and I think some MIPS hardware has the
same kind of logic.  Not just those, either.

The ARM stuff seems to have changed since last I looked!

In arch/arm/include/asm/io.h there's an __arch_ioremap()
hook; it could be used instead of __arm_ioremap() ... and
it seems <mach/io.h> would define __arch_ioremap().

So at a first glance, OMAPs _could_ define that arch function
to look at the physical address to see if it's covered by a
fixed mapping, then reuse it ... else use __arm_ioremap().

According to Mr. Grep, there are at least 10 ARMs that work
like that in mainline.  Maybe Russell can recommend one of
them as a preferred model.

- Dave



--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
