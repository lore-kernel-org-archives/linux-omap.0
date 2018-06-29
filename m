From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] thermal: ti-soc-thermal: remove dead code
Date: Fri, 29 Jun 2018 18:10:26 +0200
Message-ID: <3318201.BAqn4C3t6k@amdc3058>
References: <10747698.EAsn0e6Ddm@amdc3058>
        <CGME20180629161027eucas1p20846507c4f98f50d80ab58aaa1628fd1@eucas1p2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <10747698.EAsn0e6Ddm@amdc3058>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


Hi,

On Wednesday, May 02, 2018 03:20:35 PM Bartlomiej Zolnierkiewicz wrote:
> Majority of this code (i.e. functions from ti-bandgap.c) has been
> introduced in May 2013 by commit eb982001dbd8 ("thermal: introduce TI
> SoC thermal driver"). Just remove it altogether (in case it is needed
> it can be easily resurrected from git repo).
> 
> While at it fix incorrect "not used" comments.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/thermal/ti-soc-thermal/dra752-bandgap.h      |   68 ---
>  drivers/thermal/ti-soc-thermal/dra752-thermal-data.c |   65 ---
>  drivers/thermal/ti-soc-thermal/omap3-thermal-data.c  |    6 
>  drivers/thermal/ti-soc-thermal/omap4-thermal-data.c  |   10 
>  drivers/thermal/ti-soc-thermal/omap4xxx-bandgap.h    |   10 
>  drivers/thermal/ti-soc-thermal/omap5-thermal-data.c  |   46 --
>  drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h    |   41 --
>  drivers/thermal/ti-soc-thermal/ti-bandgap.c          |  370 -------------------
>  drivers/thermal/ti-soc-thermal/ti-bandgap.h          |   43 --
>  9 files changed, 5 insertions(+), 654 deletions(-)

Gentle ping.

It would be great to see this patch in v4.19.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
