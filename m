From: bill4carson <bill4carson@gmail.com>
Subject: Re: test jiffies on ARM SMP board
Date: Mon, 25 Feb 2013 15:04:32 +0800
Message-ID: <512B0D00.3000403@gmail.com>
References: <BLU002-W18453B5FE6CB5CDDA18C8DBCF60@phx.gbl> <1361381081.16206.45.camel@anish-Inspiron-N5050> <20130220173014.GY17852@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-da0-f42.google.com ([209.85.210.42]:56859 "EHLO
	mail-da0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753687Ab3BYHDx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Feb 2013 02:03:53 -0500
Received: by mail-da0-f42.google.com with SMTP id z17so1330104dal.29
        for <linux-omap@vger.kernel.org>; Sun, 24 Feb 2013 23:03:53 -0800 (PST)
In-Reply-To: <20130220173014.GY17852@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: anish kumar <anish198519851985@gmail.com>, linux-omap@vger.kernel.org, buyitian <buyit@live.cn>, linux-arm-kernel@lists.infradead.org, "kernelnewbies@kernelnewbies.org" <kernelnewbies@kernelnewbies.org>



On 2013=E5=B9=B402=E6=9C=8821=E6=97=A5 01:30, Russell King - ARM Linux =
wrote:
> On Wed, Feb 20, 2013 at 10:54:41PM +0530, anish kumar wrote:
>> On Thu, 2013-02-21 at 00:39 +0800, buyitian wrote:
>>> i am confused about my test. in one device driver,
>>> i put below code:
>>>
>>>      printk("start to test test jiffies\n");
>>>
>>>      local_irq_save(flags);
>>>
>>>      jf1 =3D jiffies; // read jiffies first time
>>>
>>>      // hold cpu for about 2 seconds(do some calculation)
>>>
>>>      jf2 =3D jiffies; // read jiffies after 2 seconds
>>>
>>>      local_irq_restore(flags);
>>>
>>>      printk("jf1:%lu, jf2:%lu\n", jf1, jf2);
>>>
>>> and the output is as below:
>>>
>>>      <4>[  108.551124]start to test test jiffies
>>>      <4>[  110.367604]jf1:4294948151, jf2:4294948151
>>>
>>> the jf1 and jf2 are the same value, although they are
>>> read between 2 seconds interval, i think this is because
>>> i disabled local interrupt.
>>> but the printk timestamp is from 108.551124 to 110.367604,
>>> which is about 2 seconds. and on my platform, printk timestamp
>>> is got from the function read_sched_clock:
>>>     static u32 __read_mostly (*read_sched_clock)(void) =3D jiffy_sc=
hed_clock_read;
>>>
>>> and function jiffy_sched_clock_read() is to read from jiffies.
>>>
>>> it seems that the jiffies is frozen when local irq is disabled,
>>> but after local_irq_restore(), the jiffies not only start
>>> to run, but also recover the lost 2 seconds.
>>>
>>> is the jiffies updated from another cpu when irq is disabled on
>>> local cpu?
>>>
>>> is there some internel processor interrupt between cpu1 and cpu0
>>> after local irq is re-enabled so that jiffies recover the lost 2 se=
conds? 		 	   	=09
>> I think it is because of the fact that some RTC registers keep the
>
> The RTC has nothing to do with this.
>
> As soon as the IRQs are allowed again (immediately after the
> local_irq_restore()) the pending interrupt - including the timer
> interrupt will be processed.
>
> At this point, because we read the clocksource, we can see that two
> seconds have passed, and so we advance jiffies by the elapsed time.

  80 /*
  81  * Event handler for periodic ticks
  82  */
  83 void tick_handle_periodic(struct clock_event_device *dev)
  84 {
  85     int cpu =3D smp_processor_id();
  86     ktime_t next;
  87
  88     tick_periodic(cpu);
  89
  90     if (dev->mode !=3D CLOCK_EVT_MODE_ONESHOT)
  91         return;
  92     /*
  93      * Setup the next period for devices, which do not have
  94      * periodic mode:
  95      */
  96     next =3D ktime_add(dev->next_event, tick_period);
  97     for (;;) {
  98         if (!clockevents_program_event(dev, next, ktime_get()))   =
<--- once irq enabled, here we got -ETIME, then
  99             return;
100         /*
101          * Have to be careful here. If we're in oneshot mode,
102          * before we call tick_periodic() in a loop, we need
103          * to be sure we're using a real hardware clocksource.
104          * Otherwise we could get trapped in an infinite
105          * loop, as the tick_periodic() increments jiffies,
106          * when then will increment time, posibly causing
107          * the loop to trigger again and again.
108          */
109         if (timekeeping_valid_for_hres())
110             tick_periodic(cpu);                                  <-=
--- here, we add missing jiffies
111         next =3D ktime_add(next, tick_period);
112     }
113 }


>
> This means printk() sees that the two seconds have passed.  But becau=
se
> you're reading from jiffies within the interrupt disabled region, tha=
t
> code can't see the missed ticks.
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

--=20
=E5=85=AB=E7=99=BE=E9=87=8C=E7=A7=A6=E5=B7=9D=E5=B0=98=E5=9C=9F=E9=A3=9E=
=E6=89=AC,=E4=B8=89=E5=8D=83=E4=B8=87=E8=80=81=E9=99=95=E9=BD=90=E5=90=BC=
=E7=A7=A6=E8=85=94=E3=80=82

--bill
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
