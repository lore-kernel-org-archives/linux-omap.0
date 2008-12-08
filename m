From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/1] Default MUX configuration added for GPIO140-143, GPIO0 and GPIO9
Date: Mon, 8 Dec 2008 03:11:21 -0800
Message-ID: <200812080311.21966.david-b@pacbell.net>
References: <1228729239-7757-1-git-send-email-mani.pillai@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp125.sbc.mail.sp1.yahoo.com ([69.147.65.184]:36504 "HELO
	smtp125.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751473AbYLHLLX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Dec 2008 06:11:23 -0500
In-Reply-To: <1228729239-7757-1-git-send-email-mani.pillai@ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Manikandan Pillai <mani.pillai@ti.com>
Cc: linux-omap@vger.kernel.org

On Monday 08 December 2008, Manikandan Pillai wrote:
> +MUX_CFG_34XX("AF6_34XX_GPIO140", 0x16c,
> +               OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT_PULLUP)


+MUX_CFG_34XX("AF6_34XX_GPIO140_UP", 0x16c,
                               ^^^
+               OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT_PULLUP)

as I commented before.  Stick to the naming convention,
so that folk don't need to guess about whether a given
GPIO is configured with a pullup, a pulldown, or neither.
And so they can choose the right option.
