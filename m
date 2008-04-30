From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH 0/3] DMA clean-up for multi-boot
Date: Wed, 30 Apr 2008 23:30:41 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB2E7D6A3D@dbde02.ent.ti.com>
References: omap-dma-2008-04-30
 <1209575641-25613-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47102 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752786AbYD3SAu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Apr 2008 14:00:50 -0400
In-Reply-To: <1209575641-25613-1-git-send-email-tony@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> Hi all,
>
> Here are three patches to clean DMA code to support multi-boot
> better. I have made quick testing on 24xx and 34xx only so far,
> and things seem to work.
>
> I will also do more testing, but I would appreciate if people would
> give them a quick spin and see if anything breaks. Functionality
> should be same as earlier.
>

I'll try and test these over the next couple of days.

I had some DMA cleanups pending. Will wait till these get in.

- Anand

> I've removed direct DMA register access in few places such as
> omap-hw.c, usb-udc.c, and various audio drivers. So especially
> those areas should be tested carefully.
>
> Regards,
>
> Tony
>
> --
> To unsubscribe from this list: send the line "unsubscribe
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
