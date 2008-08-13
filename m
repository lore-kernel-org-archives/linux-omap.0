From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH] MUSB: Workaround for simultaneous TX and RX usage
Date: Wed, 13 Aug 2008 11:53:21 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0256A369D9@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02568EBABF@dbde02.ent.ti.com>
 <20080805093224.GS30539@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:48007 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750956AbYHMGXf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Aug 2008 02:23:35 -0400
In-Reply-To: <20080805093224.GS30539@gandalf.research.nokia.com>
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
> I just don't like that amount of ifdefs, as we were discussing out of
> the list we should use runtime checks where possible.
> 
> Let's wait on this one since Anand will send another patch set later on
> this week.

Updated patch coming up. Run-time checks are still not implemented. It would
be nice to have, but I fail to see on what basis I can have the runtime check.
Suggestions are welcome.

I've left in only two #ifdefs - one for the dma callback function, and the other
for the call to omap_request_dma(). The other ifdefs are now gone - replaced with
runtime checks based on whether a system DMA channel has been acquired.

Also fixed a small bug which would make this patch not compile.

- Anand

