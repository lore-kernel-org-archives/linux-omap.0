From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 13/30] ARM: omap2+: fix omap_hdq_init compilation
Date: Mon, 03 Oct 2011 10:41:06 +0530
Message-ID: <4E8943EA.5060205@ti.com>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de> <1317566760-25681-14-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:36244 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755004Ab1JCFLN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Oct 2011 01:11:13 -0400
In-Reply-To: <1317566760-25681-14-git-send-email-arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sunday 02 October 2011 08:15 PM, Arnd Bergmann wrote:
> The definition of the device must depend on the hardware
> we run on, not on the kernel configuration.
> 
> arch/arm/mach-omap2/devices.c:624:13: error: 'OMAP_HDQ_BASE' undeclared here (not in a function)
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
