From: Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH RFC] i2c: omap: Fix the revision register read
Date: Wed, 31 Oct 2012 16:18:15 +0530
Message-ID: <509101EF.1070108@ti.com>
References: <1351673959-5918-1-git-send-email-shubhrajyoti@ti.com> <20121031101201.GB10094@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121031101201.GB10094-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wednesday 31 October 2012 03:42 PM, Felipe Balbi wrote:
> Hi,
>
> On Wed, Oct 31, 2012 at 02:29:19PM +0530, Shubhrajyoti D wrote:
>> The revision register on OMAP4 is a 16-bit lo and a 16-bit
>> hi. Currently the driver reads only the lower 8-bits.
>> Fix the same by preventing the truncating of the rev register
>> for OMAP4.
> very good, but you need to test this with OMAP2/3/4 (5 ??). How was this
> tested ?
>
>> Also use the scheme bit ie bit-14 of the hi register to know if it
>> is OMAP_I2C_IP_VERSION_2.
>>
>> On platforms previous to OMAP4 the offset 0x04 is IE register whose
>> bit-14 reset value is 0, the code uses the same to its advantage.
>>
>> The dev->regs is populated after reading the rev_hi. A NULL check
>> has been added in the resume handler to prevent the access before
>> the setting of the regs.
> this could get some rephrasing, I guess. At least to me it's difficult
> to understand what you mean :-s
>
>> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
>> ---
>> todo: some of the flag checks can be removed in favour of revision check.
>>
>>  drivers/i2c/busses/i2c-omap.c |   35 +++++++++++++++++++++++++----------
>>  1 files changed, 25 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
>> index db31eae..651a7f7 100644
>> --- a/drivers/i2c/busses/i2c-omap.c
>> +++ b/drivers/i2c/busses/i2c-omap.c
>> @@ -51,7 +51,8 @@
>>  /* I2C controller revisions present on specific hardware */
>>  #define OMAP_I2C_REV_ON_2430		0x36
>>  #define OMAP_I2C_REV_ON_3430_3530	0x3C
>> -#define OMAP_I2C_REV_ON_3630_4430	0x40
>> +#define OMAP_I2C_REV_ON_3630		0x40
>> +#define OMAP_I2C_REV_ON_4430_PLUS	0x5040
> I would rather see a proper decoding of the revision, meaning that you
> would:
>
> For omap2/3:
>
> rev major = rev >> 8;
> rev minor = rev & 0xff;
you mean

rev major = rev >> 4;
rev minor = rev & 0xf;

thats doable too. However that currently that is read together currently.

>
> For OMAP4/5:
>
> well, that's a lot more complex, but you have that data ;-)
>
>>  /* timeout waiting for the controller to respond */
>>  #define OMAP_I2C_TIMEOUT (msecs_to_jiffies(1000))
>> @@ -202,7 +203,7 @@ struct omap_i2c_dev {
>>  						 * fifo_size==0 implies no fifo
>>  						 * if set, should be trsh+1
>>  						 */
>> -	u8			rev;
>> +	u16			rev;
> IMHO this should be u32, so you don't need rev_lo and rev_hi below.
>
>>  	unsigned		b_hw:1;		/* bad h/w fixes */
>>  	unsigned		receiver:1;	/* true when we're in receiver mode */
>>  	u16			iestate;	/* Saved interrupt register */
>> @@ -490,7 +491,7 @@ static void omap_i2c_resize_fifo(struct omap_i2c_dev *dev, u8 size, bool is_rx)
>>  
>>  	omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG, buf);
>>  
>> -	if (dev->rev < OMAP_I2C_REV_ON_3630_4430)
>> +	if (dev->rev < OMAP_I2C_REV_ON_3630)
>>  		dev->b_hw = 1; /* Enable hardware fixes */
>>  
>>  	/* calculate wakeup latency constraint for MPU */
>> @@ -1064,6 +1065,8 @@ omap_i2c_probe(struct platform_device *pdev)
>>  	const struct of_device_id *match;
>>  	int irq;
>>  	int r;
>> +	u16 rev_lo;
>> +	u16 rev_hi;
>>  
>>  	/* NOTE: driver uses the static register mapping */
>>  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> @@ -1117,11 +1120,6 @@ omap_i2c_probe(struct platform_device *pdev)
>>  
>>  	dev->reg_shift = (dev->flags >> OMAP_I2C_FLAG_BUS_SHIFT__SHIFT) & 3;
>>  
>> -	if (dev->dtrev == OMAP_I2C_IP_VERSION_2)
>> -		dev->regs = (u8 *)reg_map_ip_v2;
>> -	else
>> -		dev->regs = (u8 *)reg_map_ip_v1;
>> -
>>  	pm_runtime_enable(dev->dev);
>>  	pm_runtime_set_autosuspend_delay(dev->dev, OMAP_I2C_PM_TIMEOUT);
>>  	pm_runtime_use_autosuspend(dev->dev);
>> @@ -1130,7 +1128,21 @@ omap_i2c_probe(struct platform_device *pdev)
>>  	if (IS_ERR_VALUE(r))
>>  		goto err_free_mem;
>>  
>> -	dev->rev = omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) & 0xff;
>> +	/* Read the Rev hi bit-14 ie scheme this is 1 indicates ver2 or
>> +	* highlander.
> the "scheme" in highlander is a 2 bit value. In order to make this
> future proof, you need to read both bits (31:30).
Good point will fix it.
>
>> +	* On omap3 Offset 4 is IE Reg the bit 14 is XDR_IE which is 0 at reset.
>> +	*/
> please align the * characters.
yes will repost
>
>> +	rev_hi = __raw_readw(dev->base + 0x04);
> you should make omap_i2c_read_reg() work fine for this case too.
 
Just felt it is more readlable this way also I didnt want to use the
reg_shift etc.

which also may get cleaned up sometime.
>
>> +
>> +	if (rev_hi & 0x4000) {/* If scheme 1*/
> you should add a symbolic define for scheme, something like:
>
> switch (OMAP_I2C_SCHEME(rev)) {
> case OMAP_I2C_SCHEME_1:
> 	foo();
> 	break;
> case OMAP_I2C_SCHEME_2:
> 	/* FALLTHROUGH */
> default:
> 	bar();
> }
>
> note that this will also default to highest known scheme if another
> scheme is added. You need to make the driver behave like that to
> decrease amount of rework to support newest OMAPs.
OK.
>
>> +		dev->regs = (u8 *)reg_map_ip_v2;
>> +		dev->rev = omap_i2c_read_reg(dev, OMAP_I2C_IP_V2_REVNB_HI);
>> +		rev_lo = omap_i2c_read_reg(dev, OMAP_I2C_IP_V2_REVNB_LO);
>> +		dev_info(dev->dev, "the low rev %x\n", rev_lo);
>> +	} else {
>> +		dev->regs = (u8 *)reg_map_ip_v1;
>> +		dev->rev = omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) & 0xff;
>> +	}
>>  
>>  	dev->errata = 0;
>>  
>> @@ -1155,7 +1167,7 @@ omap_i2c_probe(struct platform_device *pdev)
>>  
>>  		dev->fifo_size = (dev->fifo_size / 2);
>>  
>> -		if (dev->rev < OMAP_I2C_REV_ON_3630_4430)
>> +		if (dev->rev < OMAP_I2C_REV_ON_3630)
>>  			dev->b_hw = 1; /* Enable hardware fixes */
>>  
>>  		/* calculate wakeup latency constraint for MPU */
>> @@ -1264,6 +1276,9 @@ static int omap_i2c_runtime_resume(struct device *dev)
>>  	struct platform_device *pdev = to_platform_device(dev);
>>  	struct omap_i2c_dev *_dev = platform_get_drvdata(pdev);
>>  
>> +	if (!_dev->regs)
>> +		return 0;
> this is wrong, you need to make sure dev->regs is set early enough.
