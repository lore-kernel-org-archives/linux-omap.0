From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: new binutils needed for arm in 3.12-rc1
Date: Wed, 25 Sep 2013 21:44:32 +0100
Message-ID: <20130925204432.GW25647@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.03.1309242158340.312@syhkavp.arg> <1380122586.1974.84@driftwood>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1380122586.1974.84@driftwood>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Landley <rob@landley.net>
Cc: Nicolas Pitre <nico@fluxnic.net>, =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>, Andrew Morton <akpm@osdl.org>, Trivial patch monkey <trivial@kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Sep 25, 2013 at 10:23:06AM -0500, Rob Landley wrote:
> On 09/24/2013 09:07:57 PM, Nicolas Pitre wrote:
>> It could be as simple as making gas accept an extra argument for
>> instructions like dsb and just ignoring it.
>
> So you prefer I come up with the reversion patches locally and _not_  
> send them upstream?

This is a silly attitude.  What you're effectively saying is that we
are never allowed to use any future ARM instructions in any Linux
kernel because that might break your precious assembler.

I've got news for you.  We're *not* going to listen to that argument.

END OF DISCUSSION (everything else is just a waste of time.)
