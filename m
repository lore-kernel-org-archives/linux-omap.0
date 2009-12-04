From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/4 v4] OMAP: McBSP: Introduce caching in register
 write operations
Date: Fri, 4 Dec 2009 11:17:45 -0800
Message-ID: <20091204191745.GH24013@atomide.com>
References: <200912010410.10129.jkrzyszt@tis.icnet.pl>
 <200912031330.43464.jkrzyszt@tis.icnet.pl>
 <20091203200301.GB4348@atomide.com>
 <200912040018.02309.jkrzyszt@tis.icnet.pl>
 <4B19074B.1000606@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:49963 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757036AbZLDTRo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Dec 2009 14:17:44 -0500
Content-Disposition: inline
In-Reply-To: <4B19074B.1000606@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Jarkko Nikula <jhnikula@gmail.com>, linux-omap@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [091204 04:56]:
> Janusz Krzysztofik napisa=C5=82(a):

<snip>
=20
> I think I've already found one part of the answer myself: you
> probably mean putting each table definition in a corresponding
> arch/arm/mach-omap[12]/mcbsp.c source file, don't you?

Well I did not initially, but sounds like that's the cleanest
way to go.
=20
> What remains unclear for me is if you really intend to reserve
> static cache space for all McBSP ports supported by a machine, even
> if not supported by a particular cpu or not used on a particular
> board.

No idea :) But please consider what happens if we want to compile in
omap2 + omap3 into a single binary. Or what happens if some newer omaps
add more McBSP registers.

<snip>
=20
> >
> >Did you mean defining a new omap_mcbsp_read_cache() function,
> >similiar to omap_mcbsp_read(), but reading from cache instead of
> >hardware?

Yeah something like that. That is more future proof.

> >Or do you prefere if I modify omap_mcbsp_read() to be able to read
> >from both hardware and cache, dependig on an additional argument,
> >for example?

That actually sounds like the best way to solve it to me!

> But shouldn't declarations for both tables be placed in
> arch/arm/plat-omap/include/plat/mcbsp.h withing an ifdef else block?
> If yes, one ifdef else block would be replaced with another. Or did
> you mean placing those declarations inside existing ifdef block with
> defines for register offsets?

Ifdefs are OK if they just optimize out code when some omap is not
compiled in. But if you do ifdef else, then it means trouble sooner
or later. In this case you should probably have the cache initialized
separately in mach-omap1/mcbsp.c and mach-omap2/mcbsp.c.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
