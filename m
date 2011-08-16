From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] DMAEngine: Define generic transfer request api
Date: Tue, 16 Aug 2011 15:06:47 +0200
Message-ID: <CACRpkdaY_wuz+zS-iKCPT-M7EpvtxCNX+OJ6NROSaQtZ6XoNMg@mail.gmail.com>
References: <1313147667-3385-1-git-send-email-jaswinder.singh@linaro.org>
	<1313499399.1603.92.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:51495 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753Ab1HPNGs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Aug 2011 09:06:48 -0400
In-Reply-To: <1313499399.1603.92.camel@vkoul-udesk3>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: Jassi Brar <jaswinder.singh@linaro.org>, sundaram@ti.com, dan.j.williams@intel.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, rmk+kernel@arm.linux.org.uk, nsekhar@ti.com

On Tue, Aug 16, 2011 at 2:56 PM, Koul, Vinod <vinod.koul@intel.com> wrote:

> Currently we have two approaches to solve this problem first being the
> DMA_STRIDE_CONFIG proposed by Linus W, I feel this one is better
> approach as this can give client ability to configure each transfer
> rather than set for the channel. Linus W, do you agree?

I think Sundaram is in the position of doing some heavy work on
using one or the other of the API:s, and I think he is better
suited than anyone else of us to select what scheme to use,
in the end he's going to write the first code using the API.

Yours,
Linus Walleij
