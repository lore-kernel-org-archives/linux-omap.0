From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] omapfb: panel-dsi-cm: constify dsicm_attr_group
Date: Tue, 04 Jul 2017 16:33:43 +0200
Message-ID: <3864187.P2DtsQDzSm@amdc3058>
References: <CGME20170623052716epcas2p47c5c0848b3cb9b3d2b53fd805bc15099@epcas2p4.samsung.com>
        <624ffdf87293646671d3fef7079d19528108a381.1498195469.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <624ffdf87293646671d3fef7079d19528108a381.1498195469.git.arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Friday, June 23, 2017 10:56:32 AM Arvind Yadav wrote:
> File size before:
>    text	   data	    bss	    dec	    hex	filename
>    4657	    464	      0	   5121	   1401	drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.o
> 
> File size After adding 'const':
>    text	   data	    bss	    dec	    hex	filename
>    4713	    400	      0	   5113	   13f9	drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.o
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Patch queued for 4.13, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
