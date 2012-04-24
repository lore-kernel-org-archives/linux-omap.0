From: Tero Kristo <t-kristo@ti.com>
Subject: RE: OMAP3EVM not booting on l-o master
Date: Tue, 24 Apr 2012 15:23:14 +0300
Message-ID: <1335270194.2149.89.camel@sokoban>
References: <C8443D0743D26F4388EA172BF4E2A7A9317C3A03@DBDE01.ent.ti.com>
	 <C8443D0743D26F4388EA172BF4E2A7A9317C3B18@DBDE01.ent.ti.com>
	 <alpine.DEB.2.00.1204050330380.10302@utopia.booyaka.com>
	 <alpine.DEB.2.00.1204050403460.10302@utopia.booyaka.com>
	 <C8443D0743D26F4388EA172BF4E2A7A9317C4B44@DBDE01.ent.ti.com>
	 <alpine.DEB.2.00.1204051303000.10302@utopia.booyaka.com>
	 <C8443D0743D26F4388EA172BF4E2A7A9317C5DB6@DBDE01.ent.ti.com>
	 <alpine.DEB.2.00.1204060111400.10302@utopia.booyaka.com>
	 <C8443D0743D26F4388EA172BF4E2A7A9317C5EEF@DBDE01.ent.ti.com>
	 <1335173044.2149.64.camel@sokoban>
	 <C8443D0743D26F4388EA172BF4E2A7A93E96E75A@DBDE01.ent.ti.com>
	 <1335176002.2149.65.camel@sokoban>
	 <C8443D0743D26F4388EA172BF4E2A7A93E96E7A7@DBDE01.ent.ti.com>
	 <1335182388.2149.70.camel@sokoban>
	 <C8443D0743D26F4388EA172BF4E2A7A93E96F157@DBDE01.ent.ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50119 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753081Ab2DXMXS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Apr 2012 08:23:18 -0400
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E96F157@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 2012-04-24 at 14:00 +0200, Mohammed, Afzal wrote:
> Hi Tero,
> 
> On Mon, Apr 23, 2012 at 17:29:48, Kristo, Tero wrote:
> > Okay thats good (although I wonder why the attachment got corrupted.)
> > Did you check if the device suspends / resumes properly also? Can you
> > check what do you have in the /proc/interrupts for the hwmod_io
> > interrupt just after boot / after one suspend?
> 
> Device suspends & resumes properly.
> 
> At boot 2, after one suspend-resume 3

Okay that looks normal to me, you just get some prcm interrupts during
boot which was causing the device to hang earlier. Thanks for testing
out.

Paul, how should we take this forward?

-Tero


