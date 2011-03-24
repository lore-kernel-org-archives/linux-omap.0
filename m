From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH] OMAP: DSS2: DSI: Introduce sync_vc functions
Date: Thu, 24 Mar 2011 14:06:49 +0530
Message-ID: <4D8B02A1.9090907@ti.com>
References: <1300874374-23112-1-git-send-email-archit@ti.com> <1300952882.2806.29.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41522 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933710Ab1CXIcX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Mar 2011 04:32:23 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p2O8WKoJ002464
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 24 Mar 2011 03:32:22 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p2O8WJnE025857
	for <linux-omap@vger.kernel.org>; Thu, 24 Mar 2011 14:02:19 +0530 (IST)
In-Reply-To: <1300952882.2806.29.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Thursday 24 March 2011 01:18 PM, Valkeinen, Tomi wrote:
> On Wed, 2011-03-23 at 04:59 -0500, Taneja, Archit wrote:
>> From: Archit Taneja<archit@ti.com>
>>
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
>> Introduce dsi_sync_vc functions, based on Tomi Valkeinen's idea, which ensure
>> that the DSI Virtual Channel in use(update_channel) completes its previous work
>> before proceeding to the next Frame/Command.
>>
>> For a frame update, the DSI driver now sends a callback to the Panel Driver
>> on the FRAMEDONE interrupt itself. The callback in the panel driver then unlocks
>> the bus. dsi_sync_vc() functions are placed in dsi_vc_config_l4() and
>> dsi_vc_config_vp() to ensure that the previous task of the Virtual Channel is
>> completed.
>>
>> Signed-off-by: Archit Taneja<archit@ti.com>
>> ---
>> Note:
>> Applies over the master branch of the tree:
>> http://gitorious.org/linux-omap-dss2/linux/commits/master
>>
>>   drivers/video/omap2/dss/dsi.c |  180 ++++++++++++++++++++++++++--------------
>>   1 files changed, 117 insertions(+), 63 deletions(-)
>
> Looks good, but this patch introduces one problem: handling the double
> BTA for DSI TE.
>
> Currently we aim DSI to be always in a state where one BTA has been
> sent. So when the next frame transfer starts, we can just send one BTA
> and we know we'll get two consecutive BTAs.
>
> This patch removes the BTA which is sent after the frame transfer, thus
> breaking the above system. This doesn't cause problems currently because
> panel-taal.c always sends columns and rows addresses before starting the
> frame update, and a BTA is sent after those configurations. But a simple
> optimization would be to only send column/row config if they have
> changed. And in that case we would not get a double BTA, and thus we'd
> never get the DSI TE.
>
> So how to solve that...
>
> Two ways come to my mind:
> - Track sent BTAs in dsi.c. Every time we send a packet, reset the
> counter. Every time we send a BTA, increase the counter. Thus at frame
> update we would know if we need to send an extra BTA.
>
> - Always reset the BTA "status" from the panel at the beginning of frame
> transfer. This could be done by sending a null packet.
>
> The second one is probably simpler and more failsafe as there's no state
> stored. The first one (as well as the current system) would go wrong if
> something strange happens, like the panel resets. However, the second
> one introduces some overhead, as we need to send a null packet and two
> BTAs (versus one BTA) for every frame. It's probably negligible, though.

Okay. I agree the second one is a better option. I have a couple of 
queries though:
-The second BTA should be sent only after we get the Ack for the first 
one, i.e, we need to use bta_sync() for the first BTA, right?
-We shouldn't send null packets and the 2 BTAs at all if we aren't using 
Automatic TE mode, is this correct?
-Whose job should it be to send the null packet and the 2 BTAs, the dsi 
driver or the panel driver?

Archit
