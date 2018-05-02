From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v2] thermal: ti-soc-thermal: fix incorrect entry in
 omap5430_adc_to_temp[]
Date: Wed, 02 May 2018 18:20:59 +0200
Message-ID: <1861949.NMJD6FHQNL@amdc3058>
References: <CGME20180502141432eucas1p1c85aa366979b73c59a46ec0c2f7ef8e6@eucas1p1.samsung.com>
        <17742083.Vu59BImYbG@amdc3058> <20180502154931.GS27619@mai>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20180502154931.GS27619@mai>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wednesday, May 02, 2018 05:49:31 PM Daniel Lezcano wrote:
> On Wed, May 02, 2018 at 04:14:32PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > Entry for Index 941 has one zero too much. Fix it.
> > 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> 
> Good catch :)

Thanks. :)

> I'm curious, how did you spot it ?

While I was reading the driver code I've noticed that
omap5430_adc_to_temp[] and dra752_adc_to_temp[] look pretty
similar so I've diff-ed them to find the actual differences
(+ to see if one of the tables can be removed). One of such
differences was the line containing the incorrect entry.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
