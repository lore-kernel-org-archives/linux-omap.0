From: Tony Lindgren <tony@atomide.com>
Subject: Re: GPMC setup help
Date: Mon, 9 Nov 2009 14:26:59 -0800
Message-ID: <20091109222658.GK23952@atomide.com>
References: <4AE75B05.7010701@balister.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:64130 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837AbZKIW0z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Nov 2009 17:26:55 -0500
Content-Disposition: inline
In-Reply-To: <4AE75B05.7010701@balister.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Philip Balister <philip@balister.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

* Philip Balister <philip@balister.org> [091027 13:41]:
> I've been going round and round on this for a couple of days. I have
> a logic analyzer (cheap USB, that is why come edges are not quite
> synced) attached to the gpmc pins on a logicpd dev board. The read
> cycle timings are what I expect.
> 
> The write cycle seems to do one cycle OK, then thing go into the weeds.
> 
> Here are the values I write into the registers:
> 
> GPMC_CONFIG1 reg: 1200
> 
> GPMC_CONFIG2 reg: 40400
> 
> GPMC_CONFIG3 reg: 20201
> 
> GPMC_CONFIG4 reg: 4030403
> 
> GPMC_CONFIG5 reg: 1040505
> 
> GPMC_CONFIG6 reg: 4030000
> 
> and here is a screen shot of the logic analyzer:
> 
> http://balister.dyndns.org:8008/~balister/gpmc-write.png

This won't help with your current problem probably..

But once you get things working, please take a look the gpmc.c.
The GPMC values should be dynamically calculated depending on
the L3 speed. There are several examples of that in gpmc-onenand.c
and gpmc-smc91x.c.

You should be able to calculate the timings needed from the
external device data sheets. Also, Paul noted earlier that for
some devices you also need to add up the latencies for the level
shifter.

Then while at it, maybe check with your logic analyzer to make
sure the timings set using gpmc.c really are what we're trying
them to? I don't think anybody has ever verified that.

Regards,

Tony
