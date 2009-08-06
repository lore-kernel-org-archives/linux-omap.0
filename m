From: Gary Thomas <gary@mlbassoc.com>
Subject: Re: DSS2 questions
Date: Thu, 06 Aug 2009 08:24:39 -0600
Message-ID: <4A7AE7A7.1070702@mlbassoc.com>
References: <4A7AC798.6070409@mlbassoc.com> <4A7AD7B5.10500@nokia.com> <4A7ADDBD.8010901@mlbassoc.com> <4A7AE20C.1050104@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([76.76.67.137]:3401 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541AbZHFOYk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Aug 2009 10:24:40 -0400
In-Reply-To: <4A7AE20C.1050104@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Tomi Valkeinen wrote:
> Hi,
> 
> ext Gary Thomas wrote:
>>>> Second question; I've set up my system much the same as the
>>>> boards you are working on, with an LCD and TV outputs.  I'm
>>>> a bit confused as to how I configure the overlays and managers
>>>> to be able to send YUV data directly through to either the
>>>> LCD or TV.  Can you explain this?
>>> You need to change the framebuffer to YUV color mode. And YUV only works
>>> on video overlays, so you need to setup video overlay to be shown on the
>>> LCD or TV.
>>>
>>> If you have fb1 as a video overlay, you can do for example:
>>>
>>> fbset -fb /dev/fb1 -nonstd 1
>>>
>>> which sets fb1 to YUV422 mode. 8 would be YUY422. Those numbers come
>>> from omapfb.h, enum omapfb_color_format.
>>>
>>> Check also Documentation/arm/OMAP/DSS, if you haven't already done so.
>>>
>>
>> Still a bit fuzzy on this.  I'm sure that document helps, if
>> one already knows how all the overlays and managers and ...
>> are wired together.  I'm new at this game :-)
>>
>> I tried to set my TV to be video/uyv422 via the attached script.
>> I was trying to leave fb0 alone (running on the LCD) and use fb1
>> to display the YUV422 data. Alas, 'fbset' gives me "Bad video mode"?
>> Any pointers?
>>
> 
> You need to allocate memory for the framebuffer.
> 
> Try adding for example this:
> 
> mem=$((w*h*4))
> echo $mem > $fb1/size
> 
> Also, you are trying to connect video2 overlay to fb1, but by default
> DSS connects video2 to fb2. So if you really want to do that, you first
> need to detach video1 from fb1, video2 from fb2, and then attach video2
> to fb1. I suggest you use fb2 which is already attached to video2.

That helped, thanks.  'fbset' no longer complains and I now have
a lovely green screen on my TV.

Now, to figure out how to send some YUV422 data to it.  I have Vaibhav's
V4L2 support in my tree - will this work with your DSS2 devices?

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
