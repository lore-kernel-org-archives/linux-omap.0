From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] video: fbdev: omap2: omapfb: displays: panel-dsi-cm:
 Use time comparison kernel macro.
Date: Wed, 14 Jun 2017 15:48:19 +0200
Message-ID: <3422682.9ua2BuFz3Q@amdc3058>
References: <CGME20170515191442epcas5p32579d3f083abfeb3a329a25de53e6acc@epcas5p3.samsung.com>
        <1494875666-4109-1-git-send-email-karim.eshapa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1494875666-4109-1-git-send-email-karim.eshapa@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Karim Eshapa <karim.eshapa@gmail.com>
Cc: tomi.valkeinen@ti.com, peter.ujfalusi@ti.com, tj@kernel.org, mingo@kernel.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Monday, May 15, 2017 09:14:26 PM Karim Eshapa wrote:
> Use time_before_eq() kernel macro for
> time comparison more safe.
> 
> Signed-off-by: Karim Eshapa <karim.eshapa@gmail.com>

Patch queued for 4.13, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
