From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 07/30] ARM: omap: fix visibility of omap2_mbox_iva_priv
Date: Mon, 03 Oct 2011 10:38:27 +0530
Message-ID: <4E89434B.2040503@ti.com>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de> <1317566760-25681-8-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:39817 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755045Ab1JCFId (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Oct 2011 01:08:33 -0400
In-Reply-To: <1317566760-25681-8-git-send-email-arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Sunday 02 October 2011 08:15 PM, Arnd Bergmann wrote:
> map2_mbox_iva_priv is used on multiple omap2 socs but is hidden
> in an outdated #ifdef that is specific to a single soc.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
