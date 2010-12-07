From: Felipe Balbi <balbi@ti.com>
Subject: Re: beagleboard-xm network with mainline?
Date: Tue, 7 Dec 2010 11:49:24 +0200
Message-ID: <20101207094924.GP2576@legolas.emea.dhcp.ti.com>
References: <Pine.LNX.4.64.1012071042220.10621@axis700.grange>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:34797 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754999Ab0LGJt3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Dec 2010 04:49:29 -0500
Received: by mail-ew0-f49.google.com with SMTP id 20so7294248ewy.36
        for <linux-omap@vger.kernel.org>; Tue, 07 Dec 2010 01:49:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1012071042220.10621@axis700.grange>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-omap@vger.kernel.org

Hi,

On Tue, Dec 07, 2010 at 10:42:45AM +0100, Guennadi Liakhovetski wrote:
>I managed to bring a mainline 2.6.36 kinda kernel to run on my bbxm,
>Debian rootfs in mmcblk0p2, but I'm getting no connection - neither over
>the SMSC chip, nor over usb-device in gadget mode, nor can I power on the
>on-board hub to plug in a usb-to-eth dongle. What's the catch? How do I
>configure the kernel to get any of those to work?

how about you try with current linux-omap HEAD ? Or linux-mainline HEAD ?

Lots has changed since 2.6.36.

-- 
balbi
