From: "AnilKumar, Chimata" <anilkumar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 2/4] rtc: OMAP: Add system pm_power_off to rtc driver
Date: Fri, 16 Nov 2012 10:47:29 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA6D62E@DBDE01.ent.ti.com>
References: <1352108549-9341-1-git-send-email-anilkumar@ti.com>
 <1352108549-9341-3-git-send-email-anilkumar@ti.com>
 <B5906170F1614E41A8A28DE3B8D121433EC04226@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
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
To: "AnilKumar, Chimata" <anilkumar-l0cyMroinI0@public.gmane.org>, "Bedia, Vaibhav" <vaibhav.bedia-l0cyMroinI0@public.gmane.org>, "a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org" <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, "sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Colin Foe-Parker <colin.foeparker-L+YfUVVR8+RBDgjK7y7TUQ@public.gmane.org>, "rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 16, 2012 at 11:43:36, AnilKumar, Chimata wrote:
> On Mon, Nov 12, 2012 at 15:17:48, AnilKumar, Chimata wrote:
> > On Tue, Nov 06, 2012 at 11:15:34, Bedia, Vaibhav wrote:
> > > On Mon, Nov 05, 2012 at 15:12:27, AnilKumar, Chimata wrote:
> > > [...]
> > > >  
> > > > +#define SHUTDOWN_TIME_SEC		2
> > > > +#define SECS_IN_MIN			60
> > > > +#define WAIT_AFTER			(SECS_IN_MIN - SHUTDOWN_TIME_SEC)
> > > > +#define WAIT_TIME_MS			(SHUTDOWN_TIME_SEC * 1000)
> > > > +
> > > >  static void __iomem	*rtc_base;
> > > >  
> > > [...]
> > > > +
> > > > +	/* Wait few seconds instead of rollover */
> > > > +	do {
> > > > +		omap_rtc_read_time(NULL, &tm);
> > > > +		if (WAIT_AFTER <= tm.tm_sec)
> > > > +			mdelay(WAIT_TIME_MS);
> > > > +	} while (WAIT_AFTER <= tm.tm_sec);
> > > 
> > > This hardcoded wait for rollover doesn't look good. I see some
> > > helper functions in rtc-lib.c which probably could be used for
> > > converting the current time to elapsed seconds, add the delay and
> > > then convert it back to the time to be programmed in RTC without
> > > worrying about rollover. Why not use that?
> > 
> > I am not aware of those APIs, can you point some?
> 
> I have gone through rtc-lib.c, these are the API's I am seeing
> in the library
> 
> 1. rtc_time_to_tm: Convert seconds since 01-01-1970 00:00:00 to
> Gregorian date
> 2. rtc_tm_to_time: Convert Gregorian date to seconds since
> 01-01-1970 00:00:00
> 
> Steps I followed:-
> ================
> 1: unsigned long time;
> 2: omap_rtc_read_time(NULL, &tm);
> 3: rtc_tm_to_time(tm, &time);
> 4: pr_info("Time 1 %lu\n", time);
> 5: time += 2; /* (2sec) */
> 6: rtc_time_to_tm(time, tm);
> 7: rtc_tm_to_time(tm, &time); /* Only for printing time value */
> 8: pr_info("Time 2 %lu\n", time); 
> 
> With the above steps I am seeing completely two different time
> values at step4 and step8
> 

Nevermind it working now.

Thanks
AnilKumar
