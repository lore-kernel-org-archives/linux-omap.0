From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [PATCH v3 RESEND] OMAPDSS: DISPC: Improvements to DIGIT sync
 signal selection
Date: Wed, 1 Aug 2012 07:53:40 -0500
Message-ID: <501926D4.3010009@ti.com>
References: <1343779019-10611-1-git-send-email-ricardo.neri@ti.com> <1343802521.2645.6.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56506 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084Ab2HAMyz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Aug 2012 08:54:55 -0400
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id q71CssMw018453
	for <linux-omap@vger.kernel.org>; Wed, 1 Aug 2012 07:54:54 -0500
Received: from DFLE72.ent.ti.com (dfle72.ent.ti.com [128.247.5.109])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id q71Cssu9021713
	for <linux-omap@vger.kernel.org>; Wed, 1 Aug 2012 07:54:54 -0500
In-Reply-To: <1343802521.2645.6.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: archit@ti.com, s-guiriec@ti.com, linux-omap@vger.kernel.org

On 08/01/2012 01:28 AM, Tomi Valkeinen wrote:
> On Tue, 2012-07-31 at 18:56 -0500, Ricardo Neri wrote:
>> DSS code wrongly assumes that VENC is always available as source for the external
>> sync signal for the display controller DIGIT channel. One cannot blindly write/read
>> the value of DSS_CONTROL[15] as in certain processors (e.g., OMAP5) this operation
>> may not be valid. If the the sync source is not read correctly, the callers of
>> dss_get_hdmi_venc_clk_source might make wrong assumptions about, for instance,
>> video timings.
>>
>> Logic is added to correctly get the sync signal based on the available displays
>> in the DIGIT channel. The source is set only if both VENC and HDMI are supported.
>>
>> Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
>> ---
>> v3: instead of BUG_ON calls, select only if both VENC and HDMI are available.
>
> I think they do make sense. For example, if somebody calls this function
> and tries to set the switch to VENC on an OMAP that doesn't have VENC,
> something is wrong. Your new version just skips the register write in
> that case, which is ok, but I think we should also yell that something
> is wrong.
>
> I'd have the BUG_ONs there, but change them to WARN_ON. I think we
> should generally try to have less BUGs and more WARNs. Also, please keep
> the comment about the bits being written (VENC_HDMI_SWITCH), it helps to
> understand the code.

I will resubmit based on these comments.
>
>   Tomi
>

