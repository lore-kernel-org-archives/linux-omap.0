From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH v2] OMAP: DSS2: DSI: Introduce sync_vc functions
Date: Tue, 29 Mar 2011 13:24:08 +0530
Message-ID: <4D919020.7050009@ti.com>
References: <1301372773-4719-1-git-send-email-archit@ti.com> <1301382741.2370.52.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55848 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751881Ab1C2HuI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Mar 2011 03:50:08 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p2T7o5IT027582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 29 Mar 2011 02:50:07 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p2T7o3Z5026603
	for <linux-omap@vger.kernel.org>; Tue, 29 Mar 2011 13:20:04 +0530 (IST)
In-Reply-To: <1301382741.2370.52.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tuesday 29 March 2011 12:42 PM, Valkeinen, Tomi wrote:
> On Tue, 2011-03-29 at 09:56 +0530, Archit Taneja wrote:
>> The DSI protocol engine has no interrupt for signalling the end of a Frame
>> transfer. The present approach is to send a BTA after DISPC generates a
>> FRAMEDONE interrupt, and unlock the dsi bus only when the BTA Ack is received.
>>
>> The assumption made with this approach was that OMAP will send a BTA only after
>> the long packet corresponding to the last line is sent. However, it is possible
>> that on the DISPC FRAMEDONE interrupt there are 2 (or more) lines of pixel data
>> in the DSI line buffer. Hence, the BTA Ack could be received for the long packet
>> corresponding to the second last line (or the third last and so on..).
>> Therefore, the current method doesn't ensure that the complete frame data is
>> sent before we start a new transfer. A similar explanation holds valid if we
>> send a BTA in between multiple short/long command packets from the slave port.
>>
>> Introduce dsi_sync functions, based on Tomi Valkeinen's idea, which ensure
>> that all the DSI Virtual Channels enabled complete their previous work before
>> proceeding to the next Frame/Command.
>>
>> For a frame update, the DSI driver now sends a callback to the Panel Driver
>> on the FRAMEDONE interrupt itself. The callback in the panel driver then unlocks
>> the bus. dsi_sync() functions are placed in dsi_vc_config_l4() and
>> dsi_vc_config_vp() to ensure that the previous tasks of the Virtual Channels are
>> completed.
>>
>> Signed-off-by: Archit Taneja<archit@ti.com>
>> ---
>> v2:
>> -Introduce dsi_sync() which syncs all VCs.
>> -Modify commit message for above change.
>
> We don't need to sync all VCs in dsi_vc_config_l4/vp(). There's no
> problem changing a VC between l4 and vp while other VCs are still
> transmitting.

Yes, makes sense.

>
> The problematic case where we need to sync all VCs is sending a BTA. BTA
> is not a VC-based thing, but a bus wide thing. If another VC was still
> transmitting data when we send a BTA, we cannot know when the BTA was
> actually sent, and to which packet the panel responds.

We can send a BTA per VC, and we get a BTA Ack corresponding to that VC 
(in DSI_VC_IRQSTATUS_i). I don't know what BTA per VC means, I guess 
OMAP DSI implementation deviates from the specification here.

We need to figure out why the bits exist per VC and not in something 
like DSI_CTRL and DSI_IRQSTATUS.

>
> But this BTA actually quite a messy thing overall. Consider a case where
> we use two VCs. We first set VC0 to send a bunch of packets. Then we use
> VC1 to send, say, READ_ID1, and after that we send a BTA to get the ID1.
>
> Now, even if send_bta() would call dsi_sync(), we don't know which
> packet was actually sent last. Was it the READ_ID1, or something from
> VC0?
>
> Luckily these things are not a problem in any current use case, as we
> have only one DSI device connected to a single DSI bus, and we can just
> use one VC.
>
> So... I think we could just use the v1 of this patch for now (if the
> dsi_sync change was the only change). This leaves us with the problem of
> sending the double BTA (which doesn't manifest currently), which can be
> fixed in a separate patch. And we need to think more about the solution
> for using multiple VCs reliably, and see to it later if there's need.
> How does that sound?

It sounds okay, i'll send a patch on which will implement sending double 
BTAs in the correct way.

Archit
