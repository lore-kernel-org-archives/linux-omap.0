Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B6BC433F5
	for <linux-omap@archiver.kernel.org>; Mon, 27 Sep 2021 15:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2E02604D1
	for <linux-omap@archiver.kernel.org>; Mon, 27 Sep 2021 15:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234974AbhI0PIi (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 27 Sep 2021 11:08:38 -0400
Received: from netrider.rowland.org ([192.131.102.5]:60195 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S234914AbhI0PIi (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Mon, 27 Sep 2021 11:08:38 -0400
Received: (qmail 362132 invoked by uid 1000); 27 Sep 2021 11:06:59 -0400
Date:   Mon, 27 Sep 2021 11:06:59 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Arnd Bergmann <arnd@kernel.org>
List-Id: <soc.lore.kernel.org>
Cc:     soc@kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] ARM: omap1: move omap15xx local bus handling to usb.c
Message-ID: <20210927150659.GB361082@rowland.harvard.edu>
References: <20210927144118.2464881-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927144118.2464881-1-arnd@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

On Mon, Sep 27, 2021 at 04:40:50PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Commit 38225f2ef2f4 ("ARM/omap1: switch to use dma_direct_set_offset for
> lbus DMA offsets") removed a lot of mach/memory.h, but left the USB
> offset handling split into arch/arm/mach-omap1/usb.c and
> drivers/usb/host/ohci-omap.c.
> 
> This can cause a randconfig build warning that now fails the build
> with -Werror:
> 
> arch/arm/mach-omap1/usb.c:561:30: error: 'omap_1510_usb_ohci_nb' defined but not used [-Werror=unused-variable]
>   561 | static struct notifier_block omap_1510_usb_ohci_nb = {
>       |                              ^~~~~~~~~~~~~~~~~~~~~
> 
> Move it all into the platform file to get rid of the final
> location that relies on mach/memory.h.
> 
> Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

For the ohci-omap.c portion:

Acked-by: Alan Stern <stern@rowland.harvard.edu>

