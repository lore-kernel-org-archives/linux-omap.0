From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: How to handle named resources with DT?
Date: Tue, 9 Aug 2011 23:53:32 +0200
Message-ID: <4E41AC5C.20301@ti.com>
References: <4E40FC88.5090403@ti.com> <20110809162907.GA630@manju-WNB7PBC4801-0006> <4E4166F0.9050401@ti.com> <CACxGe6tbEW1EZhqXy78EZVM_sQLH0Qbr7QOzbgbsKBRn1FtVrg@mail.gmail.com> <4E4172A8.3030101@ti.com> <4E417BD5.8080409@freescale.com> <20110809205723.GE11568@ponder.secretlab.ca> <4E41A1B9.1060400@ti.com> <20110809211747.GJ11568@ponder.secretlab.ca> <4E41AA43.1000506@ti.com> <20110809214905.GK11568@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43966 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751641Ab1HIVxp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 9 Aug 2011 17:53:45 -0400
In-Reply-To: <20110809214905.GK11568@ponder.secretlab.ca>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Scott Wood <scottwood@freescale.com>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 8/9/2011 11:49 PM, Grant Likely wrote:
> On Tue, Aug 09, 2011 at 11:44:35PM +0200, Cousson, Benoit wrote:
>> On 8/9/2011 11:17 PM, Grant Likely wrote:
>>> On Tue, Aug 09, 2011 at 11:08:09PM +0200, Cousson, Benoit wrote:
>>>> On 8/9/2011 10:57 PM, Grant Likely wrote:
>>>>> On Tue, Aug 09, 2011 at 01:26:29PM -0500, Scott Wood wrote:
>>>>>> On 08/09/2011 12:47 PM, Cousson, Benoit wrote:
>>>>>>> On 8/9/2011 7:23 PM, Grant Likely wrote:
>>>>>>>> There is no analogous mechanism for _byname in the device tree.  The
>>>>>>>> DT binding for a device must explicitly state what order the register
>>>>>>>> ranges are in.  The driver will need to be adapted.
>>>>>>>
>>>>>>> That seems to be a small regression for my point of view. Relying on the
>>>>>>> order is not super safe. This is not very readable either. That's for
>>>>>>> that exact reason that we changed our drivers to use
>>>>>>> platform_get_resource_byname. That's probably the reason why that API is
>>>>>>> there as well.
>>>>>>> For the same IP, the number of entries can vary depending of the SoC
>>>>>>> revision.
>>>>>>> By using the _byname, we can check if the resource is there or not
>>>>>>> without having to care about the position.
>>>>>>
>>>>>> You could have a named u32 property that contains the reg index, e.g.:
>>>>>>
>>>>>> dev {
>>>>>> 	reg =<0x20000 0x200 0x24000 0x200>;
>>>>>> 	foo-reg =<0>;
>>>>>> 	bar-reg =<1>;
>>>>>> };
>>>>>
>>>>> That's a little nasty.  A reg-names = "foo", "bar"; would probably be
>>>>> better.
>>>>
>>>> Yep, I agree.
>>>>
>>>> And what about something like that?
>>>>    reg =<0x20000 0x200>, "foo",
>>>> 	<0x20000 0x200>, "bar" ;
>>>>
>>>> It is doable?
>>>
>>> Definitely not.  It would break all existing 'reg' parsing
>>> implementations quite badly.
>>
>> OK, so what about extending the reg attribute to be a reg node?
>>
>> dev {
>> 	reg {
>> 		name = "foo_wrapper";
>> 		start =<0x10000>;
>> 		end =<0x200>;
>> 	}
>> 	reg {
>> 		name = "foo";
>> 		start =<0x20000>;
>> 		end =<0x200>;
>> 	}
>> }
>>
>> A little bit more verbose, but at least we can add any attribute we want.
>
> That won't work either because that also breaks the existing 'reg'
> binding.  Anything you do will need to supplement the existing
> binding without changing it in an incompatible way.

OK, but can we add a new attribute then? reg2, reg_ng, reg_plusplus, 
reg_named...?

Benoit
