From: Felipe Balbi <me@felipebalbi.com>
Subject: RE: OMAP3430: MUSB host and hot-plugging
Date: Thu, 20 Mar 2008 07:27:41 -0500
Message-ID: <07bc925acf89140a399f27449dc0f68b@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:46725 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752570AbYCTM1q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Mar 2008 08:27:46 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@mvista.com>, Linux omap <linux-omap@vger.kernel.org>

> Using the default config omap_3430sdp_defconig, I'm doing some basic
> hot-plug tests of MUSB in host mode.
> 
> I noticed that after booting, the first time I connect my USB key, it
> is detected just fine, the usb/scsi storage modulesare loaded by
> hotplug and I can access the device just fine.
> 
> I then remove the key, and the kernel seems to detect the removal just
> fine, and does what seems to be a clean shutdown.
> 
> However, if I then plug the key back in, nothing happens.  
> 
> Forcing a session start via "echo 'F' > /proc/driver/musb_hdrc" causes
> the device to be (re)detected and things look good again.  It is not
> until I force the session start that I see the interrupt and the
> CONNECT event.
> 
> Any ideas why this isn't detected on insertion?

You're better than me then, I can't get even the first insertion
right.

What I'm suspecting is that we do get the insertion but twl4030
do not notify musb about id pin status through ULPI.

You can check that cuz you still in b_idle state even though
you have a mini-A connector attached to it. Also, if you put a
printk in the irq handler (on twl4030-usb.c) you can see it
gets called after attaching the cable.

And there's one other trick, after switching to host role,
you see that you're in a_host from /sys/devices/platform/musb_hdrc.0/mode,
if you remove the cable (mini-A) and attach it again right
after that, before musb_do_idle put musb in b_idle again,
you get the usb stick recognized and musb_core goes back
to a_host from a_wait_bcon state.

I'm suspecting that twl4030_phy_suspend is somehow
messing it up. I'm now digging on it and still
I can't say for sure what's happening.

Maybe somebody else has other comments on that.

-- 
Best Regards,

Felipe Balbi
http://felipebalbi.com
me@felipebalbi.com

