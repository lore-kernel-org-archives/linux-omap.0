From: Sathya Prakash <a0393677@ti.com>
Subject: Re: [PATCH v2 2/4] ARM: AM43xx: fix dpll init in bypass mode
Date: Thu, 13 Mar 2014 16:02:43 +0530
Message-ID: <5321894B.8010003@ti.com>
References: <1394701109-6721-1-git-send-email-sathyap@ti.com> <1394701109-6721-3-git-send-email-sathyap@ti.com> <53218751.20900@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33271 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753437AbaCMKct (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Mar 2014 06:32:49 -0400
In-Reply-To: <53218751.20900@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Sathya Prakash M R <sathyap@ti.com>, tony@atomide.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, paul@pwsan.com

On Thursday 13 March 2014 03:54 PM, Tomi Valkeinen wrote:
> On 13/03/14 10:58, Sathya Prakash M R wrote:
>> From: Tomi Valkeinen <tomi.valkeinen@ti.com>
>>
>> On AM43xx, if a PLL is in bypass at kernel init, the code in
>> omap2_get_dpll_rate() will not realize this and will try to calculate
>> the clock rate using the multiplier and the divider, resulting in
>> errors.
>>
>> omap2_init_dpll_parent() has similar issue.
>>
>> Add the missing soc_is_am43xx() check to make the code work on AM43xx.
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> I see you sent this already in December, and Paul asked for your
> signed-off for it, but you never replied.
just saw. Maybe i missed it during december vacation.
Will update it in v3 alongwith other changes you suggested.

>
>   Tomi
>
Sathya

