From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: Re: runtime check for omap-aes bus access permission (was: Re:
 3.13-rc3 (commit 7ce93f3) breaks Nokia N900 DT boot)
Date: Sat, 31 Jan 2015 15:38:28 +0100
Message-ID: <CAALWOA92XmRoJwg5vcL+bLQU-O+6Guxgq4cq+76kYRbLOL+i6Q@mail.gmail.com>
References: <20131206213613.GA19648@earth.universe> <20131207230305.GA9103@earth.universe>
 <20131207232205.GS26766@atomide.com> <201501241140.34479@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:35095 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751950AbbAaOiu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 31 Jan 2015 09:38:50 -0500
Received: by mail-wi0-f174.google.com with SMTP id n3so8520630wiv.1
        for <linux-omap@vger.kernel.org>; Sat, 31 Jan 2015 06:38:49 -0800 (PST)
In-Reply-To: <201501241140.34479@pali>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Joel Fernandes <joelf@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@ring0.de>

On Sunday 08 December 2013 00:22:06 Tony Lindgren wrote:
> * Sebastian Reichel <sre@ring0.de> [131207 15:04]:
> > On Sat, Dec 07, 2013 at 01:11:37PM -0800, Tony Lindgren wrote:
> > > > I asked Pali to send me his copy of the updated NOLO
> > > > bootloader, so that I can test this. I just checked the
> > > > omap documentation (I only have access to the public
> > > > one) and crypto related stuff is not documented for the
> > > > L3_PM_READ_PERMISSION register. There are a couple of
> > > > reserved bits, which may be used for this, though.
> > > >
> > > > I also CC'd Joel Fernandes, since he worked on the
> > > > driver before and may have access to the documentation.
> > >
> > > Looks like at least the 36xx public version referenced
> > > here has them:
> > >
> > > http://www.spinics.net/lists/linux-omap/msg21857.html
> > >
> > > I'd assume the registers are the same for 34xx since we
> > > don't have them defined separately in the kernel.
> >
> > I can't find it in the omap36xx documentation either. Maybe
> > I search at the wrong position.

I've checked a few of the oldest (in case it was later removed) and
newest (in case it was later added) omap3-series public TRMs I have,
none of them list the aes module or associated interconnect info. The
region is either "reserved" or just silently skipped over. The
practice of pretending something doesn't exist in the TRM while
simultaneously releasing a linux driver continues to puzzle me.

> > I tried to find something crypto related in
> >
> > Table 9-89. L3_PM_READ_PERMISSION_i
>
> Hmm maybe it's done based on the address in
> L3_PM_ADDR_MATCH_k?

According to the address (aes@480c5000) it's attached to the L4-Core
interconnect, so why would an L3 firewall be involved?  Its access
control would be configured in the L4-Core AP (2KB @ 0x48040000), and
since they have an integrated memory map you'd automatically know
which entry is responsible, assuming you can access the AP at all.
