From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Subject: Re: [RFC PATCH] i2c: busses: i2c-omap: Increase timeout for i2c
 interrupt
Date: Fri, 10 Jul 2015 10:46:40 +0200
Message-ID: <559F8670.2060305@nokia.com>
References: <1436504994-31137-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436504994-31137-1-git-send-email-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ext Vignesh R <vigneshr@ti.com>, Tony Lindgren <tony@atomide.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Vignesh,

On 10/07/15 07:09, ext Vignesh R wrote:
> When system is under load and there is an i2c transaction running
> following warning appears on the console:
> 
> [  730.003617] omap_i2c 48070000.i2c: controller timed out
> [  731.023643] omap_i2c 48070000.i2c: controller timed out
> 
> This is because, the completion() call, which is done in bottom half of
> the interrupt handler, happens after the timeout period(1s) has elapsed
> for the wait_for_completion_timeout() in omap_i2c_xfer_msg(). The
> interrupt is raised within a second but due to system load (or other
> interrupts), the bottom half does not get scheduled within a second.

I would say, if your system cannot handle an interrupt within 1 second,
you have more severe problems than just too small I2C timeout value.

> Hence even though the interrupt has happened within required time frame,
> due to delayed scheduling of bottom half, spurious timeout errors are
> reported on the console and i2c controller is reset.
> 
> i2c timeout is a rare condition, hence increase timeout to 60s in order
> to avoid reporting false timeout events under load.

60 s sounds way too much and actually I simply don't believe this is
the root cause. If I take a look into the driver, then I see, that
the design is not really the best. The whole IRQ handling could be
actually performed in hard IRQ handler, without threading overhead.
Putting even 2 bytes in the controller FIFO should not be too heavy
for the hard IRQ handler. Then these ridiculous spin_lock()s. What
is the reason behind? The IRQ is flagged with ONESHOT, so thread and
hardirq handler are anyway mutually excluded. But if this thread
ever runs longer than it's allowed in IRQ context, then it anyway
produces this IRQ latency because it locks spin_lock_irqsave() for
the whole time! So the whole point of threaded interrupt is missing.

I would propose you to throw away spinlocks. Convert threaded IRQ to
just one hardirq handler. And continue debugging. You will reduce the
load of the system with the above measures, maybe it will not happen
any more, maybe you'll figure out that problem is somewhere else.

> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
> 
> I reproduced this while running i2cdump in a loop and reading from flash
> using dd command.
> 
>  drivers/i2c/busses/i2c-omap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index d1c22e3fdd14..fa7758f0302c 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -50,7 +50,7 @@
>  #define OMAP_I2C_REV_ON_4430_PLUS	0x50400002
>  
>  /* timeout waiting for the controller to respond */
> -#define OMAP_I2C_TIMEOUT (msecs_to_jiffies(1000))
> +#define OMAP_I2C_TIMEOUT (msecs_to_jiffies(60 * 1000))
>  
>  /* timeout for pm runtime autosuspend */
>  #define OMAP_I2C_PM_TIMEOUT		1000	/* ms */

-- 
Best regards,
Alexander Sverdlin.
