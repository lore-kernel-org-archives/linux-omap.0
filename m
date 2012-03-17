From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] input: keypad: move platform_data to
 <linux/platform_data>
Date: Fri, 16 Mar 2012 22:36:19 -0700
Message-ID: <20120317053619.GA20049@core.coreip.homeip.net>
References: <1331907989-11891-1-git-send-email-sourav.poddar@ti.com>
 <1331907989-11891-2-git-send-email-sourav.poddar@ti.com>
 <1357514.ox9yZWgqO9@dtor-d630.eng.vmware.com>
 <20120316210841.GA19797@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120316210841.GA19797@arwen.pp.htv.fi>
Sender: linux-input-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Sourav Poddar <sourav.poddar@ti.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Mar 16, 2012 at 11:08:43PM +0200, Felipe Balbi wrote:
> Hi,
> 
> On Fri, Mar 16, 2012 at 09:36:19AM -0700, Dmitry Torokhov wrote:
> > On Friday, March 16, 2012 07:56:28 PM Sourav Poddar wrote:
> > > From: Felipe Balbi <balbi@ti.com>
> > > 
> > > This patch allows us to drop the OMAP depencendy
> > > from the OMAP4 keypad driver.
> > > 
> > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > > Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
> > > ---
> > >  arch/arm/mach-omap2/board-4430sdp.c            |    1 +
> > >  arch/arm/mach-omap2/devices.c                  |    1 +
> > >  arch/arm/plat-omap/include/plat/omap4-keypad.h |    9 ---------
> > >  drivers/input/keyboard/Kconfig                 |    1 -
> > >  drivers/input/keyboard/omap4-keypad.c          |    2 +-
> > >  include/linux/platform_data/omap4-keypad.h     |   13 +++++++++++++
> > 
> > Instead of creating platform_data directory why not move to
> > include/linux/input/omap4-keypad.h?
> 
> look closer, that directory already exists. But if you prefer placing
> that header on <linux/input> that's doable too.

OK, fair enough, applied.

-- 
Dmitry
