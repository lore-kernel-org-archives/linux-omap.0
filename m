From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: RE: [PATCH 2/2] OMAP:DSS: RFC Patch to add HDMI DSS driver support
Date: Tue, 07 Sep 2010 16:44:59 +0300
Message-ID: <1283867099.2363.114.camel@tubuntu.research.nokia.com>
References: <FF55437E1F14DA4BAEB721A458B6701706BE2A6AB4@dbde02.ent.ti.com>
	 <1283865397.2363.110.camel@tubuntu.research.nokia.com>
	 <FF55437E1F14DA4BAEB721A458B6701706C5776EFE@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:40310 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756159Ab0IGNpG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 7 Sep 2010 09:45:06 -0400
In-Reply-To: <FF55437E1F14DA4BAEB721A458B6701706C5776EFE@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext K, Mythri P" <mythripk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 2010-09-07 at 15:37 +0200, ext K, Mythri P wrote:
> Hi Tomi,
> 
> > -----Original Message-----
> > From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> > Sent: Tuesday, September 07, 2010 6:47 PM
> > To: K, Mythri P
> > Cc: linux-omap@vger.kernel.org
> > Subject: Re: [PATCH 2/2] OMAP:DSS: RFC Patch to add HDMI DSS driver
> > support
> > 
> > On Thu, 2010-08-26 at 07:17 +0200, ext K, Mythri P wrote:
> > > From: Mythri P K <mythripk@ti.com>
> > >
> > > This is an RFC patch to add support for HDMI DSS driver in OMAP.
> > >
> > > Signed-off-by: Mythri P K <mythripk@ti.com>
> > > ---
> > >  drivers/video/omap2/dss/hdmi.c |  292
> > ++++++++++++++++++++++++++++++++++++++++
> > >  1 files changed, 292 insertions(+), 0 deletions(-)
> > >  create mode 100644 drivers/video/omap2/dss/hdmi.c
> > >
> > > diff --git a/drivers/video/omap2/dss/hdmi.c
> > b/drivers/video/omap2/dss/hdmi.c
> > > new file mode 100644
> > > index 0000000..3d7acd2
> > > --- /dev/null
> > > +++ b/drivers/video/omap2/dss/hdmi.c
> > > @@ -0,0 +1,292 @@
> > > +/*
> > > + * linux/drivers/video/omap2/dss/hdmi.c
> > > + *
> > > + * Copyright (C) 2009 Texas Instruments
> > > + * Author: Yong Zhi
> > > + *
> > > + * HDMI settings from TI's DSS driver
> > > + *
> > > + * This program is free software; you can redistribute it and/or
> > modify it
> > > + * under the terms of the GNU General Public License version 2 as
> > published by
> > > + * the Free Software Foundation.
> > > + *
> > > + * This program is distributed in the hope that it will be useful,
> > but WITHOUT
> > > + * ANY WARRANTY; without even the implied warranty of
> > MERCHANTABILITY or
> > > + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
> > License for
> > > + * more details.
> > > + *
> > > + * You should have received a copy of the GNU General Public
> > License along with
> > > + * this program.  If not, see <http://www.gnu.org/licenses/>.
> > > + * History:
> > > + * Mythripk <mythripk@ti.com>	-Redesigned on the driver to
> > adhere to DSS2 model.
> > > + *				-GPIO calls for HDMI.
> > > + *
> > > + *
> > > + */
> > > +
> > > +#define DSS_SUBSYS_NAME "HDMI"
> > > +
> > > +#include <linux/kernel.h>
> > > +#include <linux/module.h>
> > > +#include <linux/clk.h>
> > > +#include <linux/err.h>
> > > +#include <linux/io.h>
> > > +#include <linux/interrupt.h>
> > > +#include <linux/mutex.h>
> > > +#include <linux/completion.h>
> > > +#include <linux/delay.h>
> > > +#include <linux/string.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/slab.h>
> > > +#include <plat/display.h>
> > > +#include <plat/cpu.h>
> > > +#include <plat/gpio.h>
> > > +
> > > +#include "dss.h"
> > > +
> > > +static struct {
> > > +	struct mutex lock;
> > > +} hdmi;
> > > +
> > > +#define FLD_GET(val, start, end) (((val) & FLD_MASK(start, end))
> > >> (end))
> > > +#define FLD_MOD(orig, val, start, end) \
> > > +	(((orig) & ~FLD_MASK(start, end)) | FLD_VAL(val, start, end))
> > 
> > These are already defined in dss.h
> > 
> > > +
> > > +
> > > +#define CPF			2
> > > +
> > > +int hdmi_init_display(struct omap_dss_device *dssdev)
> > > +{
> > > +	DSSDBG("init_display\n");
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +void compute_hdmi_pll(int clkin, int phy,
> > > +	int n, struct hdmi_pll_info *pi)
> > 
> > This is a non-static function, and you don't introduce it in any
> > header
> > file.
> > 
> > It is not exported, so it should be used only from inside DSS driver.
> > I
> > see you call it in the next patch from the display driver, which is
> > not
> > ok. Only exported functions should be used from the display drivers
> > (you'll notice the problem if you build DSS as a module...).
> > 
> > If the function is not static, it should have some meaningful prefix.
> > 
> > The same comments apply to some other functions in this file also.
> I have introduced these in the display.h , do you suggest adding prefix like omapdss_hdmi* for all these functions ?

Neither of the two HDMI patches you sent modify display.h...

Yes, if you export functions from DSS they should be prefixed, as they
are global functions.

 Tomi


