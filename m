From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP3: Add missing enable/disable for EMU clock
Date: Thu, 20 Dec 2012 22:48:04 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1212202247531.20441@utopia.booyaka.com>
References: <1356043426-7381-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:50501 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751944Ab2LTWsF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Dec 2012 17:48:05 -0500
In-Reply-To: <1356043426-7381-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Thu, 20 Dec 2012, Jon Hunter wrote:

> The ETM/ETB drivers for OMAP3, enable the emu_src_ck clock in order
> to access the ETM/ETB hardware. The emu_src_ck should enable the EMU
> clock domain so that the ETM/ETB hardware is accessible. However,
> currently when enabling the emu_src_ck the EMU clock domain is not
> being enabled and so the ETM/ETB drivers are failing. Add enable/disable
> clock functions to enable the EMU clock domain when enabling the
> emu_src_ck.
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>

Thanks Jon, queued for 3.8-rc. 


- Paul
