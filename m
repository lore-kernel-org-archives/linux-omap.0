From: Tony Lindgren <tony@atomide.com>
Subject: Re: drivers/usb/musb/tusb6010.c:142:21: error: 'USB_INDEX' undeclared
Date: Wed, 14 Sep 2016 07:35:48 -0700
Message-ID: <20160914143546.wuqlwhl3cckybdrf@atomide.com>
References: <201606120442.yWatggEa%fengguang.wu@intel.com>
 <20160908174521.fcrjbcwktfiuujib@atomide.com>
 <20160908182609.GG4054@uda0271908>
 <20160913223504.7mdgtipmkltikuyt@atomide.com>
 <20160914131338.GA9442@uda0271908>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160914131338.GA9442@uda0271908>
Sender: linux-kernel-owner@vger.kernel.org
To: Bin Liu <b-liu@ti.com>, kbuild test robot <fengguang.wu@intel.com>, kbuild-all@01.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Bin Liu <b-liu@ti.com> [160914 06:14]:
> On Tue, Sep 13, 2016 at 03:35:05PM -0700, Tony Lindgren wrote:
> > * Bin Liu <b-liu@ti.com> [160908 11:26]:
> > > On Thu, Sep 08, 2016 at 10:45:21AM -0700, Tony Lindgren wrote:
> > > > --- a/drivers/usb/musb/Kconfig
> > > > +++ b/drivers/usb/musb/Kconfig
> > > > @@ -87,7 +87,7 @@ config USB_MUSB_DA8XX
> > > >  config USB_MUSB_TUSB6010
> > > >  	tristate "TUSB6010"
> > > >  	depends on HAS_IOMEM
> > > > -	depends on ARCH_OMAP2PLUS || COMPILE_TEST
> > > > +	depends on (ARCH_OMAP2PLUS || COMPILE_TEST) && !BLACKFIN
> > > 
> > > Would this cause more issue later when trying to enable all glue drivers
> > > in one build?
> > 
> > Yes but see what CONFIG_BLACKFIN is doing with musb_regs.h..
> > It completely redefines all the registers with ifdef else.
> > 
> > > The macros defined in tusb6010.h are only used in tusb6010.c, so how
> > > about move '#include "tusb6010.h"' from musb_regs.h to tusb6010.c
> > > instead? This gives flexibility to random config test, isn't it?
> > 
> > I'd like to see that but we have this in musb_core.c:
> > 
> > hw_ep->conf = mbase - 0x400 + TUSB_EP0_CONF;
> > 
> > So the build would break there again on blackin with tusb6010..
> > Got any ideas on how to sort that out?
> 
> Thanks for catching it. It appears that the glues require more work to
> cleanup. I am taking your patch.

OK thanks, yeah still more work needed for the glue layers for sure.

Regards,

Tony
