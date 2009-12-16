From: "G, Manjunath Kondaiah" <manjugk-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v2] OMAP3 : Fix I2C lockup during timeout/error cases
Date: Wed, 16 Dec 2009 20:53:13 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94026A996E6C@dbde02.ent.ti.com>
References: <1260509948-12774-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1260509948-12774-1-git-send-email-manjugk-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: "Menon, Nishanth" <nm-l0cyMroinI0@public.gmane.org>, "Sonasath, Moiz" <m-sonasath-l0cyMroinI0@public.gmane.org>, "Krishnamoorthy, Balaji T" <balajitk-l0cyMroinI0@public.gmane.org>, "Varadarajan, Charu Latha" <charu-l0cyMroinI0@public.gmane.org>, "George, Harith" <harith-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


If there are no comments for this patch, can you please consider this patch
for upstream?

-Manjunath
 

> -----Original Message-----
> From: G, Manjunath Kondaiah 
> Sent: Friday, December 11, 2009 11:09 AM
> To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; 
> ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
> Cc: G, Manjunath Kondaiah; Menon, Nishanth; Sonasath, Moiz; 
> Krishnamoorthy, Balaji T; Varadarajan, Charu Latha; George, Harith
> Subject: [PATCH v2] OMAP3 : Fix I2C lockup during timeout/error cases
> 
> Current OMAP3 I2C driver code does not follow the correct 
> sequence for soft
> reset. Due to this, lock up issues are reported during 
> timeout/error cases.
> 
> This patch fixes above issue by disabling I2C controller as 
> per OMAP3430 TRM
> for soft reset. As per TRM, I2C controller needs to be 
> disabled as a first
> step during soft reset.
> 
> Here is correct soft reset sequence:
> a. Ensure that the module is disabled
> (clear the I2Ci.I2C_CON[15] I2C_EN bit to 0).
> b. Set the I2Ci.I2C_SYSC[1] SRST bit to 1.
> c. Enable the module by setting I2Ci.I2C_CON[15] I2C_EN bit to 1.
> d. Check the I2Ci.I2C_SYSS[0] RDONE bit until it is set to 1 to
> indicate the software reset is complete.
> 
> 
> Tested on Zoom2, Zoom3, 3430SDP and 3630SDP
> 
> Signed-off-by: Manjunatha GK <manjugk-l0cyMroinI0@public.gmane.org>
> Signed-off-by: George, Harith<harith-l0cyMroinI0@public.gmane.org>
> Acked-by: Varadarajan, Charu Latha<charu-l0cyMroinI0@public.gmane.org>
> ---
> v1 : Initital version
> v2 : Removed delay since time taken for disabling I2C 
> controller is zero
>      jiffies
> 
>  drivers/i2c/busses/i2c-omap.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c 
> b/drivers/i2c/busses/i2c-omap.c
> index 827da08..74620c0 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -265,6 +265,11 @@ static int omap_i2c_init(struct 
> omap_i2c_dev *dev)
>  	unsigned long internal_clk = 0;
>  
>  	if (dev->rev >= OMAP_I2C_REV_2) {
> +		/* Disable I2C controller before soft reset */
> +		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG,
> +			omap_i2c_read_reg(dev, OMAP_I2C_CON_REG) &
> +				~(OMAP_I2C_CON_EN));
> +
>  		omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG, 
> SYSC_SOFTRESET_MASK);
>  		/* For some reason we need to set the EN bit before the
>  		 * reset done bit gets set. */
> -- 
> 1.6.0.4
> 
> --
To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
