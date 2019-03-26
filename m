From: Stefan Lengfeld <contact@stefanchrist.eu>
Subject: Re: [RFC PATCH v2 6/7] i2c: tegra-bpmp: convert to use new atomic
 callbacks
Date: Tue, 26 Mar 2019 21:20:05 +0100
Message-ID: <20190326202005.s3ktyth42lfjirx2@porty>
References: <20190302134735.4393-1-wsa+renesas@sang-engineering.com>
 <20190302134735.4393-7-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190302134735.4393-7-wsa+renesas@sang-engineering.com>
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
Cc: Tero Kristo <t-kristo@ti.com>, Phil Reid <preid@electromag.com.au>, Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-renesas-soc@vger.kernel.org, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-tegra@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Peter Rosin <peda@axentia.se>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Wolfram,

On Sat, Mar 02, 2019 at 02:47:34PM +0100, Wolfram Sang wrote:
> The driver did handle this internally, convert it to use the new
> callbacks.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/i2c/busses/i2c-tegra-bpmp.c | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
> 

[...]

> @@ -268,6 +270,20 @@ static int tegra_bpmp_i2c_xfer(struct i2c_adapter *adapter,
>  	return num;
>  }
>  
> +static int tegra_bpmp_i2c_xfer(struct i2c_adapter *adapter,
> +			       struct i2c_msg *msgs, int num)
> +
> +{
> +	return tegra_bpmp_i2c_xfer_common(adapter, msgs, num, false);
> +}
> +
> +static int tegra_bpmp_i2c_xfer_atomic(struct i2c_adapter *adapter,
> +				      struct i2c_msg *msgs, int num)
> +

Here and between the function prototype of 'tegra_bpmp_i2c_xfer' and
it's function body is a unneeded blank line. Nitpick.

Kind regards,
    Stefan

> +{
> +	return tegra_bpmp_i2c_xfer_common(adapter, msgs, num, true);
> +}
> +
>  static u32 tegra_bpmp_i2c_func(struct i2c_adapter *adapter)
>  {
>  	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | I2C_FUNC_10BIT_ADDR |
> @@ -276,6 +292,7 @@ static u32 tegra_bpmp_i2c_func(struct i2c_adapter *adapter)
>  
>  static const struct i2c_algorithm tegra_bpmp_i2c_algo = {
>  	.master_xfer = tegra_bpmp_i2c_xfer,
> +	.master_xfer_atomic = tegra_bpmp_i2c_xfer_atomic,
>  	.functionality = tegra_bpmp_i2c_func,
>  };
>  
> -- 
> 2.11.0
> 
> 
