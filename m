From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCHv3 1/1] ti-soc-thermal: implement omap3 support
Date: Tue, 29 Sep 2015 14:18:55 -0700
Message-ID: <20150929211853.GA22673@localhost.localdomain>
References: <1441861089-23868-1-git-send-email-edubezval@gmail.com>
 <20150915112416.GC32689@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150915112416.GC32689@amd>
Sender: linux-pm-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pali.rohar@gmail.com, Rui Zhang <rui.zhang@intel.com>, linux-omap@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 15, 2015 at 01:24:16PM +0200, Pavel Machek wrote:
> On Wed 2015-09-09 21:58:09, Eduardo Valentin wrote:
> > From: Pavel Machek <pavel@ucw.cz>
> > 
> > This adds support for OMAP3 chips to ti-soc-thermal. As requested by
> > TI people, it is marked unreliable and warning is printed.
> > 
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: linux-pm@vger.kernel.org
> > Cc: linux-omap@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> > Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
> > ---
> >  .../devicetree/bindings/thermal/ti_soc_thermal.txt |   7 ++
> >  drivers/thermal/ti-soc-thermal/Kconfig             |  15 +++
> >  drivers/thermal/ti-soc-thermal/Makefile            |   1 +
> >  .../thermal/ti-soc-thermal/omap3-thermal-data.c    | 103 +++++++++++++++++++++
> >  drivers/thermal/ti-soc-thermal/ti-bandgap.c        |  10 ++
> >  drivers/thermal/ti-soc-thermal/ti-bandgap.h        |   9 ++
> >  6 files changed, 145 insertions(+)
> >  create mode 100644 drivers/thermal/ti-soc-thermal/omap3-thermal-data.c
> > ---
> > 
> > Just not leave Pavels work behind, I took his patch and amended a couple
> > of things:
> > (1) added the omap3 DT example
> > (2) improved the dev_warn message
> > (3) improved the code documentation
> 
> Thanks!
> 
> Is it on its way to mainline or is there something more to do?


Nothing else to do. I am applying to my next branch.

> 
> 									Pavel
> 
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
