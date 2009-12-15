From: Ranjith Lohithakshan <ranjithl@ti.com>
Subject: Re: [PATCH 2/2] AM35xx: Clock table updates for AM3505/17
Date: Tue, 15 Dec 2009 17:22:06 +0530
Message-ID: <4B277866.1070602@ti.com>
References: <20091214201431.370.35496.stgit@localhost.localdomain> <20091214201638.370.60113.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36913 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757677AbZLOLwM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Dec 2009 06:52:12 -0500
In-Reply-To: <20091214201638.370.60113.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Paul,

Two small changes wrt USB that came up when I reviewed the AM35XX
clock tree again.

On Tue, 15-Dec-09 1:46 AM +0530, Paul Walmsley wrote:
> From: Ranjith Lohithakshan <ranjithl@ti.com>
> 
> AM3505/17 though a OMAP3530 derivative have the following
> main differences
...

>         CLK("musb_hdrc",        "ick",  &hsotgusb_ick_3430es1,  CK_3430ES1),
> -       CLK("musb_hdrc",        "ick",  &hsotgusb_ick_3430es2,  CK_3430ES2),
> -       CLK(NULL,       "sdrc_ick",     &sdrc_ick,      CK_343X),
> -       CLK(NULL,       "gpmc_fck",     &gpmc_fck,      CK_343X),
> +       CLK("musb_hdrc",        "ick",  &hsotgusb_ick_3430es2,  CK_3430ES2 | CK_AM35XX),

This musb clock is NOT used on AM35XX. I might have included it in
my original patch by mistake.

...

> -       CLK(NULL,       "usbhost_120m_fck", &usbhost_120m_fck, CK_3430ES2),
> +       CLK(NULL,       "usbhost_120m_fck", &usbhost_120m_fck, CK_3430ES2 | CK_AM35XX),
>         CLK(NULL,       "usbhost_48m_fck", &usbhost_48m_fck, CK_3430ES2),

The 48 MHz USB Host fclk is used and applicable on AM35XX as well.

Do you want me to issue another patch for these two changes or could
you update it when you commit? Please let me know.

 - Ranjith

