From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH v2] OMAP: DSS2: DSI: disable manager on framedone
 timeout
Date: Tue, 22 Jun 2010 13:23:51 +0300 (EEST)
Message-ID: <alpine.DEB.2.00.1006221314510.3023@tubuntu.research.nokia.com>
References: <1277118621-2086-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:36953 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759166Ab0FVKYW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jun 2010 06:24:22 -0400
In-Reply-To: <1277118621-2086-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Archit Taneja <archit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Mon, 21 Jun 2010, ext Archit Taneja wrote:

> In the case of a dispc framedone timeout, we should set the LCD_EN
> bit in DISPC_CONTROL to 0 and reset the dsi tx fifo so that the next
> panel update call goes through cleanly.
>
> With the new way of handling dispc framedone interrupts, since everything
> is handled in irq context, the only reason a dispc framedone timeout
> may occur is because of some dispc hardware issue.
>
> Resetting the TX FIFO is listed as an errata and hence shouldn't be
> performed on a dispc framedone timeout. But in the case of timeout,
> we need to disable the manager so that atleast DISPC is in a clean
> state for the next panel update call.
>
> Starting a new DSI transfer with the DSI TX fifo already having content
> of the previous frame is not desirable, but it is better than not to have
> any future panel updates at all.

This sounds ok to me, but want to run some tests on this. Where did you 
encounter this problem? Do you have some example scenario where this 
happens?

> This patch version removes the reset_tx_fifo call as per required by the
> errata.

Please don't add patch version notes to the commit message.

If you want to add extra information to the mail, I believe you can add 
something like this after the commit message (somebody correct me if I'm 
wrong =):


---
Version 3: blaa blaa
Version 4: foo bar



  Tomi
