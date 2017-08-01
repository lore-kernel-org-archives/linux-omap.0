From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] drivers/video/fbdev/omap/lcd_mipid.c: add const to
 lcd_panel structure
Date: Tue, 01 Aug 2017 14:59:27 +0200
Message-ID: <1507371.52Fe6WDrgq@amdc3058>
References: <CGME20170714091425epcas3p330b5342b7aba66540b83256d401b7055@epcas3p3.samsung.com>
        <1500023646-8846-1-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1500023646-8846-1-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: julia.lawall@lip6.fr, tomi.valkeinen@ti.com, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Friday, July 14, 2017 02:44:06 PM Bhumika Goyal wrote:
> Make lcd_panel structure const as it is only copied to some object.
> As the only usage of this structure is a copy operation, so it can be
> made const.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

Patch queued for 4.14, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
