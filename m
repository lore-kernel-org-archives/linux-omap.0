From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH] ARM: OMAP2+: omap_device: drop broken RPM status update
 from suspend_noirq
Date: Wed, 26 Jul 2017 10:35:21 +0200
Message-ID: <20170726083521.GE27516@localhost>
References: <20170724095201.21601-1-johan@kernel.org>
 <05ae4585-8da0-6fb1-8cfd-6b236ec3a8a2@ti.com>
 <20170725082444.GL2729@localhost>
 <3f0f8ed2-9466-d5c9-10e4-de95e5155653@ti.com>
 <20170726075004.GD27516@localhost>
 <20170726081716.GB10026@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170726081716.GB10026@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Johan Hovold <johan@kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Russell King <linux@armlinux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Dave Gerlach <d-gerlach@ti.com>, Kevin Hilman <khilman@baylibre.com>, Nishanth Menon <nm@ti.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 26, 2017 at 01:17:17AM -0700, Tony Lindgren wrote: > * Johan Hovold <johan@kernel.org> [170726 00:51]:
> > On Tue, Jul 25, 2017 at 12:48:40PM -0500, Grygorii Strashko wrote:
> > > So, thank you for your patches and sorry for the noise.
> > > 
> > > Tested-by: Grygorii Strashko <grygorii.strashko@ti.com>
> > 
> > Thanks for testing.
> 
> So does the patch description need updating?

I don't think so.

I did notice that I left out a "would" in the final sentence

	"and either way, any such calls *would* have been causing
	crashes since 4.10"
	
which perhaps you could add when applying?

> And this is needed as a fix for the -rc cycle in addition to your musb
> patch?

Unlike the musb patch, this one is not critical and could possibly wait
for 4.14. But since all it does is to get rid of a (since 4.10) broken
state update, and thereby those warning messages on suspend, I'd say
it's -rc material.

Thanks,
Johan
