From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] i2c-omap: Program I2C_WE on OMAP4 to enable i2c wakeup
Date: Fri, 04 Mar 2011 09:00:00 -0800
Message-ID: <87ei6mizxr.fsf@ti.com>
References: <1299245544-23790-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1299245544-23790-1-git-send-email-rnayak@ti.com> (Rajendra
	Nayak's message of "Fri, 4 Mar 2011 19:02:24 +0530")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rajendra Nayak <rnayak@ti.com>, ben-linux@fluff.org
Cc: paul@pwsan.com, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Rajendra Nayak <rnayak@ti.com> writes:

> For the I2C module to be wakeup capable, programming I2C_WE
> register (which was skipped for OMAP4430) is needed
> even on OMAP4.
> This fixes i2c controller timeouts which were seen recently
> with the static dependency being cleared between MPU and
> L4PER clockdomains.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
> Patch is based on 2.6.38-rc7 kernel.

Acked-by: Kevin Hilman <khilman@ti.com>

Ben, looks like another fix that should be queued for 2.6.38-rc.

Thanks,

Kevin


>
>  drivers/i2c/busses/i2c-omap.c |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 829a2a1..58a58c7 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -378,9 +378,7 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
>  			 * REVISIT: Some wkup sources might not be needed.
>  			 */
>  			dev->westate = OMAP_I2C_WE_ALL;
> -			if (dev->rev < OMAP_I2C_REV_ON_4430)
> -				omap_i2c_write_reg(dev, OMAP_I2C_WE_REG,
> -								dev->westate);
> +			omap_i2c_write_reg(dev, OMAP_I2C_WE_REG, dev->westate);
>  		}
>  	}
>  	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
