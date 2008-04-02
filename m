From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] Fix TUSB6010 ID register offsets.
Date: Wed, 2 Apr 2008 05:15:09 -0500
Message-ID: <54be4db45e859f4b06bb75a9034df573@felipebalbi.com>
References: <12068131361588-git-send-email-balrogg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:42128 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703AbYDBKPL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Apr 2008 06:15:11 -0400
In-Reply-To: <12068131361588-git-send-email-balrogg@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrzej Zaborowski <balrogg@gmail.com>
Cc: linux-omap@vger.kernel.org



On Sat, 29 Mar 2008 18:52:16 +0100, Andrzej Zaborowski <balrogg@gmail.com>
wrote:
> From: Andrzej Zaborowski <balrog@zabor.org>
> 
> [Sorry, the previous patch was a copy/paste mistake, this one should be
> better]
> 
> I have no access to the docs for this chip but I'm pretty sure the
current
> address of the two DIDR1 registers is wrong because it's outside the
> TUSB-specific register space.  The modified address in turn has a good
> chance to be correct.
> 
> Signed-off-by: Andrzej Zaborowski <balrog@zabor.org>
Acked-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  drivers/usb/musb/tusb6010.h |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/musb/tusb6010.h b/drivers/usb/musb/tusb6010.h
> index bb25c3b..f2036ef 100644
> --- a/drivers/usb/musb/tusb6010.h
> +++ b/drivers/usb/musb/tusb6010.h
> @@ -225,8 +225,8 @@ extern void tusb_allow_idle(struct musb *musb, u32
> wakeup_enables);
>  #define TUSB_PROD_TEST_RESET_VAL		0xa596
>  #define TUSB_EP_FIFO(ep)			(TUSB_FIFO_BASE + (ep) * 0x20)
> 
> -#define TUSB_DIDR1_LO				0x1f8
> -#define TUSB_DIDR1_HI				0x1fc
> +#define TUSB_DIDR1_LO				(TUSB_SYS_REG_BASE + 0x1f8)
> +#define TUSB_DIDR1_HI				(TUSB_SYS_REG_BASE + 0x1fc)
>  #define		TUSB_DIDR1_HI_CHIP_REV(v)		(((v) >> 17) & 0xf)
>  #define			TUSB_DIDR1_HI_REV_20		0
>  #define			TUSB_DIDR1_HI_REV_30		1
> --
> 1.5.3.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
Best Regards,

Felipe Balbi
http://felipebalbi.com
me@felipebalbi.com

