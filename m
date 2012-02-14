From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] modpost: Fix section warnings for ARM for many
 compilers
Date: Tue, 14 Feb 2012 13:01:43 -0800
Message-ID: <20120214210143.GW1426@atomide.com>
References: <20120213212401.GH1426@atomide.com>
 <20120213222652.GL14173@pengutronix.de>
 <20120213225118.GC31482@n2100.arm.linux.org.uk>
 <878vk6cl5z.fsf@rustcorp.com.au>
 <20120214011228.GM1426@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:15467 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756934Ab2BNVBv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Feb 2012 16:01:51 -0500
Content-Disposition: inline
In-Reply-To: <20120214011228.GM1426@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org, Anders Kaseorg <andersk@ksplice.com>, Greg KH <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>, linux-arm-kernel@lists.infradead.org

* Tony Lindgren <tony@atomide.com> [120213 16:41]:
> * Rusty Russell <rusty@rustcorp.com.au> [120213 16:07]:
> > On Mon, 13 Feb 2012 22:51:18 +0000, Russell King - ARM Linux <linux=
@arm.linux.org.uk> wrote:
> > > On Mon, Feb 13, 2012 at 11:26:52PM +0100, Uwe Kleine-K=C3=B6nig w=
rote:
> > > > On Mon, Feb 13, 2012 at 01:24:01PM -0800, Tony Lindgren wrote:
> > > > Maybe:
> > > >=20
> > > > #ifndef R_ARM_CALL
> > > > #warning "you're elf.h include is outdated"
> > >=20
> > > "You are elf.h include is outdated" does not make sense.
> > >=20
> > > Why are you calling Tony an elf.h include?
> >=20
> > Because he knew it would attract the attention of pedants to the pa=
tch?
> > :)
>=20
> I've been called worse than that :)
> =20
> > Just do the #ifndef, and skip the warning.  There's not much the po=
or
> > user receiving the warning can do about it.
>=20
> OK
> =20
> > Acked-by: Rusty Russell <rusty@rustcorp.com.au>
>=20
> Assuming your ack applies for this patch below, let me know if that's
> not the case. =20

This is now in Russell's patch tracking system as patch 7324/1.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
