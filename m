From: "Hemanth V" <hemanthv@ti.com>
Subject: Re: [PATCH] OMAP3 McSPI:  Adds context save/restore
Date: Thu, 22 Jan 2009 11:18:29 +0530
Message-ID: <001201c97c55$0f4b7e80$LocalHost@wipultra793>
References: <64283.10.24.255.17.1232533474.squirrel@dbdmail.itg.ti.com> <87eiywr34b.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58557 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755565AbZAVFsm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Jan 2009 00:48:42 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

From: "Kevin Hilman" <khilman@deeprootsystems.com>
> "Hemanth V" <hemanthv@ti.com> writes:
>
>> From: Hemanth V <hemanthv@ti.com>
>>
>> This patch adds context save/restore feature to McSPI driver. This has 
>> been
>> tested by instrumenting the driver code i.e by adding a McSPI softreset
>> in omap2_mcspi_disable_clocks function.
>
> Were you able to test this on the PM branch with off-mode enabled?

Since OFF-mode is currently not working on 3430SDP board, I have tested this 
with instrumentation on the PM branch. The instrumentation was to do a 
softreset on clock disable to ensure all registers are reset to default 
values. Hence when you enable the clocks, context restore would get tested.

>
> Some general comments:
>
> The save/restore only affects a small number of registers and ones
> that do not change very often.
>
> So, I think the save/restore would be more efficiently done by getting
> rid of the 'save_ctx' and using shadow regs in memory.  IOW, when ever
> the registers are changed in the code, just update the copy in
> omap2_mcspi_ctx.  Then you do not need a save_ctx function, you only
> need a restore.

Yes I agree, will change this.

>
> Also, the restore should normally check whether its powerdomain
> actually went off before restoring.  The OMAP PM layer has the
> function omap_pm_get_last_off_on_transaction_id() for this.
>
> However, In the case of this driver, for only 4 registers it's
> probably faster to just always restore.

>
>> Signed-off-by: Hemanth V <hemanthv@ti.com>
>>
>> ---
>>  drivers/spi/omap2_mcspi.c |   88 
>> +++++++++++++++++++++++++++++++++++++++-------
>>  1 files changed, 76 insertions(+), 12 deletions(-)
>>
>> Index: linux-omap-2.6/drivers/spi/omap2_mcspi.c
>> ===================================================================
>> --- linux-omap-2.6.orig/drivers/spi/omap2_mcspi.c 2009-01-21 
>> 15:03:12.000000000
>> +0530
>> +++ linux-omap-2.6/drivers/spi/omap2_mcspi.c 2009-01-21 
>> 15:05:20.000000000 +0530
>> @@ -133,6 +133,15 @@
>>  int word_len;
>>  };
>>
>> +struct omap2_mcspi_regs {
>> + u32 sysconfig;
>> + u32 modulctrl;
>> + u32 chconf0;
>> + u32 wakeupenable;
>> +};
>> +
>> +static struct omap2_mcspi_regs omap2_mcspi_ctx[4];
>> +
>
> Can you use a symbolic constant here instead of 4?  Something like
> MAX_SPI_CONTROLLERS with a comment saying someting about omap2 having
> 3 and omap3 having 4.

Yes, will changes this.

>
>>  static struct workqueue_struct *omap2_mcspi_wq;
>>
>>  #define MOD_REG_BIT(val, mask, set) do { \
>> @@ -219,6 +228,63 @@
>>  mcspi_write_reg(master, OMAP2_MCSPI_MODULCTRL, l);
>>  }
>>
>> +static void omap2_mcspi_save_ctx(struct omap2_mcspi *mcspi)
>> +{
>> + struct spi_master *spi_cntrl;
>> + spi_cntrl = mcspi->master;
>> +
>> + /* McSPI : context save */
>> + omap2_mcspi_ctx[spi_cntrl->bus_num - 1].modulctrl =
>> + mcspi_read_reg(spi_cntrl, OMAP2_MCSPI_MODULCTRL);
>> +
>> + omap2_mcspi_ctx[spi_cntrl->bus_num - 1].sysconfig =
>> + mcspi_read_reg(spi_cntrl, OMAP2_MCSPI_SYSCONFIG);
>> +
>> + omap2_mcspi_ctx[spi_cntrl->bus_num - 1].chconf0 =
>> + mcspi_read_reg(spi_cntrl, OMAP2_MCSPI_CHCONF0);
>> +
>> + omap2_mcspi_ctx[spi_cntrl->bus_num - 1].wakeupenable =
>> + mcspi_read_reg(spi_cntrl, OMAP2_MCSPI_WAKEUPENABLE);
>> +}
>> +
>> +static void omap2_mcspi_restore_ctx(struct omap2_mcspi *mcspi)
>> +{
>> + struct spi_master *spi_cntrl;
>> + spi_cntrl = mcspi->master;
>> +
>> + /*McSPI : context restore */
>> + mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_MODULCTRL,
>> + omap2_mcspi_ctx[spi_cntrl->bus_num - 1].modulctrl);
>> +
>> + mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_SYSCONFIG,
>> + omap2_mcspi_ctx[spi_cntrl->bus_num - 1].sysconfig);
>> +
>> + mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_CHCONF0,
>> + omap2_mcspi_ctx[spi_cntrl->bus_num - 1].chconf0);
>> +
>> + mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_WAKEUPENABLE,
>> + omap2_mcspi_ctx[spi_cntrl->bus_num - 1].wakeupenable);
>> +}
>> +static void omap2_mcspi_disable_clocks(struct omap2_mcspi *mcspi)
>> +{
>> + omap2_mcspi_save_ctx(mcspi);
>> +
>> + clk_disable(mcspi->ick);
>> + clk_disable(mcspi->fck);
>> +}
>> +
>> +static int omap2_mcspi_enable_clocks(struct omap2_mcspi *mcspi)
>> +{
>> + if (clk_enable(mcspi->ick))
>> + return -ENODEV;
>> + if (clk_enable(mcspi->fck))
>> + return -ENODEV;
>> +
>> + omap2_mcspi_restore_ctx(mcspi);
>> +
>> + return 0;
>> +}
>> +
>>  static unsigned
>>  omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
>>  {
>> @@ -649,11 +715,11 @@
>>  return ret;
>>  }
>>
>> - clk_enable(mcspi->ick);
>> - clk_enable(mcspi->fck);
>> + if (omap2_mcspi_enable_clocks(mcspi))
>> + return -ENODEV;
>> +
>>  ret = omap2_mcspi_setup_transfer(spi, NULL);
>> - clk_disable(mcspi->fck);
>> - clk_disable(mcspi->ick);
>> + omap2_mcspi_disable_clocks(mcspi);
>>
>>  return ret;
>>  }
>> @@ -685,8 +751,8 @@
>>  mcspi = container_of(work, struct omap2_mcspi, work);
>>  spin_lock_irq(&mcspi->lock);
>>
>> - clk_enable(mcspi->ick);
>> - clk_enable(mcspi->fck);
>> + if (omap2_mcspi_enable_clocks(mcspi))
>> + return;
>>
>>  /* We only enable one channel at a time -- the one whose message is
>>  * at the head of the queue -- although this controller would gladly
>> @@ -788,8 +854,7 @@
>>  spin_lock_irq(&mcspi->lock);
>>  }
>>
>> - clk_disable(mcspi->fck);
>> - clk_disable(mcspi->ick);
>> + omap2_mcspi_disable_clocks(mcspi);
>>
>>  spin_unlock_irq(&mcspi->lock);
>>  }
>> @@ -877,8 +942,8 @@
>>  struct spi_master *master = mcspi->master;
>>  u32 tmp;
>>
>> - clk_enable(mcspi->ick);
>> - clk_enable(mcspi->fck);
>> + if (omap2_mcspi_enable_clocks(mcspi))
>> + return -1;
>>
>>  mcspi_write_reg(master, OMAP2_MCSPI_SYSCONFIG,
>>  OMAP2_MCSPI_SYSCONFIG_SOFTRESET);
>> @@ -896,8 +961,7 @@
>>
>>  omap2_mcspi_set_master_mode(master);
>>
>> - clk_disable(mcspi->fck);
>> - clk_disable(mcspi->ick);
>> + omap2_mcspi_disable_clocks(mcspi);
>>  return 0;
>>  }
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> 

