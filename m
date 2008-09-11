From: "shekhar, chandra" <x0044955@ti.com>
Subject: Re: [PATCH 04/12] I2C re-init for every cmd
Date: Thu, 11 Sep 2008 16:03:59 +0530
Message-ID: <002201c913f9$e86ecdd0$LocalHost@wipultra806>
References: <59975.192.168.10.89.1220276306.squirrel@dbdmail.itg.ti.com> <87sks79exx.fsf@trdhcp146196.ntc.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45955 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752219AbYIKKeQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Sep 2008 06:34:16 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?utf-8?Q?=22H=C3=B6gander=22_Jouni?= <jouni.hogander@nokia.com>, ext Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

Hi,

=46ew comments inlined.

Regards,
Chandra
----- Original Message -----=20
=46rom: ""H=C3=B6gander" Jouni" <jouni.hogander@nokia.com>
To: "ext Rajendra Nayak" <rnayak@ti.com>
Cc: <linux-omap@vger.kernel.org>
Sent: Thursday, September 11, 2008 3:34 PM
Subject: Re: [PATCH 04/12] I2C re-init for every cmd


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
> --- linux-omap-2.6.orig/drivers/i2c/busses/i2c-omap.c 2008-09-01
> 18:11:28.000000000 +0530
> +++ linux-omap-2.6/drivers/i2c/busses/i2c-omap.c 2008-09-01 18:11:52.=
000000000
> +0530
> @@ -496,6 +496,8 @@ omap_i2c_xfer(struct i2c_adapter *adap,
>
>  omap_i2c_unidle(dev);
>
> + omap_i2c_init(dev);
> +
>  if ((r =3D omap_i2c_wait_for_bb(dev)) < 0)
>  goto out;

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

+struct omap3_i2c_regs {
+       u16 sysc;
+       u16 psc;
+       u16 scll;
+       u16 sclh;
+       u16 buf;
+};
+



We can add this as a part of controller structure itself instaed of cre=
ating a=20
new structure. we will store this
psc, scll and others as a part of controller and just restore it. That =
way we=20
can do away with  omap3_i2c_save_context every time in clk disable.





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



I guess this should work for all the platforms. at least for omap2/3 it=
 should=20
work w/o any hiccups.
I2C_BUF is the only register which will require cpu check..so while res=
toring we=20
can put that check for 2430/34xx.


 };



 static inline void omap_i2c_write_reg(struct omap_i2c_dev *i2c_dev,
@@ -160,6 +171,26 @@ static inline u16 omap_i2c_read_reg(struct omap_i2=
c_dev=20
*i2c_dev, int reg)
        return __raw_readw(i2c_dev->base + reg);
 }

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



this will become redundant as data will be part of controller structure=
=2E


        return 0;
 }

@@ -496,8 +535,6 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_=
msg=20
msgs[], int num)

        omap_i2c_unidle(dev);

-       omap_i2c_init(dev);
-


instead of calling restore from clk_enable we can replace omap_i2c_init=
 by=20
omap3_i2c_restore_context. that way clock enable code will be clean.



        if ((r =3D omap_i2c_wait_for_bb(dev)) < 0)
                goto out;

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
