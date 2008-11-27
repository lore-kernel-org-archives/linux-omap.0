From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 02/10] omap mailbox: add initial omap3 support
Date: Thu, 27 Nov 2008 16:39:59 +0200 (EET)
Message-ID: <20081127.163959.70034214.Hiroshi.DOYU@nokia.com>
References: <20081125215413.GS11997@atomide.com>
	<20081126.021040.127479183.Hiroshi.DOYU@nokia.com>
	<20081126183612.GV11997@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:44494 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784AbYK0Okk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Nov 2008 09:40:40 -0500
In-Reply-To: <20081126183612.GV11997@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org

Hi Tony,

From: "ext Tony Lindgren" <tony@atomide.com>
Subject: Re: [PATCH 02/10] omap mailbox: add initial omap3 support
Date: Wed, 26 Nov 2008 10:36:14 -0800

<snip>

> Thanks, since this is a large series, can you please send your series for
> RMK to integrate to LAKML? Make sure it also applies against mainline
> first :) Please feel free to add my Ack to your patches.

OK. I'll try, anyway.

> > Also, the latest patchset is available in the git repository at:
> > 
> >   http://git.gitorious.org/lk/mainline.git mailbox
> 
> Thanks, I've added mirroring for this branch to my kernel.org tree.
> Let's wait for ack from RMK before integrating it to l-o.
> 
> BTW, we should move dspgateway also into a separate branch like
> tidspbridge as it's not in the mainline tree. Do you want to keep the
> original for that on your git server too?

I agreed that "dspgateway" is to be moved into one of branches and
this would be enough for the moment since I don't think that I have
time to work on "dspgateway" newly.

    Hiroshi DOYU
