From: "AnilKumar, Chimata" <anilkumar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 2/4] rtc: OMAP: Add system pm_power_off to rtc driver
Date: Mon, 12 Nov 2012 09:47:48 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA69B27@DBDE01.ent.ti.com>
References: <1352108549-9341-1-git-send-email-anilkumar@ti.com>
 <1352108549-9341-3-git-send-email-anilkumar@ti.com>
 <B5906170F1614E41A8A28DE3B8D121433EC04226@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433EC04226-Er742YJ7I/eIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: "Bedia, Vaibhav" <vaibhav.bedia-l0cyMroinI0@public.gmane.org>, "a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org" <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, "sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Colin Foe-Parker <colin.foeparker-L+YfUVVR8+RBDgjK7y7TUQ@public.gmane.org>, "rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 06, 2012 at 11:15:34, Bedia, Vaibhav wrote:
> On Mon, Nov 05, 2012 at 15:12:27, AnilKumar, Chimata wrote:
> [...]
> >  
> > +#define SHUTDOWN_TIME_SEC		2
> > +#define SECS_IN_MIN			60
> > +#define WAIT_AFTER			(SECS_IN_MIN - SHUTDOWN_TIME_SEC)
> > +#define WAIT_TIME_MS			(SHUTDOWN_TIME_SEC * 1000)
> > +
> >  static void __iomem	*rtc_base;
> >  
> [...]
> > +
> > +	/* Wait few seconds instead of rollover */
> > +	do {
> > +		omap_rtc_read_time(NULL, &tm);
> > +		if (WAIT_AFTER <= tm.tm_sec)
> > +			mdelay(WAIT_TIME_MS);
> > +	} while (WAIT_AFTER <= tm.tm_sec);
> 
> This hardcoded wait for rollover doesn't look good. I see some
> helper functions in rtc-lib.c which probably could be used for
> converting the current time to elapsed seconds, add the delay and
> then convert it back to the time to be programmed in RTC without
> worrying about rollover. Why not use that?

I am not aware of those APIs, can you point some?

> 
> > +
> > +	/* Add shutdown time to the current value */
> > +	tm.tm_sec += SHUTDOWN_TIME_SEC;
> > +
> > +	if (tm2bcd(&tm) < 0)
> > +		return;
> > +
> > +	pr_info("System will go to power_off state in approx. %d secs\n",
> > +			SHUTDOWN_TIME_SEC);
> > +
> > +	/* Set the ALARM2 time */
> > +	rtc_write(tm.tm_sec, OMAP_RTC_ALARM2_SECONDS_REG);
> > +	rtc_write(tm.tm_min, OMAP_RTC_ALARM2_MINUTES_REG);
> > +	rtc_write(tm.tm_hour, OMAP_RTC_ALARM2_HOURS_REG);
> > +	rtc_write(tm.tm_mday, OMAP_RTC_ALARM2_DAYS_REG);
> > +	rtc_write(tm.tm_mon, OMAP_RTC_ALARM2_MONTHS_REG);
> > +	rtc_write(tm.tm_year, OMAP_RTC_ALARM2_YEARS_REG);
> > +
> > +	/* Enable alarm2 interrupt */
> > +	val = readl(rtc_base + OMAP_RTC_INTERRUPTS_REG);
> > +	writel(val | OMAP_RTC_INTERRUPTS_IT_ALARM2,
> > +				rtc_base + OMAP_RTC_INTERRUPTS_REG);
> > +
> 
> These registers are not present in older versions of the IP so how
> does that get handled?

I think, earlier this feature is not supported/not used.

> 
> You also need to describe the connection between the ALARM2 and the
> power off logic in detail.

Sure, I will add.

Thanks
AnilKumar
