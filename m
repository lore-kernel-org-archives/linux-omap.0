From: David Cohen <dacohen@gmail.com>
Subject: Re: [PATCH 09/12] omap3: pm: TWL5030 version checking
Date: Sat, 19 Feb 2011 01:51:52 +0200
Message-ID: <AANLkTimuiYp1k2vMMnD-a=oqh==fkJdqsckTovguwqSO@mail.gmail.com>
References: <1298048938-1480-1-git-send-email-leslyam@ti.com>
	<1298048938-1480-10-git-send-email-leslyam@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:36217 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758109Ab1BRXvy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Feb 2011 18:51:54 -0500
Received: by wwa36 with SMTP id 36so4344273wwa.1
        for <linux-omap@vger.kernel.org>; Fri, 18 Feb 2011 15:51:53 -0800 (PST)
In-Reply-To: <1298048938-1480-10-git-send-email-leslyam@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lesly A M <leslyam@ti.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Hi,

On Fri, Feb 18, 2011 at 7:08 PM, Lesly A M <leslyam@ti.com> wrote:
> Added api to get the TWL5030 Si version from the IDCODE register.
> It is used for enabling the workaround for TWL errata 27.
>
> Signed-off-by: Lesly A M <leslyam@ti.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: David Derrick <dderrick@ti.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> ---
> =C2=A0drivers/mfd/twl-core.c =C2=A0| =C2=A0 50 ++++++++++++++++++++++=
+++++++++++++++++++++++++
> =C2=A0include/linux/i2c/twl.h | =C2=A0 10 +++++++++
> =C2=A02 files changed, 60 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
> index a35fa7d..211c2cc 100644
> --- a/drivers/mfd/twl-core.c
> +++ b/drivers/mfd/twl-core.c
> @@ -487,6 +487,56 @@ EXPORT_SYMBOL(twl_i2c_read_u8);
>
> =C2=A0/*-------------------------------------------------------------=
---------*/
>
> +/**
> + * twl_read_idcode_register - api to read the IDCODE register.
> + * @value: returns 32 bit IDCODE register value.
> + *
> + * Unlocks the IDCODE register and read the 32 bit value.
> + */
> +int twl_read_idcode_register(u32 *value)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int err =3D 0;

No need to initialize 'ret'.

> +
> + =C2=A0 =C2=A0 =C2=A0 err =3D twl_i2c_write_u8(TWL4030_MODULE_INTBR,=
 TWL_EEPROM_R_UNLOCK,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 R_UNLOCK_TEST_REG);
> + =C2=A0 =C2=A0 =C2=A0 if (err)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_err("TWL4030 Un=
able to unlock IDCODE registers\n");
> +
> + =C2=A0 =C2=A0 =C2=A0 err =3D twl_i2c_read(TWL4030_MODULE_INTBR, (u8=
 *)(value),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x0, 4);

Variable 'err' is being overwritten here.

> + =C2=A0 =C2=A0 =C2=A0 if (err)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_err("TWL4030: u=
nable to read IDCODE-%d\n", err);
> +
> + =C2=A0 =C2=A0 =C2=A0 err =3D twl_i2c_write_u8(TWL4030_MODULE_INTBR,=
 0x0, R_UNLOCK_TEST_REG);

Here again.

> + =C2=A0 =C2=A0 =C2=A0 if (err)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_err("TWL4030 Un=
able to relock IDCODE registers\n");
> +
> + =C2=A0 =C2=A0 =C2=A0 return err;

And then you're returning 'err'. Unless you care only about the last
'err' assignment, something is wrong here, isn't it? :)

> +}
> +
> +/**
> + * twl5030_get_si_ver - api to get TWL5030 Si version.
> + * @value: returns Si version from IDCODE.
> + *
> + * Api to get the TWL5030 Si version from IDCODE value.
> + */
> +int twl5030_get_si_ver(u32 *value)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int ret =3D 0;

No need to initialize 'ret'.

> + =C2=A0 =C2=A0 =C2=A0 static u32 twl_idcode;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (twl_idcode =3D=3D 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D twl_read_i=
dcode_register(&twl_idcode);
> + =C2=A0 =C2=A0 =C2=A0 if (ret)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_err("TWL4030 Un=
able to check Si version\n");

Shouldn't you return error here?

> +
> + =C2=A0 =C2=A0 =C2=A0 if (TWL_SIL_TYPE(twl_idcode) =3D=3D TWL_SIL_50=
30)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *value =3D TWL_SIL=
_REV(twl_idcode);

Otherwise, what happens here if twl_read_idcode_register() fails?

> +
> + =C2=A0 =C2=A0 =C2=A0 return ret;

return 0 if the code reaches this point.

Br,

David Cohen

> +}
> +EXPORT_SYMBOL(twl5030_get_si_ver);
> +
> =C2=A0static struct device *
> =C2=A0add_numbered_child(unsigned chip, const char *name, int num,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *pdata, u=
nsigned pdata_len,
> diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
> index f4bd475..5d3f2bf 100644
> --- a/include/linux/i2c/twl.h
> +++ b/include/linux/i2c/twl.h
> @@ -150,7 +150,15 @@
> =C2=A0#define MMC_PU =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x1 << 3)
> =C2=A0#define MMC_PD =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x1 << 2)
>
> +#define R_UNLOCK_TEST_REG =C2=A0 =C2=A0 =C2=A00x12
> +#define TWL_EEPROM_R_UNLOCK =C2=A0 =C2=A00x49
>
> +#define TWL_SIL_TYPE(rev) =C2=A0 =C2=A0 =C2=A0((rev) & 0x00FFFFFF)
> +#define TWL_SIL_REV(rev) =C2=A0 =C2=A0 =C2=A0 ((rev) >> 24)
> +#define TWL_SIL_5030 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x09002F
> +#define TWL5030_REV_1_0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A00x00
> +#define TWL5030_REV_1_1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A00x10
> +#define TWL5030_REV_1_2 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A00x30
>
> =C2=A0#define TWL4030_CLASS_ID =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 0x4030
> =C2=A0#define TWL6030_CLASS_ID =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 0x6030
> @@ -180,6 +188,8 @@ int twl_i2c_read_u8(u8 mod_no, u8 *val, u8 reg);
> =C2=A0int twl_i2c_write(u8 mod_no, u8 *value, u8 reg, unsigned num_by=
tes);
> =C2=A0int twl_i2c_read(u8 mod_no, u8 *value, u8 reg, unsigned num_byt=
es);
>
> +int twl5030_get_si_ver(u32 *value);
> +
> =C2=A0int twl6030_interrupt_unmask(u8 bit_mask, u8 offset);
> =C2=A0int twl6030_interrupt_mask(u8 bit_mask, u8 offset);
>
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
