From: Archit Taneja <a0393947@ti.com>
Subject: Re: OMAP4 errata i740
Date: Fri, 30 Mar 2012 14:04:28 +0530
Message-ID: <4F757014.5030006@ti.com>
References: <1333094862.1932.15.camel@deskari>  <CAMQu2gx30OLnxTS8TOh=xc36fFgtPs08Zhhx6raYDAQ3nxfO1g@mail.gmail.com> <1333095982.1932.21.camel@deskari> <4F756F66.6020103@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52097 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759930Ab2C3Iew (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Mar 2012 04:34:52 -0400
In-Reply-To: <4F756F66.6020103@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@ti.com>

On Friday 30 March 2012 02:01 PM, Santosh Shilimkar wrote:
> + Kevin
>
> On Friday 30 March 2012 01:56 PM, Tomi Valkeinen wrote:
>> On Fri, 2012-03-30 at 13:51 +0530, Shilimkar, Santosh wrote:
>>> On Fri, Mar 30, 2012 at 1:37 PM, Tomi Valkeinen<tomi.valkeinen@ti.com>  wrote:
>>
>>>> All OMAP4 versions seem to be affected. I couldn't find a mention about
>>>> this in the mainline kernel. Any ideas how and where this should be
>>>> fixed?
>>>>
>>> It's not patched for mainline. Generally clock-domain code
>>> is abstracted from drivers but considering the errata and affected
>>> modules, I guees it should be handled by DSS driver
>>> since that is where the state of DSS or ISS will be known. Note
>>> ISS will be automatically taken care since it will always use disaplay.
>>>
>>> In internal tree's this was handled as part of DSS early suspend/resume
>>
>> That version doesn't work as it uses functions that are not exported to
>> drivers.
>>
>> I don't know much about the clock domain code, but I hope there's a way
>> to handle it there. Otherwise I guess I need to add a new set of
>> platform callback functions, so that the dss driver can call
>> arch/arm/mach-omap2 code to enable and disable the work-around. I
>> dislike that because I'm currently trying to remove those kinds of hacks
>> to make dss work better with DT =).
>>
> I agree. In fact I faced similar issue when I briefly tried moving
> OMAP cpuidle code to drivers/idle/*.
>
> That time me and Kevin concluded that till we move the powerdomain,
> clockdomain code to drivers/* and export it, the cpuidle movement
> needs to be deferred.

How about preventing the issue to occur by keeping DSS and ISS in 
No-standby mode for the affected OMAP versions. The errata says:

"Such a situation can occur when the impacted initiator is generating 
short MStandby pulses (pulse durations less than one L4 clock cycle)"

Chaning the mstandby hwmod data for DSS and ISS would prevent the need 
for exporting these clock domain functions only for this errata.

Archit


>
> Regards
> Santosh
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

