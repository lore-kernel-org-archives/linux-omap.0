From: "Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>
Subject: RE: [PATCH v2 1/1] i2c:OMAP3:Errata workaround for spurious RDR
 event
Date: Tue, 23 Jun 2009 08:19:34 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B5259C55@dbde02.ent.ti.com>
References: <1245702865-4459-1-git-send-email-ubh@ti.com>
 <alpine.DEB.2.00.0906221915540.9637@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37347 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751010AbZFWCtn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Jun 2009 22:49:43 -0400
In-Reply-To: <alpine.DEB.2.00.0906221915540.9637@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "Hald, Ulrik Bech" <ubh@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Paul,

> > +			u8 stat2 = 0;
> > +			stat2 = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
> > +			if (stat2 & OMAP_I2C_STAT_BB)
> > +				return IRQ_HANDLED;
> 
> Why use stat2? Why not just test stat again?

Stat is read at the beginning of the ISR, what if BB bit gets cleared/set a while later, not along with RDR, as a corner case?

If we keep it this way, re-reading the register; what could be the potential problem?

Thanks!
-Jagadeesh
