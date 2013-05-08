From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH] USB: set device dma_mask without reference to global data
Date: Wed, 8 May 2013 09:13:56 +0800
Message-ID: <CAL411-qVnm0_wwdAiAp9eq_hYkXzFSmRMLAmknpSAG7Jb3bM9A@mail.gmail.com>
References: <1367967232-10128-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ia0-f179.google.com ([209.85.210.179]:64457 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751657Ab3EHBOR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 May 2013 21:14:17 -0400
In-Reply-To: <1367967232-10128-1-git-send-email-swarren@wwwdotorg.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Warren <swarren@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Alan Stern <stern@rowland.harvard.edu>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, May 8, 2013 at 6:53 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> From: Stephen Warren <swarren@nvidia.com>
>
> Many USB host drivers contain code such as:
>
> if (!pdev->dev.dma_mask)
>         pdev->dev.dma_mask = &tegra_ehci_dma_mask;
>
> ... where tegra_ehci_dma_mask is a global. I suspect this code originated
> in commit 4a53f4e "USB: ehci-tegra: add probing through device tree" and
> was simply copied everywhere else.
>

One question: why device tree can't do this when create device?
