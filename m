From: Tony Lindgren <tony@atomide.com>
Subject: Re: runtime check for omap-aes bus access permission (was: Re:
 3.13-rc3 (commit 7ce93f3) breaks Nokia N900 DT boot)
Date: Mon, 1 Jun 2015 10:58:07 -0700
Message-ID: <20150601175806.GZ30984@atomide.com>
References: <201502112128.44852@pali>
 <CAGo_u6oZxi7O6re30L2-wVyxTeahhyMb4qVcrE3tSCV9sBvrnw@mail.gmail.com>
 <20150528073740.GD16509@pali>
 <20150528160113.GH30984@atomide.com>
 <CAALWOA8Pfc_zbN9MoHwR=njPBpFU56WObYMbGv9N7ktzy+RSeQ@mail.gmail.com>
 <20150528222412.GM30984@atomide.com>
 <CAALWOA9qJHUST0JQxA6MBohMfbTYAP9+NbSXGYHZY4Xa3nSFvw@mail.gmail.com>
 <CAALWOA82=QmTpCeiceOFQOjqXKdSBjB3Z+jL-mi0vYF=QaL4sA@mail.gmail.com>
 <20150529155030.GO30984@atomide.com>
 <CAALWOA-X-Jb_2NODrPNnDgaLuYFDuxjPLHYwqRjaPz2PrqhJkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:55151 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752719AbbFAR6K (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Jun 2015 13:58:10 -0400
Content-Disposition: inline
In-Reply-To: <CAALWOA-X-Jb_2NODrPNnDgaLuYFDuxjPLHYwqRjaPz2PrqhJkA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sebastian Reichel <sre@ring0.de>, linux-omap <linux-omap@vger.kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, lkml <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>

* Matthijs van Duin <matthijsvanduin@gmail.com> [150530 08:24]:
> On 29 May 2015 at 17:50, Tony Lindgren <tony@atomide.com> wrote:
> > I believe some TI kernels use strongly-ordered mappings, mainline
> > kernel does not. Which kernel version are you using?
> 
> Normally I periodically rebuild based on Robert C Nelson's -bone
> kernel (but with heavily customized config). I also tried a plain
> 4.1.0-rc5-bone3, the generic 4.1.0-rc5-armv7-x0 (the most
> vanilla-looking kernel I could find in my debian package list), and
> for the heck of it also the classic 3.14.43-ti-r66.
> 
> In all cases I observed a synchronous bus error (dubiously reported as
> "external abort on non-linefetch (0x1818)") on an AM335x with this
> trivial test:
> 
> int main() {
>         int fd = open( "/dev/mem", O_RDWR | O_DSYNC );
>         if( fd < 0 ) return 1;
>         void *ptr = mmap( NULL, 4096, PROT_WRITE, MAP_SHARED, fd, 0x42000000 );
>         if( ptr == MAP_FAILED ) return 1;
>         *(volatile int *)ptr = 0;
>         return 0;
> }
> 
> I even considered for a moment that maybe the AM335x has some "all
> writes non-posted" thing enabled (which I think is available as a
> switch on OMAP 4/5?). It seemed unlikely, but since most of my
> exploration of interconnect behaviour was done on a DM814x, I
> double-checked by performing the same write in a baremetal test
> program (with that region configured Device-type in the MMU). As
> expected, no data abort occurred, so writes most certainly are posted.
> 
> So I have trouble coming up with any explanation for this other than
> the use of strongly-ordered mappings.
> 
> (Curiously BTW, omitting O_DSYNC made no difference.)

I think these kernels are missing the configuration for l3-noc
driver?

I tried it on omap4 that has l3-noc configured, and it first produces
"Unhandled fault: external abort on non-linefetch (0x1818) at 0xb6fd7000",
and the L3 interrupt only after that. So yeah, you're right, we can't
use the interrupts here. I somehow remembered we'd get only the L3
interrupt if configured.

Regards,

Tony
