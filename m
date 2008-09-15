From: "shekhar, chandra" <x0044955@ti.com>
Subject: Re: [PATCH 04/12] I2C re-init for every cmd
Date: Mon, 15 Sep 2008 12:27:23 +0530
Message-ID: <011d01c91700$4ef7eec0$LocalHost@wipultra806>
References: <56249.192.168.10.89.1221148518.squirrel@dbdmail.itg.ti.com> <877i9h7qjw.fsf@trdhcp146196.ntc.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48344 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751683AbYIOG5i (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Sep 2008 02:57:38 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?utf-8?Q?=22H=C3=B6gander=22_Jouni?= <jouni.hogander@nokia.com>
Cc: linux-omap@vger.kernel.org

Hi,

This patch looks ok.
i would have preferred runtime check for 34xx. It will be a bit overhea=
d for=20
previous platforms.
but will be good for  multi-omap support.

----- Original Message -----=20
=46rom: ""H=C3=B6gander" Jouni" <jouni.hogander@nokia.com>
To: "ext chandra shekhar" <x0044955@ti.com>
Cc: <linux-omap@vger.kernel.org>
Sent: Friday, September 12, 2008 1:18 PM
Subject: Re: [PATCH 04/12] I2C re-init for every cmd


"ext chandra shekhar" <x0044955@ti.com> writes:

> agreed..but i guess it will not compile for 2430 and prev. platforms.
> omap3_i2c_save_context and restore definition is under macro
> while call is not. let me know if i am missing something.
>
> also is SYSC register restore needed??

Here is the second version. Does it look any better to you?

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-oma=
p.c
index 3778735..0a11621 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -147,6 +147,12 @@ struct omap_i2c_dev {
        unsigned                b_hw:1;         /* bad h/w fixes */
        unsigned                idle:1;
        u16                     iestate;        /* Saved interrupt regi=
ster */
+#ifdef CONFIG_ARCH_OMAP34XX
+       u16                     pscstate;
+       u16                     scllstate;
+       u16                     sclhstate;
+       u16                     bufstate;
+#endif
 };

 static inline void omap_i2c_write_reg(struct omap_i2c_dev *i2c_dev,
@@ -209,16 +215,21 @@ static void omap_i2c_unidle(struct omap_i2c_dev *=
dev)
        if (dev->iclk !=3D NULL)
                clk_enable(dev->iclk);
        clk_enable(dev->fclk);
+
+#ifdef CONFIG_ARCH_OMAP34XX
+       omap_i2c_write_reg(dev, OMAP_I2C_PSC_REG, dev->pscstate);
+       omap_i2c_write_reg(dev, OMAP_I2C_SCLL_REG, dev->scllstate);
+       omap_i2c_write_reg(dev, OMAP_I2C_SCLH_REG, dev->sclhstate);
+       omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG, dev->bufstate);
+#endif
        dev->idle =3D 0;
-       if (dev->iestate)
-               omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, dev->iestate);
+       omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, dev->iestate);
 }

 static void omap_i2c_idle(struct omap_i2c_dev *dev)
 {
        u16 iv;

-       dev->iestate =3D omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
        omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, 0);
        if (dev->rev1)
                iv =3D omap_i2c_read_reg(dev, OMAP_I2C_IV_REG);
@@ -238,7 +249,7 @@ static void omap_i2c_idle(struct omap_i2c_dev *dev)

 static int omap_i2c_init(struct omap_i2c_dev *dev)
 {
-       u16 psc =3D 0, scll =3D 0, sclh =3D 0;
+       u16 psc =3D 0, scll =3D 0, sclh =3D 0, buf =3D 0;
        u16 fsscll =3D 0, fssclh =3D 0, hsscll =3D 0, hssclh =3D 0;
        unsigned long fclk_rate =3D 12000000;
        unsigned long timeout;
@@ -327,23 +338,30 @@ static int omap_i2c_init(struct omap_i2c_dev *dev=
)
        omap_i2c_write_reg(dev, OMAP_I2C_SCLL_REG, scll);
        omap_i2c_write_reg(dev, OMAP_I2C_SCLH_REG, sclh);

-       if (dev->fifo_size)
-               /* Note: setup required fifo size - 1 */
-               omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG,
-                                       (dev->fifo_size - 1) << 8 | /* =
RTRSH */
-                                       OMAP_I2C_BUF_RXFIF_CLR |
-                                       (dev->fifo_size - 1) | /* XTRSH=
 */
-                                       OMAP_I2C_BUF_TXFIF_CLR);
+       if (dev->fifo_size) {
+               /* Note: setup required fifo size - 1. RTRSH and XTRSH =
*/
+               buf =3D (dev->fifo_size - 1) << 8 | OMAP_I2C_BUF_RXFIF_=
CLR |
+                       (dev->fifo_size - 1) | OMAP_I2C_BUF_TXFIF_CLR;
+               omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG, buf);
+       }

        /* Take the I2C module out of reset: */
        omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);

        /* Enable interrupts */
-       omap_i2c_write_reg(dev, OMAP_I2C_IE_REG,
-                       (OMAP_I2C_IE_XRDY | OMAP_I2C_IE_RRDY |
+       dev->iestate =3D (OMAP_I2C_IE_XRDY | OMAP_I2C_IE_RRDY |
                        OMAP_I2C_IE_ARDY | OMAP_I2C_IE_NACK |
                        OMAP_I2C_IE_AL)  | ((dev->fifo_size) ?
-                               (OMAP_I2C_IE_RDR | OMAP_I2C_IE_XDR) : 0=
));
+                                           (OMAP_I2C_IE_RDR | OMAP_I2C=
_IE_XDR)=20
: 0);
+       omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, dev->iestate);
+
+#ifdef CONFIG_ARCH_OMAP34XX
+       dev->pscstate =3D psc;
+       dev->scllstate =3D scll;
+       dev->sclhstate =3D sclh;
+       dev->bufstate =3D buf;
+#endif
+
        return 0;
 }

@@ -496,8 +514,6 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_=
msg=20
msgs[], int num)

        omap_i2c_unidle(dev);

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
