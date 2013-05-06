From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [RESEND][PATCH 1/3] arm: dts: introduce config HAS_BANDGAP
Date: Mon, 6 May 2013 16:36:53 -0600
Message-ID: <20130506223653.GA12089@obsidianresearch.com>
References: <1367874058-2378-1-git-send-email-eduardo.valentin@ti.com>
 <1367874058-2378-2-git-send-email-eduardo.valentin@ti.com>
 <20130506213413.GH5634@blackmetal.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130506213413.GH5634@blackmetal.musicnaut.iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, tony@atomide.com, linux-omap@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, May 07, 2013 at 12:34:13AM +0300, Aaro Koskinen wrote:
> On Mon, May 06, 2013 at 05:00:56PM -0400, Eduardo Valentin wrote:
> > Introduce HAS_BANDGAP config entry. This config is a
> > boolean value so that arch code can flag is they
> > feature a bandgap device.
> 
> Maybe it could be mentioned that omap-thermal already depend on this?
> At least for a random reviewer it was not immediately clear why this is
> added, especially since there were no users for it in subsequent patches.

I looked (very briefly), and it seemed like omap-thermal is self
contained and doesn't need arch support?

I get the impression it is desired to minimize driver kconfig
dependencies to the minimum required to compile to increase build
testing coverage, so maybe it would be appropriate to drop this
entirely?

Jason
