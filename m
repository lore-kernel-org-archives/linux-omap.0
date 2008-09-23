From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.27-rc6-omap 1/2] twl4030: new-style driver
	conversion
Date: Tue, 23 Sep 2008 13:55:20 +0300
Message-ID: <20080923105519.GJ5102@atomide.com>
References: <200809211408.47196.david-b@pacbell.net> <20080922112617.GN24627@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:65057 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166AbYIWKz1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Sep 2008 06:55:27 -0400
Content-Disposition: inline
In-Reply-To: <20080922112617.GN24627@gandalf.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: ext David Brownell <david-b@pacbell.net>, linux-omap@vger.kernel.org

* Felipe Balbi <felipe.balbi@nokia.com> [080922 14:29]:
> On Sun, Sep 21, 2008 at 02:08:47PM -0700, David Brownell wrote:
> > More updates preparing for upstream merge of twl4030 driver:
> > 
> >  Basic fixes
> >    -	twl4030-core becomes a new-style I2C driver
> >    -	declare and use platform_data structure for that core
> >    -	stop hard-wiring the irq numbers
> >    -	check functionality that's really used:  I2C, not SMBus
> >  Cleanup:
> >    -	remove needless "client string"
> >    -	remove some fake "bool" types
> >    -	include catalog part numbers (TPS659{5,3,2}0)
> >    -	diagnostics should identify the driver!
> > 
> > To use this, all boards with these chips will need to declare this chip
> > when they declare their active I2C busses (done in a separate patch).
> > 
> > NOTE:  the TWL4030_IRQ_* symbols still need to vanish, along with other 
> > global resource assignments associated with these chips.
> > 
> > Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> 
> uuuu, great :-)
> 
> Thanks a lot Dave, we're getting there :-D
> 
> Hopefully twl can make its way to mainline before 2.6.29 ;-)

Great, pushing.

Tony

> 
> > ---
> >  drivers/i2c/chips/twl4030-core.c |  308 ++++++++++++++++---------------------
> >  include/linux/i2c/twl4030.h      |   11 +
> >  2 files changed, 145 insertions(+), 174 deletions(-)
> > 
> > --- a/drivers/i2c/chips/twl4030-core.c
> > +++ b/drivers/i2c/chips/twl4030-core.c
> > @@ -1,5 +1,5 @@
> >  /*
> > - * twl4030_core.c - driver for TWL4030 PM and audio CODEC device
> > + * twl4030_core.c - driver for TWL4030/TPS659x0 PM and audio CODEC devices
> >   *
> >   * Copyright (C) 2005-2006 Texas Instruments, Inc.
> >   *
> > @@ -56,14 +56,6 @@
> >  
> >  #define DRIVER_NAME			"twl4030"
> >  
> > -/* Macro Definitions */
> > -#define TWL_CLIENT_STRING		"TWL4030-ID"
> > -#define TWL_CLIENT_USED			1
> > -#define TWL_CLIENT_FREE			0
> > -
> > -/* IRQ Flags */
> > -#define FREE				0
> > -#define USED				1
> >  
> >  /* Primary Interrupt Handler on TWL4030 Registers */
> >  
> > @@ -293,26 +285,18 @@ static const struct twl4030_mod_iregs __
> >  
> >  
> >  /* Helper functions */
> > -static int
> > -twl4030_detect_client(struct i2c_adapter *adapter, unsigned char sid);
> > -static int twl4030_attach_adapter(struct i2c_adapter *adapter);
> > -static int twl4030_detach_client(struct i2c_client *client);
> >  static void do_twl4030_irq(unsigned int irq, irq_desc_t *desc);
> >  
> > -static void twl_init_irq(void);
> > -
> >  /* Data Structures */
> >  /* To have info on T2 IRQ substem activated or not */
> > -static unsigned char twl_irq_used = FREE;
> >  static struct completion irq_event;
> >  
> >  /* Structure to define on TWL4030 Slave ID */
> >  struct twl4030_client {
> > -	struct i2c_client client;
> > -	const char client_name[sizeof(TWL_CLIENT_STRING) + 1];
> > +	struct i2c_client *client;
> >  	const unsigned char address;
> >  	const char adapter_index;
> > -	unsigned char inuse;
> > +	bool inuse;
> >  
> >  	/* max numb of i2c_msg required is for read =2 */
> >  	struct i2c_msg xfer_msg[2];
> > @@ -356,36 +340,22 @@ static struct twl4030mapping twl4030_map
> >  static struct twl4030_client twl4030_modules[TWL4030_NUM_SLAVES] = {
> >  	{
> >  		.address	= TWL4030_SLAVEID_ID0,
> > -		.client_name	= TWL_CLIENT_STRING "0",
> >  		.adapter_index	= CONFIG_I2C_TWL4030_ID,
> >  	},
> >  	{
> >  		.address	= TWL4030_SLAVEID_ID1,
> > -		.client_name	= TWL_CLIENT_STRING "1",
> >  		.adapter_index	= CONFIG_I2C_TWL4030_ID,
> >  	},
> >  	{
> >  		.address	= TWL4030_SLAVEID_ID2,
> > -		.client_name	= TWL_CLIENT_STRING "2",
> >  		.adapter_index	= CONFIG_I2C_TWL4030_ID,
> >  	},
> >  	{
> >  		.address	= TWL4030_SLAVEID_ID3,
> > -		.client_name	= TWL_CLIENT_STRING "3",
> >  		.adapter_index	= CONFIG_I2C_TWL4030_ID,
> >  	},
> >  };
> >  
> > -/* One Client Driver , 4 Clients */
> > -static struct i2c_driver twl4030_driver = {
> > -	.driver	= {
> > -		.name	= DRIVER_NAME,
> > -		.owner	= THIS_MODULE,
> > -	},
> > -	.attach_adapter	= twl4030_attach_adapter,
> > -	.detach_client	= twl4030_detach_client,
> > -};
> > -
> >  /*
> >   * TWL4030 doesn't have PIH mask, hence dummy function for mask
> >   * and unmask.
> > @@ -425,15 +395,14 @@ int twl4030_i2c_write(u8 mod_no, u8 *val
> >  	struct i2c_msg *msg;
> >  
> >  	if (unlikely(mod_no > TWL4030_MODULE_LAST)) {
> > -		pr_err("Invalid module Number\n");
> > +		pr_err("%s: invalid module number %d\n", DRIVER_NAME, mod_no);
> >  		return -EPERM;
> >  	}
> >  	sid = twl4030_map[mod_no].sid;
> >  	twl = &twl4030_modules[sid];
> >  
> > -	if (unlikely(twl->inuse != TWL_CLIENT_USED)) {
> > -		pr_err("I2C Client[%d] is not initialized[%d]\n",
> > -		       sid, __LINE__);
> > +	if (unlikely(!twl->inuse)) {
> > +		pr_err("%s: client %d is not initialized\n", DRIVER_NAME, sid);
> >  		return -EPERM;
> >  	}
> >  	mutex_lock(&twl->xfer_lock);
> > @@ -448,7 +417,7 @@ int twl4030_i2c_write(u8 mod_no, u8 *val
> >  	msg->buf = value;
> >  	/* over write the first byte of buffer with the register address */
> >  	*value = twl4030_map[mod_no].base + reg;
> > -	ret = i2c_transfer(twl->client.adapter, twl->xfer_msg, 1);
> > +	ret = i2c_transfer(twl->client->adapter, twl->xfer_msg, 1);
> >  	mutex_unlock(&twl->xfer_lock);
> >  
> >  	/* i2cTransfer returns num messages.translate it pls.. */
> > @@ -476,15 +445,14 @@ int twl4030_i2c_read(u8 mod_no, u8 *valu
> >  	struct i2c_msg *msg;
> >  
> >  	if (unlikely(mod_no > TWL4030_MODULE_LAST)) {
> > -		pr_err("Invalid module Number\n");
> > +		pr_err("%s: invalid module number %d\n", DRIVER_NAME, mod_no);
> >  		return -EPERM;
> >  	}
> >  	sid = twl4030_map[mod_no].sid;
> >  	twl = &twl4030_modules[sid];
> >  
> > -	if (unlikely(twl->inuse != TWL_CLIENT_USED)) {
> > -		pr_err("I2C Client[%d] is not initialized[%d]\n", sid,
> > -		       __LINE__);
> > +	if (unlikely(!twl->inuse)) {
> > +		pr_err("%s: client %d is not initialized\n", DRIVER_NAME, sid);
> >  		return -EPERM;
> >  	}
> >  	mutex_lock(&twl->xfer_lock);
> > @@ -501,7 +469,7 @@ int twl4030_i2c_read(u8 mod_no, u8 *valu
> >  	msg->flags = I2C_M_RD;	/* Read the register value */
> >  	msg->len = num_bytes;	/* only n bytes */
> >  	msg->buf = value;
> > -	ret = i2c_transfer(twl->client.adapter, twl->xfer_msg, 2);
> > +	ret = i2c_transfer(twl->client->adapter, twl->xfer_msg, 2);
> >  	mutex_unlock(&twl->xfer_lock);
> >  
> >  	/* i2cTransfer returns num messages.translate it pls.. */
> > @@ -608,6 +576,8 @@ static void do_twl4030_module_irq(unsign
> >  				" be masked!\n", irq);
> >  }
> >  
> > +static unsigned twl4030_irq_base;
> > +
> >  /*
> >   * twl4030_irq_thread() runs as a kernel thread.  It queries the twl4030
> >   * interrupt controller to see which modules are generating interrupt requests
> > @@ -644,7 +614,7 @@ static int twl4030_irq_thread(void *data
> >  			continue;
> >  		}
> >  
> > -		for (module_irq = TWL4030_IRQ_BASE; 0 != pih_isr;
> > +		for (module_irq = twl4030_irq_base; 0 != pih_isr;
> >  			 pih_isr >>= 1, module_irq++) {
> >  			if (pih_isr & 0x1) {
> >  				irq_desc_t *d = irq_desc + module_irq;
> > @@ -693,78 +663,17 @@ static void do_twl4030_irq(unsigned int 
> >  	}
> >  }
> >  
> > -/* attach a client to the adapter */
> > -static int __init twl4030_detect_client(struct i2c_adapter *adapter,
> > -					unsigned char sid)
> > -{
> > -	int err = 0;
> > -	struct twl4030_client *twl;
> > -
> > -	if (unlikely(sid >= TWL4030_NUM_SLAVES)) {
> > -		pr_err("sid[%d] > MOD_LAST[%d]\n", sid, TWL4030_NUM_SLAVES);
> > -		return -EPERM;
> > -	}
> > -
> > -	/* Check basic functionality */
> > -	err = i2c_check_functionality(adapter,
> > -			I2C_FUNC_SMBUS_WORD_DATA
> > -			| I2C_FUNC_SMBUS_WRITE_BYTE);
> > -	if (!err) {
> > -		pr_err("SlaveID=%d functionality check failed\n", sid);
> > -		return err;
> > -	}
> > -	twl = &twl4030_modules[sid];
> > -	if (unlikely(twl->inuse)) {
> > -		pr_err("Client %s is already in use\n", twl->client_name);
> > -		return -EPERM;
> > -	}
> > -
> > -	memset(&twl->client, 0, sizeof(struct i2c_client));
> > -
> > -	twl->client.addr	= twl->address;
> > -	twl->client.adapter	= adapter;
> > -	twl->client.driver	= &twl4030_driver;
> > -
> > -	memcpy(&twl->client.name, twl->client_name,
> > -			sizeof(TWL_CLIENT_STRING) + 1);
> > -
> > -	pr_info("TWL4030: TRY attach Slave %s on Adapter %s [%x]\n",
> > -				twl->client_name, adapter->name, err);
> > -
> > -	err = i2c_attach_client(&twl->client);
> > -	if (err) {
> > -		pr_err("Couldn't attach Slave %s on Adapter"
> > -		       "%s [%x]\n", twl->client_name, adapter->name, err);
> > -	} else {
> > -		twl->inuse = TWL_CLIENT_USED;
> > -		mutex_init(&twl->xfer_lock);
> > -	}
> > -
> > -	return err;
> > -}
> > -
> > -static int add_children(void)
> > +static int add_children(struct twl4030_platform_data *pdata)
> >  {
> > -	static bool		children;
> > -
> >  	struct platform_device	*pdev = NULL;
> >  	struct twl4030_client	*twl = NULL;
> >  	int			status = 0;
> >  
> > -	/* FIXME this doesn't yet set up platform_data for anything;
> > -	 * it can't be available until this becomes a "new style"
> > -	 * I2C driver.  Similarly, a new style driver will know it
> > -	 * didn't already initialize its children.
> > -	 */
> > -
> > -	if (children)
> > -		return 0;
> > -
> >  #ifdef CONFIG_RTC_DRV_TWL4030
> >  	pdev = platform_device_alloc("twl4030_rtc", -1);
> >  	if (pdev) {
> >  		twl = &twl4030_modules[TWL4030_SLAVENUM_NUM3];
> > -		pdev->dev.parent = &twl->client.dev;
> > +		pdev->dev.parent = &twl->client->dev;
> >  		device_init_wakeup(&pdev->dev, 1);
> >  
> >  		/*
> > @@ -788,66 +697,9 @@ static int add_children(void)
> >  		status = -ENOMEM;
> >  #endif
> >  
> > -	children = true;
> >  	return status;
> >  }
> >  
> > -/* adapter callback */
> > -static int __init twl4030_attach_adapter(struct i2c_adapter *adapter)
> > -{
> > -	int i;
> > -	int ret = 0;
> > -	static int twl_i2c_adapter = 1;
> > -
> > -	for (i = 0; i < TWL4030_NUM_SLAVES; i++) {
> > -		/* Check if I need to hook on to this adapter or not */
> > -		if (twl4030_modules[i].adapter_index == twl_i2c_adapter) {
> > -			ret = twl4030_detect_client(adapter, i);
> > -			if (ret)
> > -				goto free_client;
> > -		}
> > -	}
> > -	twl_i2c_adapter++;
> > -
> > -	add_children();
> > -
> > -	/*
> > -	 * Check if the PIH module is initialized, if yes, then init
> > -	 * the T2 Interrupt subsystem
> > -	 */
> > -	if ((twl4030_modules[twl4030_map[TWL4030_MODULE_PIH].sid].inuse ==
> > -		TWL_CLIENT_USED) && (twl_irq_used != USED)) {
> > -		twl_init_irq();
> > -		twl_irq_used = USED;
> > -	}
> > -	return 0;
> > -
> > -free_client:
> > -	pr_err("TWL_CLIENT(Idx=%d] registration failed[0x%x]\n", i, ret);
> > -
> > -	/* ignore current slave..it never got registered */
> > -	i--;
> > -	while (i >= 0) {
> > -		/* now remove all those from the current adapter... */
> > -		if (twl4030_modules[i].adapter_index == twl_i2c_adapter)
> > -			(void)twl4030_detach_client(&twl4030_modules[i].client);
> > -		i--;
> > -	}
> > -	return ret;
> > -}
> > -
> > -/* adapter's callback */
> > -static int twl4030_detach_client(struct i2c_client *client)
> > -{
> > -	int err;
> > -	err = i2c_detach_client(client);
> > -	if (err) {
> > -		pr_err("Client detach failed\n");
> > -		return err;
> > -	}
> > -	return 0;
> > -}
> > -
> >  static struct task_struct * __init start_twl4030_irq_thread(int irq)
> >  {
> >  	struct task_struct *thread;
> > @@ -1005,12 +857,11 @@ static void __init twl4030_mask_clear_in
> >  }
> >  
> >  
> > -static void twl_init_irq(void)
> > +static void twl_init_irq(int irq_num, unsigned irq_base, unsigned irq_end)
> >  {
> >  	int	i;
> >  	int	res = 0;
> >  	char	*msg = "Unable to register interrupt subsystem";
> > -	unsigned int irq_num;
> >  
> >  	/*
> >  	 * Mask and clear all TWL4030 interrupts since initially we do
> > @@ -1019,15 +870,15 @@ static void twl_init_irq(void)
> >  	twl4030_mask_clear_intrs(twl4030_mod_regs,
> >  				 ARRAY_SIZE(twl4030_mod_regs));
> >  
> > +	twl4030_irq_base = irq_base;
> > +
> >  	/* install an irq handler for each of the PIH modules */
> > -	for (i = TWL4030_IRQ_BASE; i < TWL4030_IRQ_END; i++) {
> > +	for (i = irq_base; i < irq_end; i++) {
> >  		set_irq_chip(i, &twl4030_irq_chip);
> >  		set_irq_handler(i, do_twl4030_module_irq);
> >  		set_irq_flags(i, IRQF_VALID);
> >  	}
> >  
> > -	irq_num = (cpu_is_omap2430()) ? INT_24XX_SYS_NIRQ : INT_34XX_SYS_NIRQ;
> > -
> >  	/* install an irq handler to demultiplex the TWL4030 interrupt */
> >  	set_irq_data(irq_num, start_twl4030_irq_thread(irq_num));
> >  	set_irq_type(irq_num, IRQ_TYPE_EDGE_FALLING);
> > @@ -1035,24 +886,133 @@ static void twl_init_irq(void)
> >  
> >  	res = power_companion_init();
> >  	if (res < 0)
> > -		pr_err("%s[%d][%d]\n", msg, res, __LINE__);
> > +		pr_err("%s: %s[%d]\n", DRIVER_NAME, msg, res);
> > +}
> > +
> > +/*----------------------------------------------------------------------*/
> > +
> > +static int twl4030_remove(struct i2c_client *client)
> > +{
> > +	unsigned i;
> > +
> > +	/* FIXME undo twl_init_irq() */
> > +	if (twl4030_irq_base) {
> > +		dev_err(&client->dev, "can't yet clean up IRQs?\n");
> > +		return -ENOSYS;
> > +	}
> > +
> > +	for (i = 0; i < TWL4030_NUM_SLAVES; i++) {
> > +		struct twl4030_client	*twl = &twl4030_modules[i];
> > +
> > +		if (twl->client && twl->client != client)
> > +			i2c_unregister_device(twl->client);
> > +		twl4030_modules[i].client = NULL;
> > +		twl4030_modules[i].inuse = false;
> > +	}
> > +	return 0;
> > +}
> > +
> > +/* NOTE:  this driver only handles a single twl4030/tps659x0 chip */
> > +static int
> > +twl4030_probe(struct i2c_client *client, const struct i2c_device_id *id)
> > +{
> > +	int				status;
> > +	unsigned			i;
> > +	struct twl4030_platform_data	*pdata = client->dev.platform_data;
> > +
> > +	if (!pdata) {
> > +		dev_dbg(&client->dev, "no platform data?\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C) == 0) {
> > +		dev_dbg(&client->dev, "can't talk I2C?\n");
> > +		return -EIO;
> > +	}
> > +
> > +	for (i = 0; i < TWL4030_NUM_SLAVES; i++) {
> > +		if (twl4030_modules[i].inuse || twl4030_irq_base) {
> > +			dev_dbg(&client->dev, "driver is already in use\n");
> > +			return -EBUSY;
> > +		}
> > +	}
> > +
> > +	for (i = 0; i < TWL4030_NUM_SLAVES; i++) {
> > +		struct twl4030_client	*twl = &twl4030_modules[i];
> > +
> > +		if (i == 0)
> > +			twl->client = client;
> > +		else {
> > +			twl->client = i2c_new_dummy(client->adapter,
> > +					twl->address);
> > +			if (!twl->client) {
> > +				dev_err(&twl->client->dev,
> > +					"can't attach client %d\n", i);
> > +				status = -ENOMEM;
> > +				goto fail;
> > +			}
> > +			strlcpy(twl->client->name, id->name,
> > +					sizeof(twl->client->name));
> > +		}
> > +		twl->inuse = true;
> > +		mutex_init(&twl->xfer_lock);
> > +	}
> > +
> > +	status = add_children(pdata);
> > +	if (status < 0)
> > +		goto fail;
> > +
> > +	/*
> > +	 * Check if the PIH module is initialized, if yes, then init
> > +	 * the T2 Interrupt subsystem
> > +	 */
> > +	if (twl4030_modules[twl4030_map[TWL4030_MODULE_PIH].sid].inuse
> > +			&& twl4030_irq_base == 0
> > +			&& client->irq
> > +			&& pdata->irq_base
> > +			&& pdata->irq_end > pdata->irq_base)
> > +		twl_init_irq(client->irq, pdata->irq_base, pdata->irq_end);
> > +
> > +	dev_info(&client->dev, "chaining %d irqs\n",
> > +			twl4030_irq_base
> > +				? (pdata->irq_end - pdata->irq_base)
> > +				: 0);
> > +	return 0;
> > +
> > +fail:
> > +	twl4030_remove(client);
> > +	return status;
> >  }
> >  
> > +static const struct i2c_device_id twl4030_ids[] = {
> > +	{ "twl4030", 0 },	/* "Triton 2" */
> > +	{ "tps65950", 0 },	/* catalog version of twl4030 */
> > +	{ "tps65930", 0 },	/* fewer LDOs and DACs; no charger */
> > +	{ "tps65920", 0 },	/* fewer LDOs; no codec or charger */
> > +	{ /* end of list */ },
> > +};
> > +MODULE_DEVICE_TABLE(i2c, twl4030_ids);
> > +
> > +/* One Client Driver , 4 Clients */
> > +static struct i2c_driver twl4030_driver = {
> > +	.driver.name	= DRIVER_NAME,
> > +	.id_table	= twl4030_ids,
> > +	.probe		= twl4030_probe,
> > +	.remove		= twl4030_remove,
> > +};
> > +
> >  static int __init twl4030_init(void)
> >  {
> >  	return i2c_add_driver(&twl4030_driver);
> >  }
> > +subsys_initcall(twl4030_init);
> >  
> >  static void __exit twl4030_exit(void)
> >  {
> >  	i2c_del_driver(&twl4030_driver);
> > -	twl_irq_used = FREE;
> >  }
> > -
> > -subsys_initcall(twl4030_init);
> >  module_exit(twl4030_exit);
> >  
> > -MODULE_ALIAS("i2c:" DRIVER_NAME);
> >  MODULE_AUTHOR("Texas Instruments, Inc.");
> >  MODULE_DESCRIPTION("I2C Core interface for TWL4030");
> >  MODULE_LICENSE("GPL");
> > --- a/include/linux/i2c/twl4030.h
> > +++ b/include/linux/i2c/twl4030.h
> > @@ -52,6 +52,17 @@
> >  #define TWL4030_MODULE_RTC		0x14
> >  #define TWL4030_MODULE_SECURED_REG	0x15
> >  
> > +struct twl4030_platform_data {
> > +	unsigned	irq_base, irq_end;
> > +
> > +	/* REVISIT more to come ... _nothing_ should be hard-wired */
> > +};
> > +
> > +/*
> > + * FIXME completely stop using TWL4030_IRQ_BASE ... instead, pass the
> > + * IRQ data to subsidiary devices using platform device resources.
> > + */
> > +
> >  /* IRQ information-need base */
> >  #include <mach/irqs.h>
> >  /* TWL4030 interrupts */
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> -- 
> balbi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
