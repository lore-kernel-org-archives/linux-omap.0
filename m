From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 2/2] omap4: mux: Remove duplicate mux modes
Date: Mon, 14 Mar 2011 18:22:18 +0100
Message-ID: <4D7E4ECA.5010200@ti.com>
References: <20110311203317.26901.67180.stgit@baageli.muru.com> <20110311203420.26901.36271.stgit@baageli.muru.com> <4D7DD4BC.7080104@ti.com> <20110314165922.GA7258@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45487 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310Ab1CNRWX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Mar 2011 13:22:23 -0400
In-Reply-To: <20110314165922.GA7258@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 3/14/2011 5:59 PM, Tony Lindgren wrote:
> * Cousson, Benoit<b-cousson@ti.com>  [110314 01:39]:
>> Hi Tony,
>>
>> On 3/11/2011 9:34 PM, Tony Lindgren wrote:
>>> Remove duplicate mux modes to make the binary smaller:
>>>
>>> text    data     bss     dec     hex filename
>>> 9378   24472       0   33850    843a mux44xx.o
>>> 9378   19104       0   28482    6f42 mux44xx.o
>>>
>>> Cc: Benoit Cousson<b-cousson@ti.com>
>>> Signed-off-by: Tony Lindgren<tony@atomide.com>
>>> ---
>>>   arch/arm/mach-omap2/mux44xx.c |  282 +----------------------------------------
>>>   1 files changed, 6 insertions(+), 276 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/mux44xx.c b/arch/arm/mach-omap2/mux44xx.c
>>> index c322e7b..9a66445 100644
>>> --- a/arch/arm/mach-omap2/mux44xx.c
>>> +++ b/arch/arm/mach-omap2/mux44xx.c
>>> @@ -755,25 +755,9 @@ static struct omap_ball __initdata omap4_core_cbl_ball[] = {
>>>   #endif
>>>
>>>   /*
>>> - * Superset of all mux modes for omap4 ES2.0
>>> + * Signals different on ES2.0 compared to superset
>>
>> I didn't do it originally due to the huge amount of differences
>> between the two versions and the impact at runtime it will imply to
>> fix the modified entries at boot time. It might still be interesting
>> to measure it.
>
> A quick test shows the difference is 0.007324218 - 0.007202148 seconds.. :)

Whaoo, 122us, that chip is really fast :-)

>> Since ES1 is no longer used on any board except the early one, that
>> you probably still have :-), it might be better to consider ES2 as
>> the superset and then store ES1 diff as the subset. It will avoid
>> any performance impact for the latest devices.
>
> Well the performance impact is minimal in this case. But from cutting
> down the size point of view that makes sense as then we could later on
> optionally compile out OMAP_PACKAGE_CBL.
>
> Sounds like that's a separate incremental patch on top of this one
> though.

OK, I'll try to make that for 2.6.40.

Benoit


