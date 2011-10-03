From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 04/30] ARM: omap: add missing __devexit_p() annotations
Date: Mon, 03 Oct 2011 10:29:54 +0530
Message-ID: <4E89414A.6000301@ti.com>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de> <1317566760-25681-5-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:53734 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753310Ab1JCFAB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Oct 2011 01:00:01 -0400
In-Reply-To: <1317566760-25681-5-git-send-email-arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sunday 02 October 2011 08:15 PM, Arnd Bergmann wrote:
> Drivers that refer to a __devexit function in an operations
> structure need to annotate that pointer with __devexit_p so
> replace it with a NULL pointer when the section gets discarded.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
