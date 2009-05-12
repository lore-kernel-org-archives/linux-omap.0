From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 0/2] I2C: OMAP: spurious IRQ fixes
Date: Tue, 12 May 2009 12:41:43 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0905121238040.17514@utopia.booyaka.com>
References: <20090426042504.31316.68357.stgit@localhost.localdomain> <49F59D89.3030008@nokia.com> <alpine.DEB.2.00.0905071529070.17514@utopia.booyaka.com> <13B9B4C6EF24D648824FF11BE8967162038BBF5056@dlee02.ent.ti.com>
 <alpine.DEB.2.00.0905121139500.17514@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46573 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752590AbZELSln (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 May 2009 14:41:43 -0400
In-Reply-To: <alpine.DEB.2.00.0905121139500.17514@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Aaro Koskinen <aaro.koskinen@nokia.com>

One correction:

On Tue, 12 May 2009, Paul Walmsley wrote:

> At least receive overruns are handled gracefully by the controller. 
> Transmit FIFO underruns may be the more pressing problem.

Rather, transmit underruns are probably nonfatal in master mode also.  
But both receive overruns and transmit underruns in I2C slave mode are 
problematic, since the OMAP doesn't control the clock.


- Paul
