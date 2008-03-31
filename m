From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Fix TUSB6010 ID register offsets.
Date: Mon, 31 Mar 2008 10:58:11 +0300
Message-ID: <20080331075810.GG26502@atomide.com>
References: <12068131361588-git-send-email-balrogg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:56356 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754078AbYCaH6N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Mar 2008 03:58:13 -0400
Content-Disposition: inline
In-Reply-To: <12068131361588-git-send-email-balrogg@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrzej Zaborowski <balrogg@gmail.com>
Cc: linux-omap@vger.kernel.org

* Andrzej Zaborowski <balrogg@gmail.com> [080329 18:48]:
> From: Andrzej Zaborowski <balrog@zabor.org>
> 
> [Sorry, the previous patch was a copy/paste mistake, this one should be
> better]
> 
> I have no access to the docs for this chip but I'm pretty sure the current
> address of the two DIDR1 registers is wrong because it's outside the
> TUSB-specific register space.  The modified address in turn has a good
> chance to be correct.
> 
> Signed-off-by: Andrzej Zaborowski <balrog@zabor.org>
> ---
>  drivers/usb/musb/tusb6010.h |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/musb/tusb6010.h b/drivers/usb/musb/tusb6010.h
> index bb25c3b..f2036ef 100644
> --- a/drivers/usb/musb/tusb6010.h
> +++ b/drivers/usb/musb/tusb6010.h
> @@ -225,8 +225,8 @@ extern void tusb_allow_idle(struct musb *musb, u32 wakeup_enables);
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

This looks like a valid fix. Hmm, I guess we've had some unnecessary
software workarounds for tusb3.1 chips happening :)

Tony
