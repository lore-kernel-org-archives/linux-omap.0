From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] OMAP34xx: Add padconfig offsets for GPIOs 126-129
Date: Sun, 3 Apr 2011 14:06:31 +0300
Message-ID: <20110403110630.GB2404@legolas.emea.dhcp.ti.com>
References: <4D963442.1020106@tomtom.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:41575 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751488Ab1DCLGh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 3 Apr 2011 07:06:37 -0400
Received: by eyh6 with SMTP id 6so1554914eyh.36
        for <linux-omap@vger.kernel.org>; Sun, 03 Apr 2011 04:06:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4D963442.1020106@tomtom.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthias Kaehlcke <matthias.kaehlcke@tomtom.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Fri, Apr 01, 2011 at 10:23:30PM +0200, Matthias Kaehlcke wrote:
> Add OMAP3_CONTROL_PADCONF_GPIOxxx_OFFSET constants for GPIOs 126-129
> 
> Signed-off-by: Matthias Kaehlcke <matthias@tomtom.com>
> ---
>  arch/arm/mach-omap2/mux34xx.h |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/mux34xx.h b/arch/arm/mach-omap2/mux34xx.h
> index 6543ebf..70d2b8d 100644
> --- a/arch/arm/mach-omap2/mux34xx.h
> +++ b/arch/arm/mach-omap2/mux34xx.h
> @@ -393,6 +393,10 @@
>  #define OMAP3_CONTROL_PADCONF_SAD2D_SWAKEUP_OFFSET		0xa1c
>  #define OMAP3_CONTROL_PADCONF_JTAG_RTCK_OFFSET			0xa1e
>  #define OMAP3_CONTROL_PADCONF_JTAG_TDO_OFFSET			0xa20
> +#define OMAP3_CONTROL_PADCONF_GPIO127_OFFSET			0xa24
> +#define OMAP3_CONTROL_PADCONF_GPIO126_OFFSET			0xa26
> +#define OMAP3_CONTROL_PADCONF_GPIO128_OFFSET			0xa28
> +#define OMAP3_CONTROL_PADCONF_GPIO129_OFFSET			0xa2a

no users for these ?

-- 
balbi
