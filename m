From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 05/30] ARM: omap: enable building omap2 without omap2420/2430
Date: Mon, 03 Oct 2011 10:37:35 +0530
Message-ID: <4E894317.6040003@ti.com>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de> <1317566760-25681-6-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:59511 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755087Ab1JCFHl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Oct 2011 01:07:41 -0400
In-Reply-To: <1317566760-25681-6-git-send-email-arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sunday 02 October 2011 08:15 PM, Arnd Bergmann wrote:
> Kconfig allows selecting CONFIG_OMAP2 but no specific SOC, the options
> being omap2420 and omap2430, but that leads to a build error when
> omap3 or omap4 are also enabled and the MULTI_OMAP2 symbol is
> undefined.
> 
> This adds another clause to plat/multi.h, mainly to allow all
> possible randconfig combinations to build cleanly.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>




