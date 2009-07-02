From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH v2 1/1] i2c:OMAP3:Errata workaround for spurious RDR
 event
Date: Thu, 2 Jul 2009 05:39:43 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0907020533460.21200@utopia.booyaka.com>
References: <1245702865-4459-1-git-send-email-ubh@ti.com> <alpine.DEB.2.00.0906221915540.9637@utopia.booyaka.com> <EAF47CD23C76F840A9E7FCE10091EFAB02B5259C55@dbde02.ent.ti.com> <alpine.DEB.2.00.0906222113200.9637@utopia.booyaka.com>
 <00695C9C8F8B4448856F48142B4AA201BDA38C4A@dnce02.ent.ti.com> <alpine.DEB.2.00.0906231146550.6545@utopia.booyaka.com> <7A436F7769CA33409C6B44B358BFFF0C0116011C19@dlee02.ent.ti.com> <00695C9C8F8B4448856F48142B4AA201BDB1387D@dnce02.ent.ti.com>
 <alpine.DEB.2.00.0907020326230.6974@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43729 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917AbZGBLjk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Jul 2009 07:39:40 -0400
In-Reply-To: <alpine.DEB.2.00.0907020326230.6974@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hald, Ulrik Bech" <ubh@ti.com>
Cc: "Menon, Nishanth" <nm@ti.com>, "Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 2 Jul 2009, Paul Walmsley wrote:

> That looks correct on 2430, 3430 where the I2C controller has a FIFO.  
> But for 2420, dev->fifo_size == 0, which causes num_bytes = 1, which will 
> attempt a single read from the I2C controller.  (This assumes that the bug 
> is present on 2420 - do you know if the erratum applies there also?)

Thinking about this further, this shouldn't apply to 2420 since it is 
using the FIFO-less rev 2 I2C, and therefore won't have the RDR bit.
So, I agree with Ulrik: no patch seems necessary for this erratum.

> 
> 
> - Paul
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
