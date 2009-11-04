From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: strange usb errors
Date: Wed, 4 Nov 2009 21:25:33 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DE280401@dbde02.ent.ti.com>
References: <ac9c93b10903201109x79589487w13a74b2901d4f067@mail.gmail.com>
 <loom.20091104T162352-461@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37043 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753510AbZKDPzg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Nov 2009 10:55:36 -0500
In-Reply-To: <loom.20091104T162352-461@post.gmane.org>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Miller <danielrobertmiller@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Daniel Miller
> Sent: Wednesday, November 04, 2009 9:00 PM
> To: linux-omap@vger.kernel.org
> Subject: Re: strange usb errors
> 
> Frans Meulenbroeks <fransmeulenbroeks <at> gmail.com> writes:
> 
> > 
> > The other problem I have is with my wireless zd1211 based 
> wifi dongle.
> > If I connect it I get:
> > 
> > usb 1-2.2: new high speed USB device using ehci-omap and address 6
> > usb 1-2.2: configuration #1 chosen from 1 choice
> > usb 1-2.2: reset high speed USB device using ehci-omap and address 6
> > phy0: Selected rate control algorithm 'pid'
> > zd1211rw 1-2.2:1.0: phy0
> > usb 1-2.2: firmware: requesting zd1211/zd1211_ub
> > usb 1-2.2: firmware: requesting zd1211/zd1211_uphr
> > usb 1-2.2: Could not load firmware file zd1211/zd1211_uphr. 
> Error number -2
> > zd1211rw 1-2.2:1.0: couldn't load firmware. Error number -2
> > 
> > Whether the dongle is directly connected or through a hub does not
> > make a dfifference
> > 
> > However the firmware is there and the very same firmware works under
> > opensuse and used to work under 2.6.27
> > 
> > Anyone an idea ?
> > 
> > Frans
> 
> 
> Hi Frans,
> 
> Did you ever find a solution to this issue?  I am having the 
> same problem with
> my zd1211 wireless adapter.  I put the firmware in 
> /lib/firmware, but I'm
> concerned that request_firmware might be looking somewhere 
> else.  If you were
> able to solve it, would you mind letting me know how so I can 
> try the same fix?
> 

Daniel,

Have you looked at this discussion:
http://ubuntuforums.org/showthread.php?t=806768

Best regards,
Sanjeev

> Thanks,
> Daniel
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 