From: =?iso-8859-1?Q?=22Ander=F6=2C_Oskar=22?=
	<Oskar.Andero@sonyericsson.com>
Subject: RE: [PATCH] arm: omap2: enable smc instruction for sleep34xx
Date: Tue, 19 Apr 2011 12:13:26 +0200
Message-ID: <00D61D20F3A8774CBC77798B3FBC427082058F9871@seldmbx02.corpusers.net>
References: <1301581164-26538-1-git-send-email-oskar.andero@sonyericsson.com>
 <00D61D20F3A8774CBC77798B3FBC427082058F986D@seldmbx02.corpusers.net>
 <loom.20110419T100624-335@post.gmane.org> <20110419092014.GA2267@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from usrtrel01.sonyericsson.com ([65.202.203.201]:7234 "EHLO
	usrtrel01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754477Ab1DSKNa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Apr 2011 06:13:30 -0400
In-Reply-To: <20110419092014.GA2267@arm.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Dave Martin' <dave.martin@linaro.org>, Alexander Stevens <alexander.stevens@uqconnect.edu.au>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> > > Ping!
> > >
> > > Anyone else that gets bitten by the following when compiling
> > omap2plus_defconfig with gcc 4.5:
> > > arch/arm/mach-omap2/sleep34xx.S:150: Error: selected processor does
> not
> > support ARM mode `smc #1'
> > >
> > > -Oskar
> > >
> >
> > I can report that I get the exact same compile error as this.
> > OP patch worked beautifully.
> >
> > -Alex
> 
> Can you check what options are being passed to the compiler
> and the assembler, and check for .arch / .arch_extension directives
> in the assembler input?
> 
> i.e.,
> 
> make V=1 CFLAGS_KERNEL='-v -save-temps' arch/arm/mach-omap2/sleep34xx.o
> 
> ...and look at the output and the generated sleep34xx.s
> 
> Maybe the options being passed to the compiler/assembler are wrong
> somewhere along the line.
Yes, the "+sec" extension of armv7-a (i.e. -march=armv7-a+sec) is missing and hence the smc instruction can't be used. This is what my patch fixes. I guess earlier versions of binutils silently ignored this.

It's not visible in my patch, but plus_sec is declared as:
plus_sec := $(call as-instr,.arch_extension sec,+sec)

The following patch added the same extension for some of the other files, but I guess sleep34xx.S was missed or maybe added later:
commit fe297dde5ae8f8bf67d3a87759289a99b48ecb2c
Author: John Rigby <john.rigby@linaro.org>
Date:   Wed Dec 1 05:57:51 2010 +0000

    OMAP4: enable smc instruction in new assembler versions
    
    New assemblers need -march=armv7-a+sec on command line or
    .arch_extension sec inline to enable use of the smc instruction.
<snip>

-Oskar
