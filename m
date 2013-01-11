From: "AnilKumar, Chimata" <anilkumar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v4 1/4] rtc: OMAP: Add system pm_power_off to rtc driver
Date: Fri, 11 Jan 2013 09:55:05 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EAE7CC4@DBDE01.ent.ti.com>
References: <1355464997-19367-1-git-send-email-anilkumar@ti.com>
 <1355464997-19367-2-git-send-email-anilkumar@ti.com>
 <CA+Bv8XbfkdhZKXtve4VF6uxZB9rw=wj5tda9OxmSByM9k7wa3w@mail.gmail.com>
 <CA+Bv8XaZzWindjhYnXLaqq5mJ6X0Hq=C7NUxW3aK3eh-d6ghtg@mail.gmail.com>
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
To: "AnilKumar, Chimata" <anilkumar-l0cyMroinI0@public.gmane.org>, Russ Dill <russ.dill-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org" <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Colin Foe-Parker <colin.foeparker-L+YfUVVR8+RBDgjK7y7TUQ@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Jan 11, 2013 at 15:00:03, AnilKumar, Chimata wrote:
> On Fri, Jan 11, 2013 at 14:24:46, Russ Dill wrote:
> > On Fri, Jan 11, 2013 at 12:08 AM, Russ Dill <russ.dill-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > > On Thu, Dec 13, 2012 at 10:03 PM, AnilKumar Ch <anilkumar-l0cyMroinI0@public.gmane.org> wrote:
> > >> From: Colin Foe-Parker <colin.foeparker-L+YfUVVR8+RBDgjK7y7TUQ@public.gmane.org>
> > >>
> > >> Add system power off control to rtc driver which is the in-charge
> > >> of controlling the BeagleBone system power. The power_off routine
> > >> can be hooked up to "pm_power_off" system call.
> > >>
> > >> System power off sequence:-
> > >> * Set PMIC STATUS_OFF when PMIC_POWER_EN is pulled low
> > >> * Enable PMIC_POWER_EN in rtc module
> > >> * Set rtc ALARM2 time
> > >> * Enable ALARM2 interrupt
> > >>
> > >> Signed-off-by: Colin Foe-Parker <colin.foeparker-L+YfUVVR8+RBDgjK7y7TUQ@public.gmane.org>
> > >> [anilkumar-l0cyMroinI0@public.gmane.org: move poweroff additions to rtc driver]
> > >> Signed-off-by: AnilKumar Ch <anilkumar-l0cyMroinI0@public.gmane.org>
> > >
> > > Looks good
> > >
> > > Reviewed-by: Russ Dill <russ.dill-l0cyMroinI0@public.gmane.org>
> > > Acked-by: Russ Dill <russ.dill-l0cyMroinI0@public.gmane.org>
> > 
> > Sorry, actually, small follow up. Is there any reason this uses
> > readl/writel in some places rather than rtc_read/rtc_write?
> 
> Hi Russ Dill,
> 
> Thanks for the review
> 
> At OMAP_RTC_PMIC_POWER_EN_EN, 32-bit value needs to modified so
> readl/writel are used. While enabling the INTERRUPTS we can change
> it to rtc_read/rtc_write but I am not seeing any advantage if we
> do that apart from consistency.
 
And driver has to clean-up properly to make use of rtc_read/write
APIs with proper read/write's based on the memory type. Ideally
rtc_readb/w/l and rtc_writeb/w/l should go way from the driver.
This clean-up can be done while converting the driver with platform
specific rtc_read/write.

Thanks
AnilKumar

> > >> ---
> > >>  Documentation/devicetree/bindings/rtc/rtc-omap.txt |    5 ++
> > >>  drivers/rtc/rtc-omap.c                             |   74 +++++++++++++++++++-
> > >>  2 files changed, 78 insertions(+), 1 deletion(-)
> > >>
> > >> diff --git a/Documentation/devicetree/bindings/rtc/rtc-omap.txt b/Documentation/devicetree/bindings/rtc/rtc-omap.txt
> > >> index b47aa41..8d9f4f9 100644
> > >> --- a/Documentation/devicetree/bindings/rtc/rtc-omap.txt
> > >> +++ b/Documentation/devicetree/bindings/rtc/rtc-omap.txt
> > >> @@ -6,6 +6,10 @@ Required properties:
> > >>  - interrupts: rtc timer, alarm interrupts in order
> > >>  - interrupt-parent: phandle for the interrupt controller
> > >>
> > >> +Optional properties:
> > >> +- ti,system-power-controller: Telling whether or not rtc is controlling
> > >> +  the system power.
> > >> +
> > >>  Example:
> > >>
> > >>  rtc@1c23000 {
> > >> @@ -14,4 +18,5 @@ rtc@1c23000 {
> > >>         interrupts = <19
> > >>                       19>;
> > >>         interrupt-parent = <&intc>;
> > >> +       ti,system-power-controller;
> > >>  };
> > >> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
> > >> index 6009714..e6d4878 100644
> > >> --- a/drivers/rtc/rtc-omap.c
> > >> +++ b/drivers/rtc/rtc-omap.c
> > >> @@ -72,6 +72,14 @@
> > >>  #define OMAP_RTC_KICK0_REG             0x6c
> > >>  #define OMAP_RTC_KICK1_REG             0x70
> > >>
> > >> +#define OMAP_RTC_ALARM2_SECONDS_REG    0x80
> > >> +#define OMAP_RTC_ALARM2_MINUTES_REG    0x84
> > >> +#define OMAP_RTC_ALARM2_HOURS_REG      0x88
> > >> +#define OMAP_RTC_ALARM2_DAYS_REG       0x8c
> > >> +#define OMAP_RTC_ALARM2_MONTHS_REG     0x90
> > >> +#define OMAP_RTC_ALARM2_YEARS_REG      0x94
> > >> +#define OMAP_RTC_PMIC_REG              0x98
> > >> +
> > >>  /* OMAP_RTC_CTRL_REG bit fields: */
> > >>  #define OMAP_RTC_CTRL_SPLIT            (1<<7)
> > >>  #define OMAP_RTC_CTRL_DISABLE          (1<<6)
> > >> @@ -93,15 +101,21 @@
> > >>  #define OMAP_RTC_STATUS_BUSY            (1<<0)
> > >>
> > >>  /* OMAP_RTC_INTERRUPTS_REG bit fields: */
> > >> +#define OMAP_RTC_INTERRUPTS_IT_ALARM2   (1<<4)
> > >>  #define OMAP_RTC_INTERRUPTS_IT_ALARM    (1<<3)
> > >>  #define OMAP_RTC_INTERRUPTS_IT_TIMER    (1<<2)
> > >>
> > >> +/* OMAP_RTC_PMIC_REG bit fields: */
> > >> +#define OMAP_RTC_PMIC_POWER_EN_EN       (1<<16)
> > >> +
> > >>  /* OMAP_RTC_KICKER values */
> > >>  #define        KICK0_VALUE                     0x83e70b13
> > >>  #define        KICK1_VALUE                     0x95a4f1e0
> > >>
> > >>  #define        OMAP_RTC_HAS_KICKER             0x1
> > >>
> > >> +#define SHUTDOWN_TIME_SEC              2
> > >> +
> > >>  static void __iomem    *rtc_base;
> > >>
> > >>  #define rtc_read(addr)         readb(rtc_base + (addr))
> > >> @@ -290,6 +304,56 @@ static int omap_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
> > >>         return 0;
> > >>  }
> > >>
> > >> +/*
> > >> + * rtc_power_off: Set the pmic power off sequence. The RTC generates
> > >> + * pmic_pwr_enable control, which can be used to control an external
> > >> + * PMIC.
> > >> + */
> > >> +static void rtc_power_off(void)
> > >> +{
> > >> +       u32 val;
> > >> +       struct rtc_time tm;
> > >> +       unsigned long time;
> > >> +
> > >> +       /* Set PMIC power enable */
> > >> +       val = readl(rtc_base + OMAP_RTC_PMIC_REG);
> > >> +       writel(val | OMAP_RTC_PMIC_POWER_EN_EN, rtc_base + OMAP_RTC_PMIC_REG);
> > >> +
> > >> +       /* Read rtc time */
> > >> +       omap_rtc_read_time(NULL, &tm);
> > >> +
> > >> +       /* Convert Gregorian date to seconds since 01-01-1970 00:00:00 */
> > >> +       rtc_tm_to_time(&tm, &time);
> > >> +
> > >> +       /* Add shutdown time to the current value */
> > >> +       time += SHUTDOWN_TIME_SEC;
> > >> +
> > >> +       /* Convert seconds since 01-01-1970 00:00:00 to Gregorian date */
> > >> +       rtc_time_to_tm(time, &tm);
> > >> +
> > >> +       if (tm2bcd(&tm) < 0)
> > >> +               return;
> > >> +
> > >> +       pr_info("System will go to power_off state in approx. %d secs\n",
> > >> +                       SHUTDOWN_TIME_SEC);
> > >> +
> > >> +       /*
> > >> +        * pmic_pwr_enable is controlled by means of ALARM2 event. So here
> > >> +        * programming alarm2 expiry time and enabling alarm2 interrupt
> > >> +        */
> > >> +       rtc_write(tm.tm_sec, OMAP_RTC_ALARM2_SECONDS_REG);
> > >> +       rtc_write(tm.tm_min, OMAP_RTC_ALARM2_MINUTES_REG);
> > >> +       rtc_write(tm.tm_hour, OMAP_RTC_ALARM2_HOURS_REG);
> > >> +       rtc_write(tm.tm_mday, OMAP_RTC_ALARM2_DAYS_REG);
> > >> +       rtc_write(tm.tm_mon, OMAP_RTC_ALARM2_MONTHS_REG);
> > >> +       rtc_write(tm.tm_year, OMAP_RTC_ALARM2_YEARS_REG);
> > >> +
> > >> +       /* Enable alarm2 interrupt */
> > >> +       val = readl(rtc_base + OMAP_RTC_INTERRUPTS_REG);
> > >> +       writel(val | OMAP_RTC_INTERRUPTS_IT_ALARM2,
> > >> +                               rtc_base + OMAP_RTC_INTERRUPTS_REG);
> > >> +}
> > >> +
> > >>  static struct rtc_class_ops omap_rtc_ops = {
> > >>         .read_time      = omap_rtc_read_time,
> > >>         .set_time       = omap_rtc_set_time,
> > >> @@ -327,12 +391,16 @@ static int __init omap_rtc_probe(struct platform_device *pdev)
> > >>         struct resource         *res, *mem;
> > >>         struct rtc_device       *rtc;
> > >>         u8                      reg, new_ctrl;
> > >> +       bool                    pm_off = false;
> > >>         const struct platform_device_id *id_entry;
> > >>         const struct of_device_id *of_id;
> > >>
> > >>         of_id = of_match_device(omap_rtc_of_match, &pdev->dev);
> > >> -       if (of_id)
> > >> +       if (of_id) {
> > >>                 pdev->id_entry = of_id->data;
> > >> +               pm_off = of_property_read_bool(pdev->dev.of_node,
> > >> +                                       "ti,system-power-controller");
> > >> +       }
> > >>
> > >>         omap_rtc_timer = platform_get_irq(pdev, 0);
> > >>         if (omap_rtc_timer <= 0) {
> > >> @@ -385,6 +453,10 @@ static int __init omap_rtc_probe(struct platform_device *pdev)
> > >>         platform_set_drvdata(pdev, rtc);
> > >>         dev_set_drvdata(&rtc->dev, mem);
> > >>
> > >> +       /* RTC power off */
> > >> +       if (pm_off && !pm_power_off)
> > >> +               pm_power_off = rtc_power_off;
> > >> +
> > >>         /* clear pending irqs, and set 1/second periodic,
> > >>          * which we'll use instead of update irqs
> > >>          */
> > >> --
> > >> 1.7.9.5
> > >>
> > >> --
> > >> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > >> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> 
