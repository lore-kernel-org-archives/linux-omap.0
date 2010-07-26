From: "Taneja, Archit" <archit@ti.com>
Subject: DSS2: DSI: Check for TX FIFO emptiness when sending long packets
Date: Mon, 26 Jul 2010 14:58:12 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870305FAB05B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59073 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752006Ab0GZJ2W convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Jul 2010 05:28:22 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

I had a little query. We check for TX FIFO not full before
sending a short packet in dsi_vc_send_short(), but we
don't have a similar check in dsi_vc_send_long() before
writing to the long packet header.

There is a check of the static fifo size of the channel and
the length of data we are pushing, but that does not reflect
the state of the TX FIFO at that point of time.

Do you think we should have a check using DSI_TX_FIFO_VC_EMPTINESS
before writing to the long packet header?

Thanks,

Archit


