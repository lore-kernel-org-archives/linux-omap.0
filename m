From: Simon Horman <horms@verge.net.au>
Subject: Re: [RFC PATCH v2 1/7] i2c: apply coding style for struct i2c_adapter
Date: Fri, 15 Mar 2019 13:15:51 +0100
Message-ID: <20190315121550.53hhzjy57hndp2w5@verge.net.au>
References: <20190302134735.4393-1-wsa+renesas@sang-engineering.com>
 <20190302134735.4393-2-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190302134735.4393-2-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Keerthy <j-keerthy@ti.com>, Peter Rosin <peda@axentia.se>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Stefan Lengfeld <contact@stefanchrist.eu>, Phil Reid <preid@electromag.com.au>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sat, Mar 02, 2019 at 02:47:29PM +0100, Wolfram Sang wrote:
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  include/linux/i2c.h | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index 383510b4f083..758a6db864c9 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -517,20 +517,23 @@ i2c_register_board_info(int busnum, struct i2c_board_info const *info,
>   * Documentation file Documentation/i2c/fault-codes.
>   */
>  struct i2c_algorithm {
> -	/* If an adapter algorithm can't do I2C-level access, set master_xfer
> -	   to NULL. If an adapter algorithm can do SMBus access, set
> -	   smbus_xfer. If set to NULL, the SMBus protocol is simulated
> -	   using common I2C messages */
> -	/* master_xfer should return the number of messages successfully
> -	   processed, or a negative value on error */
> +	/*
> +	 * If an adapter algorithm can't do I2C-level access, set master_xfer
> +	 * to NULL. If an adapter algorithm can do SMBus access, set
> +	 * smbus_xfer. If set to NULL, the SMBus protocol is simulated
> +	 * using common I2C messages.
> +	 *
> +	 * master_xfer should return the number of messages successfully
> +	 * processed, or a negative value on error
> +	 */
>  	int (*master_xfer)(struct i2c_adapter *adap, struct i2c_msg *msgs,
>  			   int num);
> -	int (*smbus_xfer) (struct i2c_adapter *adap, u16 addr,
> -			   unsigned short flags, char read_write,
> -			   u8 command, int size, union i2c_smbus_data *data);
> +	int (*smbus_xfer)(struct i2c_adapter *adap, u16 addr,
> +			  unsigned short flags, char read_write,
> +			  u8 command, int size, union i2c_smbus_data *data);
>  
>  	/* To determine what the adapter supports */
> -	u32 (*functionality) (struct i2c_adapter *);
> +	u32 (*functionality)(struct i2c_adapter *adap);
>  
>  #if IS_ENABLED(CONFIG_I2C_SLAVE)
>  	int (*reg_slave)(struct i2c_client *client);
> -- 
> 2.11.0
> 
