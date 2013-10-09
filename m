From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 3/3] ARM: OMAP3: fix dpll4_m3_ck and dpll4_m4_ck dividers
Date: Wed, 9 Oct 2013 16:43:29 +0300
Message-ID: <52555D81.7070100@ti.com>
References: <1381324359-28825-1-git-send-email-tomi.valkeinen@ti.com> <1381324359-28825-3-git-send-email-tomi.valkeinen@ti.com> <525558AA.9050906@ti.com> <52555B37.80407@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46960 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751190Ab3JINnx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Oct 2013 09:43:53 -0400
In-Reply-To: <52555B37.80407@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Archit Taneja <archit@ti.com>

On 10/09/2013 04:33 PM, Tomi Valkeinen wrote:
> On 09/10/13 16:22, Tero Kristo wrote:
>> On 10/09/2013 04:12 PM, Tomi Valkeinen wrote:
>>> dpll4_m3_ck and dpll4_m4_ck have divider bit fields which are 6 bits
>>> wide. However, only values from 1 to 32 are allowed. This means we have
>>> to add a divider tables and list the dividers explicitly.
>>>
>>> I believe the same issue is there for other dpll4_mx_ck clocks, but as
>>> I'm not familiar with them, I didn't touch them.
>>
>> I think you can limit the max value with a mask only, no need to define
>> new tables.
>
> The bit field is 6 bits wide, so the mask is correct. It's just that the
> biggest allowed value is 32, which takes 6 bits, not 63.
>
> Changing the mask to 5 bits would limit the divider to 31, wouldn't it?

Oh true. Sucks with legacy clocks then.

For dt clocks, you should be able to declare max / min divider values 
for ti,divider-clock type which would take care of this case. Just 
change the ti,max-div = <63>; field to ... = <32>;

-Tero

