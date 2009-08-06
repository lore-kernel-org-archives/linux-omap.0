From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: DSS2 questions
Date: Thu, 06 Aug 2009 17:00:44 +0300
Message-ID: <4A7AE20C.1050104@nokia.com>
References: <4A7AC798.6070409@mlbassoc.com> <4A7AD7B5.10500@nokia.com> <4A7ADDBD.8010901@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:39209 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755946AbZHFOA6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Aug 2009 10:00:58 -0400
In-Reply-To: <4A7ADDBD.8010901@mlbassoc.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Gary Thomas <gary@mlbassoc.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

ext Gary Thomas wrote:
> Tomi Valkeinen wrote:
>> Hi,
>>
>> ext Gary Thomas wrote:
>>> Tomi,
>>>
>>> I've been following your DSS2 work, with reasonable success.
>>> However, when I tried to pull from your repo today, I got
>>> a ton of merge errors.  I cloned your tree a [little] while
>>> back (it seems it was 2009-06-16, but where did the time go?)
>>>
>>> Here's what I did:
>>>   git clone http://www.bat.org/~tomba/git/linux-omap-dss.git
>>>     HEAD=5bd374f9b199d46ae434489d56615b240de5a6d7
>>>   git checkout -b my_branch origin/master
>>>     ...
>>> When I went to pull into my_branch, I got the merge errors.
>>> Any clues what I did wrong?  How could/should I have managed
>>> this better?
>> The problem is that I have rebased my tree so that I end up with a clean
>> set of patches that can be posted to mailing lists. And rebasing means
>> changing history, which means that you cannot merge it normally.
>>
>> Perhaps I should keep the master branch as it is, and do rebasing on a
>> separate branch. I don't know, I'm no git-master ;).
>>
>> If you have no changes of your own in the branch, you can do
>> git reset --hard origin/master
>> which will reset that branch to the exact version that is in origin/master.
>>
> 
> I'll give this a try - I still have the old tree I was working from.
> 
>>> n.b. you earlier told me that git was better than sliced
>>> bread; I'm still waiting to be shown the light :-)
>> You'll see it when you understand how git works ;)
>>
>>> Second question; I've set up my system much the same as the
>>> boards you are working on, with an LCD and TV outputs.  I'm
>>> a bit confused as to how I configure the overlays and managers
>>> to be able to send YUV data directly through to either the
>>> LCD or TV.  Can you explain this?
>> You need to change the framebuffer to YUV color mode. And YUV only works
>> on video overlays, so you need to setup video overlay to be shown on the
>> LCD or TV.
>>
>> If you have fb1 as a video overlay, you can do for example:
>>
>> fbset -fb /dev/fb1 -nonstd 1
>>
>> which sets fb1 to YUV422 mode. 8 would be YUY422. Those numbers come
>> from omapfb.h, enum omapfb_color_format.
>>
>> Check also Documentation/arm/OMAP/DSS, if you haven't already done so.
>>
> 
> Still a bit fuzzy on this.  I'm sure that document helps, if
> one already knows how all the overlays and managers and ...
> are wired together.  I'm new at this game :-)
> 
> I tried to set my TV to be video/uyv422 via the attached script.
> I was trying to leave fb0 alone (running on the LCD) and use fb1
> to display the YUV422 data. Alas, 'fbset' gives me "Bad video mode"?
> Any pointers?
> 

You need to allocate memory for the framebuffer.

Try adding for example this:

mem=$((w*h*4))
echo $mem > $fb1/size

Also, you are trying to connect video2 overlay to fb1, but by default 
DSS connects video2 to fb2. So if you really want to do that, you first 
need to detach video1 from fb1, video2 from fb2, and then attach video2 
to fb1. I suggest you use fb2 which is already attached to video2.

  Tomi
