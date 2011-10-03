From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 30/30] ARM: omap2: select ARM_AMBA for OMAP3_EMU
Date: Mon, 03 Oct 2011 11:01:49 +0530
Message-ID: <4E8948C5.6080301@ti.com>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de> <1317566760-25681-31-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:46262 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755045Ab1JCFbz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Oct 2011 01:31:55 -0400
In-Reply-To: <1317566760-25681-31-git-send-email-arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Sunday 02 October 2011 08:16 PM, Arnd Bergmann wrote:
> OMAP3_EMU needs OC_ETM, which needs ARM_AMBA. Since the latter
> dependency is getting turned from a 'select' into a 'depends',
> omap has to select ARM_AMBA itself in order to have a correct
> dependency chain. Alternatively, we could change OMAP3_EMU
> to have a 'depends on OC_ETM' instead of selecting it.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
