From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [PATCH v2] OMAPDSS: DISPC: Improve DIGIT channel sync signal
 selection
Date: Tue, 31 Jul 2012 18:49:59 -0500
Message-ID: <50186F27.5060703@ti.com>
References: <1343693484-26133-1-git-send-email-ricardo.neri@ti.com> <1343713571.4685.6.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45598 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756488Ab2GaXvG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Jul 2012 19:51:06 -0400
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id q6VNp5wg018922
	for <linux-omap@vger.kernel.org>; Tue, 31 Jul 2012 18:51:05 -0500
Received: from DLEE74.ent.ti.com (dlee74.ent.ti.com [157.170.170.8])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id q6VNp5Pm006225
	for <linux-omap@vger.kernel.org>; Tue, 31 Jul 2012 18:51:05 -0500
In-Reply-To: <1343713571.4685.6.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: archit@ti.com, s-guiriec@ti.com, linux-omap@vger.kernel.org

On 07/31/2012 12:46 AM, Tomi Valkeinen wrote:
> On Mon, 2012-07-30 at 19:11 -0500, Ricardo Neri wrote:
>> DSS code wrongly assumes that VENC is always available as source for the external
>> sync signal for the display controller DIGIT channel. One cannot blindly
>> rely only on the value of DSS_CONTROL[15] as on certain processors (e.g., OMAP5)
>> reading/writing on that bit may not be valid. If the the sync source is not read
>> correctly, the callers of dss_get_hdmi_venc_clk_source might make wrong assumptions
>> about, for instance, video timings.
>>
>> This patch adds logic to correctly get the sync signal based on the
>> available displays in the DIGIT channel. A kernel BUG is thrown if an
>> invalid source is selected.
>>
>> Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
>> ---
>> v2: use BUG_ON() to simplify handling of invalid cases.
>>   drivers/video/omap2/dss/dss.c |   13 +++++++++++--
>>   1 files changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
>> index 04b4586..2f8e4b6 100644
>> --- a/drivers/video/omap2/dss/dss.c
>> +++ b/drivers/video/omap2/dss/dss.c
>> @@ -648,9 +648,15 @@ void dss_set_dac_pwrdn_bgz(bool enable)
>>   	REG_FLD_MOD(DSS_CONTROL, enable, 5, 5);	/* DAC Power-Down Control */
>>   }
>>
>> -void dss_select_hdmi_venc_clk_source(enum dss_hdmi_venc_clk_source_select hdmi)
>> +void dss_select_hdmi_venc_clk_source(enum dss_hdmi_venc_clk_source_select src)
>>   {
>> -	REG_FLD_MOD(DSS_CONTROL, hdmi, 15, 15);	/* VENC_HDMI_SWITCH */
>> +	enum omap_display_type dp;
>> +	dp = dss_feat_get_supported_displays(OMAP_DSS_CHANNEL_DIGIT);
>> +
>> +	BUG_ON((src == DSS_VENC_TV_CLK) && !(dp & OMAP_DISPLAY_TYPE_VENC));
>> +	BUG_ON((src == DSS_HDMI_M_PCLK) && !(dp & OMAP_DISPLAY_TYPE_HDMI));
>> +
>> +	REG_FLD_MOD(DSS_CONTROL, src, 15, 15);	/* VENC_HDMI_SWITCH */
>>   }
>
> This one will still write to the reserved bit 15 on OMAP5.

Oops. I missed that case.
>
> Perhaps we could check if both VENC and HDMI are supported, and if not,
> return.

Then in that case the BUG_ON calls will not make sense. I will resend.

Ricardo
>
>   Tomi
>

