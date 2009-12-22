From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH] OMAP: ZOOM2: Correcting key mapping for few keys
Date: Tue, 22 Dec 2009 11:30:19 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94026AD400F7@dbde02.ent.ti.com>
References: <ce9ab5790912172333q77525952ndc6deb657cf12da2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40281 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751194AbZLVGA1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Dec 2009 01:00:27 -0500
In-Reply-To: <ce9ab5790912172333q77525952ndc6deb657cf12da2@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vimal Singh <vimal.newwork@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Vimal Singh
> Sent: Friday, December 18, 2009 1:03 PM
> To: linux-omap@vger.kernel.org
> Subject: [PATCH] OMAP: ZOOM2: Correcting key mapping for few keys

Applicable for Zoom3 also. 

> 
> From ab3239189c25a19d7764042cc3f05cce8a91f291 Mon Sep 17 00:00:00 2001
> From: Vimal Singh <vimalsingh@ti.com>
> Date: Fri, 18 Dec 2009 12:09:10 +0530
> Subject: [PATCH] OMAP: ZOOM2: Correcting key mapping for few keys
> 
> Keys: 'right arrow', 'up arrow' and 'select' were mapped
> wrongly. This patch corrects them.
> This patch also adds one missing key present in the board,
> currently I added it as 'unknown' key, as I am not able to
> find proper description for this key.
> One key entry (r: 7, c: 5) is present in the keymap, which
> is really not present in the board, removing it.
> 
> Signed-off-by: Vimal Singh <vimalsingh@ti.com>
> ---
>  arch/arm/mach-omap2/board-zoom-peripherals.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c
> b/arch/arm/mach-omap2/board-zoom-peripherals.c
> index 8dd277c..1e3dfb6 100755
> --- a/arch/arm/mach-omap2/board-zoom-peripherals.c
> +++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
> @@ -63,21 +63,21 @@ static int board_keymap[] = {
>  	KEY(5, 1, KEY_H),
>  	KEY(5, 2, KEY_J),
>  	KEY(5, 3, KEY_F3),
> +	KEY(5, 4, KEY_UNKNOWN),
>  	KEY(5, 5, KEY_VOLUMEDOWN),
>  	KEY(5, 6, KEY_M),
> -	KEY(5, 7, KEY_ENTER),
> +	KEY(5, 7, KEY_RIGHT),
>  	KEY(6, 0, KEY_Q),
>  	KEY(6, 1, KEY_A),
>  	KEY(6, 2, KEY_N),
>  	KEY(6, 3, KEY_BACKSPACE),
>  	KEY(6, 6, KEY_P),
> -	KEY(6, 7, KEY_SELECT),
> +	KEY(6, 7, KEY_UP),
>  	KEY(7, 0, KEY_PROG1),	/*MACRO 1 <User defined> */
>  	KEY(7, 1, KEY_PROG2),	/*MACRO 2 <User defined> */
>  	KEY(7, 2, KEY_PROG3),	/*MACRO 3 <User defined> */
>  	KEY(7, 3, KEY_PROG4),	/*MACRO 4 <User defined> */
> -	KEY(7, 5, KEY_RIGHT),
> -	KEY(7, 6, KEY_UP),
> +	KEY(7, 6, KEY_SELECT),
>  	KEY(7, 7, KEY_DOWN)
>  };
> 
> -- 
> 1.5.5
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 