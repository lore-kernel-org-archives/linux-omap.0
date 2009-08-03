From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Question about tput constraint on zoom2 camera
Date: Mon, 03 Aug 2009 15:21:42 -0700
Message-ID: <4A7762F6.5000806@deeprootsystems.com>
References: <F12EBA124C6E064B9CF1B45E67DDB7E77D4E028E@dlee02.ent.ti.com>,<alpine.DEB.2.00.0908012017340.14755@utopia.booyaka.com> <F12EBA124C6E064B9CF1B45E67DDB7E77CDD8199@dlee02.ent.ti.com> <alpine.DEB.2.00.0908021647130.19529@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f196.google.com ([209.85.222.196]:55397 "EHLO
	mail-pz0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932218AbZHCWVo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Aug 2009 18:21:44 -0400
Received: by pzk34 with SMTP id 34so2641731pzk.4
        for <linux-omap@vger.kernel.org>; Mon, 03 Aug 2009 15:21:44 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.0908021647130.19529@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Curran, Dominic" <dcurran@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Subramaniam, Muthu" <muthu@ti.com>

Paul Walmsley wrote:
> Hello Dominic,
> 
> On Sun, 2 Aug 2009, Curran, Dominic wrote:
> 
>> From: Paul Walmsley [paul@pwsan.com]
>> Sent: Saturday, August 01, 2009 9:57 PM
>>
>> On Fri, 31 Jul 2009, Curran, Dominic wrote:
>>
>>> I have been testing the zoom2 camera streaming while using different OPP's.
>>> Following table provides summary of what OPP's caused to happen:
>>>
>>>   Streaming      Vdd1(OPP)        Vdd2(OPP)           P/F
>>>  VGA @ 30fps           1                2             Pass
>>>  8MP @ 7.5fps          1                2             Fails (stop streaming)
>>>  8MP @ 7.5fps          1                3             Pass
>>>
>>> So table shows that locking Vdd2 to OPP=3 when streaming 8MPixel works, but at OPP=2 then streaming fails (stops).
>>>
>>> So I thought the tput constraint made the most sense for camera.
>>> The Zoom2 camera sensor has a max tput of:
>>>
>>>     3280 x 2464 x 2bpp x 7.5fps = 121228800 bytes/s
>>>                                 = 118387 KB/s
>>>
>>> However, this calculated value doesn't constrain Vdd2 to OPP3 (DVFS enabled).
>>>
>>> Experimentation shows that a tput value of 350000 KB/s is required to constrain Vdd2 to OPP=3.
>>>
>>> Can you explain why the practical tput constraint is so much greater than the theoretical value ?
>> Probably it is mostly due to two reasons:
>>
>> 1. most other L3 initiator drivers (eg., for DSS, SDMA, USB, etc) don't
>> currently set bus throughput constraints, so we aren't currently adding in
>> their interconnect usage; and
>>
>> 2. the interconnect throughput model in omap-pm-srf.c is optimistic.
>>
>> A couple of questions for you: (please forgive my ignorance of the camera
>> subsystem):
>>
>> A. What other L3 initiators are active during the test?  Presumably DSS,
>> MPU?  IVA2?
>>
>> B. I am assuming you are using the CCP2.  What do you have CCP2_CTRL.BURST
>> set to?  This could impact interconnect utilization.
>>
>> - Paul
>>
>>
>>
>> Hi Paul
>> No DSS (i'm just printing a '.' when i dequeue a frame).
>> No IVA2.
>> No per pixel processing by the ARM.
>>
>> I was trying to keep me testing as simple as possible.
>>
>> HOWEVER, your questions have made me think of something else which i think _may_ explain everything.
>>
>> The camera pipe should look like this:
>>
>> Sensor --> CSI2 Receiver --> CCDC --> PREVIEWER --> RESIZER --> MEM
>>
>> But because of a hardware bug, data has to be written to memory by Previewer and then read by Resizer.
>> Thus a 'workaround' buffer is allocated for this purpose.  
>> Its not pretty but its the only way we can have Preview & Resizer in the pipe at the same time.
>> So the pipeline actually looks like this:
>>
>> Sensor --> CSI2 Receiver --> CCDC --> PREVIEWER --> Workaround MEM --> RESIZER --> MEM
>>
>> Thus in order to get a single pixel through the pipe there has to be three L3 operations:
>> 1) Write to workaround mem
>> 2) Read from workaround mem
>> 3) Write to final memory  
>>
>> This seems to me like it actually increases the tput by 3x.
>>   118387 KB/s  x  3  =  355161 KB/s
>>
>> Which looks like it is very close to the number I found in practice (350000).
>>
>> Does this seem like a reasonable explanation to you ?
> 
> It does indeed.
> 
> Thanks for the explanation of the ISP pipelines.

Dominic,

Please be sure to update the changelog in your patch to describe the 
pipeline and workaround mem which leads to your tput number.

Thanks,

Kevin
