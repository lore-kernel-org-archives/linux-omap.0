From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v3 0/3] OMAP: DSS2: Fix for DISPC core functional clock
 divider
Date: Thu, 3 Mar 2011 18:12:56 +0200
Message-ID: <1299168776.2615.154.camel@deskari>
References: <1299166080-15380-1-git-send-email-raghuveer.murthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47792 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758196Ab1CCQND (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Mar 2011 11:13:03 -0500
In-Reply-To: <1299166080-15380-1-git-send-email-raghuveer.murthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Murthy, Raghuveer" <raghuveer.murthy@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, 2011-03-03 at 09:27 -0600, Murthy, Raghuveer wrote:
> OMAP4 has 2 LCD channels and corresponding DISPC_DIVISOR1 and DISPC_DIVISOR2
> registers to configure the pixel clock frequency, for the respective LCD
> displays.
> 
> There is also DISPC_DIVISOR register, which by default has the ENABLE bit
> set to zero, for backward compatibility mode. Hence the logical clock divider of
> DISPC_DIVISOR1.LCD, gets used for core func clk configuration. The default value
> of DISPC_DIVISOR1.LCD is 4.
> 
> If only the secondary LCD is enabled, at high pixel resolutions the core clk 
> lags behind the pixel clock, causing stair-step effect (diagonal lines with
> tearing) on the display.
> 
> Hence DISPC_DIVISOR.ENABLE is set to 1, and the core functional clock is set 
> independently and exclusively in DISPC_DIVISOR.LCD.
> 
> - Added the above as dss_features

Thanks, applied.

 Tomi


