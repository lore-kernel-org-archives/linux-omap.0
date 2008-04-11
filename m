From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH 01/23] I2C: TWL4030: checkpatch.pl fixes for twl4030-core.c
Date: Fri, 11 Apr 2008 14:23:05 +0530
Message-ID: <010C7BAE6783F34D9AC336EE5A01A08805D6500C@dbde01.ent.ti.com>
References: <1207902516-6374-1-git-send-email-felipe.balbi@nokia.com> <1207902516-6374-2-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56455 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758030AbYDKIzU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Apr 2008 04:55:20 -0400
Content-class: urn:content-classes:message
In-Reply-To: <1207902516-6374-2-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Felipe Balbi
> Sent: Friday, April 11, 2008 1:58 PM
> To: linux-omap@vger.kernel.org
> Cc: Felipe Balbi
> Subject: [PATCH 01/23] I2C: TWL4030: checkpatch.pl fixes for 
> twl4030-core.c
> 
> Misc cleanup patch.
> 
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  drivers/i2c/chips/twl4030-core.c |   61 
> +++++++++++++++++--------------------
>  1 files changed, 28 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/i2c/chips/twl4030-core.c 
> b/drivers/i2c/chips/twl4030-core.c
> index 49bd63a..953c247 100644
> --- a/drivers/i2c/chips/twl4030-core.c
> +++ b/drivers/i2c/chips/twl4030-core.c
> @@ -43,8 +43,8 @@
>  #include <linux/slab.h>
>  #include <linux/clk.h>
>  #include <linux/device.h>
> +#include <linux/irq.h>
>  
> -#include <asm/irq.h>
>  #include <asm/mach/irq.h>
>  
>  #include <asm/arch/gpio.h>
> @@ -256,7 +256,7 @@ static struct irq_chip twl4030_irq_chip = {
>   *
>   * @return result of operation - 0 is success
>   */
> -int twl4030_i2c_write(u8 mod_no, u8 * value, u8 reg, u8 num_bytes)
> +int twl4030_i2c_write(u8 mod_no, u8 *value, u8 reg, u8 num_bytes)
>  {
>  	int ret;
>  	int sid;
> @@ -295,6 +295,7 @@ int twl4030_i2c_write(u8 mod_no, u8 * 
> value, u8 reg, u8 num_bytes)
>  		ret = 0;
>  	return ret;
>  }
> +EXPORT_SYMBOL(twl4030_i2c_write);
>  
>  /**
>   * @brief twl4030_i2c_read - Reads a n bit register in TWL4030
> @@ -306,7 +307,7 @@ int twl4030_i2c_write(u8 mod_no, u8 * value, u8 reg, u8 num_bytes)
>   *
>   * @return result of operation - num_bytes is success else failure.
>   */
> -int twl4030_i2c_read(u8 mod_no, u8 * value, u8 reg, u8 num_bytes)
> +int twl4030_i2c_read(u8 mod_no, u8 *value, u8 reg, u8 num_bytes)
>  {
>  	int ret;
>  	u8 val;
> @@ -348,6 +349,7 @@ int twl4030_i2c_read(u8 mod_no, u8 * value, u8 reg, u8 num_bytes)
>  		ret = 0;
>  	return ret;
>  }
> +EXPORT_SYMBOL(twl4030_i2c_read);
>  
>  /**
>   * @brief twl4030_i2c_write_u8 - Writes a 8 bit register in TWL4030
> @@ -367,6 +369,7 @@ int twl4030_i2c_write_u8(u8 mod_no, u8 value, u8 reg)
>  	temp_buffer[1] = value;
>  	return twl4030_i2c_write(mod_no, temp_buffer, reg, 1);
>  }
> +EXPORT_SYMBOL(twl4030_i2c_write_u8);
>  
>  /**
>   * @brief twl4030_i2c_read_u8 - Reads a 8 bit register from TWL4030
> @@ -377,10 +380,11 @@ int twl4030_i2c_write_u8(u8 mod_no, u8 value, u8 reg)
>   *
>   * @return result of operation - 0 is success
>   */
> -int twl4030_i2c_read_u8(u8 mod_no, u8 * value, u8 reg)
> +int twl4030_i2c_read_u8(u8 mod_no, u8 *value, u8 reg)
>  {
>  	return twl4030_i2c_read(mod_no, value, reg, 1);
>  }
> +EXPORT_SYMBOL(twl4030_i2c_read_u8);
>  
>  /* Helper Functions */
>  
> @@ -431,7 +435,8 @@ static void do_twl4030_module_irq(unsigned int irq, irq_desc_t *desc)
>  
>  			if (retval != IRQ_HANDLED)
>  				printk(KERN_ERR "ISR for TWL4030 module"
> -					" irq %d can't handle 
> interrupt\n", irq);
> +					" irq %d can't handle 
> interrupt\n",
> +					irq);
>  
>  			/*
>  			 * Here is where we should call the unmask method, but
> @@ -475,7 +480,7 @@ static int twl4030_irq_thread(void *data)
>  			if (++i2c_errors >= max_i2c_errors) {
>  				printk(KERN_ERR "Maximum I2C 
> error count"
>  						" exceeded.  
> Terminating %s.\n",
> -						__FUNCTION__);
> +						__func__);
>  				break;
>  			}
>  			continue;
> @@ -542,8 +547,10 @@ static int twl4030_detect_client(struct i2c_adapter *adapter, unsigned char sid)
>  	}
>  
>  	/* Check basic functionality */
> -	if (!(err = i2c_check_functionality(adapter, 
> I2C_FUNC_SMBUS_WORD_DATA |
> -						
> I2C_FUNC_SMBUS_WRITE_BYTE))) {
> +	err = i2c_check_functionality(adapter,
> +			I2C_FUNC_SMBUS_WORD_DATA
> +			| I2C_FUNC_SMBUS_WRITE_BYTE);
> +	if (!err) {
>  		pr_err("SlaveID=%d functionality check failed\n", sid);
>  		return err;
>  	}
> @@ -565,7 +572,8 @@ static int twl4030_detect_client(struct 
> i2c_adapter *adapter, unsigned char sid)
>  	pr_info("TWL4030: TRY attach Slave %s on Adapter %s [%x]\n",
>  				twl->client_name, adapter->name, err);
>  
> -	if ((err = i2c_attach_client(&twl->client))) {
> +	err = i2c_attach_client(&twl->client);
> +	if (err) {
>  		pr_err("Couldn't attach Slave %s on Adapter"
>  		       "%s [%x]\n", twl->client_name, 
> adapter->name, err);
>  	} else {
> @@ -586,7 +594,8 @@ static int twl4030_attach_adapter(struct i2c_adapter *adapter)
>  	for (i = 0; i < TWL4030_NUM_SLAVES; i++) {
>  		/* Check if I need to hook on to this adapter or not */
>  		if (twl4030_modules[i].adapter_index == 
> twl_i2c_adapter) {
> -			if ((ret = twl4030_detect_client(adapter, i)))
> +			ret = twl4030_detect_client(adapter, i);
> +			if (ret)
>  				goto free_client;
>  		}
>  	}
> @@ -604,7 +613,7 @@ static int twl4030_attach_adapter(struct i2c_adapter *adapter)
>  	return 0;
>  
>  free_client:
> -	pr_err("TWL_CLIENT(Idx=%d] registration failed[0x%x]\n",i,ret);
> +	pr_err("TWL_CLIENT(Idx=%d] registration 
> failed[0x%x]\n", i, ret);
>  
>  	/* ignore current slave..it never got registered */
>  	i--;
> @@ -621,7 +630,8 @@ free_client: static int twl4030_detach_client(struct i2c_client *client)
>  {
>  	int err;
> -	if ((err = i2c_detach_client(client))) {
> +	err = i2c_detach_client(client);
> +	if (err) {
>  		pr_err("Client detach failed\n");
>  		return err;
>  	}
> @@ -637,7 +647,7 @@ struct task_struct *start_twl4030_irq_thread(int irq)
>  			     "twl4030 irq %d", irq);
>  	if (!thread)
>  		pr_err("%s: could not create twl4030 irq %d thread!\n",
> -		       __FUNCTION__, irq);
> +		       __func__, irq);
>  
>  	return thread;
>  }
> @@ -686,9 +696,9 @@ static int power_companion_init(void)
>  	clk_put(osc);
>  
>  	switch (rate) {
> -		case 19200000 : ctrl = HFCLK_FREQ_19p2_MHZ; break;
> -		case 26000000 : ctrl = HFCLK_FREQ_26_MHZ; break;
> -		case 38400000 : ctrl = HFCLK_FREQ_38p4_MHZ; break;
> +	case 19200000 : ctrl = HFCLK_FREQ_19p2_MHZ; break;
> +	case 26000000 : ctrl = HFCLK_FREQ_26_MHZ; break;
> +	case 38400000 : ctrl = HFCLK_FREQ_38p4_MHZ; break;
>  	}
>  
>  	ctrl |= HIGH_PERF_SQ;
> @@ -875,23 +885,13 @@ static void twl_init_irq(void)
>  	set_irq_chained_handler(TWL4030_IRQNUM, do_twl4030_irq);
>  
>  	res = power_companion_init();
> -	if (res < 0) {
> +	if (res < 0)
>  		pr_err("%s[%d][%d]\n", msg, res, __LINE__);
> -	}
>  }
>  
>  static int __init twl4030_init(void)
>  {
> -	int res;
> -
> -	if ((res = i2c_add_driver(&twl4030_driver))) {
> -		printk(KERN_ERR "TWL4030: Driver registration failed\n");
> -		return res;
> -	}
> -
> -	pr_info(KERN_INFO "TWL4030: Driver registration complete.\n");
> -
> -	return 0;
> +	return i2c_add_driver(&twl4030_driver);
>  }

You're losing the failure print here. Not sure if it matters, but I'm pointing it out anyway.

>  
>  static void __exit twl4030_exit(void)
> @@ -903,11 +903,6 @@ static void __exit twl4030_exit(void)
>  subsys_initcall(twl4030_init);
>  module_exit(twl4030_exit);
>  
> -EXPORT_SYMBOL(twl4030_i2c_write_u8);
> -EXPORT_SYMBOL(twl4030_i2c_read_u8);
> -EXPORT_SYMBOL(twl4030_i2c_read);
> -EXPORT_SYMBOL(twl4030_i2c_write);
> -
>  MODULE_AUTHOR("Texas Instruments, Inc.");
>  MODULE_DESCRIPTION("I2C Core interface for TWL4030");
>  MODULE_LICENSE("GPL");
> -- 
> 1.5.5.23.g2a5fe
> 
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
