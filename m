From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RESEND PATCH 0/2] ARM IRQ Kconfig patches
Date: Wed, 15 Jun 2011 16:48:55 -0700
Message-ID: <8762o61wrc.fsf@ti.com>
References: <1308142960-20767-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:35859 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753327Ab1FOXs7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Jun 2011 19:48:59 -0400
Received: by mail-pz0-f43.google.com with SMTP id 1so882975pzk.2
        for <linux-omap@vger.kernel.org>; Wed, 15 Jun 2011 16:48:58 -0700 (PDT)
In-Reply-To: <1308142960-20767-1-git-send-email-balbi@ti.com> (Felipe Balbi's
	message of "Wed, 15 Jun 2011 16:02:38 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Russell King <linux@arm.linux.org.uk>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

Felipe Balbi <balbi@ti.com> writes:

> I have lost count how many times I have sent
> these patches. Will someone either take them
> in or NAK them so I stop sending ??
>
> Felipe Balbi (2):
>   arm: Kconfig: select correct HAVE_SPARSE_IRQ symbol
>   arm: Kconfig: allow OMAP to use sparse IRQ numbering
>

Tested-by: Kevin Hilman <khilman@ti.com>

Looks good to me.  Built with CONFIG_SPARSE_IRQ=y and boot tested on
OMAP3430/n900 & OMAP4430/Blaze.

Kevin


