From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 2/2] ARM: OMAP2+: Remove legacy DSS initialization for
 omap4
Date: Fri, 2 Aug 2013 08:31:13 -0500
Message-ID: <51FBB4A1.6080507@ti.com>
References: <1374570405-8301-1-git-send-email-tomi.valkeinen@ti.com> <1374570405-8301-3-git-send-email-tomi.valkeinen@ti.com> <51FBAC91.8040401@ti.com> <51FBAE5C.1060602@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47798 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751729Ab3HBNbg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Aug 2013 09:31:36 -0400
In-Reply-To: <51FBAE5C.1060602@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 08/02/2013 08:04 AM, Tomi Valkeinen wrote:
> On 02/08/13 15:56, Nishanth Menon wrote:
>> On 07/23/2013 04:06 AM, Tomi Valkeinen wrote:
>>> This is no longer needed as omap4 is now booted using device tree.
>>>
>>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>>> ---
>
> <snip>
>
>>> diff --git a/arch/arm/mach-omap2/dss-common.h
>>> b/arch/arm/mach-omap2/dss-common.h
>>> index 915f6ff..c28fe3c 100644
>>> --- a/arch/arm/mach-omap2/dss-common.h
>>> +++ b/arch/arm/mach-omap2/dss-common.h
>>> @@ -6,9 +6,7 @@
>>>     * This file will be removed when DSS supports DT.
>>>     */
>>>
>>> -void __init omap4_panda_display_init(void);
>>>    void __init omap4_panda_display_init_of(void);
>>> -void __init omap_4430sdp_display_init(void);
>>>    void __init omap_4430sdp_display_init_of(void);
>>>
>>>    #endif
>>>
>>
>> Am I missing some series which introduces dts entries for the pinctrl
>> and gpios for omap4 support?
>
> Umm... What? =).
>
> In this dss-common.c file we have code to add the SDP and Panda DSS
> related devices, for both board-file booting and for DT booting. Now the
> board-file booting is no longer available, so we can remove the parts
> that are purely for board-file booting.

Aaah. sorry about that, i was not completely enlightned about lack of 
dts conversion for DSS into dts.


-- 
Regards,
Nishanth Menon
