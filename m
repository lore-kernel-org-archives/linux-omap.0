From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2] OMAP: DSS2: DSI: Introduce sync_vc functions
Date: Tue, 29 Mar 2011 10:12:21 +0300
Message-ID: <1301382741.2370.52.camel@deskari>
References: <1301372773-4719-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:46788 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754077Ab1C2HMZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Mar 2011 03:12:25 -0400
Received: by mail-wy0-f175.google.com with SMTP id 20so3360081wye.20
        for <linux-omap@vger.kernel.org>; Tue, 29 Mar 2011 00:12:23 -0700 (PDT)
In-Reply-To: <1301372773-4719-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org

On Tue, 2011-03-29 at 09:56 +0530, Archit Taneja wrote:
> The DSI protocol engine has no interrupt for signalling the end of a Frame
> transfer. The present approach is to send a BTA after DISPC generates a
> FRAMEDONE interrupt, and unlock the dsi bus only when the BTA Ack is received.
> 
> The assumption made with this approach was that OMAP will send a BTA only after
> the long packet corresponding to the last line is sent. However, it is possible
> that on the DISPC FRAMEDONE interrupt there are 2 (or more) lines of pixel data
> in the DSI line buffer. Hence, the BTA Ack could be received for the long packet
> corresponding to the second last line (or the third last and so on..).
> Therefore, the current method doesn't ensure that the complete frame data is
> sent before we start a new transfer. A similar explanation holds valid if we
> send a BTA in between multiple short/long command packets from the slave port.
> 
> Introduce dsi_sync functions, based on Tomi Valkeinen's idea, which ensure
> that all the DSI Virtual Channels enabled complete their previous work before
> proceeding to the next Frame/Command.
> 
> For a frame update, the DSI driver now sends a callback to the Panel Driver
> on the FRAMEDONE interrupt itself. The callback in the panel driver then unlocks
> the bus. dsi_sync() functions are placed in dsi_vc_config_l4() and
> dsi_vc_config_vp() to ensure that the previous tasks of the Virtual Channels are
> completed.
> 
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
> v2:
> -Introduce dsi_sync() which syncs all VCs.
> -Modify commit message for above change.

We don't need to sync all VCs in dsi_vc_config_l4/vp(). There's no
problem changing a VC between l4 and vp while other VCs are still
transmitting.

The problematic case where we need to sync all VCs is sending a BTA. BTA
is not a VC-based thing, but a bus wide thing. If another VC was still
transmitting data when we send a BTA, we cannot know when the BTA was
actually sent, and to which packet the panel responds.

But this BTA actually quite a messy thing overall. Consider a case where
we use two VCs. We first set VC0 to send a bunch of packets. Then we use
VC1 to send, say, READ_ID1, and after that we send a BTA to get the ID1.

Now, even if send_bta() would call dsi_sync(), we don't know which
packet was actually sent last. Was it the READ_ID1, or something from
VC0?

Luckily these things are not a problem in any current use case, as we
have only one DSI device connected to a single DSI bus, and we can just
use one VC.

So... I think we could just use the v1 of this patch for now (if the
dsi_sync change was the only change). This leaves us with the problem of
sending the double BTA (which doesn't manifest currently), which can be
fixed in a separate patch. And we need to think more about the solution
for using multiple VCs reliably, and see to it later if there's need.
How does that sound?

 Tomi


