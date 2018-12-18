From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] dmaengine: ti: omap-dma: Configure LCH_TYPE for OMAP1
Date: Tue, 18 Dec 2018 07:55:32 -0800
Message-ID: <20181218155532.GC6707@atomide.com>
References: <20181122102948.GN6920@n2100.armlinux.org.uk>
 <20181122151236.GA9611@n2100.armlinux.org.uk>
 <6ed280af-edb6-4be7-82f4-7fc00378103e@ti.com>
 <20181123185215.GH12912@darkstar.musicnaut.iki.fi>
 <20181124200942.GS6920@n2100.armlinux.org.uk>
 <20181125010717.GJ53235@atomide.com>
 <20181125111105.GT6920@n2100.armlinux.org.uk>
 <20181125165830.GC3416@darkstar.musicnaut.iki.fi>
 <20181125171428.GL53235@atomide.com>
 <20181217234731.GC7288@darkstar.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181217234731.GC7288@darkstar.musicnaut.iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>, Peter Ujfalusi <peter.ujfalusi@ti.com>, vkoul@kernel.org, dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [181217 23:47]:
> Hi,
> 
> On Sun, Nov 25, 2018 at 09:14:28AM -0800, Tony Lindgren wrote:
> > * Aaro Koskinen <aaro.koskinen@iki.fi> [181125 16:58]:
> > > Below changes get traffic going with DMA & g_ether...
> > 
> > Oh cool, if you have dma and g_ether working, you should
> > test it with a variable size ping test loop :) That should
> > expose any issues within few minutes.
> 
> The ping test is working fine. Also setting MTU higher works fine.

Thanks for checking, good to hear.

Regards,

Tony
