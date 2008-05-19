From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Power management behavior of linux-2.6.14-omap2-v5
Date: Mon, 19 May 2008 08:18:08 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D913027429045555F3@dlee13.ent.ti.com>
References: <c656a4d20805182349h66efb783pc3b3658a1935ba5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:50357 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760098AbYESNSQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 May 2008 09:18:16 -0400
Content-class: urn:content-classes:message
In-Reply-To: <c656a4d20805182349h66efb783pc3b3658a1935ba5@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arun c <arunedarath@mistralsolutions.com>, linux-omap@vger.kernel.org

You are just talking about your logo disappearing (usually tux)?

It has been this way for years if not forever on all Linux systems.

A long while back in 2.4 this bothered me enough that I did fix it in a MV kernel.  This is in effect of the console layer not saving its logo settings.  It is not all that hard to fix.

For a development system having the logo is kind of a nice thing even an advertising tool.  However, probably no one ships a system with it on.

You might send a patch in to console people to fix it.  When I sent a patch to MV long back it was discarded.  I didn't send it to the proper maintainer which could have stuck then.

Regards,
Richard W.

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of arun c
> Sent: Monday, May 19, 2008 1:49 AM
> To: linux-omap@vger.kernel.org
> Subject: Power management behavior of linux-2.6.14-omap2-v5
> 
> Hi all,
> 
> I am using linux-2.6.14-omap2-v5 to test PM on 2430SDP.
> 
> I did
> 
> a) cat myimg > /dev/fb0
>     I can see "myimg" displayed on the lcd
> 
> b) cat /dev/fb0 > myimg_before_sleep
> 
> c) echo "mem" > /sys/power/state
>     Board goes to sleep state.
> 
> d) After a key press the board awakes and lcd
>    becomes blue "myimg" is disappeared from
>    the screen.
> 
> e) cat /dev/fb0 > myimg_after_wakeup
> 
>  The two binary files "myimg_before_sleep" and
> "myimg_after_wakeup" differs each other.
> 
> Can somebody explain me why such a behavior?
> Why the lcd fails to display the same image
> before and after sleeping?
> 
> Regards,
> Arun C
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
