From: Tony Lindgren <tony@atomide.com>
Subject: Re: FOR COMMENT: void __iomem * and similar casts are Bad News
Date: Tue, 2 Sep 2008 15:15:10 -0700
Message-ID: <20080902221501.GD23085@atomide.com>
References: <20080827220821.GE7227@flint.arm.linux.org.uk> <200808311447.20312.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:57426 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754735AbYIBWPY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Sep 2008 18:15:24 -0400
Content-Disposition: inline
In-Reply-To: <200808311447.20312.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-omap@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>

Hi,

* David Brownell <david-b@pacbell.net> [080831 14:47]:
> On Wednesday 27 August 2008, Russell King wrote:
> > I sent a similar patch to the one below against mainline to Tony to=
day.
>=20
> And I'm glad to see those updates.  I used to constantly trip over
> code doing strange stuff in those areas, and it would be nice to
> see "sparse" approve a lot more driver code...

Back online now. These changes look ggood to me in general, except
I suggest that we use the following standard:

- Keep OMAP1_IO_ADDRESS() and OMAP2_IO_ADDRESS() as I have some
  experimental patches to compile in both omap1 and omap2 into the
  same binary. Booting the kernel currently still requires some
  Makefile.boot patching, but at least compiling everything in makes
  things easier to maintain in the long run.

- Use io_p2v() for initializing dynamic stuff as it can be a function
  for non-optimized multiboot binaries.

>=20
> > I've marked some changes with certain tags:
> >=20
> > - FIXME: where I think the code is just plain wrong -
> > =A0 - such as putting a physical address through a macro which conv=
erts
> > =A0 =A0 virtual to physical addresses (1510 and 1610 mcbsp).
> > =A0 - or passing virtual addresses to DMA functions (mcbsp).
> > =A0 - or passing physical addresses when what's required is a virtu=
al address
> > =A0 =A0 (omap_udc).
>=20
> Yeah, the omap_udc one looks like the __REG() conversion patch
> just did the wrong thing.  Fix looks trivial, and once I verify
> it then I'll send it through mainline.
>=20
>=20
> > - CHECKME: where I've changed something to make it build but I don'=
t
> > =A0 know if this is right.
> >=20
> > - WBNI: more a preference to see something changed than a bug.
> >=20
> > Comments on the FIXMEs are what I'm really interested in, and prefe=
rably
> > having them actually fixed would be a good idea.
>=20
> I verified that the OMAP tree boots on my OMAP5912 OSK, at least
> once things like cpufreq, PM, and MTD are disabled.  The MTD thing
> is a known/solved issue in mainline.  (Block queue changes broke
> MTD...)  The oopses in cpufreq and pm_idle are more cryptic.
>=20
> So I can try my patch for the omap_udc thing ... even though for
> OSK the mainline kernel ** DOES NOT BOOT ** and dies even before
> the kernel "hello, I'm RC5!" banner prints.  Someone with a JTAG
> to throw at this might be able to fix that regression quickly.

I'll take a look at the OSK boot problem unless somebody else is
already working on it.

Looks like the FIXME mcbsp phys vs virt addresses are wrong for some
board-*.c files. Eduardo, can you please take a look at them?

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
