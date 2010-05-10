From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] DSS2 Include VRFB into omap2-3build only
Date: Mon, 10 May 2010 08:12:27 -0500
Message-ID: <4BE8063B.1080709@ti.com>
References: <1273474110-22451-1-git-send-email-svadivu@ti.com> <1A2F53DA-903A-4667-A27F-492A3499F7ED@student.utwente.nl> <FCCFB4CDC6E5564B9182F639FC356087030428879D@dbde02.ent.ti.com> <73F3CED4-60D5-4351-A921-335110542B6F@dominion.thruhere.net> <FCCFB4CDC6E5564B9182F639FC356087030428879F@dbde02.ent.ti.com> <4BE7ECE4.5070608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36536 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751103Ab0EJNMi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 May 2010 09:12:38 -0400
In-Reply-To: <4BE7ECE4.5070608@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <menon.nishanth@gmail.com>
Cc: "Guruswamy, Senthilvadivu" <svadivu@ti.com>, Koen Kooi <koen@dominion.thruhere.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

On 05/10/2010 06:24 AM, Nishanth Menon wrote:
> On 05/10/2010 03:26 AM, Guruswamy, Senthilvadivu wrote:
>> Tiler support is not yet in OMAP builds. So multi-omap build will NOT break, but would exclude VRFB feature in the build.
> in which case, is'nt this patch redundant :) ?
>
> joking apart, would'nt a set of function pointers be better - the
> function pointers could be runtime initialized. the rotational functions
> for Tiler OR vrfb could be used?

just an addon -> I can see one more potential user of the FEATURES 
framework like dma descriptor feature.. what kind of rotator do we have? 
vrfb Vs tiler..

>
>>
>>> -----Original Message-----
>>> From: Koen Kooi [mailto:koen@dominion.thruhere.net]
>>> Sent: Monday, May 10, 2010 1:33 PM
>>> To: Guruswamy, Senthilvadivu
>>> Cc: linux-omap@vger.kernel.org;
>>> linux-fbdev-devel@lists.sourceforge.net; tony@atomide.com;
>>> tomi.valkeinen@nokia.com; Hiremath, Vaibhav
>>> Subject: Re: [PATCH] DSS2 Include VRFB into omap2-3build only
>>>
>>>
>>> Op 10 mei 2010, om 10:01 heeft Guruswamy, Senthilvadivu het
>>> volgende geschreven:
>>>
>>>> Building a multi-omap kernel is not impacted as long as the
>>> display is not choosen in the build.  Usually display is
>>> chosen from the board file.
>>>
>>> So you are saying it *IS* broken when wanting vrfb on omap3
>>> and tiler on omap4, right?
>>>
>>>
>>>
>>>>
>>>>> -----Original Message-----
>>>>> From: Koen Kooi [mailto:koen@dominion.thruhere.net]
>>>>> Sent: Monday, May 10, 2010 1:10 PM
>>>>> To: Guruswamy, Senthilvadivu
>>>>> Cc: linux-omap@vger.kernel.org;
>>>>> linux-fbdev-devel@lists.sourceforge.net; tony@atomide.com;
>>>>> tomi.valkeinen@nokia.com; Hiremath, Vaibhav
>>>>> Subject: Re: [PATCH] DSS2 Include VRFB into omap2-3build only
>>>>>
>>>>>
>>>>> Op 10 mei 2010, om 08:48 heeft Senthilvadivu Guruswamy het
>>>>> volgende geschreven:
>>>>>
>>>>>> Exclude VRFB from OMAP4 onwards and include only for
>>>>>> OMAP2 and OMAP3 builds.  In OMAP4 VRFB HW IP is replaced
>>>>>> with a new HW IP "TILER"
>>>>>>
>>>>>> --- a/drivers/video/omap2/Kconfig
>>>>>> +++ b/drivers/video/omap2/Kconfig
>>>>>> @@ -3,6 +3,10 @@ config OMAP2_VRAM
>>>>>>
>>>>>> config OMAP2_VRFB
>>>>>> 	bool
>>>>>> +	depends on FB_OMAP2&&   (!ARCH_OMAP4)
>>>>>> +	default y if (ARCH_OMAP2 || ARCH_OMAP3)
>>>>>> +	help
>>>>>> +	  OMAP VRFB buffer support is efficient for rotation
>>>>>
>>>>> How does this work for multi-omap kernels, e.g. building a
>>>>> kernel with beagle and panda support?
>>>>>
>>>>> regards,
>>>>>
>>>>> Koen
>>>
>>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> Regards,
> Nishanth Menon
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

