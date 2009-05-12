From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH 0/2] I2C: OMAP: spurious IRQ fixes
Date: Tue, 12 May 2009 12:14:04 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162038BBF5056@dlee02.ent.ti.com>
References: <20090426042504.31316.68357.stgit@localhost.localdomain>
 <49F59D89.3030008@nokia.com>
 <alpine.DEB.2.00.0905071529070.17514@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47845 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756823AbZELROS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 May 2009 13:14:18 -0400
In-Reply-To: <alpine.DEB.2.00.0905071529070.17514@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>


> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Paul Walmsley
> A brief update for anyone following along on the list:
>
> Aaro sent me a test-case.  It seems that the receive overruns only affect
> PM kernels.  They are caused by the MPU going to sleep while it waits for
> an I2C interrupt.  It turns out that the current driver causes receive
> overruns also; it just hides them.  The receive overruns are fairly
> straightforward to deal with by setting an MPU wakeup latency constraint
> during I2C operations.

What kind of latency is being seen by i2c in kernel snapshot you are using?

Do you have an idea of what is tolerable given an I2C frequency? Is this error showing up in 100k/400k/HS mode?

Sometimes a constraint is the only way but it does have cost.

Regards,
Richard W.
