From: Damian <dhobsong@igel.co.jp>
Subject: Re: [PATCH 1.5/4] sh: add a YUV422 output data format, that is also
 supported by LCDC
Date: Wed, 19 May 2010 13:44:32 +0900
Message-ID: <4BF36CB0.1070107@igel.co.jp>
References: <Pine.LNX.4.64.1005071054510.4777@axis700.grange> <Pine.LNX.4.64.1005071246500.4777@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1005071246500.4777@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@nokia.com>
List-Id: linux-omap@vger.kernel.org

(4:59), Guennadi Liakhovetski wrote:
> The LCDC block is allowed to use one of the two output data formats, when used
> with MIPI DSI: RGB24 and YUV422. YUV422 is not currently handled by the LCDC
> driver, but we have to add a define for it for MIPI. Fix indentation while
> at it.
> 
> Signed-off-by: Guennadi Liakhovetski<g.liakhovetski@gmx.de>
> ---
> 
> Hm, this one is actually worse, it actually has to go in before patch 2/4.
> Sorry again.
>
Console framebuffer tested on sh-2.6 tree and sh/dmaengine branch with
the necessary clock and intc patches applied.
Boot logo and framebuffer console displayed with no problems or unusual
effects.

Tested-by: Damian Hobson-Garcia <dhobsong@igel.co.jp>

>   include/video/sh_mobile_lcdc.h |   39 +++++++++++++++++++++------------------
>   1 files changed, 21 insertions(+), 18 deletions(-)
> 
> diff --git a/include/video/sh_mobile_lcdc.h b/include/video/sh_mobile_lcdc.h
> index 2cc893f..5eaea78 100644
> --- a/include/video/sh_mobile_lcdc.h
> +++ b/include/video/sh_mobile_lcdc.h
> @@ -3,24 +3,27 @@
> 
>   #include<linux/fb.h>
> 
> -enum { RGB8,   /* 24bpp, 8:8:8 */
> -       RGB9,   /* 18bpp, 9:9 */
> -       RGB12A, /* 24bpp, 12:12 */
> -       RGB12B, /* 12bpp */
> -       RGB16,  /* 16bpp */
> -       RGB18,  /* 18bpp */
> -       RGB24,  /* 24bpp */
> -       SYS8A,  /* 24bpp, 8:8:8 */
> -       SYS8B,  /* 18bpp, 8:8:2 */
> -       SYS8C,  /* 18bpp, 2:8:8 */
> -       SYS8D,  /* 16bpp, 8:8 */
> -       SYS9,   /* 18bpp, 9:9 */
> -       SYS12,  /* 24bpp, 12:12 */
> -       SYS16A, /* 16bpp */
> -       SYS16B, /* 18bpp, 16:2 */
> -       SYS16C, /* 18bpp, 2:16 */
> -       SYS18,  /* 18bpp */
> -       SYS24 };/* 24bpp */
> +enum {
> +	RGB8,   /* 24bpp, 8:8:8 */
> +	RGB9,   /* 18bpp, 9:9 */
> +	RGB12A, /* 24bpp, 12:12 */
> +	RGB12B, /* 12bpp */
> +	RGB16,  /* 16bpp */
> +	RGB18,  /* 18bpp */
> +	RGB24,  /* 24bpp */
> +	YUV422, /* 16bpp */
> +	SYS8A,  /* 24bpp, 8:8:8 */
> +	SYS8B,  /* 18bpp, 8:8:2 */
> +	SYS8C,  /* 18bpp, 2:8:8 */
> +	SYS8D,  /* 16bpp, 8:8 */
> +	SYS9,   /* 18bpp, 9:9 */
> +	SYS12,  /* 24bpp, 12:12 */
> +	SYS16A, /* 16bpp */
> +	SYS16B, /* 18bpp, 16:2 */
> +	SYS16C, /* 18bpp, 2:16 */
> +	SYS18,  /* 18bpp */
> +	SYS24,  /* 24bpp */
> +};
> 
>   enum { LCDC_CHAN_DISABLED = 0,
>          LCDC_CHAN_MAINLCD,


-- 
Damian Hobson-Garcia
IGEL Co.,Ltd
http://www.igel.co.jp
