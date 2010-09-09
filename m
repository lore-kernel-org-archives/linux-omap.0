From: "Taneja, Archit" <archit@ti.com>
Subject: RE: [PATCH v2 1/2] OMAP: DSS2: Introduce dss_features files
Date: Thu, 9 Sep 2010 16:23:58 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608703116F94B2@dbde02.ent.ti.com>
References: <1283944659-3824-1-git-send-email-archit@ti.com>
	 <1283944659-3824-2-git-send-email-archit@ti.com>
 <1284027911.13006.54.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56701 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754677Ab0IIKyF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Sep 2010 06:54:05 -0400
In-Reply-To: <1284027911.13006.54.camel@tubuntu.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

Tomi Valkeinen wrote:
> Hi,
> 
> On Wed, 2010-09-08 at 13:17 +0200, ext Archit Taneja wrote:
>> Add dss_features.c and dss_features.h for the dss_features framework
>> 
>> Signed-off-by: Archit Taneja <archit@ti.com>
>> ---
>>  drivers/video/omap2/dss/dss_features.c |  171
> ++++++++++++++++++++++++++++++++
>>  drivers/video/omap2/dss/dss_features.h |   51 ++++++++++
>>  2 files changed, 222 insertions(+), 0 deletions(-)  create mode
>> 100644 drivers/video/omap2/dss/dss_features.c
>>  create mode 100644 drivers/video/omap2/dss/dss_features.h
>> 
>> diff --git a/drivers/video/omap2/dss/dss_features.c
>> b/drivers/video/omap2/dss/dss_features.c
>> new file mode 100644
>> index 0000000..e87816f
>> --- /dev/null
>> +++ b/drivers/video/omap2/dss/dss_features.c
>> @@ -0,0 +1,171 @@
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
>> +	struct dss_reg_field reg_fields[MAX_DSS_REG_FIELDS];
> 
> Perhaps this should be a pointer to a list, and add a
> separate field for num_reg_fields. That way you don't need a
> MAX_DSS_REG_FIELDS definition.

If it is a pointer to a list then we can't initialize things statically, won't
we need functions at runtime to add to the list of reg_fields etc, this is what
I did in v1?

> 
>> +	u32 has_feature;
>> +
>> +	int num_mgrs;
>> +	int num_ovls;
>> +	enum omap_display_type supported_displays[MAX_DSS_MANAGERS];
>> +	enum omap_color_mode supported_color_modes[MAX_DSS_OVERLAYS];
> 
> Perhaps same could be done here.
> 
>> +};
>> +
>> +/* This struct is assigned to one of the below during initialization
>> +*/ static struct omap_dss_features omap_current_dss_features; +
>> +/* OMAP2 DSS Features */
>> +static struct omap_dss_features omap2_dss_features = { +	.reg_fields = {
>> +		{FIRHINC, 11, 0},
>> +		{FIRVINC, 27, 16},
>> +		{FIFOLOWTHRESHOLD, 8, 0},
>> +		{FIFOHIGHTHRESHOLD, 24, 16},
>> +		{FIFOSIZE, 8, 0},
> 
> You should have space after { and before }.

I will correct this.

> 
>> +	},
>> +
>> +	.num_mgrs = 2,
>> +	.num_ovls = 3,
>> +	.supported_displays = {
>> +		/* OMAP_DSS_CHANNEL_LCD */
>> +		OMAP_DISPLAY_TYPE_DPI | OMAP_DISPLAY_TYPE_DBI |
>> +		OMAP_DISPLAY_TYPE_SDI | OMAP_DISPLAY_TYPE_DSI,
>> +
>> +		/* OMAP_DSS_CHANNEL_DIGIT */
>> +		OMAP_DISPLAY_TYPE_VENC,
>> +	},
>> +	.supported_color_modes = {
>> +		/* OMAP_DSS_GFX */
>> +		OMAP_DSS_COLOR_CLUT1 | OMAP_DSS_COLOR_CLUT2 |
>> +		OMAP_DSS_COLOR_CLUT4 | OMAP_DSS_COLOR_CLUT8 |
>> +		OMAP_DSS_COLOR_RGB12U | OMAP_DSS_COLOR_RGB16 |
>> +		OMAP_DSS_COLOR_RGB24U | OMAP_DSS_COLOR_RGB24P,
>> +
>> +		/* OMAP_DSS_VIDEO1 */
>> +		OMAP_DSS_COLOR_RGB16 | OMAP_DSS_COLOR_RGB24U |
>> +		OMAP_DSS_COLOR_RGB24P | OMAP_DSS_COLOR_YUV2 |
>> +		OMAP_DSS_COLOR_UYVY,
>> +
>> +		/* OMAP_DSS_VIDEO2 */
>> +		OMAP_DSS_COLOR_RGB16 | OMAP_DSS_COLOR_RGB24U |
>> +		OMAP_DSS_COLOR_RGB24P | OMAP_DSS_COLOR_YUV2 |
>> +		OMAP_DSS_COLOR_UYVY,
>> +	},
>> +};
>> +
>> +/* OMAP3 DSS Features */
>> +static struct omap_dss_features omap3_dss_features = { +	.reg_fields = {
>> +		{FIRHINC, 12, 0},
>> +		{FIRVINC, 28, 16},
>> +		{FIFOLOWTHRESHOLD, 11, 0},
>> +		{FIFOHIGHTHRESHOLD, 27, 16},
>> +		{FIFOSIZE, 10, 0},
>> +	},
>> +	.has_feature	= FEAT_GLOBAL_ALPHA,
>> +
>> +	.num_mgrs = 2,
>> +	.num_ovls = 3,
>> +	.supported_displays = {
>> +		/* OMAP_DSS_CHANNEL_LCD */
>> +		OMAP_DISPLAY_TYPE_DPI | OMAP_DISPLAY_TYPE_DBI |
>> +		OMAP_DISPLAY_TYPE_SDI | OMAP_DISPLAY_TYPE_DSI,
>> +
>> +		/* OMAP_DSS_CHANNEL_DIGIT */
>> +		OMAP_DISPLAY_TYPE_VENC,
>> +	},
>> +	.supported_color_modes = {
>> +		/* OMAP_DSS_GFX */
>> +		OMAP_DSS_COLOR_CLUT1 | OMAP_DSS_COLOR_CLUT2 |
>> +		OMAP_DSS_COLOR_CLUT4 | OMAP_DSS_COLOR_CLUT8 |
>> +		OMAP_DSS_COLOR_RGB12U | OMAP_DSS_COLOR_ARGB16 |
>> +		OMAP_DSS_COLOR_RGB16 | OMAP_DSS_COLOR_RGB24U |
>> +		OMAP_DSS_COLOR_RGB24P | OMAP_DSS_COLOR_ARGB32 |
>> +		OMAP_DSS_COLOR_RGBA32 | OMAP_DSS_COLOR_RGBX32,
>> +
>> +		/* OMAP_DSS_VIDEO1 */
>> +		OMAP_DSS_COLOR_RGB24U | OMAP_DSS_COLOR_RGB24P |
>> +		OMAP_DSS_COLOR_RGB12U | OMAP_DSS_COLOR_RGB16 |
>> +		OMAP_DSS_COLOR_YUV2 | OMAP_DSS_COLOR_UYVY,
>> +
>> +		/* OMAP_DSS_VIDEO2 */
>> +		OMAP_DSS_COLOR_RGB12U | OMAP_DSS_COLOR_ARGB16 |
>> +		OMAP_DSS_COLOR_RGB16 | OMAP_DSS_COLOR_RGB24U |
>> +		OMAP_DSS_COLOR_RGB24P | OMAP_DSS_COLOR_YUV2 |
>> +		OMAP_DSS_COLOR_UYVY | OMAP_DSS_COLOR_ARGB32 |
>> +		OMAP_DSS_COLOR_RGBA32 | OMAP_DSS_COLOR_RGBX32,
>> +	},
>> +};
>> +
>> +/* Functions returning values related to a DSS feature */ int
>> +dss_feat_get_num_mgrs(void) {
>> +	return omap_current_dss_features.num_mgrs;
>> +}
>> +
>> +int dss_feat_get_num_ovls(void)
>> +{
>> +	return omap_current_dss_features.num_ovls;
>> +}
>> +
>> +enum omap_display_type dss_feat_get_supported_displays(int id) {
>> +	return omap_current_dss_features.supported_displays[id]; +}
>> +
>> +enum omap_color_mode dss_feat_get_supported_color_modes(int id) {
>> +	return omap_current_dss_features.supported_color_modes[id]; +}
>> +
>> +/* DSS has_feature check */
>> +bool dss_has_feature(enum dss_feat_id id) {
>> +	return omap_current_dss_features.has_feature & id; } +
>> +void dss_feat_get_reg_field(enum dss_feat_reg_field id, u8 *start, u8
>> +*end) { +	*start = omap_current_dss_features.reg_fields[id].start;
>> +	*end = omap_current_dss_features.reg_fields[id].end; +}
>> +
>> +void dss_features_init(void)
>> +{
>> +	if (cpu_is_omap24xx())
>> +		omap_current_dss_features = omap2_dss_features;
>> +	else
>> +		omap_current_dss_features = omap3_dss_features; }
>> diff --git a/drivers/video/omap2/dss/dss_features.h
>> b/drivers/video/omap2/dss/dss_features.h
>> new file mode 100644
>> index 0000000..f1a7e17
>> --- /dev/null
>> +++ b/drivers/video/omap2/dss/dss_features.h
>> @@ -0,0 +1,51 @@
>> +/*
>> + * linux/drivers/video/omap2/dss/dss_features.h
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
>> +#ifndef __OMAP2_DSS_FEATURES_H
>> +#define __OMAP2_DSS_FEATURES_H
>> +
>> +#define MAX_DSS_MANAGERS	2
>> +#define MAX_DSS_OVERLAYS	3
>> +#define MAX_DSS_REG_FIELDS	10
>> +
>> +/* DSS has feature id */
>> +enum dss_feat_id {
>> +	FEAT_GLOBAL_ALPHA	= 1 << 0,
>> +	FEAT_GLOBAL_ALPHA_VID1	= 1 << 1,
>> +};
>> +
>> +/* DSS register field id */
>> +enum dss_feat_reg_field {
>> +	FIRHINC,
>> +	FIRVINC,
>> +	FIFOHIGHTHRESHOLD,
>> +	FIFOLOWTHRESHOLD,
>> +	FIFOSIZE,
>> +};
> 
> These enums should also have some prefix. FEAT_REG?
> 
>> +
>> +/* DSS Feature Functions */
>> +int dss_feat_get_num_mgrs(void);
>> +int dss_feat_get_num_ovls(void);
>> +enum omap_display_type dss_feat_get_supported_displays(int id); enum
>> +omap_color_mode dss_feat_get_supported_color_modes(int id);
> 
> These functions are a bit confusing. I know they are similar
> to what already exists in DSS driver for overlays and managers, but...
> 
> Using get_num_mgrs() and then looping through then would
> suggest that the parameter to get_supported_displays() would
> be an index to an array (which it is), but at the same time
> the parameter is an overlay ID.
> Perhaps enum omap_plane and enum omap_channel from display.h
> could be used here?

Yes we can do that, we should change dss_init_overlays() and init_managers()
to loop around the enums then, and have case labels as "OMAP_DSS_GFX" and
"OMAP_DSS_VIDEO1".. instead of "0" "1" etc.

In the same way, the structs "omap_overlay" and "omap_overlay_manager"
should have an enum instead of "int id" as the member.

> 
> Which reminds me that the names of those enums in display.h
> should be also reviewed... A global "omap_channel" is not
> very descriptive =).
> Should perhaps be omap_dss_channel or manager".

I guess so, since its in the plat-omap folder..

Archit