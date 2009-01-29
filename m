From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/9] ARM: Do early I/O mapping if spinlock debugging is
	enabled
Date: Thu, 29 Jan 2009 08:52:38 -0800
Message-ID: <20090129165232.GH32148@atomide.com>
References: <20090128181931.21007.73744.stgit@localhost> <20090128182305.21007.62781.stgit@localhost> <20090128185355.GC23301@n2100.arm.linux.org.uk> <200901281551.52060.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:60921 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754264AbZA2Qwt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Jan 2009 11:52:49 -0500
Content-Disposition: inline
In-Reply-To: <200901281551.52060.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk, Juha Yrjola <juha.yrjola@solidboot.com>, linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [090128 15:51]:
> On Wednesday 28 January 2009, Russell King - ARM Linux wrote:
> > >=20
> > > At least on OMAP, sched_clock() requires the I/O maps to be initi=
alized.
> > > Spinlock debugging invokes sched_clock() very early.
> >=20
> > NAK. =A0This doesn't and can't work on every platform out there. =A0=
The
> > only viable fix is that sched_clock() must NOT be used early.
> >=20
> > If the kernel is using sched_clock() early, that's a bug.
>=20
> So you're saying that spinlock debugging is buggy???

It used to be that CONFIG_PRINTK_TIME had a similar issue..
Anyways, dropping this patch from omap-fixes, sounds like
how to fix it needs to get sorted out on LKML.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
