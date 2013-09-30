From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.12-rc3
Date: Mon, 30 Sep 2013 02:58:15 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1309300257070.17980@utopia.booyaka.com>
References: <alpine.DEB.2.02.1309300158430.17980@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:42375 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753819Ab3I3C6R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 29 Sep 2013 22:58:17 -0400
In-Reply-To: <alpine.DEB.2.02.1309300158430.17980@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Jeff.Graham@brukeroptics.com


One of the changes to this testbed, starting with the v3.12-rc kernels, is 
the addition of an OMAP4460-based Variscite VAR-SOM-OM DVK board, 
graciously donated by Jeff Graham at Bruker Optics.

Right now, the bootloader and userspaces in use are the ones that came 
with the board.  So it should be representative of the mainline kernel's 
ability to boot to userspace on many similar board designs.


- Paul
