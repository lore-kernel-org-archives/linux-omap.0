From: Gary Thomas <gary@mlbassoc.com>
Subject: Re: DSS2 questions
Date: Thu, 06 Aug 2009 07:42:21 -0600
Message-ID: <4A7ADDBD.8010901@mlbassoc.com>
References: <4A7AC798.6070409@mlbassoc.com> <4A7AD7B5.10500@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030003040406040809080204"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([76.76.67.137]:3977 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755883AbZHFNmX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Aug 2009 09:42:23 -0400
In-Reply-To: <4A7AD7B5.10500@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This is a multi-part message in MIME format.
--------------030003040406040809080204
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Tomi Valkeinen wrote:
> Hi,
> 
> ext Gary Thomas wrote:
>> Tomi,
>>
>> I've been following your DSS2 work, with reasonable success.
>> However, when I tried to pull from your repo today, I got
>> a ton of merge errors.  I cloned your tree a [little] while
>> back (it seems it was 2009-06-16, but where did the time go?)
>>
>> Here's what I did:
>>   git clone http://www.bat.org/~tomba/git/linux-omap-dss.git
>>     HEAD=5bd374f9b199d46ae434489d56615b240de5a6d7
>>   git checkout -b my_branch origin/master
>>     ...
>> When I went to pull into my_branch, I got the merge errors.
>> Any clues what I did wrong?  How could/should I have managed
>> this better?
> 
> The problem is that I have rebased my tree so that I end up with a clean
> set of patches that can be posted to mailing lists. And rebasing means
> changing history, which means that you cannot merge it normally.
> 
> Perhaps I should keep the master branch as it is, and do rebasing on a
> separate branch. I don't know, I'm no git-master ;).
> 
> If you have no changes of your own in the branch, you can do
> git reset --hard origin/master
> which will reset that branch to the exact version that is in origin/master.
> 

I'll give this a try - I still have the old tree I was working from.

>>
>> n.b. you earlier told me that git was better than sliced
>> bread; I'm still waiting to be shown the light :-)
> 
> You'll see it when you understand how git works ;)
> 
>>
>> Second question; I've set up my system much the same as the
>> boards you are working on, with an LCD and TV outputs.  I'm
>> a bit confused as to how I configure the overlays and managers
>> to be able to send YUV data directly through to either the
>> LCD or TV.  Can you explain this?
> 
> You need to change the framebuffer to YUV color mode. And YUV only works
> on video overlays, so you need to setup video overlay to be shown on the
> LCD or TV.
> 
> If you have fb1 as a video overlay, you can do for example:
> 
> fbset -fb /dev/fb1 -nonstd 1
> 
> which sets fb1 to YUV422 mode. 8 would be YUY422. Those numbers come
> from omapfb.h, enum omapfb_color_format.
> 
> Check also Documentation/arm/OMAP/DSS, if you haven't already done so.
> 

Still a bit fuzzy on this.  I'm sure that document helps, if
one already knows how all the overlays and managers and ...
are wired together.  I'm new at this game :-)

I tried to set my TV to be video/uyv422 via the attached script.
I was trying to leave fb0 alone (running on the LCD) and use fb1
to display the YUV422 data. Alas, 'fbset' gives me "Bad video mode"?
Any pointers?

Thanks

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------

--------------030003040406040809080204
Content-Type: text/plain;
 name="tv_video"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tv_video"

#! /bin/sh

ovl0=/sys/devices/platform/omapdss/overlay0
ovl1=/sys/devices/platform/omapdss/overlay1
ovl2=/sys/devices/platform/omapdss/overlay2

mgr0=/sys/devices/platform/omapdss/manager0
mgr1=/sys/devices/platform/omapdss/manager1

lcd=/sys/devices/platform/omapdss/display0
tv=/sys/devices/platform/omapdss/display1

fb0=/sys/class/graphics/fb0
fb1=/sys/class/graphics/fb1
fb2=/sys/class/graphics/fb2

MODE=${MODE:-ntsc}
echo "0" > $tv/enabled
echo ${MODE} >$tv/timings
w=`cat $tv/timings | cut -d "," -f 2 | cut -d "/" -f 1`
h=`cat $tv/timings | cut -d "," -f 3 | cut -d "/" -f 1`
echo "... Setting ${MODE} mode, Width = ${w}, Height = ${h}"

echo "0" > $ovl2/enabled
echo "2" > $fb1/overlays

echo "$w,$h" > $ovl2/output_size
echo "tv" > $ovl2/manager

echo "1" > $ovl2/enabled
echo "1" > $tv/enabled

fbset -fb /dev/fb1 -nonstd 1


--------------030003040406040809080204--
