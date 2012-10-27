From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] i2c: omap: ensure writes to dev->buf_len are ordered
Date: Sat, 27 Oct 2012 16:20:01 +0530
Message-ID: <508BBC59.60504@ti.com>
References: <1351155648-20429-1-git-send-email-balbi@ti.com> <alpine.DEB.2.00.1210262251020.11258@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60284 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751736Ab2J0Kuc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 27 Oct 2012 06:50:32 -0400
In-Reply-To: <alpine.DEB.2.00.1210262251020.11258@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, w.sang@pengutronix.de, linux-i2c@vger.kernel.org, ben-linux@fluff.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

On Saturday 27 October 2012 04:31 AM, Paul Walmsley wrote:
> Hi Felipe
>
> just two quick comments
>
> On Thu, 25 Oct 2012, Felipe Balbi wrote:
>
>> if we allow compiler reorder our writes, we could
>> fall into a situation where dev->buf_len is reset
>> for no apparent reason.
>>
>> This bug was found with a simple script which would
>> transfer data to an i2c client from 1 to 1024 bytes
>> (a simple for loop), when we got to transfer sizes
>> bigger than the fifo size, dev->buf_len was reset
>> to zero before we had an oportunity to handle XDR
>> Interrupt. Because dev->buf_len was zero, we entered
>> omap_i2c_transmit_data() to transfer zero bytes,
>> which would mean we would just silently exit
>> omap_i2c_transmit_data() without actually writing
>> anything to DATA register. That would cause XDR
>> IRQ to trigger forever and we would never transfer
>> the remaining bytes.
>>
>> After adding the memory barrier, we also drop resetting
>> dev->buf_len to zero in omap_i2c_xfer_msg() because
>> both omap_i2c_transmit_data() and omap_i2c_receive_data()
>> will act until dev->buf_len reaches zero, rendering the
>> other write in omap_i2c_xfer_msg() redundant.
>>
>> This patch has been tested with pandaboard for a few
>> iterations of the script mentioned above.
>>
>> Signed-off-by: Felipe Balbi <balbi@ti.com>
>> ---
>>
>> This bug has been there forever, but it's quite annoying.
>> I think it deserves being pushed upstream during this -rc
>> cycle, but if Wolfram decides to wait until v3.8, I don't
>> mind.
>>
>>   drivers/i2c/busses/i2c-omap.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
>> index db31eae..1ec4e6e 100644
>> --- a/drivers/i2c/busses/i2c-omap.c
>> +++ b/drivers/i2c/busses/i2c-omap.c
>> @@ -521,6 +521,7 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
>>   	/* REVISIT: Could the STB bit of I2C_CON be used with probing? */
>>   	dev->buf = msg->buf;
>>   	dev->buf_len = msg->len;
>> +	wmb();
>>
>>   	omap_i2c_write_reg(dev, OMAP_I2C_CNT_REG, dev->buf_len);
>>
>
> Would suggest moving the wmb() immediately before the point at which the
> interrupt can occur.  Looks to me that's when the OMAP_I2C_CON_REG write
> occurs.
>
> Also would suggest adding a comment to clarify what the wmb() is intended
> to do.  Maybe something like 'Prevent the compiler from moving earlier
> changes to dev->buf and dev->buf_len after the write to CON_REG.  This
> write enables interrupts and those variables are used in the interrupt
> handler'.
>
Another alternative, which I will recommend to just make use of the
read*/wrire* instead __raw versions. The barriers are taken care
already and driver point of view, it is transparent.

-->
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index db31eae..0cd6365 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -265,13 +265,13 @@ static const u8 reg_map_ip_v2[] = {
  static inline void omap_i2c_write_reg(struct omap_i2c_dev *i2c_dev,
  				      int reg, u16 val)
  {
-	__raw_writew(val, i2c_dev->base +
+	writew(val, i2c_dev->base +
  			(i2c_dev->regs[reg] << i2c_dev->reg_shift));
  }

  static inline u16 omap_i2c_read_reg(struct omap_i2c_dev *i2c_dev, int reg)
  {
-	return __raw_readw(i2c_dev->base +
+	return readw(i2c_dev->base +
  				(i2c_dev->regs[reg] << i2c_dev->reg_shift));
  }

Patch might be damaged because of copy paste.

Regards
Santosh
