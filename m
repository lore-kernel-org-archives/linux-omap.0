From: "arun c" <arun.edarath@gmail.com>
Subject: Re: [PATCH 6/7] OMAP3 EVM: add lcd support
Date: Wed, 30 Apr 2008 11:16:31 +0530
Message-ID: <c656a4d20804292246r7c626939o54a0373cfde0726d@mail.gmail.com>
References: <5e088bd90804281630h38261b78qbd6436cfa7c1a074@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:47136 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756905AbYD3Fqc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Apr 2008 01:46:32 -0400
Received: by py-out-1112.google.com with SMTP id u52so571440pyb.10
        for <linux-omap@vger.kernel.org>; Tue, 29 Apr 2008 22:46:31 -0700 (PDT)
In-Reply-To: <5e088bd90804281630h38261b78qbd6436cfa7c1a074@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Steve Sakoman <sakoman@gmail.com>

On Tue, Apr 29, 2008 at 5:00 AM, Steve Sakoman <sakoman@gmail.com> wrote:
> From: Steve Sakoman <steve@sakoman.com>
>
>  Add LCD support for OMAP3 EVM
>
>  Signed-off-by: Steve Sakoman <steve@sakoman.com>
>  ---
>  @@ -0,0 +1,168 @@
>  +/*
>  + * LCD panel support for the TI OMAP3 EVM board
>  + *
>  + * Author: Steve Sakoman <steve@sakoman.com>
>  + *
>  + * Derived from drivers/video/omap/lcd-apollon.c
>  + *
>  + * This program is free software; you can redistribute it and/or modify it
>  + * under the terms of the GNU General Public License as published by the
>  + * Free Software Foundation; either version 2 of the License, or (at your
>  + * option) any later version.
>  + *
>  + * This program is distributed in the hope that it will be useful, but
>  + * WITHOUT ANY WARRANTY; without even the implied warranty of
>  + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>  + * General Public License for more details.
>  + *
>  + * You should have received a copy of the GNU General Public License along
>  + * with this program; if not, write to the Free Software Foundation, Inc.,
>  + * 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
>  + */
>  +
>  +#include <linux/module.h>
>  +#include <linux/platform_device.h>
>  +#include <linux/i2c/twl4030.h>
>  +
>  +#include <asm/arch/gpio.h>
>  +#include <asm/arch/mux.h>
>  +#include <asm/arch/omapfb.h>
>  +#include <asm/mach-types.h>
>  +
>  +#define LCD_PANEL_ENABLE_GPIO       153
>  +#define LCD_PANEL_LR                2
>  +#define LCD_PANEL_UD                3
>  +#define LCD_PANEL_INI               152
>  +#define LCD_PANEL_QVGA              154
>  +#define LCD_PANEL_RESB              155
>  +
>  +#define LCD_XRES               480
>  +#define LCD_YRES               640
>  +#define LCD_PIXCLOCK_MAX       41700 /* in pico seconds  */
>  +#define LCD_PIXCLOCK_MIN       38000 /* in pico seconds */
>  +
>  +#define ENABLE_VDAC_DEDICATED  0x03
>  +#define ENABLE_VDAC_DEV_GRP    0x20
>  +#define ENABLE_VPLL2_DEDICATED 0x05
>  +#define ENABLE_VPLL2_DEV_GRP   0xE0
>  +

I did not see you calling the below function any ware
in this file, does this definition really required?

>  +extern void omap2_disp_replication_enable (void);

Regards,
Arun C
