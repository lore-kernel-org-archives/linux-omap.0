From: Igor Mazanov <i.mazanov@gmail.com>
Subject: Re: [PATCH] [RFC][OMAP3:I2C]Workaround for OMAP3430 I2C silicon
    errata 1.153
Date: Thu, 25 Jun 2009 21:17:32 +0400
Message-ID: <h20bam$vnp$1@ger.gmane.org>
References: <CD8CC2B65FEE304DA95744A5472698F2028A41187E@dlee06.ent.ti.com> <7A436F7769CA33409C6B44B358BFFF0C0115F50E6C@dlee02.ent.ti.com> <h1qm0f$r7c$1@ger.gmane.org> <7A436F7769CA33409C6B44B358BFFF0C0116011AC7@dlee02.ent.ti.com>
Reply-To: i.mazanov@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:44503 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750964AbZFYRPT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Jun 2009 13:15:19 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MJsXd-000633-Ly
	for linux-omap@vger.kernel.org; Thu, 25 Jun 2009 17:15:17 +0000
Received: from ppp91-122-64-9.pppoe.avangarddsl.ru ([91.122.64.9])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Thu, 25 Jun 2009 17:15:17 +0000
Received: from i.mazanov by ppp91-122-64-9.pppoe.avangarddsl.ru with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Thu, 25 Jun 2009 17:15:17 +0000
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0C0116011AC7@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Menon, Nishanth wrote:
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Igor Mazanov
>> Sent: Tuesday, June 23, 2009 4:43 PM
>> To: linux-omap@vger.kernel.org
>> Subject: Re: [PATCH] [RFC][OMAP3:I2C]Workaround for OMAP3430 I2C silicon
>> errata 1.153
>>
>> /*
>>   * Is there a bug in the OMAP5910 I2C controller? It
>>   * generates a bunch of fake XRDY interrupts under high load.
>>   * As result, there is a very high chance to have a situation
>>   * when dev->buf_len = 0 already, but I2C_CNT != 0. So, there
>>   * is no ARDY irq then, no complete_cmd, controller timed out
>>   * issues...
>>   *
>>   * Workaround:
>>   *
>>   * When we get XRDY interrupt without transmit underflow flag
>>   * (XUDF bit in the I2C_STAT register), delay for 100 microsecs
>>   * and ignore it.
>>   *
>>   * We write data into I2C_DATA register in case of transmit
>>   * underflow condition ONLY.
>>   */
>> if (stat & OMAP_I2C_STAT_XRDY) {
>> 	if (!(stat & OMAP_I2C_STAT_XUDF)) {
>> 		udelay(100);
>> 		continue;
>> 	} else {
>> 		w = 0;
>> 		if (dev->buf_len) {
>> 			w = *dev->buf++;
>> 			dev->buf_len--;
>> 			if (dev->buf_len) {
>> 				w |= *dev->buf++ << 8;
>> 				dev->buf_len--;
>> 			}
>> 			omap_i2c_write_reg(dev, OMAP_I2C_DATA_REG, w);
>> 		} else {
>> 			dev_err(dev->dev, "XRDY IRQ while no "
>> 						"data to send\n");
>> 			break;
>> 		}
>> 		continue;
>> 	}
>> }
>>
> Could you submit a patch please?
>

OMAP1 I2C controller generates a huge amount of fake XRDY interrupts when large 
continuous blocks of data are transmitted via I2C. As result data have no time 
to be transmitted physically over I2C data line if we just look on XRDY bit 
before writing to I2C_DATA register. Taking into account a transmit underrun 
condition (XUDF bit in the I2C_STAT register) help us to transmit in more 
predictable way.

So,

Signed-off-by: Igor Mazanov <i.mazanov@gmail.com>
---
  drivers/i2c/busses/i2c-omap.c |  140 ++++++++++++++++++++++++++++------------
  1 files changed, 98 insertions(+), 42 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index ece0125..7464848 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -436,10 +436,15 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,

  	omap_i2c_write_reg(dev, OMAP_I2C_CNT_REG, dev->buf_len);

-	/* Clear the FIFO Buffers */
-	w = omap_i2c_read_reg(dev, OMAP_I2C_BUF_REG);
-	w |= OMAP_I2C_BUF_RXFIF_CLR | OMAP_I2C_BUF_TXFIF_CLR;
-	omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG, w);
+	/* Clear the FIFO Buffers
+	 * Useless for OMAP1 family - according TRMs (spru681b, spru760c),
+	 * FIFO are not controllable in this way
+	 */
+	if (!cpu_class_is_omap1()) {
+		w = omap_i2c_read_reg(dev, OMAP_I2C_BUF_REG);
+		w |= OMAP_I2C_BUF_RXFIF_CLR | OMAP_I2C_BUF_TXFIF_CLR;
+		omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG, w);
+	}

  	init_completion(&dev->cmd_complete);
  	dev->cmd_err = 0;
@@ -578,55 +583,106 @@ static irqreturn_t
  omap_i2c_rev1_isr(int this_irq, void *dev_id)
  {
  	struct omap_i2c_dev *dev = dev_id;
-	u16 iv, w;
+	u16 bits;
+	u16 stat, w;
+	int err, count = 0;

  	if (dev->idle)
  		return IRQ_NONE;

-	iv = omap_i2c_read_reg(dev, OMAP_I2C_IV_REG);
-	switch (iv) {
-	case 0x00:	/* None */
-		break;
-	case 0x01:	/* Arbitration lost */
-		dev_err(dev->dev, "Arbitration lost\n");
-		omap_i2c_complete_cmd(dev, OMAP_I2C_STAT_AL);
-		break;
-	case 0x02:	/* No acknowledgement */
-		omap_i2c_complete_cmd(dev, OMAP_I2C_STAT_NACK);
-		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_STP);
-		break;
-	case 0x03:	/* Register access ready */
-		omap_i2c_complete_cmd(dev, 0);
-		break;
-	case 0x04:	/* Receive data ready */
-		if (dev->buf_len) {
+	bits = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
+	while ((stat = (omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG))) & bits) {
+		dev_dbg(dev->dev, "IRQ (ISR = 0x%04x)\n", stat);
+		if (count++ == 200) {
+			dev_warn(dev->dev, "Too much work in one IRQ\n");
+			break;
+		}
+
+		omap_i2c_read_reg(dev, OMAP_I2C_IV_REG);
+
+		err = 0;
+		if (stat & OMAP_I2C_STAT_NACK) {
+			err |= OMAP_I2C_STAT_NACK;
+			omap_i2c_write_reg(dev, OMAP_I2C_CON_REG,
+					   OMAP_I2C_CON_STP);
+		}
+		if (stat & OMAP_I2C_STAT_AL) {
+			dev_err(dev->dev, "Arbitration lost\n");
+			err |= OMAP_I2C_STAT_AL;
+		}
+		if (stat & (OMAP_I2C_STAT_ARDY | OMAP_I2C_STAT_NACK |
+							OMAP_I2C_STAT_AL)) {
+				omap_i2c_complete_cmd(dev, err);
+				break;
+		}
+		if (stat & OMAP_I2C_STAT_RRDY) {
  			w = omap_i2c_read_reg(dev, OMAP_I2C_DATA_REG);
-			*dev->buf++ = w;
-			dev->buf_len--;
  			if (dev->buf_len) {
-				*dev->buf++ = w >> 8;
+				*dev->buf++ = w;
  				dev->buf_len--;
+				if (dev->buf_len) {
+					*dev->buf++ = w >> 8;
+					dev->buf_len--;
+				}
+			} else {
+				dev_err(dev->dev, "RRDY IRQ while no data"
+							" requested\n");
+				break;
  			}
-		} else
-			dev_err(dev->dev, "RRDY IRQ while no data requested\n");
-		break;
-	case 0x05:	/* Transmit data ready */
-		if (dev->buf_len) {
-			w = *dev->buf++;
-			dev->buf_len--;
-			if (dev->buf_len) {
-				w |= *dev->buf++ << 8;
-				dev->buf_len--;
+			continue;
+		}
+		/*
+		 * Is there a bug in the OMAP5910 I2C controller? It
+		 * generates a bunch of fake XRDY interrupts under high load.
+		 * As result, there is a very high chance to have a situation
+		 * when dev->buf_len = 0 already, but I2C_CNT != 0. So, there
+		 * is no ARDY irq then, no complete_cmd, controller timed out
+		 * issues...
+		 *
+		 * Workaround:
+		 *
+		 * When we get XRDY interrupt without transmit underflow flag
+		 * (XUDF bit in the I2C_STAT register), delay for 100 microsecs
+		 * and ignore it.
+		 *
+		 * We write data into I2C_DATA register in case of transmit
+		 * underflow condition ONLY.
+		 */
+		if (stat & OMAP_I2C_STAT_XRDY) {
+			if (!(stat & OMAP_I2C_STAT_XUDF)) {
+				udelay(100);
+				continue;
+			} else {
+				w = 0;
+				if (dev->buf_len) {
+					w = *dev->buf++;
+					dev->buf_len--;
+					if (dev->buf_len) {
+						w |= *dev->buf++ << 8;
+						dev->buf_len--;
+					}
+					omap_i2c_write_reg(dev, OMAP_I2C_DATA_REG, w);
+				} else {
+					dev_err(dev->dev, "XRDY IRQ while no "
+							"data to send\n");
+					break;
+				}
+				continue;
  			}
-			omap_i2c_write_reg(dev, OMAP_I2C_DATA_REG, w);
-		} else
-			dev_err(dev->dev, "XRDY IRQ while no data to send\n");
-		break;
-	default:
-		return IRQ_NONE;
+		}
+		/* REVISIT: Are this checks useful?
+		 * It looks like we will never hit in it... */
+		if (stat & OMAP_I2C_STAT_ROVR) {
+			dev_err(dev->dev, "Receive overrun\n");
+			dev->cmd_err |= OMAP_I2C_STAT_ROVR;
+		}
+		if (stat & OMAP_I2C_STAT_XUDF) {
+			dev_err(dev->dev, "Transmit underflow\n");
+			dev->cmd_err |= OMAP_I2C_STAT_XUDF;
+		}
  	}

-	return IRQ_HANDLED;
+	return count ? IRQ_HANDLED : IRQ_NONE;
  }
  #else
  #define omap_i2c_rev1_isr		NULL
-- 
1.6.0.1


