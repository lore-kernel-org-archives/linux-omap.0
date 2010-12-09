From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] arm: omap4: panda: fix initialize musb
Date: Thu, 09 Dec 2010 11:21:44 -0600
Message-ID: <4D011028.6020505@ti.com>
References: <1291914170-25415-1-git-send-email-tom.leiming@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:41406 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751631Ab0LIRVs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Dec 2010 12:21:48 -0500
Received: by mail-vw0-f46.google.com with SMTP id 16so1759559vws.19
        for <linux-omap@vger.kernel.org>; Thu, 09 Dec 2010 09:21:47 -0800 (PST)
In-Reply-To: <1291914170-25415-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tom.leiming@gmail.com
Cc: tony@atomide.com, balbi@ti.com, linux-omap@vger.kernel.org

tom.leiming@gmail.com had written, on 12/09/2010 11:02 AM, the following:
> From: Ming Lei <tom.leiming@gmail.com>
> 
> Obviously we should only initialize musb once.
> 
> Signed-off-by: Ming Lei <tom.leiming@gmail.com>
> ---
>  arch/arm/mach-omap2/board-omap4panda.c |    3 ---
>  1 files changed, 0 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
> index 22599fc..85371be 100644
> --- a/arch/arm/mach-omap2/board-omap4panda.c
> +++ b/arch/arm/mach-omap2/board-omap4panda.c
> @@ -393,9 +393,6 @@ static void __init omap4_panda_init(void)
>  	usb_nop_xceiv_register();
>  	omap4_ehci_init();
>  	usb_musb_init(&musb_board_data);
> -	/* FIXME: allow multi-omap to boot until musb is updated for omap4 */
> -	if (!cpu_is_omap44xx())
> -		usb_musb_init(&musb_board_data);
>  }
>  
>  static void __init omap4_panda_map_io(void)
Looks good to me. since this is for l-o master branch, I think this 
should probably be squashed to:

commit ec787afd05aad0cdb0b0d2948b356569805e5b30
Author: Felipe Balbi <balbi@ti.com>
Date:   Wed Dec 1 13:48:54 2010 +0200

     arm: omap4: panda: initialize musb

     initialize the musb port on pandaboard.

     Signed-off-by: Felipe Balbi <balbi@ti.com>

Regards,
Nishanth Menon
