From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/3] staging: tidspbridge: remove memory consistency from TODO list
Date: Mon, 11 Oct 2010 12:40:25 +0200
Message-ID: <201010111240.25759.arnd@arndb.de>
References: <1286732440-28644-1-git-send-email-felipe.contreras@gmail.com> <1286732440-28644-4-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:52237 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753629Ab0JKKkB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Oct 2010 06:40:01 -0400
In-Reply-To: <1286732440-28644-4-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, Greg KH <greg@kroah.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Russell King <linux@arm.linux.org.uk>

On Sunday 10 October 2010, Felipe Contreras wrote:
> The mempool area is not handled by the kernel any more.

But tidspbridge still uses ioremap to set up the mapping for RAM,
even though it now is outside of the kernel linar mapping.

You should really only use ioremap on MMIO registers, nothing
else. These registers are marked as __iomem pointers and can only
be passed into functions that talk to the hardware like iowrite32
or writel, but not used like memory.

Please have a look at "sparse", which will warn about address space
violations among other things. The tidspbridge driver is full of them,
and you should fix the code that sparse warns about, which will
also show you all the places where ioremap is used incorrectly.

	Arnd
