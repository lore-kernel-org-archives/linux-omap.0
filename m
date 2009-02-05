From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH PM 1/2] OMAP McSPI: Fix context save/restore
Date: Thu, 05 Feb 2009 06:52:24 -0800
Message-ID: <878wol6imv.fsf@deeprootsystems.com>
References: <498AC802.8040302@nokia.com>
	<1233832029-21614-1-git-send-email-Aaro.Koskinen@nokia.com>
	<56834.10.24.255.18.1233834716.squirrel@dbdmail.itg.ti.com>
	<87ocxh6jpq.fsf@deeprootsystems.com>
	<01de01c9879f$905ec6d0$LocalHost@wipultra793>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f11.google.com ([209.85.221.11]:43955 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377AbZBEOwa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Feb 2009 09:52:30 -0500
Received: by qyk4 with SMTP id 4so356444qyk.13
        for <linux-omap@vger.kernel.org>; Thu, 05 Feb 2009 06:52:28 -0800 (PST)
In-Reply-To: <01de01c9879f$905ec6d0$LocalHost@wipultra793> (Hemanth V.'s message of "Thu\, 5 Feb 2009 20\:09\:31 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemanth V <hemanthv@ti.com>
Cc: Aaro Koskinen <Aaro.Koskinen@nokia.com>, linux-omap@vger.kernel.org

"Hemanth V" <hemanthv@ti.com> writes:

> ----- Original Message ----- 
> From: "Kevin Hilman" <khilman@deeprootsystems.com>
> To: "Hemanth V" <hemanthv@ti.com>
> Cc: "Aaro Koskinen" <Aaro.Koskinen@nokia.com>; <linux-omap@vger.kernel.org>
> Sent: Thursday, February 05, 2009 7:59 PM
> Subject: Re: [PATCH PM 1/2] OMAP McSPI: Fix context save/restore
>
>
>> "Hemanth V" <hemanthv@ti.com> writes:
>>
>>>> Fix context save/restore to work with chip select. Also update the
>>>> shadow
>>>> CHCONF0 register on every write and eliminate register reads.
>>>
>>> I believe the shadow CHCONF register need to have only the default
>>> configuration as initialized by omap2_mcspi_setup_transfer(), since
>>> other other
>>> bits are initialized as and when required by omap2_mcspi_work().
>>>
>>> The original problem you saw might be because of not masking
>>> OMAP2_MCSPI_CHCONF_TRM_MASK and OMAP2_MCSPI_CHCONF_FORCE bits while
>>> storing to
>>> shadow register.
>>
>> Hemanth,
>>
>> Can you address this problem and post a single patch with the full
>> save/restore.
>>
>> I have reverted the original patch in the pm branch and would like
>> to see a single patch including the fixes from Jouni and Aaro.
>
> Kevin,
>
> Both fixes cannot be taken since they are conflicting, I would like
> to go with Jouni's fix.
>

Actually, I'd prefer to see Aaro's fix as it goes a little further to
optimize the save/restore path.  He also fixed a locking bug.

Kevin

>
>>
>> Kevin
>>
>>
>>>>
>>>> Signed-off-by: Aaro Koskinen <Aaro.Koskinen@nokia.com>
>>>> ---
>>>>  drivers/spi/omap2_mcspi.c |   51
>>>> +++++++++++++++++++++++++-------------------
>>>>  1 files changed, 29 insertions(+), 22 deletions(-)
>>>>
>>>> diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
>>>> index a7ee3b7..4d09777 100644
>>>> --- a/drivers/spi/omap2_mcspi.c
>>>> +++ b/drivers/spi/omap2_mcspi.c
>>>> @@ -134,6 +134,7 @@ struct omap2_mcspi_cs {
>>>>  void __iomem *base;
>>>>  unsigned long phys;
>>>>  int word_len;
>>>> + u32 chconf0;
>>>>  };
>>>>
>>>>  /* used for context save and restore, structure members to be
>>>> updated whenever
>>>> @@ -142,7 +143,6 @@ struct omap2_mcspi_cs {
>>>>  struct omap2_mcspi_regs {
>>>>  u32 sysconfig;
>>>>  u32 modulctrl;
>>>> - u32 chconf0;
>>>>  u32 wakeupenable;
>>>>  };
>>>>
>>>> @@ -187,12 +187,27 @@ static inline u32 mcspi_read_cs_reg(const struct
>>>> spi_device *spi, int idx)
>>>>  return __raw_readl(cs->base + idx);
>>>>  }
>>>>
>>>> +static inline u32 mcspi_cached_chconf0(const struct spi_device *spi)
>>>> +{
>>>> + struct omap2_mcspi_cs *cs = spi->controller_state;
>>>> +
>>>> + return cs->chconf0;
>>>> +}
>>>> +
>>>> +static inline void mcspi_write_chconf0(const struct spi_device
>>>> *spi, u32 val)
>>>> +{
>>>> + struct omap2_mcspi_cs *cs = spi->controller_state;
>>>> +
>>>> + cs->chconf0 = val;
>>>> + mcspi_write_cs_reg(spi, OMAP2_MCSPI_CHCONF0, val);
>>>> +}
>>>> +
>>>>  static void omap2_mcspi_set_dma_req(const struct spi_device *spi,
>>>>  int is_read, int enable)
>>>>  {
>>>>  u32 l, rw;
>>>>
>>>> - l = mcspi_read_cs_reg(spi, OMAP2_MCSPI_CHCONF0);
>>>> + l = mcspi_cached_chconf0(spi);
>>>>
>>>>  if (is_read) /* 1 is read, 0 write */
>>>>  rw = OMAP2_MCSPI_CHCONF_DMAR;
>>>> @@ -200,7 +215,7 @@ static void omap2_mcspi_set_dma_req(const
>>>> struct spi_device
>>>> *spi,
>>>>  rw = OMAP2_MCSPI_CHCONF_DMAW;
>>>>
>>>>  MOD_REG_BIT(l, rw, enable);
>>>> - mcspi_write_cs_reg(spi, OMAP2_MCSPI_CHCONF0, l);
>>>> + mcspi_write_chconf0(spi, l);
>>>>  }
>>>>
>>>>  static void omap2_mcspi_set_enable(const struct spi_device *spi,
>>>> int enable)
>>>> @@ -215,9 +230,9 @@ static void omap2_mcspi_force_cs(struct
>>>> spi_device *spi,
>>>> int cs_active)
>>>>  {
>>>>  u32 l;
>>>>
>>>> - l = mcspi_read_cs_reg(spi, OMAP2_MCSPI_CHCONF0);
>>>> + l = mcspi_cached_chconf0(spi);
>>>>  MOD_REG_BIT(l, OMAP2_MCSPI_CHCONF_FORCE, cs_active);
>>>> - mcspi_write_cs_reg(spi, OMAP2_MCSPI_CHCONF0, l);
>>>> + mcspi_write_chconf0(spi, l);
>>>>  }
>>>>
>>>>  static void omap2_mcspi_set_master_mode(struct spi_master *master)
>>>> @@ -248,10 +263,6 @@ static void omap2_mcspi_restore_ctx(struct
>>>> omap2_mcspi
>>>> *mcspi)
>>>>  mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_SYSCONFIG,
>>>>  omap2_mcspi_ctx[spi_cntrl->bus_num - 1].sysconfig);
>>>>
>>>> - mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_CHCONF0,
>>>> - omap2_mcspi_ctx[spi_cntrl->bus_num - 1].chconf0);
>>>> -
>>>> -
>>>>  mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_WAKEUPENABLE,
>>>>  omap2_mcspi_ctx[spi_cntrl->bus_num - 1].wakeupenable);
>>>>  }
>>>> @@ -392,7 +403,7 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct
>>>> spi_transfer *xfer)
>>>>  c = count;
>>>>  word_len = cs->word_len;
>>>>
>>>> - l = mcspi_read_cs_reg(spi, OMAP2_MCSPI_CHCONF0);
>>>> + l = mcspi_cached_chconf0(spi);
>>>>  l &= ~OMAP2_MCSPI_CHCONF_TRM_MASK;
>>>>
>>>>  /* We store the pre-calculated register addresses on stack to speed
>>>> @@ -432,8 +443,7 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct
>>>> spi_transfer *xfer)
>>>>  * more word i/o: switch to rx+tx
>>>>  */
>>>>  if (c == 0 && tx == NULL)
>>>> - mcspi_write_cs_reg(spi,
>>>> - OMAP2_MCSPI_CHCONF0, l);
>>>> + mcspi_write_chconf0(spi, l);
>>>>  *rx++ = __raw_readl(rx_reg);
>>>>  #ifdef VERBOSE
>>>>  dev_dbg(&spi->dev, "read-%d %02x\n",
>>>> @@ -471,8 +481,7 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct
>>>> spi_transfer *xfer)
>>>>  * more word i/o: switch to rx+tx
>>>>  */
>>>>  if (c == 0 && tx == NULL)
>>>> - mcspi_write_cs_reg(spi,
>>>> - OMAP2_MCSPI_CHCONF0, l);
>>>> + mcspi_write_chconf0(spi, l);
>>>>  *rx++ = __raw_readl(rx_reg);
>>>>  #ifdef VERBOSE
>>>>  dev_dbg(&spi->dev, "read-%d %04x\n",
>>>> @@ -510,8 +519,7 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct
>>>> spi_transfer *xfer)
>>>>  * more word i/o: switch to rx+tx
>>>>  */
>>>>  if (c == 0 && tx == NULL)
>>>> - mcspi_write_cs_reg(spi,
>>>> - OMAP2_MCSPI_CHCONF0, l);
>>>> + mcspi_write_chconf0(spi, l);
>>>>  *rx++ = __raw_readl(rx_reg);
>>>>  #ifdef VERBOSE
>>>>  dev_dbg(&spi->dev, "read-%d %04x\n",
>>>> @@ -559,7 +567,7 @@ static int omap2_mcspi_setup_transfer(struct
>>>> spi_device
>>>> *spi,
>>>>  } else
>>>>  div = 15;
>>>>
>>>> - l = mcspi_read_cs_reg(spi, OMAP2_MCSPI_CHCONF0);
>>>> + l = mcspi_cached_chconf0(spi);
>>>>
>>>>  /* standard 4-wire master mode:  SCK, MOSI/out, MISO/in, nCS
>>>>  * REVISIT: this controller could support SPI_3WIRE mode.
>>>> @@ -591,9 +599,7 @@ static int omap2_mcspi_setup_transfer(struct
>>>> spi_device
>>>> *spi,
>>>>  else
>>>>  l &= ~OMAP2_MCSPI_CHCONF_PHA;
>>>>
>>>> - mcspi_write_cs_reg(spi, OMAP2_MCSPI_CHCONF0, l);
>>>> -
>>>> - omap2_mcspi_ctx[spi_cntrl->bus_num - 1].chconf0 = l;
>>>> + mcspi_write_chconf0(spi, l);
>>>>
>>>>  dev_dbg(&spi->dev, "setup: speed %d, sample %s edge, clk %s\n",
>>>>  OMAP2_MCSPI_MAX_FREQ / (1 << div),
>>>> @@ -697,6 +703,7 @@ static int omap2_mcspi_setup(struct spi_device *spi)
>>>>  return -ENOMEM;
>>>>  cs->base = mcspi->base + spi->chip_select * 0x14;
>>>>  cs->phys = mcspi->phys + spi->chip_select * 0x14;
>>>> + cs->chconf0 = 0;
>>>>  spi->controller_state = cs;
>>>>  }
>>>>
>>>> @@ -791,13 +798,13 @@ static void omap2_mcspi_work(struct
>>>> work_struct *work)
>>>>  cs_active = 1;
>>>>  }
>>>>
>>>> - chconf = mcspi_read_cs_reg(spi, OMAP2_MCSPI_CHCONF0);
>>>> + chconf = mcspi_cached_chconf0(spi);
>>>>  chconf &= ~OMAP2_MCSPI_CHCONF_TRM_MASK;
>>>>  if (t->tx_buf == NULL)
>>>>  chconf |= OMAP2_MCSPI_CHCONF_TRM_RX_ONLY;
>>>>  else if (t->rx_buf == NULL)
>>>>  chconf |= OMAP2_MCSPI_CHCONF_TRM_TX_ONLY;
>>>> - mcspi_write_cs_reg(spi, OMAP2_MCSPI_CHCONF0, chconf);
>>>> + mcspi_write_chconf0(spi, chconf);
>>>>
>>>>  if (t->len) {
>>>>  unsigned count;
>>>> --
>>>> 1.5.4.3
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>>
>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
