From: Nishanth Menon <nm@ti.com>
Subject: Re: OMAP baseline test results for v3.10-rc6
Date: Tue, 2 Jul 2013 09:15:50 -0500
Message-ID: <51D2E096.5040700@ti.com>
References: <alpine.DEB.2.02.1306170521020.9909@utopia.booyaka.com> <20130625160243.GE22312@arwen.pp.htv.fi> <alpine.DEB.2.02.1306251746060.14373@utopia.booyaka.com> <51C9F0A8.1050607@ti.com> <87fvw6t136.fsf@linaro.org> <79CD15C6BA57404B839C016229A409A83ECC952D@DBDE04.ent.ti.com> <51CAEB33.5010101@ti.com> <alpine.DEB.2.02.1306261722520.6135@utopia.booyaka.com> <51CBBCD8.5030600@ti.com> <alpine.DEB.2.02.1306281844090.8767@utopia.booyaka.com> <alpine.DEB.2.02.1307010211580.3741@utopia.booyaka.com> <79CD15C6BA57404B839C016229A409A83ECCC435@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41807 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751959Ab3GBOQO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Jul 2013 10:16:14 -0400
In-Reply-To: <79CD15C6BA57404B839C016229A409A83ECCC435@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "Vutla, Lokesh" <lokeshvutla@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, Kevin Hilman <khilman@linaro.org>, "Rini, Tom" <trini@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 07/01/2013 11:29 PM, Hiremath, Vaibhav wrote:
>
>> -----Original Message-----
>> From: Paul Walmsley [mailto:paul@pwsan.com]
>> Sent: Monday, July 01, 2013 7:46 AM
>> To: Vutla, Lokesh
>> Cc: Nayak, Rajendra; Hiremath, Vaibhav; Kevin Hilman; Rini, Tom; linux-
>> omap@vger.kernel.org; Balbi, Felipe; linux-arm-
>> kernel@lists.infradead.org
>> Subject: Re: OMAP baseline test results for v3.10-rc6
>>
>> On Fri, 28 Jun 2013, Paul Walmsley wrote:
>>
>>> On Thu, 27 Jun 2013, Lokesh Vutla wrote:
>>>
>>>> Here is the catch..
>>>> Your dtb is generated in arch/arm/boot/dts/ folder(before V3.8 dtb
>> was
>>>> generated in arch/arm/boot).
>>>
>>> Ugh... that's probably it :-(
to prevent this from happening again, Lokesh did post a patch:
https://patchwork.kernel.org/patch/2796921/

Will be good to ack it if we think it might prevent such scenarios in 
the future.

-- 
Regards,
Nishanth Menon
