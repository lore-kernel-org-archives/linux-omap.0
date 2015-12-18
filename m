From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v02 0/2] ARM: DTS: am33xx/am437x: Use the new eDMA
 bindings
Date: Fri, 18 Dec 2015 05:46:57 -0800
Message-ID: <20151218134657.GE23396@atomide.com>
References: <1450359217-3038-1-git-send-email-peter.ujfalusi@ti.com>
 <20151217174844.GT23396@atomide.com>
 <20151218051801.GR1854@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151218051801.GR1854@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, arnd@arndb.de, nsekhar@ti.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Vinod Koul <vinod.koul@intel.com> [151217 21:14]:
> On Thu, Dec 17, 2015 at 09:48:44AM -0800, Tony Lindgren wrote:
> > * Peter Ujfalusi <peter.ujfalusi@ti.com> [151217 05:33]:
> > > Hi,
> > > 
> > > Changes since v1:
> > > - Updated to use the non 16bit arrays [1]
> > > - send the two patch as a series
> > > 
> > > [1]
> > > As it has been discussed earlier:
> > > https://www.mail-archive.com/linux-omap@vger.kernel.org/msg122117.html
> > > 
> > > the DT bindings has been changes compared to what we had in 4.4-rc1: the arrays
> > > now don't have the 16bit type.
> > > The changes are now merged to mainline and Vinod provided us a branch:
> > > 
> > > git://git.infradead.org/users/vkoul/slave-dma.git fix/edma
> > > 
> > > Which is based on 4.4-rc1 and only contains the two patch for changing the eDMA
> > > bindings.
> > 
> > Great, I'll merge the fix/edma also into omap-for-v4.5/dt and apply
> > your two patches.
> 
> FWIW, fix/edma is in Linu's tree now and should be in -rc6

Yes that's great, but now I can keep my branches at early -rc's
and that leaves out the need of late -rc backmerges to the
whole arm soc tree.

Regards,

Tony
