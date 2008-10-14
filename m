From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/6] HS/EMU OMAP3 SRAM size fix
Date: Tue, 14 Oct 2008 16:07:05 +0300
Message-ID: <94a0d4530810140607s7590ef54iac70d03661f6a4a6@mail.gmail.com>
References: <1223987011-25667-1-git-send-email-tero.kristo@nokia.com>
	 <1223987011-25667-2-git-send-email-tero.kristo@nokia.com>
	 <1223987011-25667-3-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.228]:19300 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752445AbYJNNHG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Oct 2008 09:07:06 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2371828rvb.1
        for <linux-omap@vger.kernel.org>; Tue, 14 Oct 2008 06:07:05 -0700 (PDT)
In-Reply-To: <1223987011-25667-3-git-send-email-tero.kristo@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

On Tue, Oct 14, 2008 at 3:23 PM, Tero Kristo <tero.kristo@nokia.com> wrote:
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
> ---
>  arch/arm/plat-omap/sram.c |   12 +++++++++---
>  1 files changed, 9 insertions(+), 3 deletions(-)
>  mode change 100644 => 100755 arch/arm/plat-omap/sram.c
>
> diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
> old mode 100644
> new mode 100755
> index 9cfb77f..f0ac426
> --- a/arch/arm/plat-omap/sram.c
> +++ b/arch/arm/plat-omap/sram.c
> @@ -125,9 +125,15 @@ void __init omap_detect_sram(void)
>        if (cpu_class_is_omap2()) {
>                if (is_sram_locked()) {
>                        if (cpu_is_omap34xx()) {
> -                               omap_sram_base = OMAP3_SRAM_PUB_VA;
> -                               omap_sram_start = OMAP3_SRAM_PUB_PA;
> -                               omap_sram_size = 0x8000; /* 32K */
> +                               if (omap_type() == OMAP2_DEVICE_TYPE_GP) {
> +                                       omap_sram_base = OMAP3_SRAM_PUB_VA;
> +                                       omap_sram_start = OMAP3_SRAM_PUB_PA;
> +                                       omap_sram_size = 0x8000; /* 32K */
> +                               } else {
> +                                       omap_sram_base = OMAP3_SRAM_PUB_VA;
> +                                       omap_sram_start = OMAP3_SRAM_PUB_PA;
> +                                       omap_sram_size = 0x7000; /* 28K */
> +                               }

It seems omap_sram_base and _start are the same, maybe have leave them
outside the if?

>                        } else {
>                                omap_sram_base = OMAP2_SRAM_PUB_VA;
>                                omap_sram_start = OMAP2_SRAM_PUB_PA;
> --
> 1.5.4.3

-- 
Felipe Contreras
