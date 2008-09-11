From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH 04/12] I2C re-init for every cmd
Date: Thu, 11 Sep 2008 13:04:10 +0300
Message-ID: <87sks79exx.fsf@trdhcp146196.ntc.nokia.com>
References: <59975.192.168.10.89.1220276306.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:25923 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752007AbYIKKDN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2008 06:03:13 -0400
In-Reply-To: <59975.192.168.10.89.1220276306.squirrel@dbdmail.itg.ti.com> (ext
	Rajendra Nayak's message of "Mon, 1 Sep 2008 19:08:26 +0530 (IST)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

"ext Rajendra Nayak" <rnayak@ti.com> writes:

> This patch does i2c init/re-init for every transfer
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  drivers/i2c/busses/i2c-omap.c |    2 ++
>  1 files changed, 2 insertions(+)
>
> Index: linux-omap-2.6/drivers/i2c/busses/i2c-omap.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-omap-2.6.orig/drivers/i2c/busses/i2c-omap.c	2008-09-01
> 18:11:28.000000000 +0530
> +++ linux-omap-2.6/drivers/i2c/busses/i2c-omap.c	2008-09-01 18:11:52.=
000000000
> +0530
> @@ -496,6 +496,8 @@ omap_i2c_xfer(struct i2c_adapter *adap,
>
>  	omap_i2c_unidle(dev);
>
> +	omap_i2c_init(dev);
> +
>  	if ((r =3D omap_i2c_wait_for_bb(dev)) < 0)
>  		goto out;

This is causing unacceptable delays on i2c transfers. This is because
occasionally reset loop in init function enters msleep. Is it
necessary to reset i2c controller after off-mode?

Any opinions on this:

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-oma=
p.c
index 3778735..4a27035 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -126,6 +126,14 @@
 /* I2C System Configuration Register (OMAP_I2C_SYSC): */
 #define OMAP_I2C_SYSC_SRST             (1 << 1)        /* Soft Reset *=
/
=20
+struct omap3_i2c_regs {
+       u16 sysc;
+       u16 psc;
+       u16 scll;
+       u16 sclh;
+       u16 buf;
+};
+
 struct omap_i2c_dev {
        struct device           *dev;
        void __iomem            *base;          /* virtual */
@@ -147,6 +155,9 @@ struct omap_i2c_dev {
        unsigned                b_hw:1;         /* bad h/w fixes */
        unsigned                idle:1;
        u16                     iestate;        /* Saved interrupt regi=
ster */
+#ifdef CONFIG_ARCH_OMAP34XX
+       struct omap3_i2c_regs   context;
+#endif
 };
=20
 static inline void omap_i2c_write_reg(struct omap_i2c_dev *i2c_dev,
@@ -160,6 +171,26 @@ static inline u16 omap_i2c_read_reg(struct omap_i2=
c_dev *i2c_dev, int reg)
        return __raw_readw(i2c_dev->base + reg);
 }
=20
+#ifdef CONFIG_ARCH_OMAP34XX
+void omap3_i2c_save_context(struct omap_i2c_dev *dev)
+{
+       dev->context.sysc =3D omap_i2c_read_reg(dev, OMAP_I2C_SYSC_REG)=
;
+       dev->context.psc =3D omap_i2c_read_reg(dev, OMAP_I2C_PSC_REG);
+       dev->context.scll =3D omap_i2c_read_reg(dev, OMAP_I2C_SCLL_REG)=
;
+       dev->context.sclh =3D omap_i2c_read_reg(dev, OMAP_I2C_SCLH_REG)=
;
+       dev->context.buf =3D omap_i2c_read_reg(dev, OMAP_I2C_BUF_REG);
+}
+
+void omap3_i2c_restore_context(struct omap_i2c_dev *dev)
+{
+       omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG, dev->context.sysc);
+       omap_i2c_write_reg(dev, OMAP_I2C_PSC_REG, dev->context.psc);
+       omap_i2c_write_reg(dev, OMAP_I2C_SCLL_REG, dev->context.scll);
+       omap_i2c_write_reg(dev, OMAP_I2C_SCLH_REG, dev->context.sclh);
+       omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG, dev->context.buf);
+}
+#endif
+
 static int __init omap_i2c_get_clocks(struct omap_i2c_dev *dev)
 {
        if (cpu_is_omap16xx() || cpu_class_is_omap2()) {
@@ -210,6 +241,10 @@ static void omap_i2c_unidle(struct omap_i2c_dev *d=
ev)
                clk_enable(dev->iclk);
        clk_enable(dev->fclk);
        dev->idle =3D 0;
+
+       if (cpu_is_omap34xx())
+               omap3_i2c_restore_context(dev);
+
        if (dev->iestate)
                omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, dev->iestate);
 }
@@ -344,6 +379,10 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
                        OMAP_I2C_IE_ARDY | OMAP_I2C_IE_NACK |
                        OMAP_I2C_IE_AL)  | ((dev->fifo_size) ?
                                (OMAP_I2C_IE_RDR | OMAP_I2C_IE_XDR) : 0=
));
+
+       if (cpu_is_omap34xx())
+               omap3_i2c_save_context(dev);
+
        return 0;
 }
=20
@@ -496,8 +535,6 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_=
msg msgs[], int num)
=20
        omap_i2c_unidle(dev);
=20
-       omap_i2c_init(dev);
-
        if ((r =3D omap_i2c_wait_for_bb(dev)) < 0)
                goto out;

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
