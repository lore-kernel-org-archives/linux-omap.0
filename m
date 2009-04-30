From: "vimal singh" <vimalsingh@ti.com>
Subject: Re: [PATCH 1/4] onenand init: Rename board-n800-flash.c to
     gpmc-onenand.c
Date: Thu, 30 Apr 2009 12:03:11 +0530 (IST)
Message-ID: <40106.192.168.10.89.1241073191.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56215 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755600AbZD3Gd2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Apr 2009 02:33:28 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: dedekind@infradead.org, linux-omap@vger.kernel.org, adrian.hunter@nokia.com, Tony Lindgren <tony@atommide.com>

'gpmc-onenand.c' is still confusing name. This is not going to used in
all boards anyway.


On Thu, Apr 30, 2009 at 3:20 AM, Tony Lindgren <tony@atomide.com> wrote:
> Rename board-n800-flash.c to gpmc-onenand.c.
>
> Signed-off-by: Tony Lindgren <tony@atommide.com>
> ---
>  arch/arm/mach-omap2/Makefile           |    4 ++--
>  arch/arm/mach-omap2/gpmc-onenand.c     |    0
>  2 files changed, 2 insertions(+), 2 deletions(-)
>  rename arch/arm/mach-omap2/{board-n800-flash.c => gpmc-onenand.c} (100%)
>
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 76acefa..9127a94 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -55,14 +55,14 @@ obj-$(CONFIG_MACH_OMAP_LDP)         += board-ldp.o \
>  obj-$(CONFIG_MACH_OMAP_APOLLON)                += board-apollon.o \
>                                           board-apollon-mmc.o  \
>                                           board-apollon-keys.o
> -obj-$(CONFIG_MACH_NOKIA_N800)          += board-n800.o board-n800-flash.o \
> +obj-$(CONFIG_MACH_NOKIA_N800)          += board-n800.o gpmc-onenand.o \
>                                           board-n800-mmc.o board-n800-bt.o \
>                                           board-n800-usb.o \
>                                           board-n800-dsp.o \
>                                           board-n800-camera.o
>  obj-$(CONFIG_MACH_NOKIA_N810)          += board-n810.o
>  obj-$(CONFIG_MACH_NOKIA_RX51)          += board-rx51.o \
> -                                          board-n800-flash.o \
> +                                          gpmc-onenand.o \
>                                           board-rx51-flash.o \
>                                           board-rx51-sdram.o \
>                                           board-rx51-video.o \
> diff --git a/arch/arm/mach-omap2/board-n800-flash.c
b/arch/arm/mach-omap2/gpmc-onenand.c
> similarity index 100%
> rename from arch/arm/mach-omap2/board-n800-flash.c
> rename to arch/arm/mach-omap2/gpmc-onenand.c
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
---
Regards,
\/ | |\/| /-\ |_


