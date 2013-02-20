From: anish kumar <anish198519851985@gmail.com>
Subject: Re: test jiffies on ARM SMP board
Date: Wed, 20 Feb 2013 22:54:41 +0530
Message-ID: <1361381081.16206.45.camel@anish-Inspiron-N5050>
References: <BLU002-W18453B5FE6CB5CDDA18C8DBCF60@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-da0-f41.google.com ([209.85.210.41]:40335 "EHLO
	mail-da0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758949Ab3BTRY5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Feb 2013 12:24:57 -0500
Received: by mail-da0-f41.google.com with SMTP id e20so3635910dak.14
        for <linux-omap@vger.kernel.org>; Wed, 20 Feb 2013 09:24:56 -0800 (PST)
In-Reply-To: <BLU002-W18453B5FE6CB5CDDA18C8DBCF60@phx.gbl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: buyitian <buyit@live.cn>
Cc: "kernelnewbies@kernelnewbies.org" <kernelnewbies@kernelnewbies.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk

On Thu, 2013-02-21 at 00:39 +0800, buyitian wrote:
> i am confused about my test. in one device driver, 
> i put below code:
> 
>     printk("start to test test jiffies\n");
> 
>     local_irq_save(flags);
> 
>     jf1 = jiffies; // read jiffies first time
> 
>     // hold cpu for about 2 seconds(do some calculation)
> 
>     jf2 = jiffies; // read jiffies after 2 seconds
> 
>     local_irq_restore(flags);
> 
>     printk("jf1:%lu, jf2:%lu\n", jf1, jf2);
> 
> and the output is as below:
> 
>     <4>[  108.551124]start to test test jiffies
>     <4>[  110.367604]jf1:4294948151, jf2:4294948151
> 
> the jf1 and jf2 are the same value, although they are
> read between 2 seconds interval, i think this is because
> i disabled local interrupt.
> but the printk timestamp is from 108.551124 to 110.367604,
> which is about 2 seconds. and on my platform, printk timestamp
> is got from the function read_sched_clock:
>    static u32 __read_mostly (*read_sched_clock)(void) = jiffy_sched_clock_read;
> 
> and function jiffy_sched_clock_read() is to read from jiffies.
> 
> it seems that the jiffies is frozen when local irq is disabled,
> but after local_irq_restore(), the jiffies not only start
> to run, but also recover the lost 2 seconds.
> 
> is the jiffies updated from another cpu when irq is disabled on
> local cpu? 
> 
> is there some internel processor interrupt between cpu1 and cpu0
> after local irq is re-enabled so that jiffies recover the lost 2 seconds? 		 	   		  
I think it is because of the fact that some RTC registers keep the
elapsed time and when the irq is re-enabled the kernel reads these
registers to be in sync with time.
However I am not that sure which registers as I think that depends on
the RTC chip and chip changes based on different boards.
I hope some expert on these matters can pitch in here.
> _______________________________________________
> Kernelnewbies mailing list
> Kernelnewbies@kernelnewbies.org
> http://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies


