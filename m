From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: Question regarding MUSB and dynamic fifo sizing
Date: Mon, 10 Aug 2009 20:02:36 +0300
Message-ID: <20090810170236.GA3528@gandalf>
References: <5A47E75E594F054BAF48C5E4FC4B92AB0305398DE4@dbde02.ent.ti.com>
 <1249665817.11736.21.camel@blitz>
 <FCCFB4CDC6E5564B9182F639FC35608702F5988E89@dbde02.ent.ti.com>
 <1249672953.11736.76.camel@blitz>
 <20090807201712.GB9780@nokia.com>
 <20090808064313.GA11613@nokia.com>
 <20090808071705.GA11844@nokia.com>
 <1249914799.25044.4.camel@blitz>
 <20090810161605.GA4357@gandalf>
 <1249923607.31495.13.camel@blitz>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:43601 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932284AbZHJRC6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Aug 2009 13:02:58 -0400
Content-Disposition: inline
In-Reply-To: <1249923607.31495.13.camel@blitz>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Barada <peterb@logicpd.com>
Cc: me@felipebalbi.com, felipe.balbi@nokia.com, "Pandita, Vikram" <vikram.pandita@ti.com>, "Gadiyar, Anand" <gadiyar@ti.com>, linux-omap <linux-omap@vger.kernel.org>

Hi,

On Mon, Aug 10, 2009 at 01:00:07PM -0400, Peter Barada wrote:
> Actually, not quite.  I noticed that twl4030_vbus_work only sets Vbus,
> never clears it. 
> With that change and the driver configured for OTG mode (I had it host
> when I tested), it doesn't enumerate.
> 
> I added code to decipher the link state, and on startup I now see:
> 
> Jan  1 00:00:13 OMAP-35x user.debug kernel: twl4030_usb twl4030_usb:
> HW_CONDITIONS 0x72/114; link 1 (None)
> 
> Then when I load the driver:
> 
> Jan  1 00:01:30 OMAP-35x user.debug kernel: twl4030_usb twl4030_usb:
> HW_CONDITIONS 0xf2/242; link 2 (Vbus)
> Jan  1 00:01:30 OMAP-35x user.debug kernel: twl4030_usb twl4030_usb:
> HW_CONDITIONS 0x72/114; link 1 (None)
> 
> And when I plug in the OTG adapter/thumbdrive:
> 
> Jan  1 00:02:24 OMAP-35x user.debug kernel: twl4030_usb twl4030_usb:
> HW_CONDITIONS 0x76/118; link 3 (ID)
> 
> and Vbus goes to +5V 30mS after ID grounds, and stays at 5V for only
> 30mS then goes back to ground.  Pulling out and reinserting repeast the
> cycle.
> 
> During this total time, only two interrupts occur ont he MUSB
> controller.  It looks like the connect interrupt is not occuring.
> 
> I'm adding more code to track the interrupts for both the twl4030-usb
> and musb_hdrc so I can understand better what's happening (and more
> importantly what's not).

good you reported :-)

I was about to send a version to linux-usb. Let's see what's going on:

on you setup:

# echo 3 > /sys/modules/musb_hdrc/parameters/debug
# echo 9 > /proc/sysrq-trigger

this will give you more verbose output of what musb sees. BTW, it's odd
you get a VBUS link irq when there shouldn't be any unless you have the
board attached to pc at that time.

-- 
balbi
