From: Viktor Rosendahl <Viktor.Rosendahl@nokia.com>
Subject: Re: [PATCH 00/10] Patches for fixing the lowmem module
Date: Mon, 15 Sep 2008 15:07:01 +0300
Message-ID: <1221480421.15659.8.camel@viktor.research.nokia.com>
References: <1221150042-10873-1-git-send-email-viktor.rosendahl@nokia.com>
	 <20080911161702.GL16796@gandalf.research.nokia.com>
	 <1221152129.10962.12.camel@viktor.research.nokia.com>
	 <20080911164809.GN16796@gandalf.research.nokia.com>
	 <20080912181444.GE10675@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:38169 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752927AbYIOL5o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Sep 2008 07:57:44 -0400
In-Reply-To: <20080912181444.GE10675@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org

On Fri, 2008-09-12 at 11:14 -0700, ext Tony Lindgren wrote:

> Still, how about posting it to LKML? Other people may be interested in
> it too. And you'll find out what would have to be fixed to get it
> integrated.

I don't really know what criteria mainline has but I am under the
impression that adding new entries to /proc [like the current lowmem
code does] would not be that popular.

Another issue is that we are thinking that it would be desirable to
still make some modifications to the interface. ABI changes are probably
not that popular in mainline so it could be benefical to make those
modifications before trying to push it there.

Anyways, I am kind of busy right now but I will try to find the time to
reshuffle the code within the next couple of weeks.

best regards,

Viktor

