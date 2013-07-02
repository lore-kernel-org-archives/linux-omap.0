From: Roger Quadros <rogerq@ti.com>
Subject: Re: omap4 ehci sporadic resume issue
Date: Tue, 2 Jul 2013 18:03:23 +0300
Message-ID: <51D2EBBB.8000504@ti.com>
References: <51CC2755.2030505@amarulasolutions.com> <51CC454A.1040104@ti.com> <20130627141704.GF12956@panicking> <51CC5105.4070301@ti.com> <20130627175623.GB21364@panicking> <CAB=otbQXVqFKOTtgvif=FZnWgDpbovAB6naPKTrsEHUJb21xTw@mail.gmail.com> <20130627192413.GA14115@panicking> <CAB=otbT-BcJg5tNZ=7jd1jvoK8N1Hd_skScuxczaeP=tagdcSw@mail.gmail.com> <20130628113314.GA25536@panicking> <51CD7783.8030907@ti.com> <20130628164751.GA1281@panicking> <51D2E6DA.6030000@ti.com> <51D2E88A.7050202@amarulasolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43012 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752907Ab3GBPD1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Jul 2013 11:03:27 -0400
In-Reply-To: <51D2E88A.7050202@amarulasolutions.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Ruslan Bilovol <ruslan.bilovol@ti.com>, USB list <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>


On 07/02/2013 05:49 PM, Michael Trimarchi wrote:
> Hi Roger
> 
> On 07/02/2013 04:42 PM, Roger Quadros wrote:
>> On 06/28/2013 07:47 PM, Michael Trimarchi wrote:
>>> Hi
>>>

>>>>
>>>> When you said earlier that the problem doesn't happen when one of the ULPIs is used
>>>> did you try both of them individually. e.g. case 1: port 1 only enabled,
>>>> case 2: port 2 only enabled.
>>>>
>>>> Did it work in both the cases?
>>>
>>> Yes, so I don't think could be a problem of ulpi pins and why this happen
>>> on both at the same time? Seems more connected to somenthing else.
>>>
>>
>> Right. Seems to be related to two things. OFF Mode and 2 ports being used simultaneously.
>>
>> I'm not sure how to go about fixing this. How important is OFF Mode for your application.
>> Can you keep it always disabled?
>>


> 
> Right now I delivery without off mode. I will try to fix in long run the usb and I think that it could be a good platform to test omap4 mainline.
> 

Yes, our aim is to get it working with mainline as well.

> Last question:
> If one domain is in RET mode and not OFF mode what happen during SAR restore in OFF mode?
> 

SAR restore will only happen when the Device enters OFF mode.

Device OFF mode can only be reached when all voltage domains are switched OFF and that would depend
if all power domains entered OFF or not. Just a simplistic explanation. You can refer to chapter
"3.9.3 Device OFF State Management" in the TRM.

cheers,
-roger
