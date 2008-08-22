From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: Patch [2/2] DaVinci CPPI TX DMA tasklet
Date: Fri, 22 Aug 2008 10:23:08 +0300
Message-ID: <20080822072308.GB9474@gandalf.research.nokia.com>
References: <48AD8526.8080206@gmail.com> <FCCFB4CDC6E5564B9182F639FC3560870229F52485@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:24159 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063AbYHVHWN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Aug 2008 03:22:13 -0400
Content-Disposition: inline
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC3560870229F52485@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Subbrathnam, Swaminathan" <swami.iyer@ti.com>
Cc: Dmitry Krivoschekov <dmitry.krivoschekov@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>

On Fri, Aug 22, 2008 at 07:01:26AM +0530, ext Subbrathnam, Swaminathan wrote:
> <Swami> When in DMA mode (mode 1) Endpoint interrupt does not get
> generated (only DMA completion interrupt) and hence cannot rely on that.

afaict, endpoint interrupt is generated case we get a short packet. Then
dma engine won't send that last short packet and an enpoint interrupt
will be generated, from that point you decide if you wanna use PIO or
reprogram the dma for mode 0.

-- 
balbi
