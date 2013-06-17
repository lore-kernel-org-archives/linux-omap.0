From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 0/2] Remove unused voltagedomain data for AM33xx
Date: Mon, 17 Jun 2013 10:42:17 +0530
Message-ID: <51BE9AB1.2080308@ti.com>
References: <1371118124-15910-1-git-send-email-rnayak@ti.com> <alpine.DEB.2.02.1306140243380.5514@utopia.booyaka.com> <8738skaj16.fsf@linaro.org> <79CD15C6BA57404B839C016229A409A83ECB9CD9@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53459 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754646Ab3FQFMu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Jun 2013 01:12:50 -0400
In-Reply-To: <79CD15C6BA57404B839C016229A409A83ECB9CD9@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Kevin Hilman <khilman@linaro.org>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Menon, Nishanth" <nm@ti.com>

On Monday 17 June 2013 10:38 AM, Hiremath, Vaibhav wrote:
> 
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Kevin Hilman
>> Sent: Friday, June 14, 2013 7:31 PM
>> To: Paul Walmsley
>> Cc: Nayak, Rajendra; Hiremath, Vaibhav; linux-omap@vger.kernel.org;
>> linux-arm-kernel@lists.infradead.org
>> Subject: Re: [PATCH 0/2] Remove unused voltagedomain data for AM33xx
>>
>> Paul Walmsley <paul@pwsan.com> writes:
>>
>>> cc Kevin, Vaibhav
>>>
>>> On Thu, 13 Jun 2013, Rajendra Nayak wrote:
>>>
>>>> The powerdomain framework today expects to always have a
>> voltagedomain
>>>> associated with a given powerdomain. We already have AM33xx which
>>>> has no Voltage Controller/Voltage Processor as part of PRCM.
>>>> There are more SoCs' to follow starting with AM437x and DRA7xx
>>>> which do not have VC/VP.
>>>>
>>>> Instead of adding dummy voltage domain data files, make the
>> powerdomain
>>>> framework aware of the fact that some SoCs' might not really have
>>>> scalable voltage domains.
>>>
>>> Fine with me in principle if AM335x doesn't support voltage scaling.
>>> Vaibhav, if this is okay for you, please ack it.
>>>
>>> Then, in terms of merging, probably Kevin would be the right person
>> for
>>> this since he's done much of the voltagedomain work.
>>
>> Yeah, I'll take this series after the minor issues I commented on are
>> fixed, and Vaivhav ack's the AM33xx parts.
>>
> 
> Yeup, Feel free to add my Ack here.

Thanks Vaibhav, I will add your and Nishanths' ack for this series
and repost a v2 addressing Kevins comments.

regards,
Rajendra
> 
> 
> Thanks,
> Vaibhav 
> 

