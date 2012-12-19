From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP4: PRM: Correct reset source map
Date: Wed, 19 Dec 2012 16:57:11 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1212191656590.16873@utopia.booyaka.com>
References: <1355911588-21977-1-git-send-email-ivan.khoronzhuk@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:46205 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614Ab2LSQ5M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Dec 2012 11:57:12 -0500
In-Reply-To: <1355911588-21977-1-git-send-email-ivan.khoronzhuk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>

On Wed, 19 Dec 2012, Ivan Khoronzhuk wrote:

> In the map for reset sources register we use defines intended for
> using with PRM_RSTCTRL register. So fix it.
> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>

Thanks, queued for v3.8-rc fixes.


- Paul
