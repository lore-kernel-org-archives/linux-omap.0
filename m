From: Peter Rosin <peda@axentia.se>
Subject: Re: [RFC PATCH 1/4] i2c: core: remove outdated DEBUG output
Date: Thu, 20 Sep 2018 19:23:44 +0200
Message-ID: <8b2e7959-da7f-846f-ace4-9859d3290c04@axentia.se>
References: <20180920161423.13990-1-wsa+renesas@sang-engineering.com>
 <20180920161423.13990-2-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180920161423.13990-2-wsa+renesas@sang-engineering.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org
Cc: Tero Kristo <t-kristo@ti.com>, preid@electromag.com.au, Keerthy <j-keerthy@ti.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-renesas-soc@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, Stefan Lengfeld <contact@stefanchrist.eu>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 2018-09-20 18:14, Wolfram Sang wrote:
> The usefulness of this debug output is questionable. It covers only
> direct i2c_transfer calls and no SMBUS calls, neither direct nor
> emulated ones. And the latter one is largely used in the kernel, so a
> lot of stuff is missed. Also, we have a proper tracing mechanism for all
> these kinds of transfers in place for years now. Remove this old one.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

This old one fires before locking and even if locking fails for the
atomic/irq case. You might want to mention that in the commit message?
But I certainly agree with the usefulness statement...

Acked-by: Peter Rosin <peda@axentia.se>

> ---
>  drivers/i2c/i2c-core-base.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index 9ee9a15e7134..c2b352c46fae 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -1940,16 +1940,6 @@ int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
>  	 */
>  
>  	if (adap->algo->master_xfer) {
> -#ifdef DEBUG
> -		for (ret = 0; ret < num; ret++) {
> -			dev_dbg(&adap->dev,
> -				"master_xfer[%d] %c, addr=0x%02x, len=%d%s\n",
> -				ret, (msgs[ret].flags & I2C_M_RD) ? 'R' : 'W',
> -				msgs[ret].addr, msgs[ret].len,
> -				(msgs[ret].flags & I2C_M_RECV_LEN) ? "+" : "");
> -		}
> -#endif
> -
>  		if (in_atomic() || irqs_disabled()) {
>  			ret = i2c_trylock_bus(adap, I2C_LOCK_SEGMENT);
>  			if (!ret)
> 
