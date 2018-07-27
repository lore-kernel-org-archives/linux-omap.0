From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 01/14] thermal: ti-soc-thermal: fix TALERT IRQ handling
 for DRA752
Date: Fri, 27 Jul 2018 16:30:22 +0200
Message-ID: <1926566.4EVPFnjd9v@amdc3058>
References: <1526298141-14045-1-git-send-email-b.zolnierkie@samsung.com>
        <2243156.HcYyxvpmOE@amdc3058> <e9452238-319e-ad4b-5e9a-df3cd0d25ae8@ti.com>
        <CGME20180727143023eucas1p1adfe1860327829e7cf39bcdd3290d11c@eucas1p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <e9452238-319e-ad4b-5e9a-df3cd0d25ae8@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Friday, July 27, 2018 10:13:51 AM Keerthy wrote:
> 
> On Wednesday 25 July 2018 07:57 PM, Bartlomiej Zolnierkiewicz wrote:
> > On Wednesday, July 11, 2018 07:49:41 AM J, KEERTHY wrote:
> >>
> >> On 5/14/2018 5:12 PM, Bartlomiej Zolnierkiewicz wrote:
> >>> .report_temperature is not set in dra752_data which
> >>> results in temperature updates not being propagated by
> >>> ti_bandgap_talert_irq_handler() (it doesn't make much
> >>> sense to handle TALERT IRQ without reporting temperature
> >>> updates to the thermal core). Fix it.
> >>
> >> ATM no one is using TALERT as the thermal software polls on the 
> >> temperature. No real benefit from TALERT.
> >>
> >> TALERT is set at different temperature and software polling thresholds 
> >> come from Device tree and i believe its best for software to go by 
> >> polling and then act on trip points.
> > 
> > Could you please explain what do you mean by "no one is using
> > TALERT"?
> > 
> > The code in ti_bandgap_probe() sets TALERT thresholds and requests
> > IRQ if the TI_BANDGAP_FEATURE_TALERT feature flag is set (and this
> > flag is set in omap4460_data, omap4470_data, omap5430_data and
> > dra752_data).
> 
> The software thresholds and the polling takes care of reducing the
> temperature. What i actually meant was we never relied on talert and the
> polling takes care of keeping a check on the temperature.

OK I see, maybe TALERT handling can be removed altogether?

If not can we make TALERT behavior on DRA752 consistent with other
chipsets supporting TALERT (this is useful for code unification
between OMAP5430 and DRA752)?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
