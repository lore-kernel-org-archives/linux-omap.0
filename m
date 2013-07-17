From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 2/4] pinctrl: Allow pinctrl to have multiple active states
Date: Wed, 17 Jul 2013 14:55:27 -0600
Message-ID: <51E704BF.20508@wwwdotorg.org>
References: <20130716090310.5541.36777.stgit@localhost> <20130716090534.5541.60381.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:59891 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752403Ab3GQUza (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Jul 2013 16:55:30 -0400
In-Reply-To: <20130716090534.5541.60381.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linus.walleij@linaro.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 07/16/2013 03:05 AM, Tony Lindgren wrote:
> It's quite common that we need to dynamically change some pins for a
> device for runtime PM, or toggle a pin between rx and tx. Changing all
> the pins for a device is not efficient way of doing it.
> 
> So let's allow setting up multiple active states for pinctrl. Currently
> we only need PINCTRL_STATIC and PINCTRL_DYNAMIC, where PINCTRL_STATIC
> covers the current default pins, and PINCTRL_DYNAMIC holds the dynamic
> pins that need to be toggled.

> diff --git a/drivers/pinctrl/core.h b/drivers/pinctrl/core.h

> +enum pinctr_states {

s/pinctr/pinctrl/
