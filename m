From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: linux omap on sdp broken?
Date: Tue, 22 Sep 2009 00:07:36 +0300
Message-ID: <4AB7EB18.8060906@gmail.com>
References: <782515bb0909181942v58ea0e95n8025eb47876116bf@mail.gmail.com>,<94a0d4530909211138g25d2cf9dxaf445032e350a45a@mail.gmail.com> <5A47E75E594F054BAF48C5E4FC4B92AB0309C861E3@dbde02.ent.ti.com> <FCCFB4CDC6E5564B9182F639FC35608702F9DAF7DF@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f210.google.com ([209.85.218.210]:64442 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752129AbZIUVHh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Sep 2009 17:07:37 -0400
Received: by bwz6 with SMTP id 6so2227467bwz.37
        for <linux-omap@vger.kernel.org>; Mon, 21 Sep 2009 14:07:40 -0700 (PDT)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702F9DAF7DF@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-omap <linux-omap@vger.kernel.org>

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
