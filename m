From: Felipe Balbi <balbi@ti.com>
Subject: Re: twl4030_usb porting advice
Date: Fri, 17 Dec 2010 14:43:53 +0200
Message-ID: <20101217124353.GE2653@legolas.emea.dhcp.ti.com>
References: <4D08ACAC.8070900@xlogic.pl>
 <20101215121023.GN2997@legolas.emea.dhcp.ti.com>
 <4D08B41E.7090400@xlogic.pl>
 <20101215123912.GC6734@legolas.emea.dhcp.ti.com>
 <4D08BE16.4020704@xlogic.pl>
 <20101216090956.GG2601@legolas.emea.dhcp.ti.com>
 <4D0B0FFF.6020409@xlogic.pl>
 <20101217101156.GC2653@legolas.emea.dhcp.ti.com>
 <4D0B462A.9070208@xlogic.pl>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:48063 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751359Ab0LQMn7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Dec 2010 07:43:59 -0500
Received: by mail-ew0-f49.google.com with SMTP id 20so249287ewy.36
        for <linux-omap@vger.kernel.org>; Fri, 17 Dec 2010 04:43:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D0B462A.9070208@xlogic.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomasz Mloduchowski <tomasz.mloduchowski@xlogic.pl>
Cc: balbi@ti.com, linux-omap@vger.kernel.org

On Fri, Dec 17, 2010 at 11:14:50AM +0000, Tomasz Mloduchowski wrote:
>I really appreciate your help, this sort of a bug that really stunned me.
>
>I've noticed that the variable storing the error code is set to NULL 
>right before printing it out :(, so I corrected this mistake.
>
>[    2.065216] ehci-omap ehci-omap.0: failed to get ehci port1 
>regulator --> -19

Thanks for that :-)

Error -19 is -ENODEV, so it means there really isn't a regulator.

Maybe you can more debug to ehci_reset() function ?!?

>I also switched to pastebin, with the new, more meaningful dmesg:
>http://pastebin.com/86kfLT2G

I'll look at it and get back to you. But try to figure out exactly where
ehci decides to bounce the port to companion ohci and start adding
printks or dev_info to that. A good start is ehci_reset(), something
like below might help:

diff --git a/drivers/usb/host/ehci-dbg.c b/drivers/usb/host/ehci-dbg.c
index 6e25996..7fdaecf 100644
--- a/drivers/usb/host/ehci-dbg.c
+++ b/drivers/usb/host/ehci-dbg.c
@@ -330,7 +330,7 @@ dbg_port_buf (char *buf, unsigned len, const char *label, int port, u32 status)
  #define dbg_cmd(ehci, label, command) { \
         char _buf [80]; \
         dbg_command_buf (_buf, sizeof _buf, label, command); \
-       ehci_dbg (ehci, "%s\n", _buf); \
+       ehci_info (ehci, "%s\n", _buf); \
  }
  
  #define dbg_port(ehci, label, port, status) { \

a lot already.

-- 
balbi
