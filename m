From: "Gulati, Shweta" <shweta.gulati@ti.com>
Subject: Re: [PATCH V4] OMAP3: PM: Set/clear T2 bit for Smartreflex on TWL
Date: Wed, 16 Feb 2011 17:24:30 +0530
Message-ID: <AANLkTiniGdh2_=eFjSaLsQ4VVG1Eh0F=0Tex-KNKspBf@mail.gmail.com>
References: <1297756738-2696-1-git-send-email-shweta.gulati@ti.com>
	<20110215171652.601c9c68.jhnikula@gmail.com>
	<20110215172931.3a6e45a8.jhnikula@gmail.com>
	<AANLkTi=3PCBOvFtd1T-=tDjXcs+_0opKqxVps+StCZqf@mail.gmail.com>
	<20110216134523.ba5d3917.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:48309 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751067Ab1BPLyb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 06:54:31 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so1498370bwz.24
        for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 03:54:30 -0800 (PST)
In-Reply-To: <20110216134523.ba5d3917.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: linux-omap@vger.kernel.org, Thara Gopinath <thara@ti.com>, Nishanth Menon <nm@ti.com>, linux-arm-kernel@lists.infradead.org

Jarkko,

On Wed, Feb 16, 2011 at 5:15 PM, Jarkko Nikula <jhnikula@gmail.com> wro=
te:
> On Wed, 16 Feb 2011 11:22:09 +0530
> "Gulati, Shweta" <shweta.gulati@ti.com> wrote:
>
>> On Tue, Feb 15, 2011 at 8:59 PM, Jarkko Nikula <jhnikula@gmail.com> =
wrote:
>> > Probably discussed earlier but would it make more sense to have fl=
ag in
>> > struct twl4030_platform_data and to do registers writes in twl-cor=
e?
>> > Looks suspicious to have i2c_writes under arch/arm/.
>> twl_i2c_read/write APIs are used from arch/arm in many board files,
>> so I think it should not cause any issue.
>
> Not good either e.g. in modularization point of view. I was thinking
> something like below. I played safe and let the SR to be enabled only=
 if
> the twl4030_power_data.sr_enable is set. I read that Kevin had proble=
ms
> earlier with 2430SDP if SR was enabled.
>
> Note proof of concept patch only. I omitted the comments and don't do
> explicit SR disable and I'd clean up the error paths in twl4030_power=
_init
> a bit before this (e.g. printing error codes). Not sure either is the
> twl4030-power.c right place for this or core.
You missed commit log which says that "T2 bit is required to enable I2C=
_SR
path of voltage control" it is not at all enabling SR, voltage scale
APIs VPforceupdate/ VCbypass
needs this path to be enabled.
And calling APIs twl_i2c_read/write in driver codebase does n't ensure =
correct
ordering of flag changes and twl_read/write.
> --
> Jarkko
>
> diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.=
c
> index 16422de0..e767b0f 100644
> --- a/drivers/mfd/twl4030-power.c
> +++ b/drivers/mfd/twl4030-power.c
> @@ -92,6 +92,9 @@ static u8 twl4030_start_script_address =3D 0x2b;
> =A0#define OFF_STATE_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A04
> =A0#define OFF_STATE_MASK =A0 =A0 =A0 =A0 (0xf << OFF_STATE_SHIFT)
>
> +#define TWL4030_DCDC_GLOBAL_CFG =A0 =A0 =A0 =A0PHY_TO_OFF_PM_RECEIVE=
R(0x61)
> +#define SMARTREFLEX_ENABLE =A0 =A0 BIT(3)
> +
> =A0static u8 res_config_addrs[] =3D {
> =A0 =A0 =A0 =A0[RES_VAUX1] =A0 =A0 =3D 0x17,
> =A0 =A0 =A0 =A0[RES_VAUX2] =A0 =A0 =3D 0x1b,
> @@ -510,6 +513,22 @@ int twl4030_remove_script(u8 flags)
> =A0 =A0 =A0 =A0return err;
> =A0}
>
> +int __init twl4030_sr_enable(void)
> +{
> + =A0 =A0 =A0 u8 temp;
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 ret =3D twl_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &te=
mp,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TWL4030_DCD=
C_GLOBAL_CFG);
> + =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> +
> + =A0 =A0 =A0 temp |=3D SMARTREFLEX_ENABLE;
> +
> + =A0 =A0 =A0 return twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, tem=
p,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TWL4030=
_DCDC_GLOBAL_CFG);
> +}
> +
> =A0void __init twl4030_power_init(struct twl4030_power_data *twl4030_=
scripts)
> =A0{
> =A0 =A0 =A0 =A0int err =3D 0;
> @@ -549,8 +568,15 @@ void __init twl4030_power_init(struct twl4030_po=
wer_data *twl4030_scripts)
>
> =A0 =A0 =A0 =A0err =3D twl_i2c_write_u8(TWL4030_MODULE_PM_MASTER, 0,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0TWL4030_PM_MASTER_PROT=
ECT_KEY);
> - =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 if (err) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("TWL4030 Unable to relock regis=
ters\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (twl4030_scripts->sr_enable)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D twl4030_sr_enable();
> + =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("TWL4030 Unable to set smartrefl=
ex. %d\n", err);
> =A0 =A0 =A0 =A0return;
>
> =A0unlock:
> diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
> index 61b9609..1f64e3e 100644
> --- a/include/linux/i2c/twl.h
> +++ b/include/linux/i2c/twl.h
> @@ -630,6 +630,7 @@ struct twl4030_power_data {
> =A0 =A0 =A0 =A0struct twl4030_script **scripts;
> =A0 =A0 =A0 =A0unsigned num;
> =A0 =A0 =A0 =A0struct twl4030_resconfig *resource_config;
> + =A0 =A0 =A0 bool sr_enable; /* Smartreflex enable state */
> =A0#define TWL4030_RESCONFIG_UNDEF =A0 =A0 =A0 =A0((u8)-1)
> =A0};
>
>
>

--=20
Thanks,
Regards,
Shweta
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
