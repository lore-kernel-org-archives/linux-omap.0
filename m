From: Ravikumar <a0131654@ti.com>
Subject: Re: [RFC 1/1] drivers: i2c: omap: Add slave support
Date: Fri, 14 Oct 2016 13:26:40 +0530
Message-ID: <1731bbba-4dc6-745e-fcd2-1a91d6c20dd9@ti.com>
References: <20160525141119.14486-1-rk@ti.com>
 <20160525141119.14486-2-rk@ti.com> <20160825171430.GM2856@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <20160825171430.GM2856@katana>
Sender: linux-i2c-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Ravikumar Kattekola <rk@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


On Thursday 25 August 2016 10:44 PM, Wolfram Sang wrote:
> Hi,
>
>> The omap i2c controller (at least on dra7x devices)
>> doesn't have  start/stop (STT/STP) support for slave mode
>> so event  #5 is not implemented in the driver.
> I think you can deduce that. If a new {READ|WRITE}_REQUESTED slave event
> comes in when you had *_PROCESSED events before, there must have been a
> STOP on the bus inbetween.
I've found that the Bus free interrupt can be used for STOP condition in 
slave mode.
So this shouldn't be a problem anymore.
>
>> +		if (stat & OMAP_I2C_STAT_XRDY) {
>> +			i2c_slave_event(omap->slave, I2C_SLAVE_READ_REQUESTED,
>> +					&value);
>> +			omap_i2c_write_reg(omap, OMAP_I2C_DATA_REG, value);
>> +			i2c_slave_event(omap->slave, I2C_SLAVE_READ_PROCESSED,
>> +					&value);
> This looks fishy. READ_REQUESTED is only sent after the address phase.
> Have you read the documentation (Documentation/i2c/slave-interface)?
> Please say if it was unclear.
Will fix this.
>> +	/* As of now, We dont need all interrupts be enabled */
>> +	omap->iestate = OMAP_I2C_IE_AAS | OMAP_I2C_IE_XRDY | OMAP_I2C_IE_RRDY;
> This looks even more fishy. Are you disabling the master interrupts?
> That's a no (unless there are HW constraints). Your driver should be
> able to switch between master and slave depending on what happens on the
> bus.
Dynamic switching on OMAP I2C IP could be a  difficult task.
There is no separate status register for master mode vs slave mode, it's 
a common register.
Even the interrupt status bits are reused.

So i cant do a check on status like if(!MSR) slave_irq_handler();

I think instead of status I may need to check the MST(1:master mode, 
0:slave mode] bit in I2C_CON
to take a decision on whether to call slave irq_handler or not.
> For more guidance, here is my talk at ELCE 2015:
> https://www.youtube.com/watch?v=JdQ21jlwb58
Thanks for sharing the video.
>
> Regards,
>
>     Wolfram
>

Regards,
RK
