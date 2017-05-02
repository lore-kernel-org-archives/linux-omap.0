From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] drivers:video:fbdev:omap:lcd_mipid.c: Use time
 comparison kernel macros
Date: Tue, 02 May 2017 13:36:29 +0200
Message-ID: <1717636.7ZkdHpLOFt@amdc3058>
References: <CGME20170430164251epcas1p263435da7131c78ae26d3bd76f26f1da1@epcas1p2.samsung.com>
        <1493570563-7188-1-git-send-email-karim.eshapa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1493570563-7188-1-git-send-email-karim.eshapa@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Karim Eshapa <karim.eshapa@gmail.com>
Cc: tomi.valkeinen@ti.com, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sunday, April 30, 2017 06:42:43 PM Karim Eshapa wrote:
> Use time_before_eq time comparison defind kernel macro
> that has safety check.
> 
> Signed-off-by: Karim Eshapa <karim.eshapa@gmail.com>

Patch queued for 4.12, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
