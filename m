From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/8] ARM: SCU: Add common routines for secondary CPU
	bootup
Date: Tue, 30 Nov 2010 22:24:57 +0000
Message-ID: <20101130222457.GB9424@n2100.arm.linux.org.uk>
References: <20101130171626.GA6165@oksana.dev.rtsoft.ru> <20101130171658.GA24034@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20101130171658.GA24034@oksana.dev.rtsoft.ru>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Anton Vorontsov <avorontsov@mvista.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, Jamie Iles <jamie.iles@picochip.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Colin Cross <ccross@android.com>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 30, 2010 at 08:16:58PM +0300, Anton Vorontsov wrote:
> For CNS3xxx we want to reuse the original ARM approach of booting
> secondary CPUs. This patch factors out VExpress' code into a common
> file, so that now platform code can call these routines.
> 
> Note that this patch doesn't convert VExpress platform to the
> generic routines. Plus, there are also a lot of other platforms
> that might benefit from this change, but we'll convert them via
> separate patches.

I still think that we can do better with this - especially once the
crappy situation with the hotplug CPU code gets resolved.

The SCU does not require the pen_release code.  What currently requires
that is the hotplug CPU code to allow offlined CPUs to be re-woken.  If
these CPUs can be properly shutdown, and brought back online via their
reset vector, they can be brought back online via the same method used
for their initial boot.

What that means is, as we send each individual CPU an IPI, we don't
need the pen_release mess nor the holding pen, and all this code can go.

If all that code is tied into a generic "SCU" support option, then we
have to ensure that _all_ SCU using platforms can use this method before
we switch to it, rather than doing it on a per-platform basis as we can
now.
