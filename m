From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] video: fbdev: omap2: remove rfbi
Date: Mon, 30 Apr 2018 17:34:59 +0200
Message-ID: <2928032.Lxc8GNNcDF@amdc3058>
References: <CGME20180427150914eucas1p14dd8df4a215014ddac990b0ccdb1805c@eucas1p1.samsung.com>
        <2238944.jilJcacc6d@amdc3058>
        <20180427182536.skryxiih5lekqoze@darkstar.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20180427182536.skryxiih5lekqoze@darkstar.musicnaut.iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Friday, April 27, 2018 09:25:37 PM Aaro Koskinen wrote:
> Hi,
> 
> On Fri, Apr 27, 2018 at 05:09:14PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > omapfb equivalent of drm's commit aa61321d4c08 ("drm/omap: remove rfbi"):
> > 
> > The RFBI driver has not worked nor compiled for many years. There are
> 
> What is the build failure you are seeing?
> 
> When removing the "BROKEN", it seems to compile fine, only some sparse
> warnings:

BROKEN is not an user selectable config option so without modifying
drivers/video/fbdev/omap2/omapfb/dss/Kconfig the RFBI driver is not
even included in the kernel build..

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
