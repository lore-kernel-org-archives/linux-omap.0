From: "Taneja, Archit" <archit@ti.com>
Subject: RE: [PATCH] OMAP: DSS2: DSI: disable manager on framedone timeout
Date: Thu, 17 Jun 2010 14:37:07 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087030580A772@dbde02.ent.ti.com>
References: =?ISO-8859-1?Q?=20<\=1B[1~>?=  <1276763395-23922-1-git-send-email-archit@ti.com>
 <1276764694.12438.74.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49365 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751494Ab0FQJHP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jun 2010 05:07:15 -0400
In-Reply-To: <1276764694.12438.74.camel@tubuntu.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> Sent: Thursday, June 17, 2010 2:22 PM
> To: Taneja, Archit
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH] OMAP: DSS2: DSI: disable manager on framedone timeout
> 
> Hi,
> 
> On Thu, 2010-06-17 at 10:29 +0200, ext Archit Taneja wrote:
> > In the case of a dsi framedone timeout, we should set the LCD_EN
> > bit to 0 and reset the dsi tx fifo so that the next panel update
> > call goes through cleanly.
> >
> > With the new way of handling framedone interrupts, since everything
> > is handled in irq context, the only reason a framedone timeout occurs
> > is because of some hardware issue.
> >
> > The reset of LCD_EN and flush of TX_FIFO won't interfere with a frame
> > in progress.
> 
> Does this work? There is the errata: 1.29. DSI: Tx FIFO flush is not
> supported. I've actually removed the dsi_reset_tx_fifo() function in my
> work tree, as I though the only way to recover is to reset the whole DSI
> block.
> 
>  Tomi
> 
The errata is there, but things still seem to be okay, the crucial thing is disabling LCD_EN, this will at least prepare DISPC for the next frame.

I think that if a framedone timeout occurs, it is DISPC which is at fault since it generates the framedone interrupt. It is quite likely that DSI is in a ok state.

I agree it is risky to flush DSI TX fifo since it is in the errata, but we should still disable LCD_EN here because no one else disables it.

Thanks,

Archit
