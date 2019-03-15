From: Simon Horman <horms@verge.net.au>
Subject: Re: [RFC PATCH v2 3/7] i2c: core: introduce callbacks for atomic
 transfers
Date: Fri, 15 Mar 2019 13:23:21 +0100
Message-ID: <20190315122320.34yibpfhv2b6ptwl@verge.net.au>
References: <20190302134735.4393-1-wsa+renesas@sang-engineering.com>
 <20190302134735.4393-4-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190302134735.4393-4-wsa+renesas@sang-engineering.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Russell King <linux@armlinux.org.uk>, Tero Kristo <t-kristo@ti.com>, linux-i2c@vger.kernel.org, linux-tegra@vger.kernel.org, Stefan Lengfeld <contact@stefanchrist.eu>, Phil Reid <preid@electromag.com.au>, Peter Rosin <peda@axentia.se>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Sat, Mar 02, 2019 at 02:47:31PM +0100, Wolfram Sang wrote:
> We had the request to access devices very late when interrupts are not
> available anymore multiple times now. Mostly to prepare shutdown or
> reboot. Allow adapters to specify a specific callback for this case.
> Note that we fall back to the generic {master|smbus}_xfer callback if
> this new atomic one is not present. This is intentional to preserve the
> previous behaviour and avoid regressions. Because there are drivers not
> using interrupts or because it might have worked "accidently" before.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/i2c/i2c-core-base.c  |  6 +++++-
>  drivers/i2c/i2c-core-smbus.c | 18 ++++++++++++++----
>  drivers/i2c/i2c-core.h       |  7 +++++--
>  include/linux/i2c.h          | 15 ++++++++++++---
>  4 files changed, 36 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index 004f8a3b6365..2127dd08ff01 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -1890,7 +1890,11 @@ int __i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
>  	/* Retry automatically on arbitration loss */
>  	orig_jiffies = jiffies;
>  	for (ret = 0, try = 0; try <= adap->retries; try++) {
> -		ret = adap->algo->master_xfer(adap, msgs, num);
> +		if ((in_atomic() || irqs_disabled()) && adap->algo->master_xfer_atomic)
> +			ret = adap->algo->master_xfer_atomic(adap, msgs, num);
> +		else
> +			ret = adap->algo->master_xfer(adap, msgs, num);
> +
>  		if (ret != -EAGAIN)
>  			break;
>  		if (time_after(jiffies, orig_jiffies + adap->timeout))
> diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
> index 357e083e8f45..e01a548fc559 100644
> --- a/drivers/i2c/i2c-core-smbus.c
> +++ b/drivers/i2c/i2c-core-smbus.c
> @@ -548,6 +548,9 @@ s32 __i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr,
>  		     unsigned short flags, char read_write,
>  		     u8 command, int protocol, union i2c_smbus_data *data)
>  {
> +	int (*xfer_func)(struct i2c_adapter *adap, u16 addr,
> +			 unsigned short flags, char read_write,
> +			 u8 command, int size, union i2c_smbus_data *data);
>  	unsigned long orig_jiffies;
>  	int try;
>  	s32 res;
> @@ -562,13 +565,20 @@ s32 __i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr,
>  
>  	flags &= I2C_M_TEN | I2C_CLIENT_PEC | I2C_CLIENT_SCCB;
>  
> -	if (adapter->algo->smbus_xfer) {
> +	xfer_func = adapter->algo->smbus_xfer;
> +	if (in_atomic() || irqs_disabled()) {
> +		if (adapter->algo->smbus_xfer_atomic)
> +			xfer_func = adapter->algo->smbus_xfer_atomic;
> +		else if (adapter->algo->master_xfer_atomic)
> +			xfer_func = NULL; /* fallback to I2C emulation */
> +	}
> +
> +	if (xfer_func) {
>  		/* Retry automatically on arbitration loss */
>  		orig_jiffies = jiffies;
>  		for (res = 0, try = 0; try <= adapter->retries; try++) {
> -			res = adapter->algo->smbus_xfer(adapter, addr, flags,
> -							read_write, command,
> -							protocol, data);
> +			res = xfer_func(adapter, addr, flags, read_write,
> +					command, protocol, data);
>  			if (res != -EAGAIN)
>  				break;
>  			if (time_after(jiffies,
> diff --git a/drivers/i2c/i2c-core.h b/drivers/i2c/i2c-core.h
> index 6e98aa811980..01a6cb9b53aa 100644
> --- a/drivers/i2c/i2c-core.h
> +++ b/drivers/i2c/i2c-core.h
> @@ -33,10 +33,13 @@ static inline int __i2c_lock_bus_helper(struct i2c_adapter *adap)
>  {
>  	int ret = 0;
>  
> -	if (in_atomic() || irqs_disabled())
> +	if (in_atomic() || irqs_disabled()) {
> +		WARN(!adap->algo->master_xfer_atomic && !adap->algo->smbus_xfer_atomic,
> +		     "No atomic I2C transfer handler for '%s'\n", dev_name(&adap->dev));

		Is WARN_ONCE more appropriate here?

>  		ret = i2c_trylock_bus(adap, I2C_LOCK_SEGMENT) ? 0 : -EAGAIN;
> -	else
> +	} else {
>  		i2c_lock_bus(adap, I2C_LOCK_SEGMENT);
> +	}
>  
>  	return ret;
>  }
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index 758a6db864c9..3cd921dd39e3 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -499,9 +499,13 @@ i2c_register_board_info(int busnum, struct i2c_board_info const *info,
>   * @master_xfer: Issue a set of i2c transactions to the given I2C adapter
>   *   defined by the msgs array, with num messages available to transfer via
>   *   the adapter specified by adap.
> + * @master_xfer_atomic: same as @master_xfer. Yet, only using atomic context
> + *   so e.g. PMICs can be accessed very late before shutdown. Optional.
>   * @smbus_xfer: Issue smbus transactions to the given I2C adapter. If this
>   *   is not present, then the bus layer will try and convert the SMBus calls
>   *   into I2C transfers instead.
> + * @smbus_xfer_atomic: same as @smbus_xfer. Yet, only using atomic context
> + *   so e.g. PMICs can be accessed very late before shutdown. Optional.
>   * @functionality: Return the flags that this algorithm/adapter pair supports
>   *   from the I2C_FUNC_* flags.
>   * @reg_slave: Register given client to I2C slave mode of this adapter
> @@ -512,9 +516,9 @@ i2c_register_board_info(int busnum, struct i2c_board_info const *info,
>   * be addressed using the same bus algorithms - i.e. bit-banging or the PCF8584
>   * to name two of the most common.
>   *
> - * The return codes from the @master_xfer field should indicate the type of
> - * error code that occurred during the transfer, as documented in the kernel
> - * Documentation file Documentation/i2c/fault-codes.
> + * The return codes from the @master_xfer{_atomic} field should indicate the

I think "field" should be "fields" in the new text.

> + * type of error code that occurred during the transfer, as documented in the
> + * Kernel Documentation file Documentation/i2c/fault-codes.
>   */
>  struct i2c_algorithm {
>  	/*
> @@ -528,9 +532,14 @@ struct i2c_algorithm {
>  	 */
>  	int (*master_xfer)(struct i2c_adapter *adap, struct i2c_msg *msgs,
>  			   int num);
> +	int (*master_xfer_atomic)(struct i2c_adapter *adap,
> +				   struct i2c_msg *msgs, int num);
>  	int (*smbus_xfer)(struct i2c_adapter *adap, u16 addr,
>  			  unsigned short flags, char read_write,
>  			  u8 command, int size, union i2c_smbus_data *data);
> +	int (*smbus_xfer_atomic)(struct i2c_adapter *adap, u16 addr,
> +				 unsigned short flags, char read_write,
> +				 u8 command, int size, union i2c_smbus_data *data);
>  
>  	/* To determine what the adapter supports */
>  	u32 (*functionality)(struct i2c_adapter *adap);
> -- 
> 2.11.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
