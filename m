From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP3 L2/outer cache enabled in kernel (after being disabled
	by uBoot)?
Date: Mon, 16 Jan 2012 10:59:49 +0000
Message-ID: <20120116105949.GG16726@n2100.arm.linux.org.uk>
References: <WC20120116100344.4204CC@terrafix.co.uk> <CAMQu2gw4H=m1QA+ucORYsO_LZR8Sj57=+jwmrkHu_7sdCzhN8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:60311 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754146Ab2APK76 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Jan 2012 05:59:58 -0500
Content-Disposition: inline
In-Reply-To: <CAMQu2gw4H=m1QA+ucORYsO_LZR8Sj57=+jwmrkHu_7sdCzhN8g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Joe Woodward <jw@terrafix.co.uk>, linux-omap@vger.kernel.org, linux-arm <linux-arm-kernel@lists.infradead.org>, Catalin Marinas <catalin.marinas@arm.com>

On Mon, Jan 16, 2012 at 11:18:21AM +0100, Shilimkar, Santosh wrote:
> + linux-arm, Russell and Catalin
>=20
> On Mon, Jan 16, 2012 at 11:03 AM, Joe Woodward <jw@terrafix.co.uk> wr=
ote:
> > The latest uBoot release (2011.12) disables the L2/outer cache duri=
ng boot on OMAP boards.
> >
> > uBoot commit: "armv7: disable L2 cache in cleanup_before_linux()" o=
n 6th Dec 2011 by Aneesh V adds the following to
> > uBootSources/arch/arm/cpu/armv7/cpu.c:cleanup_before_linux():
> > =A0...
> > =A0v7_out_cache_disable();
> >
> > The commit message implies this change was to make booting reliable=
 on OMAP4 by disabling L2 cache before jumping to Linux. Sadly
> > this commit also affects OMAP3-based boards...
> >
> > Since switching to uBoot 2011.12 I'm seeing about half the performa=
nce on my GUSMTIX Overo (OMAP3530).
> >
> > In the kernel sources there seem to be OMAP4 specific functions for=
 re-enabling the L2 cache (omap4-common.c:omap_l2_cache_init()),
> > but none for OMAP3.
> >
> > So my question is... do we expect that Linux should be re-enabling =
the L2/outer cache during boot after uBoot has disabled it on OMAP3?
> >
> Yes. Kernel already does enabled L2 on A8 CPU's but OMAP3 needs a
> secure call and then the patching becomes
> that much difficult.
>=20
> We need some kind of generic hook in proc*_setup() function where in
> such secure bits can be turned ON.

You can't have that kind of hook: there is no stack here to call other
functions, plus we aren't running with the MMU on at that point so
only carefully crafted assembly could be used.

Why is it soo difficult to issue the secure call?

This just proves my point that the lack of consistent secure monitor AP=
I
for these kinds of basic service _are_ a big problem, one which ARM Ltd
should have addressed when they invented this stuff.  My view continues
to be that the secure monitor API is a total abortion, one which should
never have been allowed to happen.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
