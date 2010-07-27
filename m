From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: RE: DSS2: DSI: Check for TX FIFO emptiness when sending long
 packets
Date: Tue, 27 Jul 2010 10:16:32 +0300
Message-ID: <1280214992.2427.33.camel@tubuntu.research.nokia.com>
References: <FCCFB4CDC6E5564B9182F639FC3560870305FAB05B@dbde02.ent.ti.com>
	 <1280139608.2427.27.camel@tubuntu.research.nokia.com>
	 <FCCFB4CDC6E5564B9182F639FC3560870305FAB129@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:25421 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751817Ab0G0HRD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Jul 2010 03:17:03 -0400
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC3560870305FAB129@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Taneja, Archit" <archit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, 2010-07-26 at 13:18 +0200, ext Taneja, Archit wrote:

> I am not sure about this, it can be probably aligned with what is done in
> update_screen_l4(). I didn't exaclty get why you block till
> fifo_stalls > 0xfffff and if we can have a similar reasoning for send_long?
> 
> It would be great though if we can make dsi_vc_send_long() configurable enough
> to be actually used in dsi_update_screen_l4(), because they both have enough
> common code beween them.

dsi_update_screen_l4() is quite old and unused code. I was mainly trying
out how CPU can be used for DSI transfer, and trying out different ways
to get better performance. You shouldn't look at it as any reference =).

The 0xfffff was just a random number to abort the transfer if it didn't
seem to go through. It worked for me, but probably won't work for other
cases.

I don't think that anyone really wants to update the screen with CPU, so
the code could even be removed.

 Tomi


