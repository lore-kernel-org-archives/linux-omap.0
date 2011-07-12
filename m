From: Vishwanath Sripathy <vishwanath.bs@ti.com>
Subject: RE: [PATCH] OMAP: Keypad: Make keypad_data initdata
Date: Tue, 12 Jul 2011 12:09:39 +0530
Message-ID: <b288e44002208a77adcd0c206d15ecf5@mail.gmail.com>
References: <1310452306-2246-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:33569 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753539Ab1GLGjl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Jul 2011 02:39:41 -0400
Received: by gyg8 with SMTP id 8so2262681gyg.26
        for <linux-omap@vger.kernel.org>; Mon, 11 Jul 2011 23:39:40 -0700 (PDT)
In-Reply-To: <1310452306-2246-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti Datta <shubhrajyoti@ti.com>, linux-omap@vger.kernel.org

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Shubhrajyoti D
> Sent: Tuesday, July 12, 2011 12:02 PM
> To: linux-omap@vger.kernel.org
> Cc: Shubhrajyoti D
> Subject: [PATCH] OMAP: Keypad: Make keypad_data initdata
>
> The keypad data is accessed only at init so making it initdata.
> This removes the section mismatch warning.
>
> Reported-by: Kevin Hilman <khilman@ti.com>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
>  arch/arm/mach-omap2/board-4430sdp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-
> omap2/board-4430sdp.c
Is this issue only for OMAP4 SDP? What about Panda, Beagle, OMAP3 SDP
boards?
If it's only for OMAP4, pls correct the subject.

Vishwa
> index 47e6ab9..2b28c7e 100644
> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@ -195,7 +195,7 @@ static struct omap4_keypad_platform_data
> sdp4430_keypad_data = {
>  	.cols			= 8,
>  };
>
> -static struct omap_board_data keypad_data = {
> +static struct omap_board_data keypad_data __initdata = {
>  	.id	    = 1,
>  	.pads	 = keypad_pads,
>  	.pads_cnt       = ARRAY_SIZE(keypad_pads),
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
