From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] modpost: Fix section warnings for ARM for many compilers
Date: Tue, 14 Feb 2012 10:59:12 +1030
Message-ID: <878vk6cl5z.fsf@rustcorp.com.au>
References: <20120213212401.GH1426@atomide.com> <20120213222652.GL14173@pengutronix.de> <20120213225118.GC31482@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120213225118.GC31482@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Uwe =?utf-8?Q?Klein?= =?utf-8?Q?e-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Anders Kaseorg <andersk@ksplice.com>, Greg KH <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Mon, 13 Feb 2012 22:51:18 +0000, Russell King - ARM Linux <linux@arm=
=2Elinux.org.uk> wrote:
> On Mon, Feb 13, 2012 at 11:26:52PM +0100, Uwe Kleine-K=C3=B6nig wrote=
:
> > On Mon, Feb 13, 2012 at 01:24:01PM -0800, Tony Lindgren wrote:
> > Maybe:
> >=20
> > #ifndef R_ARM_CALL
> > #warning "you're elf.h include is outdated"
>=20
> "You are elf.h include is outdated" does not make sense.
>=20
> Why are you calling Tony an elf.h include?

Because he knew it would attract the attention of pedants to the patch?
:)

Just do the #ifndef, and skip the warning.  There's not much the poor
user receiving the warning can do about it.

Acked-by: Rusty Russell <rusty@rustcorp.com.au>

Thanks,
Rusty.
