From: "Vanin, Matthieu" <m-vanin@ti.com>
Subject: RE: linux omap on sdp broken?
Date: Tue, 22 Sep 2009 09:31:20 +0200
Message-ID: <E8606C3FD412994585953171ED63A9340150D027A2@dnce01.ent.ti.com>
References: <782515bb0909181942v58ea0e95n8025eb47876116bf@mail.gmail.com>,<94a0d4530909211138g25d2cf9dxaf445032e350a45a@mail.gmail.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0309C861E3@dbde02.ent.ti.com>
 <FCCFB4CDC6E5564B9182F639FC35608702F9DAF7DF@dbde02.ent.ti.com>
 <4AB7EB18.8060906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:32973 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751402AbZIVHeC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Sep 2009 03:34:02 -0400
In-Reply-To: <4AB7EB18.8060906@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <menon.nishanth@gmail.com>, "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-omap <linux-omap@vger.kernel.org>

Hello, 
The last time I had a problem with starting kernel... Uncompressing..............
on beagleboard, it was because I was using an old compiler (older than the Codesourcery 2008q3). With the 2008q3, no more problem booting

Matt 

-----Original Message-----
From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Nishanth Menon
Sent: Monday, September 21, 2009 11:08 PM
To: Pandita, Vikram
Cc: Gadiyar, Anand; Felipe Contreras; linux-omap
Subject: Re: linux omap on sdp broken?

Pandita, Vikram said the following on 09/21/2009 09:46 PM:
>   
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
>> Gadiyar, Anand
>> Sent: Monday, September 21, 2009 1:43 PM
>> To: Felipe Contreras; Nishanth Menon
>> Cc: linux-omap
>> Subject: RE: linux omap on sdp broken?
>>
>>     
>>> Hi Folks,
>>>       
>>>> Has Anyone tried booting latest kernel from tmlind master tree recently?
>>>> Ref: git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
>>>>
>>>> Starting kernel ...
>>>> Uncompressing
>>>>         
>> Linux................................................................................................
>> .................................................................
>>     
>>>> done, booting the kernel.
>>>>
>>>> Gets stuck there..
>>>>         
>>> Same on beagleboard. Something got broken from 2.6.30 to 2.6.31.
>>>
>>> --
>>> Felipe Contreras
>>>
>>>       
>> It seems to work okay for me on SDP, so maybe it's related to the bootloader?
>>
>> Felipe, Nishant,
>> What was the last known working version for you?
>>     
>
>   
Have'nt had a chance to bisect it yet, but hoping to do it later when i
get some time..
> Maybe it's the new bootloader: 
> the new support for SDP on upstream u-boot that Nishant Menon added last week.
>   
nope. it fails with omapzoom bootloader also for me. and my/david B's
version of bootloader boots up and old uImage i had handy around ->
probably out of pm branch around 2.6.30 timeframe.. dont have a commit
ID handy either at the moment :(

Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

