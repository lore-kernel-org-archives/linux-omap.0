From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] watchdog: Fix omap watchdogs to enable the magic close
 bit
Date: Mon, 2 Feb 2015 15:40:15 -0800
Message-ID: <20150202234015.GJ9418@atomide.com>
References: <20141014192518.GH4972@atomide.com>
 <20150105185902.GH4081@atomide.com>
 <20150202234126.GA17515@spo001.leaseweb.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp3.ore.mailhop.org ([54.149.88.251]:51067 "EHLO
	smtp3.ore.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965109AbbBBXnB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Feb 2015 18:43:01 -0500
Content-Disposition: inline
In-Reply-To: <20150202234126.GA17515@spo001.leaseweb.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, linux-omap@vger.kernel.org, Thomas Dziedzic <gostrc@gmail.com>

* Wim Van Sebroeck <wim@iguana.be> [150202 15:44]:
> Hi Tony,
> 
> > * Tony Lindgren <tony@atomide.com> [141014 12:27]:
> > > This allows testing the watchdog easily with distros just by
> > > doing pkill -9 watchdog.
> > > 
> > > Reported-by: Thomas Dziedzic <gostrc@gmail.com>
> > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > 
> > Wim, still not seeing this applied, did you forget about this one?
> 
> I just applied it to linux-watchdog-next.
> Didn't forgot about it, just didn't had the time yet.

OK thanks!

Tony
