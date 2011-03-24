From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 1/7] OMAP2+: hwmod: remove unused voltagedomain pointer
Date: Thu, 24 Mar 2011 16:14:19 +0100
Message-ID: <4D8B5FCB.1050006@ti.com>
References: <1300493932-17362-1-git-send-email-khilman@ti.com>	<1300493932-17362-2-git-send-email-khilman@ti.com>	<4D874DC9.6020203@ti.com> <87vczcfq19.fsf@ti.com>	<AANLkTi==Mz=szoa78EaRKgqTddOeu5xEeg5hfNWbWWO2@mail.gmail.com> <87tyes39ew.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53702 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753909Ab1CXPO0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Mar 2011 11:14:26 -0400
In-Reply-To: <87tyes39ew.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "Gulati, Shweta" <shweta.gulati@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsely <paul@pwsan.com>

On 3/24/2011 3:00 PM, Hilman, Kevin wrote:
> Hi Shweta,
>
> "Gulati, Shweta"<shweta.gulati@ti.com>  writes:
>
> [...]
>
>>>>
>>>> And what about vdd_name? It should probably be removed as well.
>>>>
>>>
>>> Yes, but it's currently used by the SR layer (currently the only user.)
>>>
>>> Removing it required cleaning up the SR layer as well, so I decided to
>>> leave the SR cleanups for someone else for the moment while I focus on
>>> the voltage layer(s)
>>>
>> Even if we try to remove 'vdd_name', how should we get 'struct voltagedomain'
>> info corresponding to sr_mpu, sr_core in sr_dev_init API?
>>
>> As functional clock of SR1 and SR2 are from wake up domain, so even if
>> we try to use current Clockdomain and Powerdomain framework APIs, to
>> get 'clkdomain' pointer and then retrieve 'pwrdomain' pointer, finally
>> getting 'voltdomain' pointer we would get 'WKUP' voltage domain ptr
>> not the 'mpu' or 'core' voltdomain pointer.
>
> Correct.
>
> I got this far and realized not only does the voltage layer need a
> cleanup, the SR layer needs a cleanup, but I need to focus on one thing
> at a time.
>
> As you noticed, what we need is the voltage domain of the SR sensor, not
> the voltage domain of the SR IP.
>
> Probably the best way to do this is ad the sensor voltage domain to the
> dev_attr of each SR module.

Yep, I do agree. SR instances are all inside the CORE, but there is a 
dedicated sensor in each scalable voltage domain.
dev_attr is the perfect place for that. In fact I do not understand why 
it was not added there initially???

Even the kerneldoc is confusing and not accurate:
  * @vdd_name: voltage domain name

Whereas, SR is using that to provide the name of the voltage rail 
controlled by it.

Let's provide a quick patch to get rid of that and replace it by a dev_attr.

Shweta, are you volunteer? :-)

Thanks,
Benoit
