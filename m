From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2] OMAP: DSS2: DSI: Introduce sync_vc functions
Date: Tue, 29 Mar 2011 11:10:22 +0300
Message-ID: <1301386222.2370.62.camel@deskari>
References: <1301372773-4719-1-git-send-email-archit@ti.com>
	 <1301382741.2370.52.camel@deskari>  <4D919020.7050009@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:45040 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750908Ab1C2IK2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Mar 2011 04:10:28 -0400
Received: by wwb17 with SMTP id 17so4624495wwb.0
        for <linux-omap@vger.kernel.org>; Tue, 29 Mar 2011 01:10:24 -0700 (PDT)
In-Reply-To: <4D919020.7050009@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 2011-03-29 at 13:24 +0530, Archit Taneja wrote:
> On Tuesday 29 March 2011 12:42 PM, Valkeinen, Tomi wrote:
> > On Tue, 2011-03-29 at 09:56 +0530, Archit Taneja wrote:
> >> The DSI protocol engine has no interrupt for signalling the end of a Frame
> >> transfer. The present approach is to send a BTA after DISPC generates a
> >> FRAMEDONE interrupt, and unlock the dsi bus only when the BTA Ack is received.
> >>
> >> The assumption made with this approach was that OMAP will send a BTA only after
> >> the long packet corresponding to the last line is sent. However, it is possible
> >> that on the DISPC FRAMEDONE interrupt there are 2 (or more) lines of pixel data
> >> in the DSI line buffer. Hence, the BTA Ack could be received for the long packet
> >> corresponding to the second last line (or the third last and so on..).
> >> Therefore, the current method doesn't ensure that the complete frame data is
> >> sent before we start a new transfer. A similar explanation holds valid if we
> >> send a BTA in between multiple short/long command packets from the slave port.
> >>
> >> Introduce dsi_sync functions, based on Tomi Valkeinen's idea, which ensure
> >> that all the DSI Virtual Channels enabled complete their previous work before
> >> proceeding to the next Frame/Command.
> >>
> >> For a frame update, the DSI driver now sends a callback to the Panel Driver
> >> on the FRAMEDONE interrupt itself. The callback in the panel driver then unlocks
> >> the bus. dsi_sync() functions are placed in dsi_vc_config_l4() and
> >> dsi_vc_config_vp() to ensure that the previous tasks of the Virtual Channels are
> >> completed.
> >>
> >> Signed-off-by: Archit Taneja<archit@ti.com>
> >> ---
> >> v2:
> >> -Introduce dsi_sync() which syncs all VCs.
> >> -Modify commit message for above change.
> >
> > We don't need to sync all VCs in dsi_vc_config_l4/vp(). There's no
> > problem changing a VC between l4 and vp while other VCs are still
> > transmitting.
> 
> Yes, makes sense.
> 
> >
> > The problematic case where we need to sync all VCs is sending a BTA. BTA
> > is not a VC-based thing, but a bus wide thing. If another VC was still
> > transmitting data when we send a BTA, we cannot know when the BTA was
> > actually sent, and to which packet the panel responds.
> 
> We can send a BTA per VC, and we get a BTA Ack corresponding to that VC 
> (in DSI_VC_IRQSTATUS_i). I don't know what BTA per VC means, I guess 
> OMAP DSI implementation deviates from the specification here.
> 
> We need to figure out why the bits exist per VC and not in something 
> like DSI_CTRL and DSI_IRQSTATUS.

Hmm, that's true. The HW doesn't really make sense from DSI spec point
of view...

There's no data associated with BTA, it's just a bus-turn-around for the
whole bus. I guess OMAP's DSI HW just keeps track which VC was used to
send the BTA, and as only one BTA can be sent at a time it can then
associate the reply to the sending VC. But still, why would it do that
because it doesn't make any sense...

 Tomi


