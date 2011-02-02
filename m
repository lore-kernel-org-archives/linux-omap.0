From: Anand Gadiyar <gadiyar@ti.com>
Subject: RE: [PATCH] omap4: Fix ULPI PHY init for ES1.0 SDP (Re: 4430SDP boot failure)
Date: Thu, 3 Feb 2011 00:13:43 +0530
Message-ID: <3d41cb89c4a3a3fa93ded7aa9dfaa14d@mail.gmail.com>
References: <20110106170805.GE1198@n2100.arm.linux.org.uk> <20110106180030.GA8249@n2100.arm.linux.org.uk>
 <20110106182023.GV7771@atomide.com> <20110106203238.GH1198@n2100.arm.linux.org.uk>
 <20110106204053.GA7771@atomide.com> <20110107161230.GR1198@n2100.arm.linux.org.uk>
 <20110110185209.GC4957@atomide.com> <20110111231611.GX4957@atomide.com>
 <3c13ae6d9e13b94548bfcaaced7681e8@mail.gmail.com> <20110202011006.GP3358@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:58791 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754772Ab1BBSxT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Feb 2011 13:53:19 -0500
Received: by mail-iw0-f178.google.com with SMTP id 19so278274iwr.23
        for <linux-omap@vger.kernel.org>; Wed, 02 Feb 2011 10:53:14 -0800 (PST)
In-Reply-To: <20110202011006.GP3358@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Keshava Munegowda <keshava_mgowda@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Felipe Balbi <balbi@ti.com>

Tony Lindgren wrote:
> * Anand Gadiyar <gadiyar@ti.com> [110201 04:54]:
> >
> > I believe this fix is fixing your reboot issue, but it's breaking
> > EHCI support on the SDP.
> >
> > The MODE4 above should really be MODE3 - all GPIOs are on MODE3.
> > By changing
> >
> > The patch snippet below fixes EHCI on the SDP, but I believe that
> > making this change will reintroduce the "board reboots" issue
> > you originally reported. Could you check and tell me if this
> > is the case?
>
> Hmm sorry looks like I made a typo there. That should be fixed.
>
> > Just curious - is your board a Blaze, or an SDP?
>
> It's a ES1.0 blaze, with the patch below it reboots early
> during the boot. I also have to disable omap_l2_cache_init
> on this board to get it to boot.
>

...

> Maybe there should be a check for ES1.0 for the USB also?

Looks like a bug on the Blaze boards. There's a large capacitor
on the rails that starts charging when we try to power the USB PHY.
The inrush current is quite high and this causes the reboot.

The capacitor is on the big motherboard called the application
board, so it's independent of the silicon rev. I'm not sure
which revs are affected - I'll try and find out more about the
issue to see if I can come up with a better fix.


- Anand
