From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH 0/2] OMAPDSS: DISPC: Improvements to DIGIT sync signal
 selection
Date: Mon, 30 Jul 2012 17:18:23 +0530
Message-ID: <50167487.9080703@ti.com>
References: <1343434897-8444-1-git-send-email-ricardo.neri@ti.com> <1343646716.8019.22.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49826 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752456Ab2G3Ltr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Jul 2012 07:49:47 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id q6UBnjRP021270
	for <linux-omap@vger.kernel.org>; Mon, 30 Jul 2012 06:49:46 -0500
In-Reply-To: <1343646716.8019.22.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Ricardo Neri <ricardo.neri@ti.com>, s-guiriec@ti.com, linux-omap@vger.kernel.org

On Monday 30 July 2012 04:41 PM, Tomi Valkeinen wrote:
> On Fri, 2012-07-27 at 19:21 -0500, Ricardo Neri wrote:
>> Hello,
>>
>> DSS code wrongly assumes that VENC is always available as source for the external
>> sync signal for the display controller DIGIT channel. One cannot blindly
>> rely only on the value of DSS_CONTROL register as certain processors may not
>> have VENC (e.g., OMAP5).
>>
>> These patches add logic to correctly set/get the sync signal based on the
>> available displays in the DIGIT channel.
>>
>> For the HDMI driver, handle the error in the selection of the source.
>
> Is there an actual problem seen that this resolves? If so, It'd be nice
> to have a brief description of the problem.

The issue is seen on OMAP5 with a 3.5 kernel. In 3.5 kernel, we had a 
hack where we used to divide the TV manager's height by 2 if the 
connected interface was VENC. On OMAP5, the bit 15 returns VENC (a zero) 
irrespective of what we write.

This won't happen in 3.6 as we have included interlace as a part of the 
omap_video_timings struct, and we don't try to check the bit to see 
whether we are VENC or HDMI.

I guess we should still put a check to not set the bit on OMAP5 as it 
may cause unknown HW behavior, i.e, make the select function like:

void dss_select_hdmi_venc_clk_source()
{
	...

	displays =
		dss_feat_get_supported_displays(OMAP_DSS_CHANNEL_DIGIT);

	if ((displays & OMAP_DISPLAY_TYPE_VENC) == 0)
		return;

	REG_FLD_MOD(DSS_CONTROL, src, 15, 15);	/* VENC_HDMI_SWITCH */
}

Archit

>
> Does the bit 15 in DSS_CONTROL still exist on OMAP5? What does it return
> on OMAP5?
>
> I think it's clear that dss_get_hdmi_venc_clk_source() needs to return a
> correct value so that DSS operates correctly. But I'm not sure we need
> the extra code in dss_select_hdmi_venc_clk_source().
>
> dss_select_hdmi_venc_clk_source() should be called by venc or hdmi, and
> there should be any possibility of using it in the wrong way. For extra
> sanity checking there could be a BUG_ON() check in the
> dss_select_hdmi_venc_clk_source() to point out if there's a bad bug in
> venc or hdmi.
>
> I'd like to keep the lowest level dss-internal functions as simple as
> possible, and written in the manner that they presume they are called
> correctly. Otherwise we'll end up with lots of new code, checking for
> errors that can never happen in practice.
>
>   Tomi
>

