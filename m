From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH v2 1/1] i2c:OMAP3:Errata workaround for spurious RDR
 event
Date: Tue, 23 Jun 2009 15:29:00 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0906231524590.6545@utopia.booyaka.com>
References: <1245702865-4459-1-git-send-email-ubh@ti.com> <alpine.DEB.2.00.0906221915540.9637@utopia.booyaka.com> <EAF47CD23C76F840A9E7FCE10091EFAB02B5259C55@dbde02.ent.ti.com> <alpine.DEB.2.00.0906222113200.9637@utopia.booyaka.com>
 <00695C9C8F8B4448856F48142B4AA201BDA38C4A@dnce02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42808 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240AbZFWV26 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Jun 2009 17:28:58 -0400
In-Reply-To: <00695C9C8F8B4448856F48142B4AA201BDA38C4A@dnce02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hald, Ulrik Bech" <ubh@ti.com>
Cc: "Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello Ulrik,

one other thing to check,

On Tue, 23 Jun 2009, Hald, Ulrik Bech wrote:

> > -----Original Message-----
> > From: Paul Walmsley [mailto:paul@pwsan.com]
>
> > Is it possible for the RDR bit to be erroneously set when BB =
> > 0?
> 
> Yes, the nature of the errata is that the RDR interrupt could be 
> spurious. Although, if the bus is not busy and the RDR is set 
> erroneously (there are no bytes in the FIFO to be drained), then the 
> normal isr code would just leave and do nothing, which is what we also 
> need in the errata work around.

Is the BB bit indirectly controlled by the driver, or by the I2C IP block?

If the former, then perhaps there is no need to read the BB bit at all. 
The ISR can just ignore the RDR interrupts until the rest of the driver 
code indicates that the RDRs are worth paying attention to.


- Paul
