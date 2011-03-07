From: Sricharan R <r.sricharan@ti.com>
Subject: RE: [PATCH] omap2+: mux: Initialise the static pads.
Date: Mon, 7 Mar 2011 10:09:34 +0530
Message-ID: <2782019daf925e90676e1d40323b747e@mail.gmail.com>
References: <1299003360-32120-1-git-send-email-r.sricharan@ti.com>
 <20110304022832.GR20560@atomide.com> <44e29d555f2b399b7067d827603897cc@mail.gmail.com>
 <20110304162858.GW20560@atomide.com> <4ad439dff008aeca2a058207ef744650@mail.gmail.com>
 <20110304174301.GA20560@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:57161 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754920Ab1CGEjh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 6 Mar 2011 23:39:37 -0500
Received: by mail-vx0-f179.google.com with SMTP id 38so3237719vxc.10
        for <linux-omap@vger.kernel.org>; Sun, 06 Mar 2011 20:39:36 -0800 (PST)
In-Reply-To: <20110304174301.GA20560@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, paul@pswan.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

Hi Tony,
>-----Original Message-----
>From: Tony Lindgren [mailto:tony@atomide.com]
>Sent: Friday, March 04, 2011 11:13 PM
>To: Sricharan R
>Cc: linux-omap@vger.kernel.org; Benoit Cousson; paul@pswan.com; Santosh
>Shilimkar
>Subject: Re: [PATCH] omap2+: mux: Initialise the static pads.
>
>* Sricharan R <r.sricharan@ti.com> [110304 09:31]:
>> Hi Tony,
>>
>> >Hmm it's there as commit 93c5f165e10c21a3813a687204388a34072b2a62
>>
>> >in devel-mux branch. Can you please update your patch against
>>
>> >that commit so it's easier to see what your changes are?
>>
>> >
>>
>> >BTW, the patch you posted got trashed by your email client
>>
>> >or server..
>>
>> >
>>
>> Here is the updated patch on top of your previous patch.
>
>The patch formatting is still trashed, notice the double line
>spacing..
>

Very sorry about this.
Below is the link for the patch.
http://marc.info/?l=linux-omap&m=129947252016935&w=2

>> +++ b/arch/arm/mach-omap2/mux.c
>>
>> @@ -359,7 +359,6 @@ void omap_hwmod_mux(struct omap_hwmod_mux_info
*hmux,
>u8
>> state)
>
>..and the line wrapping of the patch lines.
>
>>
>> +     if ((state == _HWMOD_STATE_ENABLED) && hmux->pads_dynamic
>>
>> +                             && hmux->enabled) {
>
>Yes I see that might allow removing the idle flag. Will give it
>a try with my testcase once you get your mail issue sorted out
>and can post a patch that applies.
>
Ok. I have checked this applies on top of the devel-mux branch.
>Tony
>

Thanks,
 Sricharan
