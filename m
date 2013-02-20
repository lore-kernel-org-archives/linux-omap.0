From: anish kumar <anish198519851985@gmail.com>
Subject: Re: test jiffies on ARM SMP board
Date: Wed, 20 Feb 2013 23:35:11 +0530
Message-ID: <1361383511.16206.50.camel@anish-Inspiron-N5050>
References: <BLU002-W18453B5FE6CB5CDDA18C8DBCF60@phx.gbl>
	 <1361381081.16206.45.camel@anish-Inspiron-N5050>
	 <20130220173014.GY17852@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:62189 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933815Ab3BTSFb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Feb 2013 13:05:31 -0500
Received: by mail-pb0-f42.google.com with SMTP id xb4so3024409pbc.29
        for <linux-omap@vger.kernel.org>; Wed, 20 Feb 2013 10:05:31 -0800 (PST)
In-Reply-To: <20130220173014.GY17852@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: buyitian <buyit@live.cn>, "kernelnewbies@kernelnewbies.org" <kernelnewbies@kernelnewbies.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, 2013-02-20 at 17:30 +0000, Russell King - ARM Linux wrote:
> On Wed, Feb 20, 2013 at 10:54:41PM +0530, anish kumar wrote:
> > On Thu, 2013-02-21 at 00:39 +0800, buyitian wrote:
> > > i am confused about my test. in one device driver, 
> > > i put below code:
> > > 
> > >     printk("start to test test jiffies\n");
> > > 
> > >     local_irq_save(flags);
> > > 
> > >     jf1 = jiffies; // read jiffies first time
> > > 
> > >     // hold cpu for about 2 seconds(do some calculation)
> > > 
> > >     jf2 = jiffies; // read jiffies after 2 seconds
> > > 
> > >     local_irq_restore(flags);
> > > 
> > >     printk("jf1:%lu, jf2:%lu\n", jf1, jf2);
> > > 
> > > and the output is as below:
> > > 
> > >     <4>[  108.551124]start to test test jiffies
> > >     <4>[  110.367604]jf1:4294948151, jf2:4294948151
> > > 
> > > the jf1 and jf2 are the same value, although they are
> > > read between 2 seconds interval, i think this is because
> > > i disabled local interrupt.
> > > but the printk timestamp is from 108.551124 to 110.367604,
> > > which is about 2 seconds. and on my platform, printk timestamp
> > > is got from the function read_sched_clock:
> > >    static u32 __read_mostly (*read_sched_clock)(void) = jiffy_sched_clock_read;
> > > 
> > > and function jiffy_sched_clock_read() is to read from jiffies.
> > > 
> > > it seems that the jiffies is frozen when local irq is disabled,
> > > but after local_irq_restore(), the jiffies not only start
> > > to run, but also recover the lost 2 seconds.
> > > 
> > > is the jiffies updated from another cpu when irq is disabled on
> > > local cpu? 
> > > 
> > > is there some internel processor interrupt between cpu1 and cpu0
> > > after local irq is re-enabled so that jiffies recover the lost 2 seconds? 		 	   		  
> > I think it is because of the fact that some RTC registers keep the
> 
> The RTC has nothing to do with this.
> 
> As soon as the IRQs are allowed again (immediately after the
> local_irq_restore()) the pending interrupt - including the timer
> interrupt will be processed.
> 
> At this point, because we read the clocksource, we can see that two
> seconds have passed, and so we advance jiffies by the elapsed time.
So I understand there is some register which stores the elapsed time and
in my understanding it was RTC register which is wrong as suggested by
you.I suppose some timer register is used for this information on the
SOC.
> 
> This means printk() sees that the two seconds have passed.  But because
> you're reading from jiffies within the interrupt disabled region, that
> code can't see the missed ticks.


