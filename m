From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v4 1/4] rtc: omap: Cut down the shutdown time from 2
 seconds to 1 sec
Date: Thu, 19 Jul 2018 14:36:17 +0200
Message-ID: <20180719123617.GV10204@localhost>
References: <1531372060-10532-1-git-send-email-j-keerthy@ti.com>
 <1531372060-10532-2-git-send-email-j-keerthy@ti.com>
 <20180719100229.GQ10204@localhost>
 <ed335c7a-f079-082d-d572-93632087fd8f@ti.com>
 <a6930aca-f475-5b53-ce9d-d45fbc75d69c@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a6930aca-f475-5b53-ce9d-d45fbc75d69c@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: Johan Hovold <johan@kernel.org>, a.zummo@towertech.it, alexandre.belloni@bootlin.com, t-kristo@ti.com, linux-rtc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Jul 19, 2018 at 05:52:17PM +0530, Keerthy wrote:
> On Thursday 19 July 2018 05:23 PM, Keerthy wrote:
> > On Thursday 19 July 2018 03:32 PM, Johan Hovold wrote:
> >> On Thu, Jul 12, 2018 at 10:37:37AM +0530, Keerthy wrote:

> >>> @@ -470,6 +476,9 @@ static void omap_rtc_power_off(void)
> >>>  	val = rtc_read(rtc, OMAP_RTC_INTERRUPTS_REG);
> >>>  	rtc_writel(rtc, OMAP_RTC_INTERRUPTS_REG,
> >>>  			val | OMAP_RTC_INTERRUPTS_IT_ALARM2);

> >>> +	/* Our calculations started right before the rollover, try again */

> >>> +	if (seconds != rtc_read(omap_rtc_power_off_rtc, OMAP_RTC_SECONDS_REG))
> >>> +		goto again;
> >>
> >> Here the alarm may have gone off as part of the roll over, in which case
> >> you shouldn't retry.
> > 
> > Ex: We programmed at Sec = 2 and we expect ALARM2 to fire at sec = 3.
> > 
> > In the event of Roll over before setting the
> > OMAP_RTC_INTERRUPTS_IT_ALARM2 bit in the OMAP_RTC_INTERRUPTS_REG will we
> > not miss the ALARM2 event? Then poweroff would fail right?

Right, that would fail.

> > Hence the attempt to retry the next second. This sequence would begin
> > right at the beginning of a new second and we expect the full sequence
> > to get over without having to retry again.
> > 
> > Hope i am clear.

Yes, sure, but my point is that could end up retrying also after the
alarm has fired correctly (e.g. due to latencies in turning of the
power).

It may be enough to check OMAP_RTC_STATUS_REG before retrying.

> I tried to program the interrupt for the same second on the hardware and
> it does not fire. So to take care of roll over corner case one attempt
> to retry is needed.

Yes, that's expected.

Thanks,
Johan
