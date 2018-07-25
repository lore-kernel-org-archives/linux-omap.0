From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 04/14] thermal: ti-soc-thermal: cleanup COUNTER feature
 handling for OMAP5
Date: Wed, 25 Jul 2018 16:28:32 +0200
Message-ID: <3308752.XLZtalhOvD@amdc3058>
References: <1526298141-14045-1-git-send-email-b.zolnierkie@samsung.com>
        <1526298141-14045-5-git-send-email-b.zolnierkie@samsung.com>
        <51799355-1a39-7f2f-6a20-a1718b9e0a64@ti.com>
        <CGME20180725142832eucas1p26a8b5a1226b1043d57332b70ba5caaa0@eucas1p2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <51799355-1a39-7f2f-6a20-a1718b9e0a64@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "J, KEERTHY" <j-keerthy@ti.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wednesday, July 11, 2018 09:08:29 AM J, KEERTHY wrote:
> 
> On 5/14/2018 5:12 PM, Bartlomiej Zolnierkiewicz wrote:
> > OMAP5 sensors don't claim COUNTER feature support (they use
> > COUNTER_DELAY feature instead) so there is no need to set fields
> > of struct temp_sensor_registers which are only used for COUNTER
> > feature.
> > 
> > There should be no functional changes caused by this patch.
> 
> Acked-by: Keerthy <j-keerthy@ti.com>

Thank you! Could you please also review/verify patches 5-14?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
