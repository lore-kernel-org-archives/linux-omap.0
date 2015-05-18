From: Tony Lindgren <tony@atomide.com>
Subject: Re: High CPU usage when video streaming on EHCI, 3.17.8 kernel with
 DMA enabled
Date: Mon, 18 May 2015 07:59:20 -0700
Message-ID: <20150518145919.GC10274@atomide.com>
References: <CALmG-ASRge4g6euyUEaxrLryvNR_tFSRexFSDZ5HNuzx_W4AyA@mail.gmail.com>
 <Pine.LNX.4.44L0.1505170956410.2774-100000@netrider.rowland.org>
 <20150518102715.34e29c33@perruche.parrot.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:51806 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752179AbbERO7W (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 May 2015 10:59:22 -0400
Content-Disposition: inline
In-Reply-To: <20150518102715.34e29c33@perruche.parrot.biz>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthieu CASTET <matthieu.castet@parrot.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Tom Mises <tommises@gmail.com>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org

* Matthieu CASTET <matthieu.castet@parrot.com> [150518 01:34]:
> Hi,
> 
> last time I checked uvc driver, it was doing memcpy of video buffer : see uvc_video_decode_data.
> 
> It your video resolution is big, this can eat lot's of cpu.
> 
> Doing a trace should help you.

For the memcpy part with DMA this patch should help too:

[PATCH] dmaengine: omap-dma: Add support for memcpy

Regards,

Tony
