From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAP: DSS2: DSI: Introduce sync_vc functions
Date: Thu, 24 Mar 2011 10:38:31 +0200
Message-ID: <1300955911.2806.38.camel@deskari>
References: <1300874374-23112-1-git-send-email-archit@ti.com>
	 <1300952882.2806.29.camel@deskari>  <4D8B02A1.9090907@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41838 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933750Ab1CXIif (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Mar 2011 04:38:35 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p2O8cYvM006559
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 24 Mar 2011 03:38:34 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id p2O8cYZY020275
	for <linux-omap@vger.kernel.org>; Thu, 24 Mar 2011 03:38:34 -0500 (CDT)
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p2O8cYH7017633
	for <linux-omap@vger.kernel.org>; Thu, 24 Mar 2011 03:38:34 -0500 (CDT)
In-Reply-To: <4D8B02A1.9090907@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Taneja, Archit" <archit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 2011-03-24 at 03:36 -0500, Taneja, Archit wrote:
> Hi,
> 
> On Thursday 24 March 2011 01:18 PM, Valkeinen, Tomi wrote:

> > So how to solve that...
> >
> > Two ways come to my mind:
> > - Track sent BTAs in dsi.c. Every time we send a packet, reset the
> > counter. Every time we send a BTA, increase the counter. Thus at frame
> > update we would know if we need to send an extra BTA.
> >
> > - Always reset the BTA "status" from the panel at the beginning of frame
> > transfer. This could be done by sending a null packet.
> >
> > The second one is probably simpler and more failsafe as there's no state
> > stored. The first one (as well as the current system) would go wrong if
> > something strange happens, like the panel resets. However, the second
> > one introduces some overhead, as we need to send a null packet and two
> > BTAs (versus one BTA) for every frame. It's probably negligible, though.
> 
> Okay. I agree the second one is a better option. I have a couple of 
> queries though:
> -The second BTA should be sent only after we get the Ack for the first 
> one, i.e, we need to use bta_sync() for the first BTA, right?

True.

> -We shouldn't send null packets and the 2 BTAs at all if we aren't using 
> Automatic TE mode, is this correct?

If by automatic TE mode you mean the DSI TEE trigger, then yes. There's
currently check for the dsi.te_enabled in dsi_update_screen_dispc() for
that.

> -Whose job should it be to send the null packet and the 2 BTAs, the dsi 
> driver or the panel driver?

I'd say the dsi driver. It currently sends the one BTA in
dsi_update_screen_dispc(). Adding one null packet and a BTA there should
be quite simple.

 Tomi


