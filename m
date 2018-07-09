From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v2] rtc: OMAP: Add support for rtc-only mode
Date: Mon, 9 Jul 2018 11:29:52 +0200
Message-ID: <20180709092952.GF16084@piout.net>
References: <1531116709-20135-1-git-send-email-j-keerthy@ti.com>
 <20180709075553.GA3633@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180709075553.GA3633@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Keerthy <j-keerthy@ti.com>, a.zummo@towertech.it, t-kristo@ti.com, linux-rtc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 09/07/2018 09:55:53+0200, Johan Hovold wrote:
> On Mon, Jul 09, 2018 at 11:41:49AM +0530, Keerthy wrote:
> > Prepare rtc driver for rtc-only with DDR in self-refresh mode.
> > omap_rtc_power_off now should cater to two features:
> > 
> > 1) RTC plus DDR in self-refresh is power a saving mode where in the
> > entire system including the different voltage rails from PMIC are
> > shutdown except the ones feeding on to RTC and DDR. DDR is kept in
> > self-refresh hence the contents are preserved. RTC ALARM2 is connected
> > to PMIC_EN line once we the ALARM2 is triggered we enter the mode with
> > DDR in self-refresh and RTC Ticking. After a predetermined time an RTC
> > ALARM1 triggers waking up the system[1]. The control goes to bootloader.
> > The bootloader then checks RTC scratchpad registers to confirm it was an
> > rtc_only wakeup and follows a different path, configure bare minimal
> > clocks for ddr and then jumps to the resume address in another RTC
> > scratchpad registers and transfers the control to Kernel. Kernel then
> > restores the saved context. omap_rtc_power_off_program does the ALARM2
> > programming part.
> > 
> >      [1] http://www.ti.com/lit/ug/spruhl7h/spruhl7h.pdf Page 2884
> > 
> > 2) Power-off: This is usual poweroff mode. omap_rtc_power_off calls the
> > above omap_rtc_power_off_program function and in addition to that
> > programs the OMAP_RTC_PMIC_REG for any external wake ups for PMIC like
> > the pushbutton and shuts off the PMIC.
> > 
> > Hence the split in omap_rtc_power_off.
> > 
> > Signed-off-by: Keerthy <j-keerthy@ti.com>
> > ---
> > 
> > Changes in v2:
> > 
> >   * Add details in the commit log.
> >   * Use of_device_is_system_power_controller to check if rtc node is
> >     indeed the system power control instead of manually reading property.
> > 
> >  drivers/rtc/interface.c |  12 ++++
> >  drivers/rtc/rtc-omap.c  | 167 +++++++++++++++++++++++++++++++++---------------
> >  include/linux/rtc.h     |   2 +
> >  3 files changed, 131 insertions(+), 50 deletions(-)
> > 
> > diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
> > index 6d4012d..d8b70f0 100644
> > --- a/drivers/rtc/interface.c
> > +++ b/drivers/rtc/interface.c
> > @@ -1139,3 +1139,15 @@ int rtc_set_offset(struct rtc_device *rtc, long offset)
> >  	trace_rtc_set_offset(offset, ret);
> >  	return ret;
> >  }
> > +
> > +/**
> > + * rtc_power_off_program - Some of the rtc are hooked on to PMIC_EN
> > + * line and can be used to power off the SoC.
> > + *
> > + * Kernel interface to program rtc to power off
> > + */
> > +void rtc_power_off_program(struct rtc_device *rtc)
> > +{
> > +	rtc->ops->power_off_program(rtc->dev.parent);
> > +}
> > +EXPORT_SYMBOL_GPL(rtc_power_off_program);
> 
> We typically do not add new interfaces without any users, so this will
> probably have to go in along with the corresponding omap changes for
> rtc-only mode.
> 

I'm probably not smart enough but I still don't get why you need to add
an interface at all, especially one that will result in a NULL pointer
dereference on 99.6% of the drivers.

This is so specific to your use case that this has zero chance to be
reused by another driver.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
