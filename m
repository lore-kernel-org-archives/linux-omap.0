From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH v8 4/7] omap3: pm: TWL5030 version checking
Date: Thu, 10 Mar 2011 09:45:46 +0530
Message-ID: <AANLkTimO1b5OXUj_Vjsp1YD6W5yOFBzdHFQVoQk_HJ5K@mail.gmail.com>
References: <1299072653-13414-1-git-send-email-leslyam@ti.com> <1299072653-13414-5-git-send-email-leslyam@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:56904 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751119Ab1CJEQI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Mar 2011 23:16:08 -0500
Received: by mail-ww0-f43.google.com with SMTP id 17so1262148wwb.24
        for <linux-omap@vger.kernel.org>; Wed, 09 Mar 2011 20:16:06 -0800 (PST)
In-Reply-To: <1299072653-13414-5-git-send-email-leslyam@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lesly A M <leslyam@ti.com>
Cc: linux-omap@vger.kernel.org, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

$subject - OMAP3: pm? this is mfd twl-core rt?

On Wed, Mar 2, 2011 at 19:00, Lesly A M <leslyam@ti.com> wrote:
>
> Added api to get the TWL5030 Si version from the IDCODE register.
Does this work for 4030 and TPS variants as well? since this is
twl-core - how about the impact to 6030?

> It is used for enabling the workaround for TWL errata 27.
>
> Signed-off-by: Lesly A M <leslyam@ti.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: David Derrick <dderrick@ti.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> ---
> =A0drivers/mfd/twl-core.c =A0| =A0 61 +++++++++++++++++++++++++++++++=
++++++++++++++++
> =A0include/linux/i2c/twl.h | =A0 17 ++++++++++++-
> =A02 files changed, 77 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
> index a35fa7d..5e706d7 100644
> --- a/drivers/mfd/twl-core.c
> +++ b/drivers/mfd/twl-core.c
> @@ -229,6 +229,9 @@
> =A0/* is driver active, bound to a chip? */
> =A0static bool inuse;
>
> +/* TWL IDCODE Register value */
> +static u32 twl_idcode;
> +
> =A0static unsigned int twl_id;
> =A0unsigned int twl_rev(void)
> =A0{
> @@ -487,6 +490,61 @@ EXPORT_SYMBOL(twl_i2c_read_u8);
>
> =A0/*----------------------------------------------------------------=
------*/
>
> +/**
> + * twl_read_idcode_register - api to read the IDCODE register.
s/api/API ?
> + * @value: returns 32 bit IDCODE register value.
 Warning(drivers/mfd/twl-core.c:500): Excess function parameter
'value' description in 'twl_read_idcode_register'
please run scripts/kernel-doc on file when you add documentation to
ensure the documentation is in sync
> + *
> + * Unlocks the IDCODE register and read the 32 bit value.
> + */
> +int twl_read_idcode_register(void)
as previously mentioned:
drivers/mfd/twl-core.c:499:5: warning: symbol
'twl_read_idcode_register' was not declared. Should it be static?

> +{
> + =A0 =A0 =A0 int err;
> +
> + =A0 =A0 =A0 err =3D twl_i2c_write_u8(TWL4030_MODULE_INTBR, TWL_EEPR=
OM_R_UNLOCK,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 REG_UNLOCK_TEST_REG);
> + =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("TWL4030 Unable to unlock IDCODE=
 registers\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail;
> + =A0 =A0 =A0 }
Do you want to be consistent everywhere and provide err value in print =
as well?


> +
> + =A0 =A0 =A0 err =3D twl_i2c_read(TWL4030_MODULE_INTBR, (u8 *)(&twl_=
idcode),
Why should I cast this if I read only u8, why not make twl_idcode as u8=
?
Also modify twl_get_si_type, twl_get_si_version to return appropriately=
?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 REG_IDCODE_7_0, 4);
> + =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("TWL4030: unable to read IDCODE =
-%d\n", err);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 err =3D twl_i2c_write_u8(TWL4030_MODULE_INTBR, 0x0, REG=
_UNLOCK_TEST_REG);
> + =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("TWL4030 Unable to relock IDCODE=
 registers\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail;
why goto fail here?
> + =A0 =A0 =A0 }
> +fail:
> + =A0 =A0 =A0 return err;
> +}
> +
> +/**
> + * twl_get_si_type - api to get TWL Si type.
> + *
> + * Api to get the TWL Si type from IDCODE value.
> + */
> +int twl_get_si_type(void)
> +{
> + =A0 =A0 =A0 return TWL_SIL_TYPE(twl_idcode);
> +}
> +EXPORT_SYMBOL(twl_get_si_type);
EXPORT_SYMBOL_GPL instead?
> +
> +/**
> + * twl_get_si_version - api to get TWL Si version.
> + *
> + * Api to get the TWL Si version from IDCODE value.
> + */
> +int twl_get_si_version(void)
> +{
> + =A0 =A0 =A0 return TWL_SIL_REV(twl_idcode);
> +}
> +EXPORT_SYMBOL(twl_get_si_version);
^^^^ here as well.
> +
> =A0static struct device *
> =A0add_numbered_child(unsigned chip, const char *name, int num,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0void *pdata, unsigned pdata_len,
> @@ -1056,6 +1114,9 @@ twl_probe(struct i2c_client *client, const stru=
ct i2c_device_id *id)
> =A0 =A0 =A0 =A0/* setup clock framework */
> =A0 =A0 =A0 =A0clocks_init(&client->dev, pdata->clock);
>
> + =A0 =A0 =A0 /* read TWL IDCODE Register */
> + =A0 =A0 =A0 twl_read_idcode_register();
> +
as already mentioned, what do we do when this fails?

> =A0 =A0 =A0 =A0/* load power event scripts */
> =A0 =A0 =A0 =A0if (twl_has_power() && pdata->power)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0twl4030_power_init(pdata->power);
> diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
> index f4bd475..d3cc2ac 100644
> --- a/include/linux/i2c/twl.h
> +++ b/include/linux/i2c/twl.h
> @@ -150,7 +150,12 @@
> =A0#define MMC_PU =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x=
1 << 3)
> =A0#define MMC_PD =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x=
1 << 2)
>
> -
> +#define TWL_SIL_TYPE(rev) =A0 =A0 =A0 =A0 =A0 =A0 =A0((rev) & 0x00FF=
=46FFF)
> +#define TWL_SIL_REV(rev) =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((rev) >> 24)
> +#define TWL_SIL_5030 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x09002F
> +#define TWL5030_REV_1_0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A00x00
> +#define TWL5030_REV_1_1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A00x10
> +#define TWL5030_REV_1_2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A00x30
how about 4030 and 6030?

>
> =A0#define TWL4030_CLASS_ID =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x4030
> =A0#define TWL6030_CLASS_ID =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x6030
> @@ -180,6 +185,9 @@ int twl_i2c_read_u8(u8 mod_no, u8 *val, u8 reg);
> =A0int twl_i2c_write(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes=
);
> =A0int twl_i2c_read(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes)=
;
>
> +int twl_get_si_type(void);
> +int twl_get_si_version(void);
Please change the names of these APIs - what is Si?

> +
> =A0int twl6030_interrupt_unmask(u8 bit_mask, u8 offset);
> =A0int twl6030_interrupt_mask(u8 bit_mask, u8 offset);
>
> @@ -279,7 +287,12 @@ static inline int twl6030_mmc_card_detect(struct=
 device *dev, int slot)
> =A0*(Use TWL_4030_MODULE_INTBR)
> =A0*/
>
> +#define REG_IDCODE_7_0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x00
> +#define REG_IDCODE_15_8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A00x01
> +#define REG_IDCODE_16_23 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x02
> +#define REG_IDCODE_31_24 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x03
> =A0#define REG_GPPUPDCTR1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x0F
> +#:define REG_UNLOCK_TEST_REG =A0 =A0 =A0 =A0 =A0 =A00x12
>
> =A0/*I2C1 and I2C4(SR) SDA/SCL pull-up control bits */
>
> @@ -288,6 +301,8 @@ static inline int twl6030_mmc_card_detect(struct =
device *dev, int slot)
> =A0#define SR_I2C_SCL_CTRL_PU =A0 =A0 =A0 =A0 =A0 =A0 BIT(4)
> =A0#define SR_I2C_SDA_CTRL_PU =A0 =A0 =A0 =A0 =A0 =A0 BIT(6)
>
> +#define TWL_EEPROM_R_UNLOCK =A0 =A0 =A0 =A0 =A0 =A00x49
rest of the file seems to have a convention:
REG_NAME why is this register with a different convention?




Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
