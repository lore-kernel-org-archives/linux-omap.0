From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: OTG MUSB driver issue?
Date: Fri, 27 Feb 2009 19:56:39 +0200
Message-ID: <20090227175638.GE16801@frodo>
References: <ac9c93b10902270952w37660667pece3640b0ba46ffc@mail.gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:44601 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464AbZB0R4p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Feb 2009 12:56:45 -0500
Content-Disposition: inline
In-Reply-To: <ac9c93b10902270952w37660667pece3640b0ba46ffc@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Cc: linux-omap@vger.kernel.org, beagleboard@googlegroups.com

On Fri, Feb 27, 2009 at 06:52:38PM +0100, Frans Meulenbroeks wrote:
> Hi,
> 
> Several times I encountered issues with devices connected to the
> beagle board's OTG port (through a powered hub).
> (kernel 2.6.28-omap1).
> Today this happened again and I was lucky enough to be able to find
> the symptoms.
> 
> Scenario: I had a file on a USB hard disk. This file was copied to an
> SD card. After copying the file was corrupted.
> Removing the card and hard disk and connecting them to my linux box
> allowed me to compare the SD and hard disk version (using cmp -l).
> There were differences on four places. Each difference was 4 bytes (32
> bits) and occurred on a 4 byte boundary.
> 
> I have no idea what causes it, but I strongly suspect the MUSB driver.
> A hauppauge usb tv card also does not work when connected to the hub,
> whereas the same card works without problem on a linksys NSLU2 (which
> also has an arm processor).
> 
> Anyone suggestions? Patches ??

I guess that should be already fixed with patches queued up in Greg's
queue, but then again, let me check more. Could you:

# echo 5 > /sys/modules/musb_hdrc/parameters/debug
# echo 8 > /proc/sysrq-trigger

then connect device and send me log output ?

-- 
balbi
