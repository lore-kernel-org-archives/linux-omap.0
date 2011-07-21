From: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Subject: Re: [PATCH 5/5] OMAP: I2C: Restore only if context is lost
Date: Thu, 21 Jul 2011 13:44:25 +0530
Message-ID: <CANrkHUbRh0GG2XN4xDm84c3vV7U-4Am3a9CPLx+G-cR4X841GA@mail.gmail.com>
References: <1311231185-5503-1-git-send-email-shubhrajyoti@ti.com>
	<1311231185-5503-6-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1311231185-5503-6-git-send-email-shubhrajyoti@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: khilman@ti.com, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rnayak@ti.com
List-Id: linux-omap@vger.kernel.org

On Thu, Jul 21, 2011 at 12:23 PM, Shubhrajyoti D <shubhrajyoti@ti.com> wrot=
e:
> Currently restore is done always.
> Adding conditional restore.The restore is done only if the context is los=
t.
>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
> @@ -261,6 +263,18 @@ static inline u16 omap_i2c_read_reg(struct omap_i2c_=
dev *i2c_dev, int reg)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(i2c_dev->=
regs[reg] << i2c_dev->reg_shift));
> =A0}
>
> +
spurious line

> +static void omap_i2c_restore(struct omap_i2c_dev *dev)
> +{
> + =A0 =A0 =A0 omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
> + =A0 =A0 =A0 omap_i2c_write_reg(dev, OMAP_I2C_PSC_REG, dev->pscstate);
> + =A0 =A0 =A0 omap_i2c_write_reg(dev, OMAP_I2C_SCLL_REG, dev->scllstate);
> + =A0 =A0 =A0 omap_i2c_write_reg(dev, OMAP_I2C_SCLH_REG, dev->sclhstate);
> + =A0 =A0 =A0 omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG, dev->bufstate);
> + =A0 =A0 =A0 omap_i2c_write_reg(dev, OMAP_I2C_WE_REG, dev->westate);
> + =A0 =A0 =A0 omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
> +}
> +
> =A0static void omap_i2c_unidle(struct omap_i2c_dev *dev)
> =A0{
> =A0 =A0 =A0 =A0struct platform_device *pdev;
> @@ -274,14 +288,11 @@ static void omap_i2c_unidle(struct omap_i2c_dev *de=
v)
> =A0 =A0 =A0 =A0pm_runtime_get_sync(&pdev->dev);
>
> =A0 =A0 =A0 =A0if (pdata->flags & OMAP_I2C_FLAG_RESET_REGS_POSTIDLE) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0=
);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c_write_reg(dev, OMAP_I2C_PSC_REG, d=
ev->pscstate);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c_write_reg(dev, OMAP_I2C_SCLL_REG, =
dev->scllstate);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c_write_reg(dev, OMAP_I2C_SCLH_REG, =
dev->sclhstate);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG, d=
ev->bufstate);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c_write_reg(dev, OMAP_I2C_WE_REG, de=
v->westate);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, O=
MAP_I2C_CON_EN);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 loss_cnt =3D omap_device_get_context_lo=
ss_count(pdev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dev->dev_lost_count !=3D loss_cnt)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c_restore(dev);
> =A0 =A0 =A0 =A0}
> +
> =A0 =A0 =A0 =A0dev->idle =3D 0;
>
> =A0 =A0 =A0 =A0/*
> @@ -318,7 +329,7 @@ static void omap_i2c_idle(struct omap_i2c_dev *dev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0dev->idle =3D 1;
> -
> + =A0 =A0 =A0 dev->dev_lost_count =3D omap_device_get_context_loss_count(=
pdev);
> =A0 =A0 =A0 =A0pm_runtime_put_sync(&pdev->dev);
> =A0}
>
> @@ -574,6 +585,7 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0r =3D dev->device_reset(de=
v->dev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (r < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(de=
v->dev, "reset failed\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c_restore(dev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_i2c_init(dev);

Are you sure you need both omap_i2c_restore, omap_i2c_init calls here ?

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ETIMEDOUT;
> @@ -589,6 +601,7 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0r =3D dev->device_reset(de=
v->dev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (r < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(de=
v->dev, "reset failed\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c_restore(dev);

same comment here

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_i2c_init(dev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EIO;
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
