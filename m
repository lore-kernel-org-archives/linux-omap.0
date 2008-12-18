From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [PATCH] Add TI TSC2005 Touchscreen driver
Date: Thu, 18 Dec 2008 13:25:16 +0530
Message-ID: <5d5443650812172355j6e548fa9scd55a2636341abfb@mail.gmail.com>
References: <5d5443650812080949h5aff6010mb7341f581841f126@mail.gmail.com>
	 <20081208182648.GA9740@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.174]:35197 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778AbYLRHzR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Dec 2008 02:55:17 -0500
In-Reply-To: <20081208182648.GA9740@uranus.ravnborg.org>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>, Lauri Leukkunen <lauri.leukkunen@nokia.com>
Cc: David Brownell <david-b@pacbell.net>, dmitry.torokhov@gmail.com, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, spi-devel-general@lists.sourceforge.net, linux-input@vger.kernel.org

Hi Sam/Lauri,

>>
>> +config TOUCHSCREEN_TSC2005
>> +     tristate "TSC2005 touchscreen support"
> I would be good to see Texas Instruments spelled out here.
>> +     depends on SPI_MASTER
>> +     help
>> +       Say Y here for if you are using the touchscreen features of TSC2005.
> And maybe with a bit text explaining where it is used or maybe where to find info.

I can add this.

>
>> +#define TSC2005_VDD_LOWER_27
>> +
>> +#ifdef TSC2005_VDD_LOWER_27
>> +#define TSC2005_HZ     (10000000)
>> +#else
>> +#define TSC2005_HZ     (25000000)
>> +#endif
>
> You define TSC2005_VDD_LOWER_27 and test for it two
> lines later - looks strange.

I will this as is right now, probably Lauri can explain if there is
some other way possible to pass it using platform hook if it is
specific to particular board design.

>
>> +
>> +static void tsc2005_cmd(struct tsc2005 *ts, u8 cmd)
>> +{
>> +     u16 data = TSC2005_CMD | TSC2005_CMD_12BIT | cmd;
>> +     struct spi_message msg;
>> +     struct spi_transfer xfer = { 0 };
>> +
>> +     xfer.tx_buf = &data;
>> +     xfer.rx_buf = NULL;
>> +     xfer.len = 1;
>> +     xfer.bits_per_word = 8;
> data is a 16 bit quantity yet you specify a len of 1.
> Maybe len is counted from 0?
>

This looks like bug. I will change data to u8. Lauri please confirm.

>> +static void tsc2005_write(struct tsc2005 *ts, u8 reg, u16 value)
>> +{
>> +     u32 tx;
>> +     struct spi_message msg;
>> +     struct spi_transfer xfer = { 0 };
>> +
>> +     tx = (TSC2005_REG | reg | TSC2005_REG_PND0 |
>> +            TSC2005_REG_WRITE) << 16;
>> +     tx |= value;
> Is this endian safe? Does spi know about LSB/MSB in the value?
>
>> +
>> +     xfer.tx_buf = &tx;
>> +     xfer.rx_buf = NULL;
>> +     xfer.len = 4;
>> +     xfer.bits_per_word = 24;
>> +

As per this bits_per_word and length we have 4 messages of 24 bits
each, and so it is job of omap2_mcspi_txrx_pio in
drivers/spi/omap2_mcspi.c to handle this messages and proper order.
AFAIR, OMAP2 mcspi block has registers settings for this byte-order
stuf. Lauri could you please add some points here. I don't have access
to OMAP2 TRM anymore. Thanks.


-- 
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
