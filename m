From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH v4 06/11] remoteproc: wkup_m3: Add wkup_m3 remote proc
 driver
Date: Mon, 14 Jul 2014 14:07:39 -0500
Message-ID: <53C42A7B.7030302@ti.com>
References: <1405047349-15101-1-git-send-email-d-gerlach@ti.com> <1405047349-15101-7-git-send-email-d-gerlach@ti.com> <53C3EF38.4040903@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42978 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752518AbaGNTIH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Jul 2014 15:08:07 -0400
In-Reply-To: <53C3EF38.4040903@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>, Dave Gerlach <d-gerlach@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, Russ Dill <russ.dill@ti.com>, Daniel Mack <daniel@zonque.org>, Benoit Cousson <bcousson@baylibre.com>, Ohad Ben-Cohen <ohad@wizery.com>

Hi Dave,

I have a few more comments in addition to Santosh's..

On 07/14/2014 09:54 AM, Santosh Shilimkar wrote:
> On Thursday 10 July 2014 10:55 PM, Dave Gerlach wrote:
>> Add a remoteproc driver to load the firmware for and boot the wkup_m3
>> present on am33xx. The wkup_m3 is an integrated Cortex M3 that allows
>> the SoC to enter the lowest possible power state by taking control from
>> the MPU after it has gone into its own low power state and shutting off
>> any additional peripherals.
>>
>> Communication between the MPU and CM3 is handled by several IPC
>> registers in the control module and a mailbox. An API is exposed for
>> programming the aforementioned IPC registers and notifying the wkup_m3
>> of pending data using the mailbox. The wkup_m3 has the ability to
>> trigger an interrupt back to the MPU to allow for bidirectional
>> communication through these registers.
>>
>> Two callbacks are provided. rproc_ready allows code to hook into the
>> driver to see when firmware has been loaded and execute other code and
>> txev_handler allows external code to run when the wkup_m3 triggers an
>> interrupt back to the m3.
>>
>> The driver expects a resource table to be present in the wkup_m3 to
>> define the required memory resources needed by wkup_m3, at least the
>> data memory so that the firmware can be copied for the proper place for
>> execution.
>>
>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>> CC: Ohad Ben-Cohen <ohad@wizery.com>
>> ---
>>  drivers/remoteproc/Kconfig         |  15 ++
>>  drivers/remoteproc/Makefile        |   1 +
>>  drivers/remoteproc/wkup_m3_rproc.c | 512 +++++++++++++++++++++++++++++++++++++
>>  include/linux/wkup_m3.h            |  71 +++++
>>  4 files changed, 599 insertions(+)
>>  create mode 100644 drivers/remoteproc/wkup_m3_rproc.c
>>  create mode 100644 include/linux/wkup_m3.h
>>
>> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
>> index 5e343ba..4b00c21 100644
>> --- a/drivers/remoteproc/Kconfig
>> +++ b/drivers/remoteproc/Kconfig
>> @@ -41,6 +41,21 @@ config STE_MODEM_RPROC
>>  	  This can be either built-in or a loadable module.
>>  	  If unsure say N.
>>  
>> +config WKUP_M3_RPROC
>> +	bool "AM33xx wkup-m3 remoteproc support"
>> +        depends on SOC_AM33XX
>> +        select REMOTEPROC
>> +	select MAILBOX
>> +	select OMAP2PLUS_MBOX
> Please fix the indentation.
> 
>> +	default n
> Default is always 'n' so drop above.
>> +	help
>> +	  Say y here to support AM33xx wkup-m3.
>> +
>> +	  Required for Suspend-to-ram and CPUIdle on AM33xx. Allows for
>> +	  loading of firmware and communication with CM3 PM coproccesor

typo - coprocessor*

>> +	  that is present on AM33xx family of SoCs
>> +	  If unsure say N.
>> +
>>  config DA8XX_REMOTEPROC
>>  	tristate "DA8xx/OMAP-L13x remoteproc support"
>>  	depends on ARCH_DAVINCI_DA8XX
>> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
>> index ac2ff75..81b04d1 100644
>> --- a/drivers/remoteproc/Makefile
>> +++ b/drivers/remoteproc/Makefile
>> @@ -9,4 +9,5 @@ remoteproc-y				+= remoteproc_virtio.o
>>  remoteproc-y				+= remoteproc_elf_loader.o
>>  obj-$(CONFIG_OMAP_REMOTEPROC)		+= omap_remoteproc.o
>>  obj-$(CONFIG_STE_MODEM_RPROC)	 	+= ste_modem_rproc.o
>> +obj-$(CONFIG_WKUP_M3_RPROC)		+= wkup_m3_rproc.o
>>  obj-$(CONFIG_DA8XX_REMOTEPROC)		+= da8xx_remoteproc.o
>> diff --git a/drivers/remoteproc/wkup_m3_rproc.c b/drivers/remoteproc/wkup_m3_rproc.c
>> new file mode 100644
>> index 0000000..58aeaf2
>> --- /dev/null
>> +++ b/drivers/remoteproc/wkup_m3_rproc.c
>> @@ -0,0 +1,512 @@
>> +/*
>> + * AMx3 Wkup M3 Remote Processor driver
>> + *
>> + * Copyright (C) 2014 Texas Instruments, Inc.
>> + *
>> + * Dave Gerlach <d-gerlach@ti.com>
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * version 2 as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/err.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/irq.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/elf.h>

Do you require this header?

>> +#include <linux/pm_runtime.h>
>> +#include <linux/firmware.h>
>> +#include <linux/remoteproc.h>
>> +#include <linux/omap-mailbox.h>
>> +#include <linux/mailbox_client.h>
>> +#include <linux/wkup_m3.h>
>> +#include <linux/kthread.h>
>> +#include "remoteproc_internal.h"

Suggest moving the internal header to after including the
standard headers..

>> +
>> +#include <linux/platform_data/wkup_m3.h>
>> +
>> +#define WKUP_M3_WAKE_SRC_MASK		0xFF
>> +
>> +#define WKUP_M3_STATUS_RESP_SHIFT	16
>> +#define WKUP_M3_STATUS_RESP_MASK	(0xffff << 16)
>> +
>> +#define WKUP_M3_FW_VERSION_SHIFT	0
>> +#define WKUP_M3_FW_VERSION_MASK		0xffff
>> +
>> +/* AM33XX M3_TXEV_EOI register */
>> +#define AM33XX_CONTROL_M3_TXEV_EOI	0x00
>> +
>> +#define AM33XX_M3_TXEV_ACK		(0x1 << 0)
>> +#define AM33XX_M3_TXEV_ENABLE		(0x0 << 0)
>> +
>> +/* AM33XX IPC message registers */
>> +#define AM33XX_CONTROL_IPC_MSG_REG0	0x04
>> +#define AM33XX_CONTROL_IPC_MSG_REG1	0x08
>> +#define AM33XX_CONTROL_IPC_MSG_REG2	0x0c
>> +#define AM33XX_CONTROL_IPC_MSG_REG3	0x10
>> +#define AM33XX_CONTROL_IPC_MSG_REG4	0x14
>> +#define AM33XX_CONTROL_IPC_MSG_REG5	0x18
>> +#define AM33XX_CONTROL_IPC_MSG_REG6	0x1c
>> +#define AM33XX_CONTROL_IPC_MSG_REG7	0x20

How about using a macro for these, especially given that the AM43xx has
a bit more registers.

>> +
> Is this driver going to be AM33xx specific ?
> 
>> +struct wkup_m3_rproc {
>> +	struct rproc *rproc;
>> +
>> +	void * __iomem dev_table_va;
>> +	void * __iomem ipc_mem_base;
>> +	struct platform_device *pdev;
>> +
>> +	struct mbox_client mbox_client;
>> +	struct mbox_chan *mbox;
>> +	struct wkup_m3_ops *ops;
>> +
>> +	bool is_active;
>> +};
>> +
>> +static struct wkup_m3_rproc *m3_rproc_static;
>> +
>> +static struct wkup_m3_wakeup_src wakeups[] = {
>> +	{.irq_nr = 35,	.src = "USB0_PHY"},
>> +	{.irq_nr = 36,	.src = "USB1_PHY"},
>> +	{.irq_nr = 40,	.src = "I2C0"},
>> +	{.irq_nr = 41,	.src = "RTC Timer"},
>> +	{.irq_nr = 42,	.src = "RTC Alarm"},
>> +	{.irq_nr = 43,	.src = "Timer0"},
>> +	{.irq_nr = 44,	.src = "Timer1"},
>> +	{.irq_nr = 45,	.src = "UART"},
>> +	{.irq_nr = 46,	.src = "GPIO0"},
>> +	{.irq_nr = 48,	.src = "MPU_WAKE"},
>> +	{.irq_nr = 49,	.src = "WDT0"},
>> +	{.irq_nr = 50,	.src = "WDT1"},
>> +	{.irq_nr = 51,	.src = "ADC_TSC"},
>> +	{.irq_nr = 0,	.src = "Unknown"},
>> +};

Is this table going to be same for AM43xx? If not, it is better to store
this as match data, so that a different table can easily be plugged in
based on compatible string.

>> +
> const ?
> 
>> +static void am33xx_txev_eoi(struct wkup_m3_rproc *m3_rproc)
>> +{
>> +	writel(AM33XX_M3_TXEV_ACK,
>> +	       m3_rproc->ipc_mem_base + AM33XX_CONTROL_M3_TXEV_EOI);
>> +}
>> +
>> +static void am33xx_txev_enable(struct wkup_m3_rproc *m3_rproc)
>> +{
>> +	writel(AM33XX_M3_TXEV_ENABLE,
>> +	       m3_rproc->ipc_mem_base + AM33XX_CONTROL_M3_TXEV_EOI);
>> +}
>> +
>> +static void wkup_m3_ctrl_ipc_write(struct wkup_m3_rproc *m3_rproc,
>> +				   struct wkup_m3_ipc_regs *ipc_regs)
>> +{
>> +	writel(ipc_regs->reg0,
>> +	       m3_rproc->ipc_mem_base + AM33XX_CONTROL_IPC_MSG_REG0);
>> +	writel(ipc_regs->reg1,
>> +	       m3_rproc->ipc_mem_base + AM33XX_CONTROL_IPC_MSG_REG1);
>> +	writel(ipc_regs->reg2,
>> +	       m3_rproc->ipc_mem_base + AM33XX_CONTROL_IPC_MSG_REG2);
>> +	writel(ipc_regs->reg3,
>> +	       m3_rproc->ipc_mem_base + AM33XX_CONTROL_IPC_MSG_REG3);
>> +	writel(ipc_regs->reg4,
>> +	       m3_rproc->ipc_mem_base + AM33XX_CONTROL_IPC_MSG_REG4);
>> +	writel(ipc_regs->reg5,
>> +	       m3_rproc->ipc_mem_base + AM33XX_CONTROL_IPC_MSG_REG5);
>> +	writel(ipc_regs->reg6,
>> +	       m3_rproc->ipc_mem_base + AM33XX_CONTROL_IPC_MSG_REG6);
>> +	writel(ipc_regs->reg7,
>> +	       m3_rproc->ipc_mem_base + AM33XX_CONTROL_IPC_MSG_REG7);

How about defining a static inline function for the read and write
operations?

>> +}
>> +
>> +static void wkup_m3_ctrl_ipc_read(struct wkup_m3_rproc *m3_rproc,
>> +				  struct wkup_m3_ipc_regs *ipc_regs)
>> +{
>> +	ipc_regs->reg0 = readl(m3_rproc->ipc_mem_base
>> +			       + AM33XX_CONTROL_IPC_MSG_REG0);
>> +	ipc_regs->reg1 = readl(m3_rproc->ipc_mem_base
>> +			       + AM33XX_CONTROL_IPC_MSG_REG1);
>> +	ipc_regs->reg2 = readl(m3_rproc->ipc_mem_base
>> +			       + AM33XX_CONTROL_IPC_MSG_REG2);
>> +	ipc_regs->reg3 = readl(m3_rproc->ipc_mem_base
>> +			       + AM33XX_CONTROL_IPC_MSG_REG3);
>> +	ipc_regs->reg4 = readl(m3_rproc->ipc_mem_base
>> +			       + AM33XX_CONTROL_IPC_MSG_REG4);
>> +	ipc_regs->reg5 = readl(m3_rproc->ipc_mem_base
>> +			       + AM33XX_CONTROL_IPC_MSG_REG5);
>> +	ipc_regs->reg6 = readl(m3_rproc->ipc_mem_base
>> +			       + AM33XX_CONTROL_IPC_MSG_REG6);
>> +	ipc_regs->reg7 = readl(m3_rproc->ipc_mem_base
>> +			       + AM33XX_CONTROL_IPC_MSG_REG7);
>> +}
>> +
>> +static irqreturn_t wkup_m3_txev_handler(int irq, void *unused)
>> +{
>> +	am33xx_txev_eoi(m3_rproc_static);
>> +
>> +	if (m3_rproc_static->ops && m3_rproc_static->ops->txev_handler)
>> +		m3_rproc_static->ops->txev_handler();
>> +
>> +	am33xx_txev_enable(m3_rproc_static);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +/**
>> + * wkup_m3_fw_version_clear - Clear FW version from ipc regs
>> + *
>> + * Invalidate M3 firmware version before hardreset.
>> + * Write invalid version in lower 4 nibbles of parameter
>> + * register (ipc_regs + 0x8).
>> + */
>> +
>> +static void wkup_m3_fw_version_clear(void)
>> +{
>> +	struct wkup_m3_ipc_regs ipc_regs;
>> +
>> +	wkup_m3_ctrl_ipc_read(m3_rproc_static, &ipc_regs);
>> +	ipc_regs.reg2 &= 0xFFFF0000;
> Probably define a macro and use it.
>> +	wkup_m3_ctrl_ipc_write(m3_rproc_static, &ipc_regs);
>> +}
>> +
>> +static void wkup_m3_mbox_callback(struct mbox_client *client, void *data)
>> +{
>> +	omap_mbox_disable_irq(m3_rproc_static->mbox, IRQ_RX);
>> +}
>> +
>> +static int wkup_m3_rproc_start(struct rproc *rproc)
>> +{
>> +	struct wkup_m3_rproc *m3_rproc = rproc->priv;
>> +	struct platform_device *pdev = m3_rproc->pdev;
>> +	struct device *dev = &pdev->dev;
>> +	struct wkup_m3_platform_data *pdata = dev->platform_data;
>> +	int ret;
>> +
>> +	wkup_m3_fw_version_clear();
>> +
>> +	if (pdata && pdata->deassert_reset) {
>> +		ret = pdata->deassert_reset(pdev, pdata->reset_name);
>> +		if (ret) {
>> +			dev_err(dev, "Unable to reset wkup_m3!\n");
>> +			return -ENODEV;
>> +		}
>> +	} else {
>> +		dev_err(dev, "Platform data missing deassert_reset!\n");
>> +		return -ENODEV;
>> +	}

You don't need a runtime check for this, check once in probe, this ops
is essential right?

>> +
>> +	m3_rproc->mbox_client.dev = dev;
>> +	m3_rproc->mbox_client.tx_done = NULL;
>> +	m3_rproc->mbox_client.rx_callback = wkup_m3_mbox_callback;
>> +	m3_rproc->mbox_client.tx_block = false;
>> +	m3_rproc->mbox_client.knows_txdone = false;
>> +
>> +	m3_rproc->mbox = mbox_request_channel(&m3_rproc->mbox_client);
>> +
nit, no need of an additional blank line

>> +	if (IS_ERR(m3_rproc->mbox)) {
>> +		dev_err(dev, "IPC Request for A8->M3 Channel failed!\n");
>> +		ret = PTR_ERR(m3_rproc->mbox);
>> +		m3_rproc->mbox = NULL;
>> +		return ret;
>> +	}
>> +
>> +	if (m3_rproc_static->ops && m3_rproc_static->ops->rproc_ready)
>> +		m3_rproc_static->ops->rproc_ready();
>> +
>> +	m3_rproc_static->is_active = 1;
>> +
>> +	return 0;
>> +}
>> +
>> +
>> +static int wkup_m3_rproc_stop(struct rproc *rproc)
>> +{
>> +	return 0;

Any reason this is a stub, don't you need to assert the reset in stop?

>> +}
>> +
>> +static void wkup_m3_rproc_kick(struct rproc *rproc, int vqid)
>> +{
>> +}

If you can remove this empty stub, please do so. I do not think we will
be using virtio for communicating with the WkupM3.

>> +
>> +static struct rproc_ops wkup_m3_rproc_ops = {
>> +	.start		= wkup_m3_rproc_start,
>> +	.stop		= wkup_m3_rproc_stop,
>> +	.kick		= wkup_m3_rproc_kick,
>> +};
>> +
>> +/* Public Functions */
>> +
>> +/**
>> + * wkup_m3_set_ops - Set callbacks for user of rproc
>> + * @ops - struct wkup_m3_ops *
>> + *
>> + * Registers callbacks to wkup_m3 to be invoked after rproc is ready to use
>> + * and after an interrupt is handled.
>> + */
>> +void wkup_m3_set_ops(struct wkup_m3_ops *ops)
>> +{
>> +	m3_rproc_static->ops = ops;
>> +
>> +	if (m3_rproc_static->is_active && m3_rproc_static->ops &&
>> +	    m3_rproc_static->ops->rproc_ready)
>> +		m3_rproc_static->ops->rproc_ready();
>> +}



>> +
>> +/**
>> + * wkup_m3_ping - Send a dummy msg to wkup_m3 to tell to to check IPC regs
>> + *
>> + * Returns the result of sending mbox msg or -EIO if no mbox handle is present
>> + */
>> +int wkup_m3_ping(void)
>> +{
>> +	int ret;
>> +	mbox_msg_t dummy_msg = 0;
>> +
>> +	if (!m3_rproc_static->mbox) {
>> +		dev_err(&m3_rproc_static->pdev->dev,
>> +			"No IPC channel to communicate with wkup_m3!\n");
>> +		return -EIO;
>> +	}
>> +
>> +	/*
>> +	 * Write a dummy message to the mailbox in order to trigger the RX
>> +	 * interrupt to alert the M3 that data is available in the IPC
>> +	 * registers. We must enable the IRQ here and disable it after in
>> +	 * the RX callback to avoid multiple interrupts being received
>> +	 * by the CM3.
>> +	 */
>> +	omap_mbox_enable_irq(m3_rproc_static->mbox, IRQ_RX);
>> +	ret = mbox_send_message(m3_rproc_static->mbox, (void *)dummy_msg);
>> +
nit, no need of an additional blank line

>> +	if (ret < 0) {
>> +		pr_err("%s: mbox_send_message() failed: %d\n", __func__, ret);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * wkup_m3_wake_src - Get the wakeup source info passed from wkup_m3
>> + * @wkup_m3_wakeup: struct wkup_m3_wakeup_src * gets assigned the
>> + *		    wakeup src value
>> + */
>> +void wkup_m3_wake_src(struct wkup_m3_wakeup_src *wkup_m3_wakeup)
>> +{
>> +	struct wkup_m3_ipc_regs ipc_regs;
>> +	unsigned int wakeup_src_idx;
>> +	int j;
>> +
>> +	wkup_m3_ctrl_ipc_read(m3_rproc_static, &ipc_regs);
>> +
>> +	wakeup_src_idx = ipc_regs.reg6 & WKUP_M3_WAKE_SRC_MASK;
>> +
>> +	for (j = 0; j < ARRAY_SIZE(wakeups)-1; j++) {
>> +		if (wakeups[j].irq_nr == wakeup_src_idx) {
>> +			*wkup_m3_wakeup = wakeups[j];
>> +			return;
>> +		}
>> +	}
>> +	*wkup_m3_wakeup = wakeups[j];
>> +}
>> +
>> +/**
>> + * wkup_m3_pm_status - Return the status code from wkup_m3 after sleep event
>> + *
>> + * Returns an error code that indicates whether or not the dsired sleep
>> + * action was a success or not.
>> + */
>> +int wkup_m3_pm_status(void)
>> +{
>> +	unsigned int i;
>> +	struct wkup_m3_ipc_regs ipc_regs;
>> +
>> +	wkup_m3_ctrl_ipc_read(m3_rproc_static, &ipc_regs);

Do you need to read back all the registers, given that this is a local
structure anyway?

>> +
>> +	i = WKUP_M3_STATUS_RESP_MASK & ipc_regs.reg1;
>> +	i >>= __ffs(WKUP_M3_STATUS_RESP_MASK);
>> +
>> +	return i;
>> +}
>> +
>> +/**
>> + * wkup_m3_fw_version_read - Return the fw version given by the wkup_m3
>> + *
>> + * After boot the fw version should be read to ensure it is compatible.
>> + */
>> +int wkup_m3_fw_version_read(void)
>> +{
>> +	struct wkup_m3_ipc_regs ipc_regs;
>> +
>> +	wkup_m3_ctrl_ipc_read(m3_rproc_static, &ipc_regs);
>> +
>> +	return ipc_regs.reg2 & WKUP_M3_FW_VERSION_MASK;
>> +}
>> +
>> +/**
>> + * wkup_m3_set_cmd - write contents of struct to ipc regs
>> + * @ipc_regs: struct wkup_m3_ipc_regs *
>> + */
>> +void wkup_m3_set_cmd(struct wkup_m3_ipc_regs *ipc_regs)
>> +{
>> +	wkup_m3_ctrl_ipc_write(m3_rproc_static, ipc_regs);
>> +}
>> +
>> +static void wkup_m3_rproc_loader_thread(struct rproc *rproc)
>> +{
>> +	struct wkup_m3_rproc *m3_rproc = rproc->priv;
>> +	struct device *dev = &m3_rproc->pdev->dev;
>> +	int ret;
>> +
>> +	wait_for_completion(&rproc->firmware_loading_complete);
>> +
>> +	ret = rproc_boot(rproc);
>> +	if (ret)
>> +		dev_err(dev, "rproc_boot failed\n");
>> +
>> +	do_exit(0);
>> +}
>> +
>> +static int wkup_m3_rproc_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct device_node *np = pdev->dev.of_node;
>> +	struct wkup_m3_rproc *m3_rproc;
>> +	struct rproc *rproc;
>> +	int irq, ret;
>> +	struct resource *res;
>> +	struct task_struct *task;
>> +	const char *mbox_name;
>> +
>> +	pm_runtime_enable(&pdev->dev);
>> +
>> +	ret = pm_runtime_get_sync(&pdev->dev);
>> +	if (IS_ERR_VALUE(ret)) {
>> +		dev_err(&pdev->dev, "pm_runtime_get_sync() failed\n");
>> +		return ret;
>> +	}
>> +
>> +	rproc = rproc_alloc(dev, "wkup_m3", &wkup_m3_rproc_ops,
>> +			    "am335x-pm-firmware.elf", sizeof(*m3_rproc));
>> +	if (!rproc)
>> +		return -ENOMEM;
>> +
>> +	m3_rproc = rproc->priv;
>> +	m3_rproc->rproc = rproc;
>> +	m3_rproc->pdev = pdev;
>> +
>> +	m3_rproc_static = m3_rproc;
>> +
>> +	irq = platform_get_irq(pdev, 0);
>> +	if (!irq) {
>> +		dev_err(&pdev->dev, "no irq resource\n");
>> +		ret = -ENXIO;
>> +		goto err;
>> +	}

Colocate this to the same place as the request_irq.

>> +
>> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ipc_regs");
>> +	if (!res) {

No need to check for error, the devm function following this should take
care of any errors.

>> +		dev_err(&pdev->dev, "no memory resource for ipc\n");
>> +		ret = -ENXIO;
>> +		goto err;
>> +	}
>> +
>> +	m3_rproc->ipc_mem_base = devm_request_and_ioremap(dev, res);

Is some one else doing an ioremap of this space, otherwise
devm_ioremap_resource is preferred.

>> +	if (!m3_rproc->ipc_mem_base) {
>> +		dev_err(dev, "could not ioremap ipc_mem\n");
>> +		ret = -EADDRNOTAVAIL;
>> +		goto err;
>> +	}

Don't you need to be retrieving umem and dmem?


>> +
>> +	ret = devm_request_irq(dev, irq, wkup_m3_txev_handler,
>> +			       IRQF_DISABLED, "wkup_m3_txev", m3_rproc);
>> +	if (ret) {
>> +		dev_err(dev, "request_irq failed\n");
>> +		goto err;
>> +	}
>> +
>> +	/* Get mbox name from device tree node */
>> +	ret = of_property_read_string(np, "mbox-names", &mbox_name);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "Unable to get mbox name from dt node: %d\n",
>> +			ret);
>> +			goto err;
>> +	};
>> +
>> +	m3_rproc->mbox_client.chan_name = mbox_name;
>> +
>> +	/* Register as a remoteproc device */
>> +	ret = rproc_add(rproc);
>> +	if (ret) {
>> +		dev_err(dev, "rproc_add failed\n");
>> +		goto err;
>> +	}
>> +
>> +	/*
>> +	 * Wait for firmware loading completion in a thread so we
>> +	 * can boot the wkup_m3 as soon as it's ready without holding
>> +	 * up kernel boot
>> +	 */
>> +	task = kthread_run((void *)wkup_m3_rproc_loader_thread, rproc,
>> +			   "wkup_m3_rproc_loader");
>> +
>> +	if (IS_ERR(task)) {
>> +		dev_err(dev, "can't create rproc_loader thread\n");
>> +		goto err;
>> +	}
>> +
>> +	return 0;
>> +
>> +err:
>> +	rproc_put(rproc);
> pm_runtime_put_sync() ?
>> +	return ret;
>> +}
>> +
>> +static int wkup_m3_rproc_remove(struct platform_device *pdev)
>> +{
>> +	struct rproc *rproc = platform_get_drvdata(pdev);
>> +
>> +	rproc_del(rproc);
>> +	rproc_put(rproc);

Need to reset m3_rproc_static?

>> +
> Here too ?
>> +	return 0;
>> +}
>> +
>> +static int wkup_m3_rpm_suspend(struct device *dev)
>> +{
>> +	return -EBUSY;
>> +}
>> +
>> +static int wkup_m3_rpm_resume(struct device *dev)
>> +{
>> +	return 0;
>> +}
>> +
> If you are not doing any meaningfull in suspend/resume hooks,
> why are you even registering them ?
> 
>> +static const struct dev_pm_ops wkup_m3_rproc_pm_ops = {
>> +	SET_RUNTIME_PM_OPS(wkup_m3_rpm_suspend, wkup_m3_rpm_resume, NULL)
>> +};
>> +
>> +static const struct of_device_id wkup_m3_rproc_of_match[] = {
>> +	{ .compatible = "ti,am3353-wkup-m3", .data = NULL, },
>> +	{},
>> +};
>> +
>> +static struct platform_driver wkup_m3_rproc_driver = {
>> +	.probe = wkup_m3_rproc_probe,
>> +	.remove = wkup_m3_rproc_remove,
>> +	.driver = {
>> +		.name = "wkup_m3",
>> +		.owner = THIS_MODULE,
>> +		.of_match_table = wkup_m3_rproc_of_match,
>> +		.pm = &wkup_m3_rproc_pm_ops,
>> +	},
>> +};
>> +
>> +module_platform_driver(wkup_m3_rproc_driver);
>> +
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_DESCRIPTION("wkup m3 remote processor control driver");
>> diff --git a/include/linux/wkup_m3.h b/include/linux/wkup_m3.h
>> new file mode 100644
>> index 0000000..1a2237f
>> --- /dev/null
>> +++ b/include/linux/wkup_m3.h
>> @@ -0,0 +1,71 @@
>> +/*
>> + * TI Wakeup M3 Power Management Routines

Suggest adding for AMx3x SoCs

>> + *
>> + * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
>> + * Dave Gerlach <d-gerlach@ti.com>
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License as
>> + * published by the Free Software Foundation version 2.
>> + *
>> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
>> + * kind, whether express or implied; without even the implied warranty
>> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#ifndef _LINUX_WKUP_M3_H
>> +#define _LINUX_WKUP_M3_H
>> +
>> +/**
>> + * struct wkup_m3_ops - Callbacks for allowing pm code to interact with wkup_m3.
>> + *
>> + * @txev_handler: Callback to allow pm code to react to response from wkup_m3
>> + *		  after pinging it using wkup_m3_ping.
>> + *
>> + * @firmware_loaded: Callback invoked when the firmware has been loaded to the
>> + *		     m3 to allow the pm code to enable suspend/resume ops.

firmware_loaded ops does not exist

>> + */
>> +
>> +struct wkup_m3_ops {
>> +	void (*txev_handler)(void);
>> +	void (*rproc_ready)(void);
>> +};
>> +
>> +struct wkup_m3_wakeup_src {
>> +	int irq_nr;
>> +	char src[10];

What is the @src used for, debug? Don't see anywhere this is getting used.

regards
Suman

>> +};
>> +
>> +struct wkup_m3_ipc_regs {
>> +	u32 reg0;
>> +	u32 reg1;
>> +	u32 reg2;
>> +	u32 reg3;
>> +	u32 reg4;
>> +	u32 reg5;
>> +	u32 reg6;
>> +	u32 reg7;
>> +};
>> +
>> +#ifdef CONFIG_WKUP_M3_RPROC
>> +int wkup_m3_prepare(void);
>> +void wkup_m3_set_ops(struct wkup_m3_ops *ops);
>> +int wkup_m3_ping(void);
>> +void wkup_m3_wake_src(struct wkup_m3_wakeup_src *wakeup_src);
>> +int wkup_m3_pm_status(void);
>> +int wkup_m3_is_valid(void);
>> +int wkup_m3_fw_version_read(void);
>> +void wkup_m3_set_cmd(struct wkup_m3_ipc_regs *ipc_regs);
>> +
>> +#else
>> +
>> +int wkup_m3_prepare(void) { return -EINVAL; }
>> +void wkup_m3_set_ops(struct wkup_m3_ops *ops) { }
>> +int wkup_m3_ping(void) { return -EINVAL }
>> +void wkup_m3_wake_src(struct wkup_m3_wakeup_src *wakeup_src) { }
>> +int wkup_m3_pm_status(void) { return -1; }
>> +int wkup_m3_fw_version_read(void) { return -1; }
>> +void wkup_m3_set_cmd(struct wkup_m3_ipc_regs *ipc_regs) { }
> 
> Mark all of above in else as static inline.
> 
>> +#endif /* CONFIG_WKUP_M3_RPROC */
>> +#endif /* _LINUX_WKUP_M3_H */
>>
> 

