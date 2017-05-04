From: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] RTC: Add functionality to read/write rtc
 scratch registers
Date: Fri, 5 May 2017 00:38:27 +0200
Message-ID: <20170504223827.l56sbaozuarq5xwi@piout.net>
References: <1492492807-20316-1-git-send-email-j-keerthy@ti.com>
 <8b28ca13-9822-4172-95b0-59802187ec93@ti.com>
Reply-To: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <rtc-linux+bncBCKYNX7Y3IMBB362V3EAKGQEDP6EIMQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <8b28ca13-9822-4172-95b0-59802187ec93-l0cyMroinI0@public.gmane.org>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/rtc-linux/subscribe>
To: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Cc: a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russ Dill <Russ.Dill-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On 03/05/2017 at 11:39:34 +0530, Keerthy wrote:
> On Tuesday 18 April 2017 10:50 AM, Keerthy wrote:
> > From: Russ Dill <Russ.Dill-l0cyMroinI0@public.gmane.org>
> > 
> > Many RTCs provide scratch registers that are maintained so long as the RTC
> > has power. Provide a generic method to access these registers.
> > 
> 
> A gentle ping on this
> 

Yeah, I apologize for the delay (I know you already sent this 6-8 months
ago).
I'm not satisfied with the interface (and its name). I gave a lot of
thought into it and I'm currently reworking part of the subsystem to
create a similar feature. I'm planning to have it in 4.13.

> > Signed-off-by: Russ Dill <Russ.Dill-l0cyMroinI0@public.gmane.org>
> > Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
> > ---
> >  drivers/rtc/interface.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  drivers/rtc/rtc-omap.c  | 35 ++++++++++++++++++++++++++++++++++
> >  include/linux/rtc.h     |  7 +++++++
> >  3 files changed, 92 insertions(+)
> > 
> > diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
> > index fc0fa75..facde06 100644
> > --- a/drivers/rtc/interface.c
> > +++ b/drivers/rtc/interface.c
> > @@ -1016,3 +1016,53 @@ int rtc_set_offset(struct rtc_device *rtc, long offset)
> >  	mutex_unlock(&rtc->ops_lock);
> >  	return ret;
> >  }
> > +
> > +/* rtc_read_scratch - Read from RTC scratch register
> > + * @ rtc: rtc device to be used
> > + * @ index: index of scratch register
> > + * @ value: returned value read
> > + *
> > + * Kernel interface read from an RTC scratch register
> > + */
> > +int rtc_read_scratch(struct rtc_device *rtc, unsigned int index, u32 *value)
> > +{
> > +	int err;
> > +
> > +	mutex_lock(&rtc->ops_lock);
> > +	if (!rtc->ops)
> > +		err = -ENODEV;
> > +	else if (index >= rtc->ops->scratch_size || !rtc->ops->read_scratch)
> > +		err = -EINVAL;
> > +	else
> > +		err = rtc->ops->read_scratch(rtc->dev.parent, index, value);
> > +	mutex_unlock(&rtc->ops_lock);
> > +	return err;
> > +}
> > +EXPORT_SYMBOL_GPL(rtc_read_scratch);
> > +
> > +/* rtc_write_scratch - Write to RTC scratch register
> > + * @ rtc: rtc device to be used
> > + * @ index: index of scratch register
> > + * @ value: value to write
> > + *
> > + * Kernel interface write to an RTC scratch register
> > + */
> > +int rtc_write_scratch(struct rtc_device *rtc, unsigned int index, u32 value)
> > +{
> > +	int err;
> > +
> > +	mutex_lock(&rtc->ops_lock);
> > +
> > +	if (!rtc->ops)
> > +		err = -ENODEV;
> > +	else if (index >= rtc->ops->scratch_size ||
> > +		 !rtc->ops->write_scratch)
> > +		err = -EINVAL;
> > +	else
> > +		err = rtc->ops->write_scratch(rtc->dev.parent, index, value);
> > +
> > +	mutex_unlock(&rtc->ops_lock);
> > +
> > +	return err;
> > +}
> > +EXPORT_SYMBOL_GPL(rtc_write_scratch);
> > diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
> > index 13f7cd1..c90d93e 100644
> > --- a/drivers/rtc/rtc-omap.c
> > +++ b/drivers/rtc/rtc-omap.c
> > @@ -70,6 +70,10 @@
> >  #define OMAP_RTC_COMP_MSB_REG		0x50
> >  #define OMAP_RTC_OSC_REG		0x54
> >  
> > +#define OMAP_RTC_SCRATCH0_REG		0x60
> > +#define OMAP_RTC_SCRATCH1_REG		0x64
> > +#define OMAP_RTC_SCRATCH2_REG		0x68
> > +
> >  #define OMAP_RTC_KICK0_REG		0x6c
> >  #define OMAP_RTC_KICK1_REG		0x70
> >  
> > @@ -414,6 +418,34 @@ static int omap_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
> >  
> >  static struct omap_rtc *omap_rtc_power_off_rtc;
> >  
> > +static const u32 omap_rtc_scratch_regs[] = {
> > +	OMAP_RTC_SCRATCH0_REG,
> > +	OMAP_RTC_SCRATCH1_REG,
> > +	OMAP_RTC_SCRATCH2_REG,
> > +};
> > +
> > +static int omap_rtc_read_scratch(struct device *dev, unsigned int index,
> > +				 u32 *value)
> > +{
> > +	*value = readl(omap_rtc_power_off_rtc->base +
> > +		       omap_rtc_scratch_regs[index]);
> > +
> > +	return 0;
> > +}
> > +
> > +static int omap_rtc_write_scratch(struct device *dev, unsigned int index,
> > +				  u32 value)
> > +{
> > +	struct omap_rtc *rtc = dev_get_drvdata(dev);
> > +
> > +	rtc->type->unlock(rtc);
> > +	writel(value, omap_rtc_power_off_rtc->base +
> > +	       omap_rtc_scratch_regs[index]);
> > +	rtc->type->lock(rtc);
> > +
> > +	return 0;
> > +}
> > +
> >  /*
> >   * omap_rtc_poweroff: RTC-controlled power off
> >   *
> > @@ -484,6 +516,9 @@ static void omap_rtc_power_off(void)
> >  	.read_alarm	= omap_rtc_read_alarm,
> >  	.set_alarm	= omap_rtc_set_alarm,
> >  	.alarm_irq_enable = omap_rtc_alarm_irq_enable,
> > +	.read_scratch	= omap_rtc_read_scratch,
> > +	.write_scratch	= omap_rtc_write_scratch,
> > +	.scratch_size	= ARRAY_SIZE(omap_rtc_scratch_regs),
> >  };
> >  
> >  static const struct omap_rtc_device_type omap_rtc_default_type = {
> > diff --git a/include/linux/rtc.h b/include/linux/rtc.h
> > index b693ada..da5e003 100644
> > --- a/include/linux/rtc.h
> > +++ b/include/linux/rtc.h
> > @@ -91,6 +91,10 @@ struct rtc_class_ops {
> >  	int (*alarm_irq_enable)(struct device *, unsigned int enabled);
> >  	int (*read_offset)(struct device *, long *offset);
> >  	int (*set_offset)(struct device *, long offset);
> > +	int (*read_scratch)(struct device *, unsigned int, u32*);
> > +	int (*write_scratch)(struct device *, unsigned int, u32);
> > +
> > +	unsigned int scratch_size;
> >  };
> >  
> >  #define RTC_DEVICE_NAME_SIZE 20
> > @@ -214,6 +218,9 @@ int rtc_timer_start(struct rtc_device *rtc, struct rtc_timer *timer,
> >  int rtc_set_offset(struct rtc_device *rtc, long offset);
> >  void rtc_timer_do_work(struct work_struct *work);
> >  
> > +int rtc_read_scratch(struct rtc_device *rtc, unsigned int index, u32 *value);
> > +int rtc_write_scratch(struct rtc_device *rtc, unsigned int index, u32 value);
> > +
> >  static inline bool is_leap_year(unsigned int year)
> >  {
> >  	return (!(year % 4) && (year % 100)) || !(year % 400);
> > 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
