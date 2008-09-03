From: David Brownell <david-b@pacbell.net>
Subject: Re: FOR COMMENT: void __iomem * and similar casts are Bad News
Date: Wed, 3 Sep 2008 14:18:44 -0700
Message-ID: <200809031418.44929.david-b@pacbell.net>
References: <20080827220821.GE7227@flint.arm.linux.org.uk> <20080903193421.GC19980@flint.arm.linux.org.uk> <13B9B4C6EF24D648824FF11BE8967162036545FAD7@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:39890 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752293AbYICVSr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2008 17:18:47 -0400
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162036545FAD7@dlee02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

On Wednesday 03 September 2008, Woodruff, Richard wrote:
> Fixed translations do have some benefits. =A0You can ensure that you
> are using section or super section descriptors to cover large areas.
> This does result in better TLB usage. =A0Along with freeing up TLB
> entries you also generally avoid TLB misses on IO calls which
> touch a variety of internal spaces as part of the IRQ sequence.   =20

=2E.. which is exactly why some linux/arch/... code makes sure ioremap(=
)
can return fixed mappings instead of always requiring dynamic ones.


> Frankly I've never been convinced that a multi OMAP1/2/3 image makes =
much
> sense apart forcing better code structure

Which is actually a pretty big thing.  Along with "structure", it
helps avoid #define collisions ... and also ensures that test
builds can cover increasing fractions of the code base, giving a
big win for maintainability.

Maintainability is a *big thing* ... without it, you ensure that
lots of code will begin bitrotting long before it needs to.


>		 and being kind of cool. =A0Each=20
> chip has very different performance targets and is really better buil=
t with
> an optimized tool chain (ARMv5, ARMv6, ARMv7). =A0Doing multi-boots w=
ith in
> the same architecture family seems really good but across seems less =
so.

True enough, but that decision can be in the hands of whoever
builds a kernel.  If you want to deploy an A8-optimized system,
the kernel will be only one part of the equation.

- Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
