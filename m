From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: timer: remove CONFIG_OMAP_32K_TIMER
Date: Mon, 12 Nov 2012 12:01:00 +0100
Message-ID: <50A0D6EC.2040608@ti.com>
References: <1352299344-8011-1-git-send-email-grinberg@compulab.co.il> <509AD478.1050904@ti.com> <509B666F.6080507@compulab.co.il> <509BFFDF.9040605@ti.com> <79CD15C6BA57404B839C016229A409A83EB68799@DBDE01.ent.ti.com> <509C050C.6010201@ti.com> <79CD15C6BA57404B839C016229A409A83EB71352@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33994 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751751Ab2KLLBX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Nov 2012 06:01:23 -0500
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EB71352@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Hunter, Jon" <jon-hunter@ti.com>, Igor Grinberg <grinberg@compulab.co.il>, Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

Hi Vaibhav,

On 11/12/2012 11:38 AM, Hiremath, Vaibhav wrote:
> On Fri, Nov 09, 2012 at 00:46:28, Hunter, Jon wrote:
>>
>> On 11/08/2012 12:59 PM, Hiremath, Vaibhav wrote:
>>> On Fri, Nov 09, 2012 at 00:24:23, Hunter, Jon wrote:
>>>>
>>>> On 11/08/2012 01:59 AM, Igor Grinberg wrote:
>>>>
>>>> [snip]
>>>>
>>>>> There is no reliable way to determine which source should be used in runtime
>>>>> for boards that do not have the 32k oscillator wired.
>>>>
>>>> So thinking about this some more and given that we are moving away from
>>>> board files, if a board does not provide a 32kHz clock source, then this
>>>> should be reflected in the device-tree source file for that board.
>>>> Hence, at boot time we should be able to determine if a 32kHz clock
>>>> source can be used.
>>>>
>>>
>>> Let me feed some more thoughts here :)
>>>
>>> The way it is being detected currently is based on timer idle status bit.
>>> I am worried that, this is the only option we have.
>>
>> Why not use device-tree to indicate the presence of a 32k clock source?
>> This seems like a board level configuration and so device-tree seems to
>> be the perfect place for this IMO.
>>
> 
> I think I agree with you, but for this to happen in clean way, its time to 
> start populating clock-nodes in DT, don't you think? Something like,
> 
> 
> clocks {
> 	rtc_clk: clk@X {
> 		compatible = "crystal-32k, per-32k, xyz";
> 		clock-frequency = <32768>;
> 	};
> 	...
> };
> 
> Timer {
> 
> 	ref-clock = <&rtc_clk>;
> };
> 
> What do you think?

That's indeed the proper way to do it, since this is a pure board level
parameter and we do have the binding to express that.
We just have to add that in the DTS:-)

Regards,
Benoit



