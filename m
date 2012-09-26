From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH v2 10/18] OMAPDSS: DISPC: Configure input and output sizes
 for writeback
Date: Wed, 26 Sep 2012 11:52:03 +0530
Message-ID: <50629F0B.1080904@ti.com>
References: <1347538505-25359-1-git-send-email-archit@ti.com>  <1348553993-8083-1-git-send-email-archit@ti.com>  <1348553993-8083-11-git-send-email-archit@ti.com> <1348583595.21717.2.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47554 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752319Ab2IZGWC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 26 Sep 2012 02:22:02 -0400
In-Reply-To: <1348583595.21717.2.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Tuesday 25 September 2012 08:03 PM, Tomi Valkeinen wrote:
> On Tue, 2012-09-25 at 11:49 +0530, Archit Taneja wrote:
>> Writeback uses the WB_PICTURE_SIZE register to define the size of the content
>> written to memory, this is the output of the scaler. It uses the WB_SIZE
>> register to define the size of the content coming from the overlay/manager to
>> which it is connected, this is the input to the scaler. This naming is different
>> as compared to overlays.
>>
>> Add checks for writeback in dispc_ovl_set_input_size() and
>> dispc_ovl_set_output_size() to write to the correct registers.
>>
>> Signed-off-by: Archit Taneja <archit@ti.com>
>> ---
>>   drivers/video/omap2/dss/dispc.c |    7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
>> index e42e902..04fdd33 100644
>> --- a/drivers/video/omap2/dss/dispc.c
>> +++ b/drivers/video/omap2/dss/dispc.c
>> @@ -719,7 +719,7 @@ static void dispc_ovl_set_input_size(enum omap_plane plane, int width,
>>   {
>>   	u32 val = FLD_VAL(height - 1, 26, 16) | FLD_VAL(width - 1, 10, 0);
>>
>> -	if (plane == OMAP_DSS_GFX)
>> +	if (plane == OMAP_DSS_GFX || plane == OMAP_DSS_WB)
>>   		dispc_write_reg(DISPC_OVL_SIZE(plane), val);
>>   	else
>>   		dispc_write_reg(DISPC_OVL_PICTURE_SIZE(plane), val);
>> @@ -734,7 +734,10 @@ static void dispc_ovl_set_output_size(enum omap_plane plane, int width,
>>
>>   	val = FLD_VAL(height - 1, 26, 16) | FLD_VAL(width - 1, 10, 0);
>>
>> -	dispc_write_reg(DISPC_OVL_SIZE(plane), val);
>> +	if (plane == OMAP_DSS_WB)
>> +		dispc_write_reg(DISPC_OVL_PICTURE_SIZE(plane), val);
>> +	else
>> +		dispc_write_reg(DISPC_OVL_SIZE(plane), val);
>>   }
>
> Should we just rename the dispc registers to DISPC_OVL_IN_SIZE and
> DISPC_OVL_OUT_SIZE, and then we could do without the ifs? The registers
> have always confused me a bit, I don't know why they are named so in the
> TRM.

It'll be hard for someone who's referring to the TRM in that case. It'll 
also be hard to track reg dumps if these names change. I think we should 
stick to the TRM names only.

Archit

