From: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Subject: Re: [PATCH 3/5] OMAP: I2C: Remove the reset in the init path
Date: Thu, 21 Jul 2011 14:01:42 +0530
Message-ID: <CANrkHUZbL++_-etFzRD55G8gMChrs9geXvLOXzacTLKshAfryw@mail.gmail.com>
References: <1311231185-5503-1-git-send-email-shubhrajyoti@ti.com>
	<1311231185-5503-4-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1311231185-5503-4-git-send-email-shubhrajyoti@ti.com>
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
> The reset in the driver at init is not needed
> anymore as the hwmod framework takes care of
> reseting it.
>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
> =A0drivers/i2c/busses/i2c-omap.c | =A0 57 +++++++++++--------------------=
----------
> =A01 files changed, 15 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 8f87a37..d6ea7de 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -155,9 +155,6 @@ enum {
> =A0#define OMAP_I2C_SYSTEST_SDA_O =A0 =A0 =A0 =A0 (1 << 0) =A0 =A0 =A0 =
=A0/* SDA line drive out */
> =A0#endif
>
> -/* OCP_SYSSTATUS bit definitions */
> -#define SYSS_RESETDONE_MASK =A0 =A0 =A0 =A0 =A0 =A0(1 << 0)
> -
> =A0/* OCP_SYSCONFIG bit definitions */
> =A0#define SYSC_CLOCKACTIVITY_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x3 <<=
 8)
> =A0#define SYSC_SIDLEMODE_MASK =A0 =A0 =A0 =A0 =A0 =A0(0x3 << 3)
> @@ -182,6 +179,8 @@ struct omap_i2c_dev {
> =A0 =A0 =A0 =A0u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 latency; =A0 =
=A0 =A0 =A0/* maximum mpu wkup latency */
> =A0 =A0 =A0 =A0void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(*set_mpu_wkup=
_lat)(struct device *dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0long latency);
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (*device_reset)=
(struct device *dev);
> +
> =A0 =A0 =A0 =A0u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 speed; =A0 =A0=
 =A0 =A0 =A0/* Speed of bus in Khz */
> =A0 =A0 =A0 =A0u16 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmd_err;
> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*buf;
> @@ -332,7 +331,6 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
> =A0 =A0 =A0 =A0u16 psc =3D 0, scll =3D 0, sclh =3D 0, buf =3D 0;
> =A0 =A0 =A0 =A0u16 fsscll =3D 0, fssclh =3D 0, hsscll =3D 0, hssclh =3D 0;
> =A0 =A0 =A0 =A0unsigned long fclk_rate =3D 12000000;
> - =A0 =A0 =A0 unsigned long timeout;
> =A0 =A0 =A0 =A0unsigned long internal_clk =3D 0;
> =A0 =A0 =A0 =A0struct clk *fclk;
> =A0 =A0 =A0 =A0struct platform_device *pdev;
> @@ -341,43 +339,7 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
> =A0 =A0 =A0 =A0pdev =3D to_platform_device(dev->dev);
> =A0 =A0 =A0 =A0pdata =3D pdev->dev.platform_data;
>
> - =A0 =A0 =A0 if (dev->rev >=3D OMAP_I2C_OMAP1_REV_2) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Disable I2C controller before soft reset=
 */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c_write_reg(dev, OMAP_I2C_CON_REG,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c_read_reg(dev, OMAP=
_I2C_CON_REG) &
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ~(OMAP_I2C_=
CON_EN));
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG, =
SYSC_SOFTRESET_MASK);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* For some reason we need to set the EN bi=
t before the
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* reset done bit gets set. */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout =3D jiffies + OMAP_I2C_TIMEOUT;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, O=
MAP_I2C_CON_EN);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (!(omap_i2c_read_reg(dev, OMAP_I2C_SY=
SS_REG) &
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SYSS_RESETDONE_MASK)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (time_after(jiffies, tim=
eout)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(de=
v->dev, "timeout waiting "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 "for controller reset\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ETI=
MEDOUT;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msleep(1);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* SYSC register is cleared by the reset; r=
ewrite it */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dev->rev =3D=3D OMAP_I2C_REV_ON_2430) {
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c_write_reg(dev, OMA=
P_I2C_SYSC_REG,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0SYSC_AUTOIDLE_MASK);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (dev->rev >=3D OMAP_I2C_REV_ON_34=
30) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->syscstate =3D SYSC_AUT=
OIDLE_MASK;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->syscstate |=3D SYSC_EN=
AWAKEUP_MASK;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->syscstate |=3D (SYSC_I=
DLEMODE_SMART <<
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __ffs(SYSC_SIDL=
EMODE_MASK));
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->syscstate |=3D (SYSC_C=
LOCKACTIVITY_FCLK <<
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __ffs(SYSC_CLOC=
KACTIVITY_MASK));
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c_write_reg(dev, OMA=
P_I2C_SYSC_REG,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->syscstate);
> + =A0 =A0 =A0 if (dev->rev >=3D OMAP_I2C_REV_ON_3430) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * Enabling all wakup sour=
ces to stop I2C freezing on
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * WFI instruction.

one extra level of indentation

> @@ -388,7 +350,7 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_i2c_w=
rite_reg(dev, OMAP_I2C_WE_REG,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev->westate);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}

same

> - =A0 =A0 =A0 }
> +

spurious change, This comment applies to other patches in the series.

> =A0 =A0 =A0 =A0omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
>
> =A0 =A0 =A0 =A0if (pdata->flags & OMAP_I2C_FLAG_ALWAYS_ARMXOR_CLK) {
