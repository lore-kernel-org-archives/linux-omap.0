From: "Taneja, Archit" <archit@ti.com>
Subject: RE: [PATCH v3 1/2] OMAP: DSS2: Introduce dss_features files
Date: Wed, 15 Sep 2010 13:47:26 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608703117E9C91@dbde02.ent.ti.com>
References: <1284355810-20899-1-git-send-email-archit@ti.com>
	 <1284355810-20899-2-git-send-email-archit@ti.com>
 <1284538241.2522.100.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50424 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750932Ab0IOIRg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Sep 2010 04:17:36 -0400
In-Reply-To: <1284538241.2522.100.camel@tubuntu.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

Tomi Valkeinen wrote:
> Hi,
> 
> On Mon, 2010-09-13 at 07:30 +0200, ext Archit Taneja wrote:
>> Add dss_features.c and dss_features.h for the dss_features framework
>> 
>> Signed-off-by: Archit Taneja <archit@ti.com>
>> ---
>>  drivers/video/omap2/dss/Makefile       |    2 +-
>>  drivers/video/omap2/dss/dss_features.c |  191
> ++++++++++++++++++++++++++++++++
>>  drivers/video/omap2/dss/dss_features.h |   50 ++++++++
>>  3 files changed, 242 insertions(+), 1 deletions(-)  create mode
>> 100644 drivers/video/omap2/dss/dss_features.c
>>  create mode 100644 drivers/video/omap2/dss/dss_features.h
>> 
>> diff --git a/drivers/video/omap2/dss/Makefile
>> b/drivers/video/omap2/dss/Makefile
>> index d71b5d9..7db17b5
>> --- a/drivers/video/omap2/dss/Makefile
>> +++ b/drivers/video/omap2/dss/Makefile
>> @@ -1,5 +1,5 @@
>>  obj-$(CONFIG_OMAP2_DSS) += omapdss.o
>> -omapdss-y := core.o dss.o dispc.o display.o manager.o overlay.o
>> +omapdss-y := core.o dss.o dss_features.o dispc.o display.o manager.o
>>  +overlay.o omapdss-$(CONFIG_OMAP2_DSS_DPI) += dpi.o
>>  omapdss-$(CONFIG_OMAP2_DSS_RFBI) += rfbi.o
>>  omapdss-$(CONFIG_OMAP2_DSS_VENC) += venc.o diff --git
>> a/drivers/video/omap2/dss/dss_features.c
>> b/drivers/video/omap2/dss/dss_features.c
>> new file mode 100644
>> index 0000000..c3e4d4d
>> --- /dev/null
>> +++ b/drivers/video/omap2/dss/dss_features.c
>> @@ -0,0 +1,191 @@
>> +/*
>> + * linux/drivers/video/omap2/dss/dss_features.c
>> + *
>> + * Copyright (C) 2010 Texas Instruments
>> + * Author: Archit Taneja <archit@ti.com>
>> + *
>> + * This program is free software; you can redistribute it and/or +modify it
>> + * under the terms of the GNU General Public License version 2 as
>> +published by + * the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful, +but
>> WITHOUT + * ANY WARRANTY; without even the implied warranty of
>> MERCHANTABILITY +or + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> General Public +License for + * more details.
>> + *
>> + * You should have received a copy of the GNU General Public License +along
>> with + * this program.  If not, see <http://www.gnu.org/licenses/>. + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/types.h>
>> +#include <linux/err.h>
>> +#include <linux/slab.h>
>> +
>> +#include <plat/display.h>
>> +#include <plat/cpu.h>
>> +
>> +#include "dss_features.h"
>> +
>> +/* Defines a generic omap register field */ struct dss_reg_field { +	enum
>> dss_feat_reg_field id; +	u8 start, end;
>> +};
>> +
>> +struct omap_dss_features {
>> +	struct dss_reg_field *reg_fields;
>> +	int num_reg_fields;
>> +
>> +	u32 has_feature;
>> +
>> +	int num_mgrs;
>> +	int num_ovls;
>> +	enum omap_display_type *supported_displays;
>> +	enum omap_color_mode *supported_color_modes; };
>> +
>> +/* This struct is assigned to one of the below during initialization
>> +*/ static struct omap_dss_features omap_current_dss_features;
> 
> Any particular reason this is not a pointer?

Not really, it didn't cross my mind that I could make it a pointer.
I will make these changes..

Do you have comments for the 2nd patch in this series, I wanted to consider
them while making a next series.

> 
> Also, I think most (all?) of the structs can be consts, as they are never
> changed. 
> 
> Otherwise I think this looks good.
> 
>  Tomi

Archit