From: David Brownell <david-b@pacbell.net>
Subject: Re: Benchmarking: POP flash vs. MMC?
Date: Sun, 5 Apr 2009 15:53:38 -0700
Message-ID: <200904051553.38586.david-b@pacbell.net>
References: <6541c55b1b4ad133498add734c9eecc8.squirrel@localhost> <1238813563.12072.4.camel@surfer> <f9d2a5e10904032116p4087be51o14efd360114d3d9f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n27.bullet.mail.mud.yahoo.com ([68.142.206.222]:25153 "HELO
	n27.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752550AbZDEWxm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 5 Apr 2009 18:53:42 -0400
In-Reply-To: <f9d2a5e10904032116p4087be51o14efd360114d3d9f@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <russ.dill@gmail.com>
Cc: David Hagood <david.hagood@gmail.com>, linux-omap@vger.kernel.org

On Friday 03 April 2009, Russ Dill wrote:
> On Fri, Apr 3, 2009 at 7:52 PM, David Hagood <david.hagood@gmail.com> wrote:
> > Well, that's not what I would have expected - I would have thought
> > reads on POP would have been faster than that, and cheaper - the SD
> > being the same speed but less CPU is surprising.  
> 
> The POP flash may not have a DMA ability.

ISTR it does, but it's not used.  There are other speedups possible;
the NAND driver in the OMAP tree is pretty simplistic.  It doesn't
use the "Prefetch and Write-Posting Engine" (we don't know if that
really helps though); or the more aggressive ECC support (4-bit and
8-bit modes both work).

Of course using DMA in the MTD stack can be a bit problematic in
general.  It assumes that DMA is not used ... to the extent of not
guaranteeing to provide DMA-mappable I/O buffers.

That said, it's hard to achieve speedups through DMA for such small
blocks of memory ... an issue which is not unique to NAND.


> Also, the POP flash contents 
> are compressed and ECC corrected, so its a lot of extra work for the
> CPU.

ECC is done in hardware for the native NAND stack on OMAP;
but you're right about compression.

Another point is that "managed NAND" (like MMC and eMMC, and
various SSD flavors) is there to offload some complicated
and error-prone tasks like wear-leveling.


