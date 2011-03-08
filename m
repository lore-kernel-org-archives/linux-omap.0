From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: Integration branch base switchover to Tony's omap-for-linus branch
Date: Tue, 8 Mar 2011 17:28:10 +0100
Message-ID: <4D76591A.7060508@ti.com>
References: <alpine.DEB.2.00.1102251722450.6198@utopia.booyaka.com> <3f332cbd75f835ca119bdeccd72c4bb2@mail.gmail.com> <alpine.DEB.2.00.1103011431240.16349@utopia.booyaka.com> <4D6F89FB.7080201@ti.com> <4D70F25C.4040206@ti.com> <58ec7480fe87b4d64c33cb2c4454a805@mail.gmail.com> <02124a94c82909eff5a589819ec86357@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59864 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751634Ab1CHQ2P (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Mar 2011 11:28:15 -0500
In-Reply-To: <02124a94c82909eff5a589819ec86357@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>, "Hilman, Kevin" <khilman@ti.com>

On 3/8/2011 4:16 PM, Shilimkar, Santosh wrote:
> Paul,
>> -----Original Message-----
>> From: Santosh Shilimkar [mailto:santosh.shilimkar@ti.com]
>> Sent: Friday, March 04, 2011 10:14 PM
>> To: Rajendra Nayak
>> Cc: linux-omap@vger.kernel.org; Benoit Cousson; Paul Walmsley
>> Subject: RE: Integration branch base switchover to Tony's omap-for-
>> linus branch
>>
>
>   [....]
>
>>> Some more debugging by the Hardware team and analyzing
>>> the register dumps showed that the I2C_WE register of the i2c
>>> modules needs to be programmed correctly for i2c wakeups to
>>> function as expected.
>>> This turned out to be the root cause for the i2c issues observed
>>> by clearing the staticdeps and a patch has been posted
>>> to address this...
>>> http://marc.info/?l=linux-omap&m=129924557219813&w=2
>>>
>>>>
>>>> Also some more testing showed up a lockup in suspend on OMAP4
>>> which I
>>>> could narrow down to a similar case with GPT1. Either keeping
>> the
>>>> staticdep between MPU and L4_WKUP _or_ forcing GPT1 to use
>>> software
>>>> idle control seems to help.
>>>
>>> This however is still not rootcaused and is not the same as the
>>> issue
>>> seen with i2c as the WE for GPT1 is already programmed for
>> enabling
>>> wakeup.
>>>
>>> The one way to fix this for now is to put GPT1 block in software
>>> controlled idle as was done by your test patch for i2c.
>>>
>> I tried all the floating patches for static dependency. It did
>> worked when CPU RET was tried but with MPU OFF I see the hang.
>>
>> Below is the global hack I have which works as expected for
>> all cases.
>>
> Thanks to Rajendra for isolating the OMAP4 MPU OFF issue
> with static dependency series. The issue is isolated
> to MPU<->  EMIF clock dependency.  There issue appears
> if we clear this static dependency.
>
> I have posted a patch to work-around this issue till its
> being root-caused with help of hardware team so that
> OMAP4 PM series continue to work.
>
> 'OMAP4: PM: Set static dependency between MPUSS and EMIF'
> http://www.listware.net/201103/linux-omap/2628-patch-omap4-pm-set-static-d
> ependency-between-mpuss-and-emif.html

Cool, so the timer1 fix is not longer needed?

Benoit
