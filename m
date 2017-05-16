From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/8] ARM: OMAP2+: AM33XX/AM43XX: Add suspend-resume
 support
Date: Tue, 16 May 2017 08:47:17 -0700
Message-ID: <20170516154717.GF31418@atomide.com>
References: <20170329015801.22240-1-d-gerlach@ti.com>
 <20170329171314.GD10760@atomide.com>
 <cd340d7a-c0cf-9227-1382-2277ffa5b1b0@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cd340d7a-c0cf-9227-1382-2277ffa5b1b0@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Keerthy J <j-keerthy@ti.com>
List-Id: linux-omap@vger.kernel.org

* Dave Gerlach <d-gerlach@ti.com> [170329 11:52]:
> Hi Tony,
> On 03/29/2017 12:13 PM, Tony Lindgren wrote:
> > * Dave Gerlach <d-gerlach@ti.com> [170328 19:00]:
> > > Hi,
> > > This series contains the remaining code to enable suspend to mem and standby on
> > > am335x and am437x platforms. It depends on the ti-emif-sram series sent here [1].
> > 
> > Looks good to me in general. To remove the dependency, can some
> > of this be merged separately without breaking things before [1]?
> > Maybe by disabling some of the PM states until [1] is in place?
> 
> Thanks for the feedback. Actually, patch 7 is the only patch with a
> dependency to [1]. The rest of the patches just add platform PM support
> needed for suspend but won't do much of anything until patch 7 actually
> enables the suspend states, so there is no reason why patches 1-6 and patch
> 8 can't be merged now.

I'm applying patches 1-5 into omap-for-v4.13/soc. Patch 6 needs
ack from Russell.

Regards,

Tony
