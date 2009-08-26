From: Graeme Gregory <dp@xora.org.uk>
Subject: Re: [alsa-devel] Audio capture not working with AIC23/McBSP1 on OMAP3517
Date: Wed, 26 Aug 2009 15:06:00 +0100
Message-ID: <4A954148.5030602@xora.org.uk>
References: <5A47E75E594F054BAF48C5E4FC4B92AB0309E9D82D@dbde02.ent.ti.com> <20090826130356.GB29299@sirena.org.uk> <5A47E75E594F054BAF48C5E4FC4B92AB0309E9D83F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f227.google.com ([209.85.219.227]:58683 "EHLO
	mail-ew0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932985AbZHZONr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Aug 2009 10:13:47 -0400
Received: by ewy27 with SMTP id 27so211573ewy.40
        for <linux-omap@vger.kernel.org>; Wed, 26 Aug 2009 07:13:48 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0309E9D83F@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>

Aggarwal, Anuj wrote:
>> -----Original Message-----
>> From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
>> Sent: Wednesday, August 26, 2009 6:34 PM
>> To: Aggarwal, Anuj
>> Cc: linux-omap@vger.kernel.org; alsa-devel@alsa-project.org
>> Subject: Re: [alsa-devel] Audio capture not working with AIC23/McBSP1 on
>> OMAP3517
>>
>> On Wed, Aug 26, 2009 at 06:30:52PM +0530, Aggarwal, Anuj wrote:
>>
>>     
>>> I am trying to capture audio through LineIn on my OMAP3517 EVM, using
>>> AIC23 codec and McBSP1, and getting the following error:
>>>       
>>> arecord: pcm_read:1529: read error: Input/output error
>>>       
>> That suggests that DMA isn't happening - might be worth checking to see
>> that clocks are being generated properly.
>>     
> I am able to see the bit clock and frame sync coming properly.
>   
>>     
>>> Playback is working fine using the same combination.
>>>       
>>> I have tried using another instance of AIC23 codec which uses McBSP2
>>> and both playback & capture works fine there.
>>>       
>>> Has anyone faced this issue before? Any suggestions?
>>>       
>> Which kernel are you using?  There are rather a lot of McBSP changes
>> queued up for 2.6.32.  If this ever worked in the past a git bisect
>> might be interesting.
>>     
> I am on 2.6.31-rc5. I have to check whether the new patches fix 
> anything related to this.
>   
Not having the corect pinmux settings will also cause this issue as I 
found trying to get McBSP3 working.

Graeme

