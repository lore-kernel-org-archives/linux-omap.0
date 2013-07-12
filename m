From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 1/2] ARM i.MX53: mba53: Fix PWM backlight DT node
Date: Fri, 12 Jul 2013 15:55:37 +0800
Message-ID: <20130712075535.GE25501@S2101-09.ap.freescale.net>
References: <1373553468-6564-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1373553468-6564-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-db8lp0187.outbound.messaging.microsoft.com ([213.199.154.187]:34328
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757184Ab3GLHz4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Jul 2013 03:55:56 -0400
Content-Disposition: inline
In-Reply-To: <1373553468-6564-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, Boris BREZILLON <linux-arm@overkiz.com>, Tomasz Figa <t.figa@samsung.com>, Philip Avinash <avinashphilip@ti.com>, Tony Prisk <linux@prisktech.co.nz>, linux-pwm@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Jul 11, 2013 at 04:37:47PM +0200, Laurent Pinchart wrote:
> The i.MX53 PWM controller uses two cells to describe the PWM specifier.
> Remove the extra unused values from the backlight DT node pwms property.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Applied, thanks.

