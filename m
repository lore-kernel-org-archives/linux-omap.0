From: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Subject: Re: [PATCH] OMAP4: 4430sdp: OTG: increase max allowed output current
Date: Fri, 13 Jul 2012 11:23:12 +0530
Message-ID: <CAAe_U6Kza7Zc2SF-ve761Kb2_0Q-9K19qkAZ2eahh-AHrsfh8w@mail.gmail.com>
References: <1342099542-13862-1-git-send-email-ruslan.bilovol@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:60081 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030184Ab2GMFxO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Jul 2012 01:53:14 -0400
Received: by vbal1 with SMTP id l1so2205454vba.9
        for <linux-omap@vger.kernel.org>; Thu, 12 Jul 2012 22:53:12 -0700 (PDT)
In-Reply-To: <1342099542-13862-1-git-send-email-ruslan.bilovol@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ruslan Bilovol <ruslan.bilovol@ti.com>
Cc: balbi@ti.com, tony@atomide.com, linux-omap@vger.kernel.org

Hi,

On Thu, Jul 12, 2012 at 6:55 PM, Ruslan Bilovol <ruslan.bilovol@ti.com> wrote:
> TWL6030/32 that is used on 4430sdp board can deliver up to 200mA
> for OTG port power supply in the HOST mode.
>
> Signed-off-by: Ruslan Bilovol <ruslan.bilovol@ti.com>
> ---
>  arch/arm/mach-omap2/board-4430sdp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
> index 8e17284..10223f5 100644
> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@ -429,7 +429,7 @@ static struct platform_device *sdp4430_devices[] __initdata = {
>  static struct omap_musb_board_data musb_board_data = {
>         .interface_type         = MUSB_INTERFACE_UTMI,
>         .mode                   = MUSB_OTG,
> -       .power                  = 100,
> +       .power                  = 200,
>  };

Shouldn't this change be made for omap4 panda as well.

Thanks
Kishon
