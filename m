From: Dave Martin <dave.martin@linaro.org>
Subject: Re: [PATCH] arm: omap2: enable smc instruction for sleep34xx
Date: Tue, 19 Apr 2011 11:28:52 +0100
Message-ID: <20110419102852.GA30588@arm.com>
References: <1301581164-26538-1-git-send-email-oskar.andero@sonyericsson.com>
 <00D61D20F3A8774CBC77798B3FBC427082058F986D@seldmbx02.corpusers.net>
 <loom.20110419T100624-335@post.gmane.org>
 <20110419092014.GA2267@arm.com>
 <00D61D20F3A8774CBC77798B3FBC427082058F9871@seldmbx02.corpusers.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38844 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753637Ab1DSK3D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Apr 2011 06:29:03 -0400
Received: by wya21 with SMTP id 21so4674095wya.19
        for <linux-omap@vger.kernel.org>; Tue, 19 Apr 2011 03:29:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <00D61D20F3A8774CBC77798B3FBC427082058F9871@seldmbx02.corpusers.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?iso-8859-1?Q?Ander=F6=2C?= Oskar <Oskar.Andero@sonyericsson.com>
Cc: Alexander Stevens <alexander.stevens@uqconnect.edu.au>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Apr 19, 2011 at 12:13:26PM +0200, "Ander=F6, Oskar" wrote:
> > > > Ping!
> > > >
> > > > Anyone else that gets bitten by the following when compiling
> > > omap2plus_defconfig with gcc 4.5:
> > > > arch/arm/mach-omap2/sleep34xx.S:150: Error: selected processor =
does
> > not
> > > support ARM mode `smc #1'
> > > >
> > > > -Oskar
> > > >
> > >
> > > I can report that I get the exact same compile error as this.
> > > OP patch worked beautifully.
> > >
> > > -Alex
> >=20
> > Can you check what options are being passed to the compiler
> > and the assembler, and check for .arch / .arch_extension directives
> > in the assembler input?
> >=20
> > i.e.,
> >=20
> > make V=3D1 CFLAGS_KERNEL=3D'-v -save-temps' arch/arm/mach-omap2/sle=
ep34xx.o
> >=20
> > ...and look at the output and the generated sleep34xx.s
> >=20
> > Maybe the options being passed to the compiler/assembler are wrong
> > somewhere along the line.
> Yes, the "+sec" extension of armv7-a (i.e. -march=3Darmv7-a+sec) is m=
issing and hence the smc instruction can't be used. This is what my pat=
ch fixes. I guess earlier versions of binutils silently ignored this.
>=20
> It's not visible in my patch, but plus_sec is declared as:
> plus_sec :=3D $(call as-instr,.arch_extension sec,+sec)

Ah right, I was slightly confused by the context.

You're right -- sleep34xx.S also needs this change in the Makefile,
as per your patch.  This isn't new; the original patch focused on
omap4, so I guess this file was just missed.

Cheers
---Dave

>=20
> The following patch added the same extension for some of the other fi=
les, but I guess sleep34xx.S was missed or maybe added later:
> commit fe297dde5ae8f8bf67d3a87759289a99b48ecb2c
> Author: John Rigby <john.rigby@linaro.org>
> Date:   Wed Dec 1 05:57:51 2010 +0000
>=20
>     OMAP4: enable smc instruction in new assembler versions
>    =20
>     New assemblers need -march=3Darmv7-a+sec on command line or
>     .arch_extension sec inline to enable use of the smc instruction.
> <snip>
>=20
> -Oskar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
