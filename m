From: <kalle.jokiniemi@nokia.com>
Subject: RE: [PATCH V4 3/3] OMAP: I2C: Add mpu wake up latency constraint	in
 i2c
Date: Fri, 20 Nov 2009 09:35:20 +0100
Message-ID: <E839BB5467CE1640B3CC2F90F647A52C274A01DB80@NOK-EUMSG-02.mgdnok.nokia.com>
References: <> <1256125881-12441-1-git-send-email-kalle.jokiniemi@digia.com>
	 <1256125881-12441-2-git-send-email-kalle.jokiniemi@digia.com>
	 <1256125881-12441-3-git-send-email-kalle.jokiniemi@digia.com>
	 <1256125881-12441-4-git-send-email-kalle.jokiniemi@digia.com>
	 <CD8CC2B65FEE304DA95744A5472698F2029E427B04@dlee06.ent.ti.com>
 <1256806523.31764.57.camel@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:48887 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752485AbZKTIfr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Nov 2009 03:35:47 -0500
In-Reply-To: <1256806523.31764.57.camel@ubuntu>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, m-sonasath@ti.com, jouni.hogander@nokia.com

Kevin,

Could you please take this patch in? Currently i2c is not working very well with cpuidle and off mode, and the patch is needed.

I would go with V4 of the patch.

- Kalle

>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org 
>[mailto:linux-omap-owner@vger.kernel.org] On Behalf Of ext 
>Kalle Jokiniemi
>Sent: 29. lokakuuta 2009 10:55
>To: Sonasath, Moiz
>Cc: khilman@deeprootsystems.com; linux-omap@vger.kernel.org
>Subject: RE: [PATCH V4 3/3] OMAP: I2C: Add mpu wake up latency 
>constraint in i2c
>
>OK, let's try this once more, since my mail did not seem to go 
>to linux-omap.
>
>Sorry for the spam.
>
>See my comments below:
>
>On Fri, 2009-10-23 at 18:53 +0300, Sonasath, Moiz wrote:
>> Hello Jokiniemi!
>> 
>> > -----Original Message-----
>> > From: Kalle Jokiniemi [mailto:kalle.jokiniemi@digia.com]
>> > Sent: Wednesday, October 21, 2009 6:51 AM
>> > To: khilman@deeprootsystems.com
>> > Cc: linux-omap@vger.kernel.org; Kalle Jokiniemi; Sonasath, Moiz;
>> Jarkko
>> > Nikula; Paul Walmsley; Menon, Nishanth
>> > Subject: [PATCH V4 3/3] OMAP: I2C: Add mpu wake up latency
>> constraint in
>> > i2c
>> > 
>> > While waiting for completion of the i2c transfer, the MPU 
>could hit 
>> > OFF mode and cause several msecs of delay that made i2c transfers 
>> > fail more often. The extra delays and subsequent re-trys cause i2c 
>> > clocks to be active more often. This has also an negative 
>effect on 
>> > power consumption.
>> > 
>> > Created a mechanism for passing and using the constraint setting 
>> > function in driver code. The used mpu wake up latency constraints 
>> > are now set individually per bus, and they are calculated based on 
>> > clock rate and fifo size.
>> > 
>> > Thanks to Jarkko Nikula, Moiz Sonasath, Paul Walmsley, and 
>Nishanth 
>> > Menon for tuning out the details of this patch.
>> > 
>> > Cc: Moiz Sonasath <m-sonasath@ti.com>
>> > Cc: Jarkko Nikula <jhnikula@gmail.com>
>> > Cc: Paul Walmsley <paul@pwsan.com>
>> > Cc: Nishanth Menon <nm@ti.com>
>> > Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
>> > ---
>> > 
>> 
>> 
>> >  	dev->speed = speed;
>> >  	dev->idle = 1;
>> > @@ -911,6 +923,11 @@ omap_i2c_probe(struct platform_device *pdev)
>> >  		 */
>> >  		dev->fifo_size = (dev->fifo_size / 2);
>> >  		dev->b_hw = 1; /* Enable hardware fixes */
>> > +
>> > +		/* calculate wakeup latency constraint for MPU */
>> > +		if (dev->set_mpu_wkup_lat != NULL)
>> > +			dev->latency = (1000000 * dev->fifo_size) /
>> > +				       (1000 * speed / 8);
>> >  	}
>> 
>> IMHO, here instead of using 'dev->fifo_size' for calculating the 
>> 'dev->latency', we need to use:
>> 
>> 1. For RX case, to avoid Reciver overrun:
>> 	if (msg->flags & I2C_M_RD)
>> 		Use [(FIFO Depth)bytes - (FIFO THRSH)bytes] in 
>calculating 
>> 		dev->latency
>> 
>> Because conceptually, RDR/RRDY interrupts are generated when 
>RTRSH is 
>> reached, so we want the MPU to be wake up within the time it 
>takes to 
>> fill the FIFO from RTRSH to FIFO Depth (FIFO full).
>> 
>> 2. For TX case, to avoid Transmitter Underflow:
>> 	if (!(msg->flags & I2C_M_RD))
>> 		Use (FIFO THRSH)bytes in calculating dev->latency
>> 
>> Because conceptually, XDR/XRDY interrupts are generated when 
>XTRSH is 
>> reached, so we want the MPU to be wake up within the time it 
>takes to 
>> drain the FIFO from XTRSH to Zero (FIFO empty).
>> 
>> Using, dev->fifo_size instead, works in the present code because we 
>> have a RTRSH/XTRSH = dev->fifo_size/2 = 4 bytes And therefore, (FIFO 
>> Depth)bytes - (FIFO THRSH)bytes = 8 - 4 = 4 bytes
>> 
>> But, to make it more generic in future and to make it independent of 
>> any changes in the RTRSH/XTRSH values or FIFO depths in future, we 
>> should use a generic code here.
>
>Well, I don't completely agree with the necessity of preparing 
>for different rx/tx thresholds. For this to make sense, the 
>i2c-omap driver should first separate in it's code the use of 
>rx and tx thresholds. If someone is planning to do that, 
>he/she should anyway update the usage of fifo_size throughout 
>the code, including the wake up latency setting.
>
>Anyways, attached a patch that separates the mpu wake up 
>latencies for rx and tx. In case that is needed. Though I'm 
>not for it, since it adds unneeded complexity.
>
>- Kalle
>
>> 
>> > 
>> >  	/* reset ASAP, clearing any IRQs */ diff --git 
>> > a/include/linux/i2c-omap.h b/include/linux/i2c-omap.h new 
>file mode 
>> > 100644 index 0000000..1362fba
>> > --- /dev/null
>> > +++ b/include/linux/i2c-omap.h
>> > @@ -0,0 +1,9 @@
>> > +#ifndef __I2C_OMAP_H__
>> > +#define __I2C_OMAP_H__
>> > +
>> > +struct omap_i2c_bus_platform_data {
>> > +	u32		clkrate;
>> > +	void		(*set_mpu_wkup_lat)(struct device *dev, 
>int set);
>> > +};
>> > +
>> > +#endif
>> > --
>> > 1.5.4.3
>> 
>> Regards
>> Moiz Sonasath
>> 
>