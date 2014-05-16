From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: remove some dead code
Date: Fri, 16 May 2014 14:11:25 -0700
Message-ID: <20140516211125.GE12881@atomide.com>
References: <1400181381.11786.18.camel@x220>
 <20140515194317.GB4752@drone.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140515194317.GB4752@drone.musicnaut.iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Paul Bolle <pebolle@tiscali.nl>, Kevin Hilman <khilman@deeprootsystems.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [140515 12:48]:
> On Thu, May 15, 2014 at 09:16:21PM +0200, Paul Bolle wrote:
> > A check for CONFIG_CBUS_TAHVO_USB was added in v2.6.17. The related
> > Kconfig symbol has never been part of the tree. Remove that check.
> > 
> > Replace the while (...) loop with a simple if (...) statement, while
> > we're at it.
> > 
> > Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> 
> Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> 
> > ---
> > Untested, as usual.
> > 
> > A quick search across the history of the tree suggests CBUS_TAHVO_USB
> > was N770 related. Not that this matters much.
> 
> Yes, Tahvo USB is only used on Nokia 770 (which is the correct name,
> not N770). The driver is nowadays behind TAHVO_USB, but like you said
> the old symbol was never part of the mainline so it's OK to delete it.

Thanks applying into omap-for-v3.16/board.

Tony
