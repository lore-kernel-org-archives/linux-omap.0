From: Igor Mazanov <i.mazanov@gmail.com>
Subject: Re: [PATCH] [RFC][OMAP3:I2C]Workaround for OMAP3430 I2C silicon
  errata 1.153
Date: Tue, 23 Jun 2009 17:43:01 +0400
Message-ID: <h1qm0f$r7c$1@ger.gmane.org>
References: <CD8CC2B65FEE304DA95744A5472698F2028A41187E@dlee06.ent.ti.com> <7A436F7769CA33409C6B44B358BFFF0C0115F50E6C@dlee02.ent.ti.com>
Reply-To: i.mazanov@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:46592 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755788AbZFWNkr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Jun 2009 09:40:47 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MJ6Ex-00037L-RN
	for linux-omap@vger.kernel.org; Tue, 23 Jun 2009 13:40:47 +0000
Received: from ppp91-122-64-9.pppoe.avangarddsl.ru ([91.122.64.9])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Tue, 23 Jun 2009 13:40:47 +0000
Received: from i.mazanov by ppp91-122-64-9.pppoe.avangarddsl.ru with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Tue, 23 Jun 2009 13:40:47 +0000
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0C0115F50E6C@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

Menon, Nishanth wrote:
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Sonasath, Moiz
>> Sent: Monday, June 22, 2009 7:50 PM
>> To: linux-omap@vger.kernel.org
>> Cc: Pandita, Vikram
>> Subject: [PATCH] [RFC][OMAP3:I2C]Workaround for OMAP3430 I2C silicon
>> errata 1.153
>>
>> This patch includes the workarround for I2C Errata 1.153: When an XRDY/XDR
>> is hit, wait for XUDF before writing data to DATA_REG
> 
> Is this workaround valid for omap2430 also?

Some kind of such workaround needs to be applied and for OMAP1 ISR too. 
I had
the same problem on our OMAP5910 based custom made board. While writing 
a large contiguous amount of data constantly occurs a situation when 
dev->buf_len = 0, but I2C_CNT register != 0, and, as result, I2C 
controller doesn't generate ARDY IRQ, no complete_cmd occurs in ISR, and 
we get "controller timed out" issues then...

So, here is a part of modified OMAP1 ISR. It works for me at least.

/*
  * Is there a bug in the OMAP5910 I2C controller? It
  * generates a bunch of fake XRDY interrupts under high load.
  * As result, there is a very high chance to have a situation
  * when dev->buf_len = 0 already, but I2C_CNT != 0. So, there
  * is no ARDY irq then, no complete_cmd, controller timed out
  * issues...
  *
  * Workaround:
  *
  * When we get XRDY interrupt without transmit underflow flag
  * (XUDF bit in the I2C_STAT register), delay for 100 microsecs
  * and ignore it.
  *
  * We write data into I2C_DATA register in case of transmit
  * underflow condition ONLY.
  */
if (stat & OMAP_I2C_STAT_XRDY) {
	if (!(stat & OMAP_I2C_STAT_XUDF)) {
		udelay(100);
		continue;
	} else {
		w = 0;
		if (dev->buf_len) {
			w = *dev->buf++;
			dev->buf_len--;
			if (dev->buf_len) {
				w |= *dev->buf++ << 8;
				dev->buf_len--;
			}
			omap_i2c_write_reg(dev, OMAP_I2C_DATA_REG, w);
		} else {
			dev_err(dev->dev, "XRDY IRQ while no "
						"data to send\n");
			break;
		}
		continue;
	}
}	

Regards,
Igor.

