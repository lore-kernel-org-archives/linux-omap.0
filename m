From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH] OMAP: DSS2: DSI: disable manager on framedone timeout
Date: Thu, 17 Jun 2010 11:51:34 +0300
Message-ID: <1276764694.12438.74.camel@tubuntu.research.nokia.com>
References: =?ISO-8859-1?Q?=20<\=1B[1~>?=  <1276763395-23922-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:39848 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753369Ab0FQIwh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jun 2010 04:52:37 -0400
In-Reply-To: <1276763395-23922-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Archit Taneja <archit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Thu, 2010-06-17 at 10:29 +0200, ext Archit Taneja wrote:
> In the case of a dsi framedone timeout, we should set the LCD_EN
> bit to 0 and reset the dsi tx fifo so that the next panel update
> call goes through cleanly.
> 
> With the new way of handling framedone interrupts, since everything
> is handled in irq context, the only reason a framedone timeout occurs
> is because of some hardware issue.
> 
> The reset of LCD_EN and flush of TX_FIFO won't interfere with a frame
> in progress.

Does this work? There is the errata: 1.29. DSI: Tx FIFO flush is not
supported. I've actually removed the dsi_reset_tx_fifo() function in my
work tree, as I though the only way to recover is to reset the whole DSI
block.

 Tomi


