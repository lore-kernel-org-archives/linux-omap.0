From: Daniel Miller <danielrobertmiller@gmail.com>
Subject: Re: strange usb errors
Date: Wed, 4 Nov 2009 15:29:33 +0000 (UTC)
Message-ID: <loom.20091104T162352-461@post.gmane.org>
References: <ac9c93b10903201109x79589487w13a74b2901d4f067@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:38483 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751984AbZKDPfE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 Nov 2009 10:35:04 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1N5ht2-00071z-AT
	for linux-omap@vger.kernel.org; Wed, 04 Nov 2009 16:35:06 +0100
Received: from bul-cryptolab-6.uwaterloo.ca ([129.97.34.69])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Wed, 04 Nov 2009 16:35:04 +0100
Received: from danielrobertmiller by bul-cryptolab-6.uwaterloo.ca with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Wed, 04 Nov 2009 16:35:04 +0100
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Frans Meulenbroeks <fransmeulenbroeks <at> gmail.com> writes:

> 
> The other problem I have is with my wireless zd1211 based wifi dongle.
> If I connect it I get:
> 
> usb 1-2.2: new high speed USB device using ehci-omap and address 6
> usb 1-2.2: configuration #1 chosen from 1 choice
> usb 1-2.2: reset high speed USB device using ehci-omap and address 6
> phy0: Selected rate control algorithm 'pid'
> zd1211rw 1-2.2:1.0: phy0
> usb 1-2.2: firmware: requesting zd1211/zd1211_ub
> usb 1-2.2: firmware: requesting zd1211/zd1211_uphr
> usb 1-2.2: Could not load firmware file zd1211/zd1211_uphr. Error number -2
> zd1211rw 1-2.2:1.0: couldn't load firmware. Error number -2
> 
> Whether the dongle is directly connected or through a hub does not
> make a dfifference
> 
> However the firmware is there and the very same firmware works under
> opensuse and used to work under 2.6.27
> 
> Anyone an idea ?
> 
> Frans


Hi Frans,

Did you ever find a solution to this issue?  I am having the same problem with
my zd1211 wireless adapter.  I put the firmware in /lib/firmware, but I'm
concerned that request_firmware might be looking somewhere else.  If you were
able to solve it, would you mind letting me know how so I can try the same fix?

Thanks,
Daniel


