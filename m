From: Stefan Roese <stefan.roese@gmail.com>
Subject: Re: [RFC 00/22] OMAPDSS: DT support
Date: Wed, 04 Sep 2013 09:29:02 +0200
Message-ID: <5226E13E.1030807@gmail.com>
References: <1376037547-10859-1-git-send-email-tomi.valkeinen@ti.com> <2305295.bk1TpuGLMv@avalon> <5224458F.9070401@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:40310 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756283Ab3IDH3N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Sep 2013 03:29:13 -0400
In-Reply-To: <5224458F.9070401@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Archit Taneja <archit@ti.com>, Nishanth Menon <nm@ti.com>, Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>

On 28.08.2013 13:40, Tero Kristo wrote:
> On 08/28/2013 01:14 PM, Tomi Valkeinen wrote:
>> On 28/08/13 12:48, Tero Kristo wrote:
>>> On 08/28/2013 12:22 PM, Tomi Valkeinen wrote:
>>>> Hi,
>>>>
>>>> I'm seeing odd clock behavior with Beagle, booting with DT. I'm using
>>>> v3.11-rc7 + DSS DT patches.
>>>
>>> I guess you are not using the clock DT patches? Just making sure I
>>> didn't break anything.
>>
>> No, plain rc7 with my DSS DT patches.
>>
>>>> So, for some reason, the first clk_set_rate goes wrong. Any ideas?
>>>
>>> Hmm, strange. I am not seeing similar behavior, but I am calling
>>> clk_set_rate in different location.... also I am using clock DT patches
>>> (don't try the current version though, as I am reworking them.)
>>>
>>> [    0.000000] dpll4_ck: 432000000
>>> [    0.000000] dpll4_m4_ck: 72000000
>>> [    0.000000] dpll4_m4x2_ck: 144000000
>>> [    0.000000] dss1_alwon_fck_3430es2: 144000000
>>> [    0.000000] dpll4_ck: 432000000
>>> [    0.000000] dpll4_m4_ck: 86400000
>>> [    0.000000] dpll4_m4x2_ck: 172800000
>>> [    0.000000] dss1_alwon_fck_3430es2: 172800000
>>>
>>> Do you see the error only when setting to some specific rate (86400000)
>>> or it doesn't matter?
>>
>> I also tried setting to 72000000, with the same result.
>>
>> Do you know if I can somehow easily get debug prints from the clock
>> framework, that could lighten up the issue?
>
> There isn't any good config option for that, I would suggest add prints
> to the clk_set_rate and then for the clocks you are interested in, print
> results for the recalc_rate / set_rate ops also.

Tomi, did you make any progress on this issue? If not I'll try to dig
into it later this week.

BTW: Whats the current plan for your OMAPDSS DT patchset? Is it queued
for v3.12 (this merge windows)? And do you have a git tree to pull the
latest version from?

Thanks,
Stefan

