From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] modpost: Fix section warnings for ARM for many compilers
Date: Mon, 13 Feb 2012 22:51:18 +0000
Message-ID: <20120213225118.GC31482@n2100.arm.linux.org.uk>
References: <20120213212401.GH1426@atomide.com>
 <20120213222652.GL14173@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20120213222652.GL14173@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Tony Lindgren <tony@atomide.com>, Anders Kaseorg <andersk@ksplice.com>, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Mon, Feb 13, 2012 at 11:26:52PM +0100, Uwe Kleine-K=F6nig wrote:
> On Mon, Feb 13, 2012 at 01:24:01PM -0800, Tony Lindgren wrote:
> > It turns out that many compilers don't show section warnings on ARM
> > currently because handling for ARM_CALL relocs are missing from
> > modpost.c.
> > =

> > Based on commit c2e26114 ([ARM] 3205/1: Handle new EABI relocations when
> > loading kernel modules) it seems that R_ARM_PC24, R_ARM_CALL and
> > R_ARM_JUMP24 can be handled the same way.
> > =

> > As modpost.c includes elf.h, we need to also consider that at least
> > Debian libc6-dev is missing defines for both R_ARM_CALL and R_ARM_JUMP24
> > in /usr/include/elf.h.
> Huh, even unstable's /usr/include/elf.h doesn't have these symbols.
> =

> > So for now let's just use the numbers in modpost.c.
> > =

> > Cc: Rusty Russell <rusty@rustcorp.com.au>
> > Cc: Ben Hutchings <ben@decadent.org.uk>
> > Cc: Anders Kaseorg <andersk@ksplice.com>
> > Cc: Greg KH <gregkh@linuxfoundation.org>
> > Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > =

> > ---
> > =

> > Anybody got better ideas for dealing with the missing elf.h
> > defines?
> Maybe:
> =

> #ifndef R_ARM_CALL
> #warning "you're elf.h include is outdated"

"You are elf.h include is outdated" does not make sense.

Why are you calling Tony an elf.h include?
