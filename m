From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH v2] usb: musb: fix bug in musbhsdma programming
Date: Tue, 13 Jan 2009 10:01:52 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403ECF70A33@dbde02.ent.ti.com>
References: <1231475946-6810-1-git-send-email-ajay.gupta@ti.com>
 <20090112222649.GL25493@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51757 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753375AbZAMEdL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Jan 2009 23:33:11 -0500
In-Reply-To: <20090112222649.GL25493@frodo>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "me@felipebalbi.com" <me@felipebalbi.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "david-b@pacbell.net" <david-b@pacbell.net>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>

> -----Original Message-----
> From: Felipe Balbi [mailto:me@felipebalbi.com]
> Sent: Tuesday, January 13, 2009 3:57 AM
> To: Gupta, Ajay Kumar
> Cc: linux-omap@vger.kernel.org; david-b@pacbell.net; felipe.balbi@nokia.com
> Subject: Re: [PATCH v2] usb: musb: fix bug in musbhsdma programming
> 
> On Fri, Jan 09, 2009 at 10:09:06AM +0530, Ajay Kumar Gupta wrote:
> > Mode bit should be set based on function parameter "mode" of
> > configure_channel() function.
> >
> > Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> 
> Acked-by: Felipe Balbi <felipe.balbi@nokia.com>
> 
> > ---
> > Original version of this patch is at,
> > http://marc.info/?l=linux-usb&m=123141793611158&w=2
> 
> tony, this should go to l-o

Tony, 

Please use below version refreshed against latest l-o git.

-Ajay
=========================== cut here ======================================
Mode bit should be set based on function parameter "mode" of
configure_channel() function.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
Acked-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/musb/musbhsdma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c index 75b15ce..4394bd3 100644
--- a/drivers/usb/musb/musbhsdma.c
+++ b/drivers/usb/musb/musbhsdma.c
@@ -136,7 +136,7 @@ static void configure_channel(struct dma_channel *channel,
 		csr |= MUSB_HSDMA_BURSTMODE_INCR4;
 
 	csr |= (musb_channel->epnum << MUSB_HSDMA_ENDPOINT_SHIFT)
-		| MUSB_HSDMA_MODE1
+		| (mode ? MUSB_HSDMA_MODE1 : 0)
 		| MUSB_HSDMA_ENABLE
 		| MUSB_HSDMA_IRQENABLE
 		| (musb_channel->transmit
--
1.5.6
