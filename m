From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: [PATCH 1/3] omap3evm: ehci: Add EHCI padconfig for board Rev >=
 E
Date: Wed, 28 Oct 2009 15:44:56 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C012AD6D875@dlee02.ent.ti.com>
References: <1256742758-32702-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59079 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755563AbZJ1Uo7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Oct 2009 16:44:59 -0400
In-Reply-To: <1256742758-32702-1-git-send-email-ajay.gupta@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "tony@atomide.com" <tony@atomide.com>

> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Gupta, Ajay Kumar
> Sent: Wednesday, October 28, 2009 5:13 PM
 [...]
> 
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> ---
>  arch/arm/mach-omap2/mux.c             |    7 +++++++
>  arch/arm/plat-omap/include/plat/mux.h |    5 +++++
>  2 files changed, 12 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
> index 32c953e..00ad592 100644
> --- a/arch/arm/mach-omap2/mux.c
> +++ b/arch/arm/mach-omap2/mux.c
> @@ -551,6 +551,13 @@ MUX_CFG_34XX("AF13_3430_MMC3_DAT3", 0x5e2,
>  MUX_CFG_34XX("AF26_34XX_SYS_NIRQ", 0x1E0,
>  		OMAP3_WAKEUP_EN | OMAP34XX_PIN_INPUT_PULLUP |
>  		OMAP34XX_MUX_MODE0)
> +/* EHCI GPIO's on OMAP3EVM (Rev >= E) */
> +MUX_CFG_34XX("AH14_34XX_GPIO21", 0x5ea,
> +	OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT_PULLUP)
> +MUX_CFG_34XX("AF9_34XX_GPIO22", 0x5ec,
> +	OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT_PULLUP)
> +MUX_CFG_34XX("U3_34XX_GPIO61", 0x0c8,
> +	OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT_PULLUP)
Apologies, but cant the bootloader handle this? do we want to wait for cleanup of mux system before doing this?

Regards,
Nishanth Menon
