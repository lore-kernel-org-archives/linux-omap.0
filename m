From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH] MUSB: Workaround for simultaneous TX and RX usage
Date: Mon, 4 Aug 2008 20:21:22 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02569B8532@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02568EBABF@dbde02.ent.ti.com>
 <20080804141734.GG30539@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:42738 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753297AbYHDO5y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Aug 2008 10:57:54 -0400
In-Reply-To: <20080804141734.GG30539@gandalf.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

> On Mon, Aug 04, 2008 at 06:48:22PM +0530, ext Gadiyar, Anand wrote:
> > MUSB RTL v1.4 has a hardware issue which results in a DMA controller
> > hang when TX and RX DMA channels are simultaneously enabled. This
> > affects at least OMAP2430 and OMAP34XX.
> >
> > Since RX transfers are in Mode 0 and anyway result in one DMA interrupt
> > per packet, we can use System DMA to unload the RX fifos. MUSB DMA can
> > be used for all TX channels as before.
> >
> > Tested with full-duplex TX and RX transfers using g_ether. Runs for 24
> > hours without a hang. Without this patch, the hang occurs within minutes.
>
> This patch is not applying against linux-omap musb neither musb on
> greg's queue. Could you please refresh it ? It's better to use the
> version on greg's queue, if it fails for linux-omap I can prepare a
> clean patch to avoid conflicts later.
>
> --
> balbi
>

Okay! I had prepared this Friday evening and it seemed to apply for me.
I'll check again and re-send.

- Anand
