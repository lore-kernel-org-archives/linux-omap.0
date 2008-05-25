From: "nick loeve" <trickie@gmail.com>
Subject: Re: [PATCH] Fix n800 build - Remove kernel config conditional declaration of TSC2005 device config structures
Date: Sun, 25 May 2008 10:48:58 +0200
Message-ID: <83c2b2e00805250148j54bd3b77sb4740051d293f5dd@mail.gmail.com>
References: <1211705141-12878-1-git-send-email-trickie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:6787 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968AbYEYItC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 25 May 2008 04:49:02 -0400
Received: by fg-out-1718.google.com with SMTP id 19so908229fgg.17
        for <linux-omap@vger.kernel.org>; Sun, 25 May 2008 01:48:58 -0700 (PDT)
In-Reply-To: <1211705141-12878-1-git-send-email-trickie@gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

This patch is if i do not build with CONFIG_TOUCHSCREEN_TSC2005 enabled.

I am trying to build a bare basics kernel for the n800, and it seems
that arch/arm/mach-omap2/board-n800.c could do with some rearrangement
to not declare/use structures for devices not present in a n800 and
vice versa for the n810.

Im fairly newb, but could have a go at it, if it is deemed a good use of time.

Cheers

On Sun, May 25, 2008 at 10:45 AM,  <trickie@gmail.com> wrote:
>
> Signed-off-by: Nick Loeve <trickie@gmail.com>
> ---
>  arch/arm/mach-omap2/board-n800.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-n800.c b/arch/arm/mach-omap2/board-n800.c
> index ae85c2c..f902482 100644
> --- a/arch/arm/mach-omap2/board-n800.c
> +++ b/arch/arm/mach-omap2/board-n800.c
> @@ -372,7 +372,6 @@ static struct omap2_mcspi_device_config cx3110x_mcspi_config = {
>        .single_channel = 1,
>  };
>
> -#ifdef CONFIG_TOUCHSCREEN_TSC2005
>  static struct tsc2005_platform_data tsc2005_config = {
>        .reset_gpio = 94,
>        .dav_gpio = 106
> @@ -382,7 +381,6 @@ static struct omap2_mcspi_device_config tsc2005_mcspi_config = {
>        .turbo_mode     = 0,
>        .single_channel = 1,
>  };
> -#endif
>
>  static struct spi_board_info n800_spi_board_info[] __initdata = {
>        {
> --
> 1.5.5.1
>
>



-- 
Nick Loeve
