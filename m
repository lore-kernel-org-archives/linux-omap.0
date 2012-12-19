From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: Re: [PATCH V2 4/6] OMAPDSS: DSI: Move DSI specific reg_fields to
 dsi_feats
Date: Wed, 19 Dec 2012 14:28:05 +0530
Message-ID: <50D1819D.2090404@ti.com>
References: <cover.1354086150.git.cmahapatra@ti.com> <cover.1354702077.git.cmahapatra@ti.com> <55965d940f45ecaf56f5145d7dcc8c28e4c9586f.1354702077.git.cmahapatra@ti.com> <50CF0EA6.2040302@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45834 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750721Ab2LSJBm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Dec 2012 04:01:42 -0500
In-Reply-To: <50CF0EA6.2040302@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Monday 17 December 2012 05:53 PM, Tomi Valkeinen wrote:
> Hi,
> 
> On 2012-12-05 12:16, Chandrabhanu Mahapatra wrote:
>> The DSI specific dss_reg_fields are moved to corresponding dsi_reg_fields
>> initialized in dsi_feats. The dsi_feats structure is initialized as per
>> corresponding DSS version in dsi_init_features().
>>
>> Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
>> ---
>>  drivers/video/omap2/dss/dsi.c          |  126 +++++++++++++++++++++++++++++---
>>  drivers/video/omap2/dss/dss_features.c |   16 ----
>>  drivers/video/omap2/dss/dss_features.h |    4 -
>>  3 files changed, 114 insertions(+), 32 deletions(-)
>>
> 
>> +static int __init dsi_init_features(struct platform_device *dsidev)
>> +{
>> +	const struct feats *src;
>> +	struct feats *dst;
>> +
>> +	dst = devm_kzalloc(&dsidev->dev, sizeof(*dst), GFP_KERNEL);
>> +	if (!dst) {
>> +		dev_err(&dsidev->dev, "Failed to allocate DISPC Features\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	switch (omapdss_get_version()) {
>> +	case OMAPDSS_VER_OMAP24xx:
>> +		src = &omap24xx_dsi_feats;
>> +		break;
>> +
>> +	case OMAPDSS_VER_OMAP34xx_ES1:
>> +	case OMAPDSS_VER_OMAP34xx_ES3:
>> +	case OMAPDSS_VER_OMAP3630:
>> +	case OMAPDSS_VER_AM35xx:
>> +		src = &omap34xx_dsi_feats;
>> +		break;
>> +
>> +	case OMAPDSS_VER_OMAP4430_ES1:
>> +	case OMAPDSS_VER_OMAP4430_ES2:
>> +	case OMAPDSS_VER_OMAP4:
>> +		src = &omap44xx_dsi_feats;
>> +		break;
>> +
>> +	case OMAPDSS_VER_OMAP5:
>> +		src = &omap54xx_dsi_feats;
>> +		break;
>> +
>> +	default:
>> +		return -ENODEV;
>> +	}
> 
> There's no DSI on OMAP2, so that case can be left out.
> 
>  Tomi
> 
> 

Ok. Forgot to see that in dss_features.

-- 
Chandrabhanu Mahapatra
Texas Instruments India Pvt. Ltd.
