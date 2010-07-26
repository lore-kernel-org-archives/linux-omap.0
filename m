From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: DSS2: DSI: Check for TX FIFO emptiness when sending long
 packets
Date: Mon, 26 Jul 2010 13:20:08 +0300
Message-ID: <1280139608.2427.27.camel@tubuntu.research.nokia.com>
References: <FCCFB4CDC6E5564B9182F639FC3560870305FAB05B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:16391 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752815Ab0GZKUU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Jul 2010 06:20:20 -0400
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC3560870305FAB05B@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Taneja, Archit" <archit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, 2010-07-26 at 11:28 +0200, ext Taneja, Archit wrote:
> Hi,
> 
> I had a little query. We check for TX FIFO not full before
> sending a short packet in dsi_vc_send_short(), but we
> don't have a similar check in dsi_vc_send_long() before
> writing to the long packet header.
> 
> There is a check of the static fifo size of the channel and
> the length of data we are pushing, but that does not reflect
> the state of the TX FIFO at that point of time.
> 
> Do you think we should have a check using DSI_TX_FIFO_VC_EMPTINESS
> before writing to the long packet header?

Yes, I think we should check that. Otherwise the transfer will break
with DSI_VC_IRQ_FIFO_TX_OVF interrupt, although I think the lcd driver
doesn't currently see this in any way.

Although I'm not sure which would be better, return an error (EBUSY?
EWOULDBLOCK?) if the FIFO cannot hold the whole message, or block until
the FIFO can hold the whole message...

 Tomi


