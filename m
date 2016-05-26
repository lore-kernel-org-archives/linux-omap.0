From: Manish Badarkhe <badarkhe.manish@gmail.com>
Subject: Re: [RFC 1/1] drivers: i2c: omap: Add slave support
Date: Thu, 26 May 2016 21:37:21 +0530
Message-ID: <CAKDJKT4Ws3XusYJTkojjeMvwxc2R9BRYpmn6HwGOH_8QF+pe0A@mail.gmail.com>
References: <20160525141119.14486-1-rk@ti.com>
	<20160525141119.14486-2-rk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160525141119.14486-2-rk@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ravikumar Kattekola <rk@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, wsa@the-dreams.de, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Ravikumar

Some sanity comments, just good to have.

> +#ifdef CONFIG_I2C_SLAVE
> +static int omap_i2c_slave_irq(struct omap_i2c_dev *omap)
> +{
> +       u16 stat_raw;
> +       u16 stat;
> +       u16 bits;
> +       u8 value;
> +
> +       stat_raw = omap_i2c_read_reg(omap, OMAP_I2C_IP_V2_IRQSTATUS_RAW);
> +       bits = omap_i2c_read_reg(omap, OMAP_I2C_IE_REG);
> +       stat_raw &= bits;
> +
> +       if (stat_raw & OMAP_I2C_STAT_AAS) {
> +               omap_i2c_ack_stat(omap, OMAP_I2C_STAT_AAS);
> +               stat_raw &= ~OMAP_I2C_STAT_AAS;
> +       }
> +
> +out:
> +       return 0;
> +}
> +#endif

This function always return 0.

> +#ifdef CONFIG_I2C_SLAVE
> +static int omap_i2c_reg_slave(struct i2c_client *slave)
> +{
> +       struct omap_i2c_dev *omap = i2c_get_adapdata(slave->adapter);
> +       u16 reg;
> +       int ret = 0;
> +       /* Enable necessary interrupts */
> +       omap_i2c_write_reg(omap, OMAP_I2C_IE_REG, omap->iestate);
> +
> +       return 0;
> +
> +}

Better to return "ret" here as already been initialized to 0

> +
> +static int omap_i2c_unreg_slave(struct i2c_client *slave)
> +{
> +       struct omap_i2c_dev *omap = i2c_get_adapdata(slave->adapter);
> +       u16 reg;
> +
> +       pm_runtime_put(omap->dev);
> +       return 0;
> +}
> +#endif

This function always return 0


Regards
Manish Badarkhe
