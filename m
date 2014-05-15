From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH] ARM: OMAP: remove some dead code
Date: Thu, 15 May 2014 22:43:17 +0300
Message-ID: <20140515194317.GB4752@drone.musicnaut.iki.fi>
References: <1400181381.11786.18.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1400181381.11786.18.camel@x220>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, May 15, 2014 at 09:16:21PM +0200, Paul Bolle wrote:
> A check for CONFIG_CBUS_TAHVO_USB was added in v2.6.17. The related
> Kconfig symbol has never been part of the tree. Remove that check.
> 
> Replace the while (...) loop with a simple if (...) statement, while
> we're at it.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>

Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>

> ---
> Untested, as usual.
> 
> A quick search across the history of the tree suggests CBUS_TAHVO_USB
> was N770 related. Not that this matters much.

Yes, Tahvo USB is only used on Nokia 770 (which is the correct name,
not N770). The driver is nowadays behind TAHVO_USB, but like you said
the old symbol was never part of the mainline so it's OK to delete it.

A.
