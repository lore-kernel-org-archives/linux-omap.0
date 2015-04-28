From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: ARM errata 430973 on multi platform kernels
Date: Tue, 28 Apr 2015 19:11:10 +0100
Message-ID: <20150428181109.GA4027@n2100.arm.linux.org.uk>
References: <20150407135713.GL4027@n2100.arm.linux.org.uk>
 <20150407152207.GM18048@atomide.com>
 <20150408230658.GO4027@n2100.arm.linux.org.uk>
 <20150409134843.GQ4027@n2100.arm.linux.org.uk>
 <20150415163108.GB2033@earth>
 <20150416160858.GH18048@atomide.com>
 <20150417184156.GA3326@earth>
 <20150420234032.GM18048@atomide.com>
 <20150423102542.GZ4027@n2100.arm.linux.org.uk>
 <CAALWOA_3wfn=K3qt9MzWYXMGTM7mZvqY03Biqk5T2wVF4uMVxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:60632 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030316AbbD1SLV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Apr 2015 14:11:21 -0400
Content-Disposition: inline
In-Reply-To: <CAALWOA_3wfn=K3qt9MzWYXMGTM7mZvqY03Biqk5T2wVF4uMVxQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Pavel Machek <pavel@ucw.cz>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Apr 24, 2015 at 10:54:29AM +0200, Matthijs van Duin wrote:
> On 23 April 2015 at 12:25, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > And you can't detect whether you're running in secure mode or not.
> 
> If not, you get an undefined instruction exception, which you could trap.
> 
> This may not be convenient, but "can't detect" is an overstatement.

It's these kinds of statements that really piss me off.

At this stage in the boot, there's no memory allocators.  There's no
MMU.  There's really not very much.  There's no guarantee that the
location where the vectors are is writable on all platforms.

It's pretty much _impossible_ to do generically.

"Can't detect" is _not_ an overstatement.  It's a statement that I'm
giving you through my experience and knowledge of the Linux kernel,
the ARM archtecture, the capabilities of the platforms we have to
deal with, and how we want the kernel to work.

Sure, we _can_ detect it if (and only if) we code specifically for a
platform which has RAM at the CPU vector location.  Unfortunately,
that's a _very_ small proportion which approximates a number very
close to zero.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
