From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP3 L2/outer cache enabled in kernel (after being disabled
	by uBoot)?
Date: Thu, 2 Feb 2012 14:49:42 +0000
Message-ID: <20120202144942.GD1275@n2100.arm.linux.org.uk>
References: <WC20120120085711.330803@terrafix.co.uk> <20120127173029.GA3281@arm.com> <4F277A6E.9070107@ti.com> <CAHkRjk7z2QYbU09BRfAWmChw5xj9taCarWfnttWveyqtadiEOg@mail.gmail.com> <CAMQu2gxr5ZkH4AE_7QNptxx7onQMGaj+qhUF+DSw9MnkCqCRog@mail.gmail.com> <CAHkRjk7Fh=OUk8K=bJa8xzPqMvT6P6gjT+kqAA0DeVfrF0sUNg@mail.gmail.com> <CAMQu2gwDJ=aezNAUD3YmGHQ6fBxkxgUonYkQYPH8WBeNvZCKMQ@mail.gmail.com> <CAHkRjk6KQXR1kt8VTPC3GOaHUusKikxXHR=Mge8akaVL2ipvaw@mail.gmail.com> <alpine.LFD.2.02.1201311253460.2759@xanadu.home> <CAHkRjk690R951NUDC_erNsBtbmtrM-nPjY2gR=Tf-sW4qXX7ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:44516 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932067Ab2BBOtx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Feb 2012 09:49:53 -0500
Content-Disposition: inline
In-Reply-To: <CAHkRjk690R951NUDC_erNsBtbmtrM-nPjY2gR=Tf-sW4qXX7ww@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, Aneesh V <aneesh@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Joe Woodward <jw@terrafix.co.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Thu, Feb 02, 2012 at 02:32:03PM +0000, Catalin Marinas wrote:
> We could do the same and move the bit enabling to separate repository :).

We must certainly could do but that doesn't get around the errata
issues when you have things before the kernel (or before these blobs)
enabling things like the caches and MMU.

The only answer which assures complete system stability is for the
earliest reasonable point in the booting sequence to handle the errata,
before any of the potential errata scenarios occur.  For things like
working around L2 cache problems, that means before the L2 cache is
enabled for the first time.

If the boot loader enables the L2 cache, then _it_ has to take care of
the errata before it enables the L2 cache, and not some blob that it
loads.

If the boot loader enables the cache, and there are workarounds for buggy
cache behaviour, then the boot loader has to implement those errata
itself.

And so the list goes on.

I think the one issue which Santosh is justified about is: if that is
the case, why have the errata workarounds in the kernel in the first
place.  I agree - it makes no sense when we have things like the
decompressor enabling the caches.

So, I propose that we rip out all those work-arounds that are just
'set this bit in some register' at boot time from the kernel itself
right now, and reconsider how these are handled.

If that means boot loader people need to update their code to deal with
errata, because they want to use CPU features which have errata associated
with them, they then get to deal with the errata updates themselves, and
also have to carry the pain of dealing with running in non-secure mode.
Or, they will have to chose to avoid using those features.

But, having errata for things like DMB being faulty in the kernel after
things like the boot loader will _already_ have had to issue DMB
instructions, or for failing I-cache invalidate after we've already done
some I-cache invalidates (eg, boot loader or the decompressor) is quite
absurd.

So, I think we need to rip out a fair number of these errata from the
kernel itself; it's quite clear they're already being done far too late
in the system boot sequence.
