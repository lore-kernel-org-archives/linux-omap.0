From: Mikko Ylinen <mikko.k.ylinen@nokia.com>
Subject: Re: [PATCH 9/9] i2c: move twl4030-madc to new registration style
Date: Sat, 27 Sep 2008 10:37:17 +0300
Message-ID: <48DDE2AD.1030202@nokia.com>
References: <1222427996-7018-1-git-send-email-felipe.balbi@nokia.com> <1222427996-7018-9-git-send-email-felipe.balbi@nokia.com> <1222427996-7018-10-git-send-email-felipe.balbi@nokia.com> <200809261009.12639.david-b@pacbell.net> <20080926174643.GA9890@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:54606 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973AbYI0Hhs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 27 Sep 2008 03:37:48 -0400
In-Reply-To: <20080926174643.GA9890@frodo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com, David Brownell <david-b@pacbell.net>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Hi,

Felipe Balbi wrote:
> On Fri, Sep 26, 2008 at 10:09:12AM -0700, David Brownell wrote:
>> Passing those registers in platform data seems bizarre.
>> Doesn't the MADC code know its own register offsets??
> 
> there two of them. i[ms]r[12].

twl4030 has two interrupt lines. For INT1 and INT2
lines you should use I[MS]R1 and I[MS]R2, respectively.

This is board specific information. Beagleboard uses
INT1.

>> The platform data should probably say which ADC channels
>> are wired up...

Yeah, I thought about this at the time of writing the driver
but dropped the idea because of problems with twl4030-core.

I think this is a good idea and should be re-considered now.

>> And no ADC lines are even hooked up on Beagle, so the right
>> fix is just to not provide madc platform data on beagle.
>> Probably the same is true on some other boards.
> 
> Yeah, i wasn't sure if beagle and overo were using them, so I put
> anyways.

Not completely true. MADC has 16 channels out of which only 6
are truly general purpose channels. Some channels are reserved
for battery charger interface (BCI) and some for chip's internal
purposes.

Boards having twl4030 should have at least VBAT (ch 12),
V backup battery (ch 9), and VBUS (ch 8) measurement available.

On Beagleboard you can measure these three channels.

>> Plus:  MADC is just a set of ADC channels, right?
>> If so, the driver should have a comment saying that.
> 
> Mikko should comment on that as he wrote the driver.

How detailed information would you like to have here?

-- 
Regards, Mikko
