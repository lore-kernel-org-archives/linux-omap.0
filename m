From: "Taneja, Archit" <archit@ti.com>
Subject: RE: [PATCH v2] OMAP: DSS2: DSI: disable manager on framedone timeout
Date: Tue, 22 Jun 2010 20:37:43 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608703058D0D26@dbde02.ent.ti.com>
References: <1277118621-2086-1-git-send-email-archit@ti.com>
 <alpine.DEB.2.00.1006221314510.3023@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42219 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756498Ab0FVPHx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jun 2010 11:07:53 -0400
In-Reply-To: <alpine.DEB.2.00.1006221314510.3023@tubuntu.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> Sent: Tuesday, June 22, 2010 3:54 PM
> To: Taneja, Archit
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH v2] OMAP: DSS2: DSI: disable manager on framedone
> timeout
> 
> Hi,
> 
> On Mon, 21 Jun 2010, ext Archit Taneja wrote:
> 
> > In the case of a dispc framedone timeout, we should set the LCD_EN
> > bit in DISPC_CONTROL to 0 and reset the dsi tx fifo so that the next
> > panel update call goes through cleanly.
> >
> > With the new way of handling dispc framedone interrupts, since
> everything
> > is handled in irq context, the only reason a dispc framedone timeout
> > may occur is because of some dispc hardware issue.
> >
> > Resetting the TX FIFO is listed as an errata and hence shouldn't be
> > performed on a dispc framedone timeout. But in the case of timeout,
> > we need to disable the manager so that atleast DISPC is in a clean
> > state for the next panel update call.
> >
> > Starting a new DSI transfer with the DSI TX fifo already having content
> > of the previous frame is not desirable, but it is better than not to
> have
> > any future panel updates at all.
> 
> This sounds ok to me, but want to run some tests on this. Where did you
> encounter this problem? Do you have some example scenario where this
> happens?
> 
There is a use case in OMAP4 which requires a 1080p to WVGA downscale. There is some silicon issue which causes the first dispc framedone interrupt to never occur. So for the later frames, we have an issue if we don't clear the LCD_EN bit. I didn't have this issue when the dsi_update_thread existed as the code cleared the bit in the case of a framedone timeout.

I am not sure if such an issue is seen on OMAP3, is there any specific scenario on OMAP3 where you get a framedone timeout (apart from framedone interrupt handling latency)? I want to test too.

I think that on a dispc framedone timeout we can't be sure if there is a problem with only DISPC, only DSI, or a combination of both. But clearly it points more to a DISPC issue.

As a future solution, we can probably have something like a dsi_error_worker which handles things like TA_TO, LP_RX timeout etc by resetting DSI in totality.
> > This patch version removes the reset_tx_fifo call as per required by the
> > errata.
> 
> Please don't add patch version notes to the commit message.
> 
> If you want to add extra information to the mail, I believe you can add
> something like this after the commit message (somebody correct me if I'm
> wrong =):
> 
> 
> ---
> Version 3: blaa blaa
> Version 4: foo bar
> 
Thanks for this suggestion. I will keep it in mind for future submissions.
> 
> 
>   Tomi

Archit
