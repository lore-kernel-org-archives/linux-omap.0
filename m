From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH] MAINTAINERS: add omap2plus_defconfig under OMAP SUPPORT
Date: Mon, 19 Jan 2015 22:52:56 +0100
Message-ID: <CABxcv=keBgUme5mrNKg_h_h1WZHsaz4QOOyEPLa3XJYaEPE0Jw@mail.gmail.com>
References: <1421703901-28295-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f172.google.com ([74.125.82.172]:58691 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730AbbASVw6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Jan 2015 16:52:58 -0500
Received: by mail-we0-f172.google.com with SMTP id k11so33757874wes.3
        for <linux-omap@vger.kernel.org>; Mon, 19 Jan 2015 13:52:56 -0800 (PST)
In-Reply-To: <1421703901-28295-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>

Hello Felipe,

On Mon, Jan 19, 2015 at 10:45 PM, Felipe Balbi <balbi@ti.com> wrote:
> omap2plus_defconfig is also part of the OMAP Support
> maintained, because of that it's best to list it
> under OMAP SUPPORT on MAINTAINERS so people know
> to Cc linux-omap when patching that file.
>
> Reported-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 97de006f38f0..abc6281892e7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6783,6 +6783,7 @@ Q:        http://patchwork.kernel.org/project/linux-omap/list/
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
>  S:     Maintained
>  F:     arch/arm/*omap*/
> +F:     arch/arm/configs/omap2plus_defconfig

While been there, could you please also add omap1_defconfig?

Best regards,
Javier
