From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: RE: [PATCH v2 1/2] OMAP: DSS2: Introduce dss_features files
Date: Thu, 09 Sep 2010 13:59:18 +0300
Message-ID: <1284029958.13006.62.camel@tubuntu.research.nokia.com>
References: <1283944659-3824-1-git-send-email-archit@ti.com>
	 <1283944659-3824-2-git-send-email-archit@ti.com>
	 <1284027911.13006.54.camel@tubuntu.research.nokia.com>
	 <FCCFB4CDC6E5564B9182F639FC35608703116F94B2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:36861 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753840Ab0IIK7Y (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Sep 2010 06:59:24 -0400
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608703116F94B2@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Taneja, Archit" <archit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 2010-09-09 at 12:53 +0200, ext Taneja, Archit wrote:
> Hi,
> 
> Tomi Valkeinen wrote:
> > Hi,
> > 
> > On Wed, 2010-09-08 at 13:17 +0200, ext Archit Taneja wrote:
> >> Add dss_features.c and dss_features.h for the dss_features framework
> >> 
> >> Signed-off-by: Archit Taneja <archit@ti.com>
> >> ---
> >>  drivers/video/omap2/dss/dss_features.c |  171
> > ++++++++++++++++++++++++++++++++
> >>  drivers/video/omap2/dss/dss_features.h |   51 ++++++++++
> >>  2 files changed, 222 insertions(+), 0 deletions(-)  create mode
> >> 100644 drivers/video/omap2/dss/dss_features.c
> >>  create mode 100644 drivers/video/omap2/dss/dss_features.h
> >> 
> >> diff --git a/drivers/video/omap2/dss/dss_features.c
> >> b/drivers/video/omap2/dss/dss_features.c
> >> new file mode 100644
> >> index 0000000..e87816f
> >> --- /dev/null
> >> +++ b/drivers/video/omap2/dss/dss_features.c
> >> @@ -0,0 +1,171 @@
> >> +/*
> >> + * linux/drivers/video/omap2/dss/dss_features.c
> >> + *
> >> + * Copyright (C) 2010 Texas Instruments
> >> + * Author: Archit Taneja <archit@ti.com>
> >> + *
> >> + * This program is free software; you can redistribute it and/or +modify it
> >> + * under the terms of the GNU General Public License version 2 as
> >> +published by + * the Free Software Foundation.
> >> + *
> >> + * This program is distributed in the hope that it will be useful, +but
> >> WITHOUT + * ANY WARRANTY; without even the implied warranty of
> >> MERCHANTABILITY +or + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> >> General Public +License for + * more details.
> >> + *
> >> + * You should have received a copy of the GNU General Public License +along
> >> with + * this program.  If not, see <http://www.gnu.org/licenses/>. + */
> >> +
> >> +#include <linux/kernel.h>
> >> +#include <linux/types.h>
> >> +#include <linux/err.h>
> >> +#include <linux/slab.h>
> >> +
> >> +#include <plat/display.h>
> >> +#include <plat/cpu.h>
> >> +
> >> +#include "dss_features.h"
> >> +
> >> +/* Defines a generic omap register field */ struct dss_reg_field { +	enum
> >> dss_feat_reg_field id; +	u8 start, end;
> >> +};
> >> +
> >> +struct omap_dss_features {
> >> +	struct dss_reg_field reg_fields[MAX_DSS_REG_FIELDS];
> > 
> > Perhaps this should be a pointer to a list, and add a
> > separate field for num_reg_fields. That way you don't need a
> > MAX_DSS_REG_FIELDS definition.
> 
> If it is a pointer to a list then we can't initialize things statically, won't
> we need functions at runtime to add to the list of reg_fields etc, this is what
> I did in v1?

Something like:

static struct dss_reg_field omap2_dss_reg_fields[] =
{
      {FIRHINC, 11, 0},
      {FIRVINC, 27, 16},
      {FIFOLOWTHRESHOLD, 8, 0},
      {FIFOHIGHTHRESHOLD, 24, 16},
      {FIFOSIZE, 8, 0},
};

static struct omap_dss_features omap2_dss_features = {
       .num_reg_fields = ARRAY_SIZE(omap2_dss_reg_fields),
       .reg_fields = omap2_dss_reg_fields,

...

 Tomi
	


