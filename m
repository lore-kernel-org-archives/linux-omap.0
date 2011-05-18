From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PM-WIP/voltdm_c][PATCH 06/11] OMAP4: PM: VC: fix channel bit
 offset for MPU
Date: Wed, 18 May 2011 04:47:09 -0500
Message-ID: <BANLkTimGiPSOyQDzoa2im3ewk9NbTjGJjg@mail.gmail.com>
References: <1305695854-9638-1-git-send-email-nm@ti.com> <1305695854-9638-7-git-send-email-nm@ti.com>
 <87d3jgwdvv.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:58495 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756838Ab1ERJrb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 May 2011 05:47:31 -0400
Received: by mail-ww0-f53.google.com with SMTP id 40so1372861wwj.10
        for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 02:47:29 -0700 (PDT)
In-Reply-To: <87d3jgwdvv.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

On Wed, May 18, 2011 at 04:34, Kevin Hilman <khilman@ti.com> wrote:
> Nishanth Menon <nm@ti.com> writes:
>
>> Patch "OMAP3+: VC: abstract out channel configuration" abstracts out
>> VC channel configuration. However, TRM has it's little surprises suc=
h
>> as the following for channel_cfg:
>> CFG_CHANNEL_SA =A0 =A0BIT(0)
>> CFG_CHANNEL_RAV =A0 BIT(1)
>> CFG_CHANNEL_RAC =A0 BIT(2)
>> CFG_CHANNEL_RACEN BIT(3)
>> CFG_CHANNEL_CMD =A0 BIT(4)
>> is valid for core and iva, *but* for mpu, the channel offsets
>> are as follows:
>> CFG_CHANNEL_SA =A0 =A0BIT(0)
>> CFG_CHANNEL_CMD =A0 BIT(1)
>> CFG_CHANNEL_RAV =A0 BIT(2)
>> CFG_CHANNEL_RAC =A0 BIT(3)
>> CFG_CHANNEL_RACEN BIT(4)
>
> sigh, glad to see the IP designers have something to do. :(
/me thinks "lets say 'integration folks'.." ;)

>
> Hmm, and I don't suppose there's any chance we can tell the differenc=
e
> based on IP revision information from the IP? =A0After looking at the=
 TRM
> and the functional spec, there's a difference. =A0In the funcional sp=
ec,
> all 3 OMAP4 VCs have the "default" order, but in the TRM, the MPU is
> different. =A0Which one is right? =A0 I assume you found this because=
 of a
> bug in testing, so I take it the TRM is right.
Unfortunately, that is what I have been burnt previously upon as well
- in all cases, I have been told, "in case of conflict funcspec Vs
TRM, believe the TRM" as there is integration aspects of an IP for an
SoC involved :(. Unfortunately in this case, MPU caused core to
transition until fixed.

>
>> to handle this on the fly, add a structure to describe this
>> and use the structure for vc44xx mpu definition. use the
>> default for rest of the domains.
>
> IMO, while it makes us generate a few more struct in the data, I thin=
k
> it's cleaner to not treat this as an exception. =A0IOW, just define
> the channel struct(s) in each data file, so every VC has one associat=
ed
> with it. =A0Probably also need a WARN() and graceful failure during i=
nit
> if a channel doesn't have a channel config defined.
=2E.

>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/vc.c =A0 =A0 =A0 =A0 =A0| =A0 35 ++++++++++++=
+++++++----------------
>> =A0arch/arm/mach-omap2/vc.h =A0 =A0 =A0 =A0 =A0| =A0 33 ++++++++++++=
+++++++++++++++++++++
>> =A0arch/arm/mach-omap2/vc44xx_data.c | =A0 10 ++++++++++
>> =A03 files changed, 62 insertions(+), 16 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
>> index f8185d2..2add945 100644
>> --- a/arch/arm/mach-omap2/vc.c
>> +++ b/arch/arm/mach-omap2/vc.c
[..]
>>
>> + =A0 =A0 /* if there is an exception case, use the exception data *=
/
>> + =A0 =A0 if (!vc->cfg_ch_data)
>> + =A0 =A0 =A0 =A0 =A0 =A0 cfg_channel_data =3D &cfg_channel_common;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 cfg_channel_data =3D vc->cfg_ch_data;
>
> Based on the above, =A0this block could be dropped, and...
Except I will have to replicate this for OMAP3 and 4 - which is
possible.. but replicated data which is needed only during init
:( did not want vc pointer to contain __initdata pointer (dangling
ones after boot)

>
>> =A0 =A0 =A0 vc->cfg_channel =3D 0;
>>
>> =A0 =A0 =A0 /* get PMIC/board specific settings */
>> @@ -284,7 +286,7 @@ void __init omap_vc_init_channel(struct voltaged=
omain *voltdm)
>> =A0 =A0 =A0 voltdm->rmw(vc->smps_sa_mask,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vc->i2c_slave_addr << __ffs(vc->=
smps_sa_mask),
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vc->common->smps_sa_reg);
>> - =A0 =A0 vc->cfg_channel |=3D CFG_CHANNEL_SA;
>> + =A0 =A0 vc->cfg_channel |=3D cfg_channel_data->cfg_channel_sa;
>
> ...this would look like
>
> =A0 =A0 =A0 =A0vc->cfg_channel |=3D vc->cfg_ch_bits->sa;
>
> and similar for below.
ok..
[...]

>> diff --git a/arch/arm/mach-omap2/vc.h b/arch/arm/mach-omap2/vc.h
>> index f0fb61f..bbd8f1f 100644
>> --- a/arch/arm/mach-omap2/vc.h
>> +++ b/arch/arm/mach-omap2/vc.h
>> @@ -62,11 +62,42 @@ struct omap_vc_common {
>> =A0 =A0 =A0 u8 i2c_mcode_mask;
>> =A0};
>>
>> +/*
>> + * Channel configuration bits, common for OMAP3 & 4
>> + * OMAP3 register: PRM_VC_CH_CONF
>> + * OMAP4 register: PRM_VC_CFG_CHANNEL
>> + */
>> +#define CFG_CHANNEL_SA =A0 =A0BIT(0)
>> +#define CFG_CHANNEL_RAV =A0 BIT(1)
>> +#define CFG_CHANNEL_RAC =A0 BIT(2)
>> +#define CFG_CHANNEL_RACEN BIT(3)
>> +#define CFG_CHANNEL_CMD =A0 BIT(4)
>> +#define CFG_CHANNEL_MASK 0x3f
>> +/**
>> + * struct omap_vc_channel_cfg - describe the cfg_channel bitfield
>> + * @cfg_channel_sa: =A0SA_VDD_xxx_L
>> + * @cfg_channel_rav: RAV_VDD_xxx_L
>> + * @cfg_channel_rac: RAC_VDD_xxx_L
>> + * @cfg_channel_racen: =A0 =A0 =A0 RACEN_VDD_xxx_L
>> + * @cfg_channel_cmd: CMD_VDD_xxx_L
>
> You should drop the cfg_channel_ prefix here (and below.)
ok..

>
>> + *
>> + * by default it uses CFG_CHANNEL_xyz regs, but in OMAP4 MPU,
>> + * there is a need for an exception case.
>
> This comment isn't really needed here. =A0IOW, let's assume it's not =
an
> exception, as new SoCs might decide to change again.
true.

[..]
>> =A0 */
>> =A0struct omap_vc_channel {
>> =A0 =A0 =A0 /* channel state */
>> @@ -74,6 +105,7 @@ struct omap_vc_channel {
>> =A0 =A0 =A0 u8 volt_reg_addr;
>> =A0 =A0 =A0 u8 cmd_reg_addr;
>> =A0 =A0 =A0 u8 cfg_channel;
>> + =A0 =A0 struct omap_vc_channel_cfg *cfg_ch_data;
>
> s/cfg_ch_data/cfg_ch_bits/
ok.

>
>> =A0 =A0 =A0 u16 setup_time;
>> =A0 =A0 =A0 bool i2c_high_speed;
>>
>> @@ -86,6 +118,7 @@ struct omap_vc_channel {
>> =A0 =A0 =A0 u8 cfg_channel_sa_shift;
>> =A0};
>>
>> +
>
> stray whitespace change
oops :( will fix in rev2

[...]


Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
