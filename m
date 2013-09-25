From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: new binutils needed for arm in 3.12-rc1
Date: Tue, 24 Sep 2013 22:07:57 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309242158340.312@syhkavp.arg>
References: <1380071607.1974.78@driftwood>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1380071607.1974.78@driftwood>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Landley <rob@landley.net>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, =?ISO-8859-15?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>, Andrew Morton <akpm@osdl.org>, Trivial patch monkey <trivial@kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Tue, 24 Sep 2013, Rob Landley wrote:

> On 09/24/2013 04:48:00 PM, Russell King - ARM Linux wrote:
> > Now, if you feel strongly about this, we _could_ introduce a
> > CONFIG_OLD_BINUTILS and give everyone their cake - but it will be
> > fragile.  Not everyone will remember to get that right, because they'll
> > be using the later binutils.  Also, we already have an excessive number
> > of potential breakage-inducing options and we certainly don't need
> > another.
> 
> I'm doing the regression testing either way, on several different
> architectures. (Although I tend to to only really do a thorough job quarterly
> when a new kernel comes out and it's time to make it work.) So I'm going to be
> doing something locally like this anyway, and if a CONFIG_OLD_BINUTILS is
> acceptable I might as well push it upstream.

If you are convinced you have no choice but to stick to old binutils, 
I'd strongly suggest you make your binutils compatible with newer 
instruction syntax instead of making the kernel more complex.  This is 
more in line with being future proof rather than stuck into the past.

It could be as simple as making gas accept an extra argument for 
instructions like dsb and just ignoring it.


Nicolas
