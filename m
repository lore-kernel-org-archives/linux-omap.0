From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 3/3] OMAP3 EVM: Add twl4030 keypad driver support
Date: Tue, 24 Jun 2008 01:45:15 +0300
Message-ID: <20080623224514.GD5257@kedavra.cpe.vivax.com.br>
References: <48601AD8.7060303@ridgerun.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:41000 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbYFWWpG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Jun 2008 18:45:06 -0400
Content-Disposition: inline
In-Reply-To: <48601AD8.7060303@ridgerun.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Miguel Angel Aguilar Ulloa <miguel.aguilar@ridgerun.com>
Cc: linux-omap@vger.kernel.org

On Mon, Jun 23, 2008 at 03:51:20PM -0600, Miguel Angel Aguilar Ulloa wrote:
> Enable twl4030 keypad driver in omap3_evm_defconfig
>
> Signed-off-by: Miguel Angel Aguilar <miguel.aguilar@ridgerun.com>
>
> --- a/arch/arm/configs/omap3_evm_defconfig	2008-06-11 08:32:45.000000000 -0600
> +++ b/arch/arm/configs/omap3_evm_defconfig	2008-06-23 14:35:23.000000000 -0600
> @@ -601,7 +601,16 @@ CONFIG_INPUT=y
> #
> # Input Device Drivers
> #
> -# CONFIG_INPUT_KEYBOARD is not set
> +CONFIG_INPUT_KEYBOARD=y
> +# CONFIG_KEYBOARD_ATKBD is not set
> +# CONFIG_KEYBOARD_SUNKBD is not set
> +# CONFIG_KEYBOARD_LKKBD is not set
> +# CONFIG_KEYBOARD_XTKBD is not set
> +# CONFIG_KEYBOARD_NEWTON is not set
> +# CONFIG_KEYBOARD_STOWAWAY is not set
> +CONFIG_KEYBOARD_TWL4030=y

make them modules. If something happens we can rmmod/insmod.

-- 
Best Regards,

Felipe Balbi
me@felipebalbi.com
http://blog.felipebalbi.com
