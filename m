From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: DSS2 questions
Date: Thu, 06 Aug 2009 16:16:37 +0300
Message-ID: <4A7AD7B5.10500@nokia.com>
References: <4A7AC798.6070409@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:33145 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755665AbZHFNQw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Aug 2009 09:16:52 -0400
In-Reply-To: <4A7AC798.6070409@mlbassoc.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Gary Thomas <gary@mlbassoc.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

ext Gary Thomas wrote:
> Tomi,
> 
> I've been following your DSS2 work, with reasonable success.
> However, when I tried to pull from your repo today, I got
> a ton of merge errors.  I cloned your tree a [little] while
> back (it seems it was 2009-06-16, but where did the time go?)
> 
> Here's what I did:
>   git clone http://www.bat.org/~tomba/git/linux-omap-dss.git
>     HEAD=5bd374f9b199d46ae434489d56615b240de5a6d7
>   git checkout -b my_branch origin/master
>     ...
> When I went to pull into my_branch, I got the merge errors.
> Any clues what I did wrong?  How could/should I have managed
> this better?

The problem is that I have rebased my tree so that I end up with a clean 
set of patches that can be posted to mailing lists. And rebasing means 
changing history, which means that you cannot merge it normally.

Perhaps I should keep the master branch as it is, and do rebasing on a 
separate branch. I don't know, I'm no git-master ;).

If you have no changes of your own in the branch, you can do
git reset --hard origin/master
which will reset that branch to the exact version that is in origin/master.

> 
> n.b. you earlier told me that git was better than sliced
> bread; I'm still waiting to be shown the light :-)

You'll see it when you understand how git works ;)

> 
> Second question; I've set up my system much the same as the
> boards you are working on, with an LCD and TV outputs.  I'm
> a bit confused as to how I configure the overlays and managers
> to be able to send YUV data directly through to either the
> LCD or TV.  Can you explain this?

You need to change the framebuffer to YUV color mode. And YUV only works 
on video overlays, so you need to setup video overlay to be shown on the 
LCD or TV.

If you have fb1 as a video overlay, you can do for example:

fbset -fb /dev/fb1 -nonstd 1

which sets fb1 to YUV422 mode. 8 would be YUY422. Those numbers come 
from omapfb.h, enum omapfb_color_format.

Check also Documentation/arm/OMAP/DSS, if you haven't already done so.

  Tomi
