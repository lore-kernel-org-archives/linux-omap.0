From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP2: twl-common: fix compiler warnings
Date: Fri, 29 Jun 2012 16:42:44 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206291642290.2338@utopia.booyaka.com>
References: <1340880592-21700-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42766 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752148Ab2F2Wmp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Jun 2012 18:42:45 -0400
In-Reply-To: <1340880592-21700-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, 28 Jun 2012, Tero Kristo wrote:

> OMAP2 does not use the external voltage controller code for TWL, and
> thus OMAP2 only compilation generates following warnings:
> 
> arch/arm/mach-omap2/twl-common.c:51: warning: 'twl_set_voltage' defined but not used
> arch/arm/mach-omap2/twl-common.c:57: warning: 'twl_get_voltage' defined but not used
> 
> This patch moves the code in question behind ARCH specific flags and
> eliminates these warnings.
> 
> Reported-by: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Thanks Tero, looks okay to me.  I guess Kevin or Tony should queue this 
one.


- Paul
