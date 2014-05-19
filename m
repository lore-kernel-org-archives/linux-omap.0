From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH] ARM: OMAP2+: gpmc: enable wait-pin monitoring for NAND
 devices via DT
Date: Mon, 19 May 2014 17:00:23 +0200
Message-ID: <CABxcv=k7KZAwsP-oW_8k_bZRtMLToCy904kq7Xv=c0da465w2A@mail.gmail.com>
References: <1400267276-16001-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:48339 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374AbaESPAY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 May 2014 11:00:24 -0400
Received: by mail-we0-f174.google.com with SMTP id k48so5733575wev.33
        for <linux-omap@vger.kernel.org>; Mon, 19 May 2014 08:00:23 -0700 (PDT)
In-Reply-To: <1400267276-16001-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-omap <linux-omap@vger.kernel.org>, Roger Quadros <rogerq@ti.com>

Hello Pekon,

On Fri, May 16, 2014 at 9:07 PM, Pekon Gupta <pekon@ti.com> wrote:
> This patch enables 'wait-pin' monitoring in NAND driver if following properties
> are present under NAND DT node
>         gpmc,wait-pin = <wait-pin number>
>         gpmc,wait-on-read;
>         gpmc,wait-on-write;
> As NAND generic framework uses common path nand_chip->dev_ready() for monitoring
> completion of Read and Write status, so wait-pin monitoring is enabled only when
> both 'gpmc,wait-on-read' and 'gpmc,wait-on-write' are specified.
>

I see that the GPMC driver checks if "gpmc,wait-pin" property is
defined and only in that case tries to read both "gpmc,wait-on-read"
and "gpmc,wait-on-write" and prints a "read/write wait monitoring not
enabled!" warning if one of those is not defined.

So my question is, it's a requirement and these 3 properties need to
always be defined together?  If that is the case then I wonder why
there are 3 different properties and why not just defining
"gpmc,wait-pin" implies "gpmc,wait-on-{read,write}" ?

Or if is valid to define "gpmc-wait-pin" without
"gpmc-wait-on-{read,write}" or only one those then why that scary
warning is printed?

Whatever is the case I think that the GPMC DT binding documentation
(Documentation/devicetree/bindings/bus/ti-gpmc.txt) should be more
clear on this regard.

> Signed-off-by: Pekon Gupta <pekon@ti.com>
> ---
>  arch/arm/mach-omap2/gpmc-nand.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
> index 4349e82..7dc742d 100644
> --- a/arch/arm/mach-omap2/gpmc-nand.c
> +++ b/arch/arm/mach-omap2/gpmc-nand.c
> @@ -123,11 +123,13 @@ int gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data,
>                 }
>         }
>
> -       if (gpmc_nand_data->of_node)
> +       if (gpmc_nand_data->of_node) {
>                 gpmc_read_settings_dt(gpmc_nand_data->of_node, &s);
> -       else
> +               if (s.wait_on_read && s.wait_on_write)

You said that wait-on-pin monitoring is only enabled if both
"gpmc,wait-on-read" and "gpmc,wait-on-write" are specified. But in
that case I think we should clear the wait_pin on
gpmc_read_settings_dt() if either "gpmc,wait-on-read" or
"gpmc,wait-on-write" were not specified and check s.wait_pin instead.

Or is this semantic only for NAND and other devices connected to the
GPMC behave differently wrt "gpmc,wait-pin"?

> +                       gpmc_nand_data->dev_ready = "true";

You should really use gpmc_nand_data->dev_ready = true here. The C99
standard allows you to assign a string literal to a _Bool type and
will be evaluated to 1 but that is confusing and I haven't seen that
used in other part of the kernel.

> +       } else {
>                 gpmc_set_legacy(gpmc_nand_data, &s);
> -
> +       }
>         s.device_nand = true;
>
>         err = gpmc_cs_program_settings(gpmc_nand_data->cs, &s);
> --
> 1.8.5.1.163.gd7aced9
>

Best regards,
Javier
