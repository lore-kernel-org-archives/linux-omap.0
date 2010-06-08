From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH V3 2/2]OMAP: Disable internal I2C pull-ups in OMAP3630
Date: Tue, 8 Jun 2010 18:29:50 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE896716203BB6EAF57@dlee02.ent.ti.com>
References: <1267211687-23551-1-git-send-email-m-sonasath@ti.com>
 <CD8CC2B65FEE304DA95744A5472698F202D3F744A2@dlee06.ent.ti.com>
 <20100608100437.GP15515@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60725 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752971Ab0FHX3z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Jun 2010 19:29:55 -0400
In-Reply-To: <20100608100437.GP15515@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "Sonasath, Moiz" <m-sonasath@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pais, Allen" <allen.pais@ti.com>, "Pandita, Vikram" <vikram.pandita@ti.com>


> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Tony Lindgren
> Sent: Tuesday, June 08, 2010 5:05 AM

> Sorry for the delay, here's some more info on this issue. So it looks
> like starting with 3630 there are dedicated pull-up for all the I2C buses.
> And the pull values are configurable with software.

Even 3430 claimed to have this controllable in CONGROL.CONTROL_DEVCONF1[12,13,14]

Last year I had read some of this for an omap34xx issue.  A read of TRM + schematic might imply you have 4 possible resistors to watch out for on a typical I2C channel.
        1 weak pull through standard padconf
        2 stronger pull accessible in CONTROL block of SOC
        3 pulls available on T2 (if your i2c target was twl5030)
        4 possible pull on trace for board schematic

Depending on the TRM/DM you look at guidance of value is given in terms of capacitive loading and speed of operation.

A very strong pull might be good to overcome capacitive loading but it will burn more power per bit transmitted.  I saw one customer stick with full speed and use a weaker pull just based on power savings.

If you want to play around you can use pulls in parallel and attempt to make a stronger pull up.  What you end up doing is really determined by what the signal looks like for that design.

> - Disable mux register pull-ups on 3630 and later
>
> - Allow setting the dedicated I2C pull-up values from board-*.c files
>   for 3630 and later
>
> - Warn if the dedicated pull-up values are not configured on 3630 and
>   later

3430 claims to have some dedicated ones. I have heard that seconded guessed.  IIRC 2430 might even have had something. I don't think this is really so new for 36xx just no one used it.

> - Allow disabling the dedicated I2C pull-up values on 3630 and later
>   in case external pull-up resistors are being used.

The settings required are board specific and depend on speed in use.  Having more than available is not necessary an error and might even be deliberate if someone was trying to be cleaver.

Regards,
Richard W.

