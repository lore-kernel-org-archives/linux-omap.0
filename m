From: Leigh Brown <leigh@solinno.co.uk>
Subject: Re: Help running latest linux-omap kernel on Nokia N810
Date: Thu, 27 Feb 2014 08:19:06 +0000
Message-ID: <277ac9055a67992eb1c03e89788afebf@doppler.thel33t.co.uk>
References: <c57950d5cfbbdcf952b9fceb4cd243d4@doppler.thel33t.co.uk>
 <20140226185331.GA17632@earth.universe>
 <20140226212927.GB671@drone.musicnaut.iki.fi> <530EE6F2.7040903@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from doppler.thel33t.co.uk ([193.110.88.198]:37179 "EHLO
	doppler.thel33t.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363AbaB0II3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Feb 2014 03:08:29 -0500
In-Reply-To: <530EE6F2.7040903@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@ring0.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On 2014-02-27 07:19, Tomi Valkeinen wrote:
> On 26/02/14 23:29, Aaro Koskinen wrote:
> 
>> First the bad news: display support is not in the mainline kernel. 
>> Also
>> since linux-omap tree follows the mainline, it's not there either 
>> anymore.
>> Tomi removed the n8x0 panel driver some time ago (I don't know why), 
>> but
>> even then it wasn't working as the platform data failed to set up some
> 
> It would've been a big effort to keep the panel driver compiling, as we
> moved to a new display driver architecture. And, as it wasn't working
> anyway, I deemed it simpler to just remove it.
> 
> I have no objections to add it back, but it needs to be split into two
> separate drivers, blizzard encoder driver and the panel driver. The 
> RFBI
> driver also probably needs some love. And, of course, DT support for 
> all
> those.
> 
> In theory, RFBI is relatively simple. If I recall right, the panel is
> also quite simple, although it still needs to be controlled via SPI.
> Blizzard was a bit more complex one, but perhaps most of its features
> can be just left out.
> 
> But getting all those three working fine without being able to make any
> measurements between the components, well, one might needs some luck
> there =).
> 
> I do have N800 and N810 (no serial mods), so I might be able to give
> some help there at some point, if I'm able to boot the board with usb
> gadget ethernet (which hasn't been working for me for omap3 for some 
> time).

Hi Tomi,

In the following commit it states that you ported the old blizzard 
driver to
the new omapdss driver:

commit fdcb68884b3b0def9cc410d07adbafe7c3a9e537
Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date:   Tue May 10 17:31:20 2011 +0300

     OMAPFB: remove old blizzard driver

     N8x0's blizzard driver has been ported to new omapdss driver, so we 
can
     now remove the old blizzard driver.

     Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Did that driver work on the N810 at that point?  If I look at the kernel 
tree
at that point in time would all the components be there?  It would make 
it
easier if I had a starting point as I don't have any documentation so 
reading
the old source code is the only way I can figure out how things 
work(ed).

Regards,

Leigh.
