From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH v4 2/7] OMAP: DSS2: Represent DISPC register defines
 with channel as parameter
Date: Mon, 15 Nov 2010 17:17:18 +0200
Message-ID: <1289834238.2668.41.camel@tubuntu>
References: <1289219065-1362-1-git-send-email-archit@ti.com>
	 <1289219065-1362-3-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:34763 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757775Ab0KOPR1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Nov 2010 10:17:27 -0500
In-Reply-To: <1289219065-1362-3-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Archit Taneja <archit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Sumit Semwal <sumit.semwal@ti.com>, Mukund Mittal <mmittal@ti.com>, Samreen <samreen@ti.com>

Hi,

On Mon, 2010-11-08 at 13:24 +0100, ext Archit Taneja wrote:
> From: Sumit Semwal <sumit.semwal@ti.com>
> 
> Introduce new enum members for LCD2 Channel and corresponding Overlay Manager.
> 
> Represent some of the DISPC register defines with channel as a parameter
> to differentiate between LCD, DIGIT and LCD2 channels. Replace the existing
> reads/writes to these registers in this new way.
> 
> Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
> Signed-off-by: Mukund Mittal <mmittal@ti.com>
> Signed-off-by: Samreen <samreen@ti.com>

<snip>

> @@ -1843,9 +1847,9 @@ static void dispc_enable_digit_out(bool enable)
>  bool dispc_is_channel_enabled(enum omap_channel channel)
>  {
>         if (channel == OMAP_DSS_CHANNEL_LCD)
> -               return !!REG_GET(DISPC_CONTROL, 0, 0);
> +               return !!REG_GET(DISPC_CONTROL(channel), 0, 0);
>         else if (channel == OMAP_DSS_CHANNEL_DIGIT)
> -               return !!REG_GET(DISPC_CONTROL, 1, 1);
> +               return !!REG_GET(DISPC_CONTROL(channel), 1, 1);
>         else
>                 BUG();
>  }

I don't think this is good.

Looking at the code here, it looks like we're accessing different
DISPC_CONTROL registers for LCD and DIGIT out. But we're not.

For some registers it's good to have DISPC_XXX(ch) style, when the
registers are accessed identically for different channels. Then you can
just modify the same bits in DISPC_REG(ch) register, and you don't have
to mind what the channel actually is.

But this is not the case in the function above.

The DISPC_CONTROL(ch) is defined as:
DISPC_REG(ch != 2 ? 0x0040 : 0x0238)

I don't think this is actually right. DISPC_CONTROL is not a register
defined per channel. The register at 0x40 contains bits for both
channels 0 and 1. Perhaps leave DISPC_CONTROL as it was, and add
DISPC_CONTROL2, because the registers are not used similarly for all
channels. Or you can come up with some other solution, but using channel
as argument for the macro doesn't look right.

The same comments apply to other functions using DISPC_CONTROL(channel).
(And possibly to some other registers which are similar).

 Tomi


