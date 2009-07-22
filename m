From: Wim Van Sebroeck <wim@iguana.be>
Subject: Re: Handling multiple watchdogs
Date: Wed, 22 Jul 2009 20:52:32 +0200
Message-ID: <20090722185232.GK2155@infomag.iguana.be>
References: <4A672B97.1070704@emlix.com> <20090722171920.505ffc4b@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailrelay003.isp.belgacom.be ([195.238.6.53]:3748 "EHLO
	mailrelay003.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750938AbZGVSwd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Jul 2009 14:52:33 -0400
Content-Disposition: inline
In-Reply-To: <20090722171920.505ffc4b@lxorguk.ukuu.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Simon Braunschmidt <sb@emlix.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

Hi Simon,

> > I have two watchdogs on my board that I both want to handle. What would 
> > be the proper approach in this case?
> 
> Fixing the watchdog core to create a class of watchdog drivers and
> treating the existing /dev/watchdog as a back compatibility hack. It's
> been talked about for a very long time but not done, although I believe
> Wim had some test code at one point ?

The support of multiple watchdog's is not there at this moment. But we will indeed
need it. The embedded platforms (like omap) start to have devices with different
watchdogs that all need to be supported.

To overcome this issue we will indeed need to:
1) make sure that we have the new watchdog core infrastructure going in for 2.6.32.
This new core integrates the common code that we use over and over again. I once
wrote code for it and then Alan had different ideas and thoughts and wrote his updated
code. I reviewed that and I am changing some small bits so that we will have the new
watchdog core version 1. Expect the code to appear in the linux-2.6-watchdog-next tree
in the coming weeks (I first did some pre-cleanup stuff).
2) Then we will need a dicussion on how we will support multiple watchdog's with this
new framework. My feeling is that the /dev/watchdog* solution is not the right way to go.
I think a sysfs interface will be better. This sysfs interface would then be added to the
core version (and makes "core version 2").
I once wrote the first basis of this sysfs interface (based on rusty's input I believe).
I need to check if I still have it after the hard-disk crash I had almost a year ago.

I hope this gives you an idea about how we are proceeding with the watchdog devices driver core
and what we are trying to do (and OK i'm slower than other maintainers but I'm doing this all
in my own time and for free and thus my priority's are different...). 

Kind regards,
Wim.

(Note: for completeness; I know that the following drivers have a "non-standard"
watchdog part: drivers/watchdog/cpwd.c drivers/hwmon/fschmd.c).

