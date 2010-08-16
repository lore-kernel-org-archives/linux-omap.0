From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] omap: rx51: Add bq27200 battery platform data
Date: Mon, 16 Aug 2010 11:10:29 +0300
Message-ID: <20100816111029.a4c003e0.jhnikula@gmail.com>
References: <201008150112.30128.luke@dashjr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:41720 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339Ab0HPIKY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Aug 2010 04:10:24 -0400
Received: by eyg5 with SMTP id 5so1090191eyg.19
        for <linux-omap@vger.kernel.org>; Mon, 16 Aug 2010 01:10:22 -0700 (PDT)
In-Reply-To: <201008150112.30128.luke@dashjr.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Luke-Jr <luke@dashjr.org>
Cc: Anton Vorontsov <cbou@mail.ru>, linux-omap@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>

On Sun, 15 Aug 2010 01:12:10 -0500
"Luke-Jr" <luke@dashjr.org> wrote:

> Signed-off-by: Luke Dashjr <luke-jr+git@utopios.org>
> ---
>  arch/arm/mach-omap2/board-rx51-peripherals.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
> index 0348392..4131cc6 100644
> --- a/arch/arm/mach-omap2/board-rx51-peripherals.c
> +++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
> @@ -731,6 +731,9 @@ static struct i2c_board_info __initdata rx51_peripherals_i2c_board_info_2[] = {
>  	{
>  		I2C_BOARD_INFO("tlv320aic3x", 0x18),
>  	},
> +	{
> +		I2C_BOARD_INFO("bq27200", 0x55),
> +	},
>  };
>  
Hi

There has been changes in board-rx51-peripherals.c and patch doesn't
apply. Could you refresh this patch against linux-2.6 or linux-omap
tree.


-- 
Jarkko
