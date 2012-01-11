From: Archit <a0393947@ti.com>
Subject: Re: DSS2/PM on 3.2 broken?
Date: Wed, 11 Jan 2012 19:52:13 +0530
Message-ID: <4F0D9B15.4070803@ti.com>
References: <WC20120109124643.880164@terrafix.co.uk> <20120110080849.5a242adf@notabene.brown> <alpine.DEB.2.00.1201110632100.31702@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46526 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932404Ab2AKOWb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Jan 2012 09:22:31 -0500
In-Reply-To: <alpine.DEB.2.00.1201110632100.31702@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>
Cc: Paul Walmsley <paul@pwsan.com>, NeilBrown <neilb@suse.de>, khilman@ti.com, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi,

On Wednesday 11 January 2012 07:13 PM, Paul Walmsley wrote:
> cc Kevin
>
> On Tue, 10 Jan 2012, NeilBrown wrote:
>
>> It seems that when cpuidle on an omap3 tries to switch to lower power
>> states, various things misbehave:
>>   - UARTs lose characters
>
> Is this with off-mode enabled, or is this with only retention idle
> enabled?
>
> If off-mode is enabled, and incoming serial traffic is used to wake the
> system, it's known and expected that the first byte will be lost.  This is
> an artifact of the hardware and seems to be unavoidable.
>
>>   - dss loses sync
>
> Best to take this up with the DSS maintainer directly.

Could you enable omapdss debug by adding 'omapdss.debug=1 debug' in your 
bootargs and share logs?

The pm_runtime_get_sync() call in dss_runtime_get() is returning  a 
negative value, could you print out that value too?

If the call to pm_runtime_get_sync() fails, we bail out immediately. So 
the LCD interface shouldn't have been enabled at all. I don't know why 
we get sync lost errors.

There is a possibility that the LCD interface wasn't switched off when 
for some reason when we suspended, and switching on the clocks again 
tries to start the transfer without DSS being configured correctly?

Also, are you on the final 3.2, or the 3.2-rc's by any chance? There 
were some hwmod patches which got in 3.2-rc4 related to hwmod fixes.

Archit

>
>>   - HDQ seems to lose everything.
>
> Is this with off-mode enabled, or just with retention idle?
>
> If the former, this is hardly surprising as the HDQ driver
> (drivers/w1/masters/omap_hdq.c) doesn't contain any context save/restore
> code.  In fact the HDQ driver doesn't even use PM runtime, so quite a bit
> of work is needed there.
>
>
> - Paul
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

