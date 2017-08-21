From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] omapfb: constify omap_video_timings structures
Date: Mon, 21 Aug 2017 16:48:21 +0200
Message-ID: <3428710.6cjvJVMMQN@amdc3058>
References: <CGME20170812064614epcas2p2dee0d2e45189a2bb6753b40ca99321a1@epcas2p2.samsung.com>
        <1502518836-27189-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1502518836-27189-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, kernel-janitors@vger.kernel.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Bhumika Goyal <bhumirks@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Saturday, August 12, 2017 08:20:36 AM Julia Lawall wrote:
> These omap_video_timings structures are only copied into other
> structures, so they can be const.
> 
> Done with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Patch queued for 4.14, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
