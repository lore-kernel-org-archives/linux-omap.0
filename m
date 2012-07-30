From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [PATCH 0/2] OMAPDSS: DISPC: Improvements to DIGIT sync signal
 selection
Date: Mon, 30 Jul 2012 14:21:50 -0500
Message-ID: <5016DECE.5000107@ti.com>
References: <1343434897-8444-1-git-send-email-ricardo.neri@ti.com> <1343646716.8019.22.camel@lappyti> <50167487.9080703@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36144 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754508Ab2G3TW4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Jul 2012 15:22:56 -0400
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id q6UJMugG005209
	for <linux-omap@vger.kernel.org>; Mon, 30 Jul 2012 14:22:56 -0500
Received: from DFLE73.ent.ti.com (dfle73.ent.ti.com [128.247.5.110])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id q6UJMujY003849
	for <linux-omap@vger.kernel.org>; Mon, 30 Jul 2012 14:22:56 -0500
In-Reply-To: <50167487.9080703@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, s-guiriec@ti.com, linux-omap@vger.kernel.org

Hi Tomi, Archit,

Thanks for your feedback.

On 07/30/2012 06:48 AM, Archit Taneja wrote:
> On Monday 30 July 2012 04:41 PM, Tomi Valkeinen wrote:
>> On Fri, 2012-07-27 at 19:21 -0500, Ricardo Neri wrote:
>>> Hello,
>>>
>>> DSS code wrongly assumes that VENC is always available as source for
>>> the external
>>> sync signal for the display controller DIGIT channel. One cannot blindly
>>> rely only on the value of DSS_CONTROL register as certain processors
>>> may not
>>> have VENC (e.g., OMAP5).
>>>
>>> These patches add logic to correctly set/get the sync signal based on
>>> the
>>> available displays in the DIGIT channel.
>>>
>>> For the HDMI driver, handle the error in the selection of the source.
>>
>> Is there an actual problem seen that this resolves? If so, It'd be nice
>> to have a brief description of the problem.
>
> The issue is seen on OMAP5 with a 3.5 kernel. In 3.5 kernel, we had a
> hack where we used to divide the TV manager's height by 2 if the
> connected interface was VENC. On OMAP5, the bit 15 returns VENC (a zero)
> irrespective of what we write.
>
> This won't happen in 3.6 as we have included interlace as a part of the
> omap_video_timings struct, and we don't try to check the bit to see
> whether we are VENC or HDMI.
>
> I guess we should still put a check to not set the bit on OMAP5 as it
> may cause unknown HW behavior, i.e, make the select function like:
>
> void dss_select_hdmi_venc_clk_source()
> {
>      ...
>
>      displays =
>          dss_feat_get_supported_displays(OMAP_DSS_CHANNEL_DIGIT);
>
>      if ((displays & OMAP_DISPLAY_TYPE_VENC) == 0)
>          return;
>
>      REG_FLD_MOD(DSS_CONTROL, src, 15, 15);    /* VENC_HDMI_SWITCH */
> }

As Tomi mentions, perhaps this could be complemented with a BUG_ON could 
be used if someone tries to use VENC as source when this is not available.
>
> Archit
>
>>
>> Does the bit 15 in DSS_CONTROL still exist on OMAP5? What does it return
>> on OMAP5?
>>
>> I think it's clear that dss_get_hdmi_venc_clk_source() needs to return a
>> correct value so that DSS operates correctly. But I'm not sure we need
>> the extra code in dss_select_hdmi_venc_clk_source().

Yes, the main purpose of these patch was to avoid blindly reading 
DSS_CONTROL[15]. The additions to selection were just for completeness.
>>
>> dss_select_hdmi_venc_clk_source() should be called by venc or hdmi, and
>> there should be any possibility of using it in the wrong way. For extra
>> sanity checking there could be a BUG_ON() check in the
>> dss_select_hdmi_venc_clk_source() to point out if there's a bad bug in
>> venc or hdmi.
>>
>> I'd like to keep the lowest level dss-internal functions as simple as
>> possible, and written in the manner that they presume they are called
>> correctly. Otherwise we'll end up with lots of new code, checking for
>> errors that can never happen in practice.
Well, this was an error that happened in practice :).

I will resubmit based on these comments.

Thanks,

Ricardo
>>
>>   Tomi
>>
>

