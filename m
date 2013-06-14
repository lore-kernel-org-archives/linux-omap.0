From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP3EVM: Marking omap3_evm_display_init() with
 CONFIG_BROKEN
Date: Fri, 14 Jun 2013 02:38:41 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1306140238270.5514@utopia.booyaka.com>
References: <1371120838-29599-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:52372 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759651Ab3FNCio (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Jun 2013 22:38:44 -0400
In-Reply-To: <1371120838-29599-1-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, rnayak@ti.com

On Thu, 13 Jun 2013, Lokesh Vutla wrote:

> On 37xx EVM non-dt boot fails with current mainline,
> because of broken GPIO numbering in the board file
> that uses hardcoded GPIOs.
> 
> So marking omap3_evm_display_init() with CONFIG_BROKEN
> for now as suggested by Tony as per the below link:
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg90399.html
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com> ---

Tested-by: Paul Walmsley <paul@pwsan.com>

- Paul
