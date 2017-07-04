From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] fbdev: omapfb: constify ctrl_caps, color_caps,
 panel_attr_grp and ctrl_attr_grp
Date: Tue, 04 Jul 2017 16:52:27 +0200
Message-ID: <3053644.gsX76xZsQc@amdc3058>
References: <CGME20170623054258epcas4p102c3c92ced742f0337a2e7c1e2a149e7@epcas4p1.samsung.com>
        <6008756483cab9ccb8566866367d30ef6d98f181.1498196466.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <6008756483cab9ccb8566866367d30ef6d98f181.1498196466.git.arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Friday, June 23, 2017 11:12:14 AM Arvind Yadav wrote:
> File size before:
>    text	   data	    bss	    dec	    hex	filename
>   13007	   1536	    156	  14699	   396b	drivers/video/fbdev/omap/omapfb_main.o
> 
> File size After adding 'const':
>    text	   data	    bss	    dec	    hex	filename
>   13135	   1408	    156	  14699	   396b	drivers/video/fbdev/omap/omapfb_main.o
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Patch queued for 4.13, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
