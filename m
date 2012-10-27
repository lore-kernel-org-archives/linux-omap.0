From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 7/8] i2c: add 'transferred' field to struct i2c_msg
Date: Sat, 27 Oct 2012 21:03:25 +0200
Message-ID: <20121027210325.093dc92a@endymion.delvare>
References: <1350899218-13624-8-git-send-email-balbi@ti.com>
	<20121025145748.760c218b@endymion.delvare>
	<20121025131459.GG28061@n2100.arm.linux.org.uk>
	<20121025154202.41f3cbba@endymion.delvare>
	<20121025134609.GH28061@n2100.arm.linux.org.uk>
	<20121025155633.609c5554@endymion.delvare>
	<20121025141800.GI28061@n2100.arm.linux.org.uk>
	<20121027163224.67d57aef@endymion.delvare>
	<20121027164013.GV2616@ZenIV.linux.org.uk>
	<20121027170235.GA24388@ZenIV.linux.org.uk>
	<20121027171036.GA24822@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from zoneX.GCU-Squad.org ([194.213.125.0]:26235 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932330Ab2J0TDm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 27 Oct 2012 15:03:42 -0400
In-Reply-To: <20121027171036.GA24822@ZenIV.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Felipe Balbi <balbi@ti.com>, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, w.sang@pengutronix.de, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-i2c@vger.kernel.org, ben-linux@fluff.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Shubhrajyoti Datta <shubhrajyoti@ti.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

Hi Al,

On Sat, 27 Oct 2012 18:10:36 +0100, Al Viro wrote:
> On Sat, Oct 27, 2012 at 06:02:35PM +0100, Al Viro wrote:
> > On Sat, Oct 27, 2012 at 05:40:13PM +0100, Al Viro wrote:
> >
> > > You are wrong.  Assumption that pointers are aligned to 32bit boundary
> > > is simply not true.  In particular, on m68k alignment is 16bit, i.e. there
> > > struct foo {
> > > 	char x;
> > > 	void *p;
> > > }; will have 1 byte occupied by x, followed by 1-byte gap, followed by 4 bytes
> > > occupied by p.
> > >
> > > Note, BTW, that m68k includes things like coldfire, etc. and I wouldn't be
> > > surprised by e.g. coldfire-based SoC with i2c on it.
> >
> > BTW, that's easily verified - take a cross-compiler and do this:
> > ; cat >a.c <<'EOF'
> > struct { char x; void *y; } v;
> > int z = (char *)&v.y - (char *)&v;
> > EOF
> > ; m68k-linux-gnu-gcc -S a.c
> > ; grep -A1 'z:' a.s
> > z:
> >         .long   2
> > ;
> > and watch what it puts into z.  gcc is very liberal about what it considers
> > a constant expression, so it allows that sort of expressions as initializers
> > for global variables.  Not a portable C, but convenient for experiments like
> > that; just grab a cross-toolchain and feed it testcases of that kind...

Thanks for the fast and complete answer.

> ... and google for i2c coldfire immediately turns up this:
> http://mailman.uclinux.org/pipermail/uclinux-dev/2012-May/051874.html
> with
> +config I2C_COLDFIRE
> +       tristate "Freescale Coldfire I2C driver"
> +       depends on !M5272
> +       help
> +         This driver supports the I2C interface availible on most Freescale
> +         Coldfire processors.
> +
> +         This driver can be built as a module.  If so, the module
> +         will be called i2c-coldfire.
> 
> in it, along with addition of drivers/i2c/busses/i2c-coldfire.c...  IOW,
> i2c on m68k is quite real.  Sorry, no go - you don't even have an excuse
> of i2c never existing on the architecture in question.

You are completely right, we will have to find another way to let bus
drivers report how much of each message they managed to transmit or
receive.

Thanks again,
-- 
Jean Delvare
