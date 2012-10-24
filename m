From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] gpio/omap: fix off-mode bug: clear debounce clock enable
 mask on disable
Date: Wed, 24 Oct 2012 13:03:45 +0530
Message-ID: <508799D9.6030501@ti.com>
References: <1351015771-6308-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42463 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934396Ab2JXHd5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Oct 2012 03:33:57 -0400
In-Reply-To: <1351015771-6308-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Igor Grinberg <grinberg@compulab.co.il>, linux-arm-kernel@lists.infradead.org

On Tuesday 23 October 2012 11:39 PM, Kevin Hilman wrote:
> From: Kevin Hilman <khilman@ti.com>
>
> When debounce clocks are disabled, ensure that the banks
> dbck_enable_mask is cleared also.  Otherwise, context restore on
> subsequent off-mode transition will restore previous value from the
> shadow copies (bank->context.debounce*) leading to mismatch state
> between driver state and hardware state.
>
> This was discovered when board code was doing
>
>    gpio_request_one()
>    gpio_set_debounce()
>    gpio_free()
>
> which was leaving the GPIO debounce settings in a confused state.
> Then, enabling off mode causing bogus state to be restored, leaving
> GPIO debounce enabled which then prevented the CORE powerdomain from
> transitioning.
>
> Reported-by: Paul Walmsley <paul@pwsan.com>
> Cc: Igor Grinberg <grinberg@compulab.co.il>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

