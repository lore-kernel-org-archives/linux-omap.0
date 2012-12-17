From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/2] ARM: OMAP3: PRCM: Fix incorrect read of reset
 sources
Date: Mon, 17 Dec 2012 18:24:14 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1212171823020.29833@utopia.booyaka.com>
References: <1355765191-21545-1-git-send-email-ivan.khoronzhuk@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:38930 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753798Ab2LQSYP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Dec 2012 13:24:15 -0500
In-Reply-To: <1355765191-21545-1-git-send-email-ivan.khoronzhuk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>

Hi

On Mon, 17 Dec 2012, Ivan Khoronzhuk wrote:

> The flag mask are incorrect, so fix it.
> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>

arch/arm/mach-omap2/prcm.c no longer exists in current mainline; please 
rebase this against Linus' current tree.


- Paul
