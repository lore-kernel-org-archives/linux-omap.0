From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP4: PRM: fix RSTTIME and RSTST offsets
Date: Wed, 19 Dec 2012 16:57:24 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1212191657170.16873@utopia.booyaka.com>
References: <1355911588-21977-1-git-send-email-ivan.khoronzhuk@ti.com> <1355911588-21977-3-git-send-email-ivan.khoronzhuk@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:46214 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755647Ab2LSQ5Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Dec 2012 11:57:25 -0500
In-Reply-To: <1355911588-21977-3-git-send-email-ivan.khoronzhuk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>

On Wed, 19 Dec 2012, Ivan Khoronzhuk wrote:

> From: Nishanth Menon <nm@ti.com>
> 
> RSTTIME is offset 0x8 and RSTST is offset 0x04 for OMAP4430 and
> OMAP4460.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> [ivan.khoronzhuk@ti.com: ported from k3.4]
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>

Thanks guys, queued for v3.8-rc fixes.

- Paul
