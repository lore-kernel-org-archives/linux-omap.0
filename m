From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: ARM defconfig files
Date: Mon, 12 Jul 2010 18:32:28 +0100
Message-ID: <20100712173228.GC9897@n2100.arm.linux.org.uk>
References: <20100603074548.GA12104@flint.arm.linux.org.uk> <alpine.LFD.2.00.1006030725420.8175@i5.linux-foundation.org> <20100603181010.GA25779@flint.arm.linux.org.uk> <1275589230.23384.19.camel@c-dwalke-linux.qualcomm.com> <alpine.LFD.2.00.1006031119440.8175@i5.linux-foundation.org> <20100614083214.GA2104@pengutronix.de> <20100630104043.GG11746@pengutronix.de> <20100712155518.GA24144@pengutronix.de> <AANLkTilhI9O6YwnuAylo_jNgwR8VXmpSVJ1kylIYPCGT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTilhI9O6YwnuAylo_jNgwR8VXmpSVJ1kylIYPCGT@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Daniel Walker <dwalker@codeaurora.org>, Kevin Hilman <khilman@deeprootsystems.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@secretlab.ca>, Eric Miao <eric.miao@canonical.com>, linux-omap@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
List-Id: linux-omap@vger.kernel.org

On Mon, Jul 12, 2010 at 09:51:47AM -0700, Linus Torvalds wrote:
> So if the ARM people decide that your script is a good way to clean up
> the mess, I might be happy with that. But that would require that they
> NEVER EVER try to push me a update that contains an un-cleaned-up
> defconfig file.

Does this mean that you aren't going to delete all the defconfigs
during the next merge window if we come up with an alternative
solution to yours?

When you brought up the problem you seemed absolutely convinced
that nothing except your solution was going to be acceptable.
