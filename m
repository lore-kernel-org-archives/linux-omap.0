From: "Taneja, Archit" <archit@ti.com>
Subject: RE: [PATCH 1/2] OMAP: DSS2: Introduce dss_features files
Date: Tue, 7 Sep 2010 16:35:54 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087031162D3AE@dbde02.ent.ti.com>
References: <1282826618-24584-1-git-send-email-archit@ti.com>
	 <1282826618-24584-2-git-send-email-archit@ti.com>
 <1283855584.2363.53.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52860 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755369Ab0IGLGE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Sep 2010 07:06:04 -0400
In-Reply-To: <1283855584.2363.53.camel@tubuntu.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

Tomi Valkeinen wrote:
> Hi,
> 
> On Thu, 2010-08-26 at 14:43 +0200, ext Archit Taneja wrote:
>> Add dss_features.c and dss_features.h for the dss_features framework
>> 
>> Signed-off-by: Archit Taneja <archit@ti.com>
> 
> And some more comments inline
> 
>> ---
>>  drivers/video/omap2/dss/dss_features.c |  197
> ++++++++++++++++++++++++++++++++
>>  drivers/video/omap2/dss/dss_features.h |   48 ++++++++
>>  2 files changed, 245 insertions(+), 0 deletions(-)  create mode
>> 100644 drivers/video/omap2/dss/dss_features.c
>>  create mode 100644 drivers/video/omap2/dss/dss_features.h
>> 
>> diff --git a/drivers/video/omap2/dss/dss_features.c
>> b/drivers/video/omap2/dss/dss_features.c
>> new file mode 100644
>> index 0000000..0ac18d2
>> --- /dev/null
>> +++ b/drivers/video/omap2/dss/dss_features.c
>> @@ -0,0 +1,197 @@
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
>> +static struct list_head reg_field_list; static int num_reg_fields; +
>> +/* Defines a generic omap register field */ struct dss_reg_field { +	struct
>> list_head list; +	int id;
>> +	u8 start, end;
>> +};
>> +
>> +/* This struct is divided into 2 sets: the first gives a value
>> +corresponding + * to a feature, the second tells if a dss feature exists or
>> not */ +static struct { +	int num_mgrs;
>> +	int num_ovls;
>> +	enum omap_display_type supported_displays[MAX_DSS_MANAGERS];
>> +	enum omap_color_mode supported_color_modes[MAX_DSS_OVERLAYS]; +
>> +	bool has_feature[MAX_DSS_FEATURES];
>> +} omap_dss_features;
>> +
>> +/* Functions to add/fetch the start and end bits of a DSS register
>> +field */ static void dss_add_reg_field(int id, u8 start, u8 end) {
>> +	struct dss_reg_field *field;
>> +	field = kzalloc(sizeof(*field), GFP_KERNEL);
>> +
>> +	++num_reg_fields;
>> +
>> +	field->id = id;
>> +	field->start = start;
>> +	field->end = end;
>> +
>> +	list_add_tail(&field->list, &reg_field_list); }
>> +
>> +void omap_dss_get_reg_field(int id, u8 *start, u8 *end) {
>> +	struct dss_reg_field *field;
>> +
>> +	list_for_each_entry(field, &reg_field_list, list) { +		if (field->id ==
>> id) { +			*start = field->start;
>> +			*end = field->end;
>> +			return;
>> +		}
>> +	}
>> +	BUG();
>> +}
>> +EXPORT_SYMBOL(omap_dss_get_reg_field);
> 
> I don't think these need to be exported. The only users for
> these should be inside DSS driver. And, as you've probably noticed, I've been
> using (usually) omap_dss_* prefix for exported functions, and
> (usually) dss_* prefix for non-exported, non-static functions.
> 
> Although the naming convention inside DSS is sadly quite inconsistent...
> =)

Yes, exporting them is unnecessary, I will correct this.

There are 2 functions in the present code:
omap_dss_get_num_overlays()
omap_dss_get_num_overlay_managers()

They look very similar to the dss_feature functions but are required.
I will need to come up with new names for them to avoid confusion.

We could probably give a naming like : dss_feat_get_num_mgrs() etc so
that it doesn't confuse things.

Archit
> 
>> +/* Functions returning values related to a DSS feature */ int
>> +omap_dss_num_mgrs(void) { +	return omap_dss_features.num_mgrs;
>> +}
>> +EXPORT_SYMBOL(omap_dss_num_mgrs);
> 
> Perhaps this should be dss_get_num_mgrs().
> 
>> +
>> +int omap_dss_num_ovls(void)
>> +{
>> +	return omap_dss_features.num_ovls;
>> +}
>> +EXPORT_SYMBOL(omap_dss_num_ovls);
> 
> And "get" here too. And for the functions below.
> 
>> +enum omap_display_type omap_dss_supported_displays(int id) {
>> +	return omap_dss_features.supported_displays[id];
>> +}
>> +EXPORT_SYMBOL(omap_dss_supported_displays);
>> +
>> +enum omap_color_mode omap_dss_supported_color_modes(int id) {
>> +	return omap_dss_features.supported_color_modes[id]; +}
>> +EXPORT_SYMBOL(omap_dss_supported_color_modes);
>> +
>> +/* DSS has_feature check */
>> +bool omap_dss_has_feature(int id)
>> +{
>> +	return omap_dss_features.has_feature[id];
>> +}
>> +EXPORT_SYMBOL(omap_dss_has_feature);
> 
>  Tomi