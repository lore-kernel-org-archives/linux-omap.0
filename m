From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH] arm: omap5: dts: fix reg property size
Date: Fri, 12 Jul 2013 18:07:04 +0530
Message-ID: <51DFF870.5060507@ti.com>
References: <1373630285-17389-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55765 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932193Ab3GLMha (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Jul 2013 08:37:30 -0400
In-Reply-To: <1373630285-17389-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

On Friday 12 July 2013 05:28 PM, Felipe Balbi wrote:
> USB3 block has a 64KiB space, another 64KiB is
> used for the wrapper.
> 
> Without this change, resource_size() will get
> confused and driver won't probe because size
> will be negative.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
> 
> does anybody know Benoit's knew email address ?
benoit.cousson@linaro.org

-Kishon
