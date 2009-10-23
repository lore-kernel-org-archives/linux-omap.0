From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 2/2 v2] OMAP3:PM:SR: SmartReflex Refactor Rev3.0
Date: Thu, 22 Oct 2009 21:40:14 -0500
Message-ID: <4AE1178E.5060302@ti.com>
References: <1256232481-30636-1-git-send-email-nm@ti.com> <1256232481-30636-2-git-send-email-nm@ti.com> <1256232481-30636-3-git-send-email-nm@ti.com> <6A943D54E5EAED4BA437305D3EF62FB30326E922@zuk35exm61.ds.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55954 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751011AbZJWCkW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Oct 2009 22:40:22 -0400
In-Reply-To: <6A943D54E5EAED4BA437305D3EF62FB30326E922@zuk35exm61.ds.mot.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Imberton Guilhem-gimb01 <guilhem.imberton@motorola.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>, Roger Quadros <ext-roger.quadros@nokia.com>, Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>, "Reddy, Teerth" <teerth@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, =?ISO-8859-1?Q?H=F6gander_Jouni?= <jouni.hogander@nokia.com>, Mike Chan <mikechan@google.com>

Imberton Guilhem-gimb01 had written, on 10/22/2009 04:04 PM, the following:
>  I have one small comment on the actual implementation
>> +     do {
>> +             value = prm_read_mod_reg(OMAP3430_GR_MOD,
>> +                                      OMAP3_PRM_VC_BYPASS_VAL_OFFSET)
>> +                 & OMAP3430_VALID;
>> +             /* should i wait? */
>> +             if (value && (count % 50))
>> +                     udelay(10);
>> +             count--;
>> +             *timeout_us -= 5;
>> +     } while (value && count);
> 
> Why are you removing 5us every read ?
Thanks for catching this. Yep, I have got my counters mixed up :(.. will 
add it as part of v2 for tomorrow evening with other potential comments 
if any.

> If 50 iteration is 1us and we delay every loop by 10us we should remove 11us
> 
> Shouldn't it be:
> 
> +       do {
> +               value = prm_read_mod_reg(OMAP3430_GR_MOD,
> +                                        OMAP3_PRM_VC_BYPASS_VAL_OFFSET)
> +                   & OMAP3430_VALID;
> +               /* should i wait? */
> +               if (value && (count % 50)) {
> +                       udelay(10);
> +                     *timeout_us -= 11;
> +           }
> +               count--;
> +       } while (value && count);
> 
here is a problem with the above logic:
a) I dont know for sure if 50 iterations == 1 uSec.
b) count = timeout*5
   ==> if function is called with timeout = 10 uSec, count = 50, and 
udelay(10) will be called once. now *timeout -=11 will make it a 
negative value, which is not helpeful.

so, the decrement has to be by 10 OR i can pad timeout_us .. not exactly 
useful either..
-- 
Regards,
Nishanth Menon
