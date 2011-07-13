From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] ARM: OMAP4: PCM049: remove vusim regulator
Date: Wed, 13 Jul 2011 16:13:01 +0400
Message-ID: <4E1D8BCD.5060901@ru.mvista.com>
References: <1310554738.18446.12.camel@lws-weitzel> <1310554762-10743-1-git-send-email-j.weitzel@phytec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:54831 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945Ab1GMMOS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jul 2011 08:14:18 -0400
Received: by wyg8 with SMTP id 8so87881wyg.19
        for <linux-omap@vger.kernel.org>; Wed, 13 Jul 2011 05:14:16 -0700 (PDT)
In-Reply-To: <1310554762-10743-1-git-send-email-j.weitzel@phytec.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jan Weitzel <j.weitzel@phytec.de>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

Hello.

On 13-07-2011 14:59, Jan Weitzel wrote:

> vusim is not used.

> Signed-off-by: Jan Weitzel<j.weitzel@phytec.de>
> ---
>   arch/arm/mach-omap2/board-omap4pcm049.c |   16 +---------------
>   1 files changed, 1 insertions(+), 15 deletions(-)

> diff --git a/arch/arm/mach-omap2/board-omap4pcm049.c b/arch/arm/mach-omap2/board-omap4pcm049.c
> index ad8cb46..85193ec 100644
> --- a/arch/arm/mach-omap2/board-omap4pcm049.c
> +++ b/arch/arm/mach-omap2/board-omap4pcm049.c
[...]
> @@ -318,9 +306,7 @@ static struct i2c_board_info __initdata pcm049_i2c_4_boardinfo[] = {
>   	}
>   };
>
> -static struct twl4030_platform_data pcm049_twldata = {
> -	.vusim		=&pcm049_vusim,
> -};
> +static struct twl4030_platform_data pcm049_twldatai;

    Have you added that 'i' at the end intentionally?

WBR, Sergei
