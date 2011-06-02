From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [pm_wip/voltdm_nm][PATCH v2 2/3] OMAP4: PM: VC: introduce concept
 of default channel
Date: Thu, 2 Jun 2011 18:53:38 -0500
Message-ID: <BANLkTimtJijoVjSX2csi8-MXzGzfbmQfSg@mail.gmail.com>
References: <1306711180-8631-1-git-send-email-nm@ti.com> <1306711180-8631-3-git-send-email-nm@ti.com>
 <87pqmvn6gk.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:58588 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752578Ab1FBXyA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 2 Jun 2011 19:54:00 -0400
Received: by mail-wy0-f171.google.com with SMTP id 32so1643063wyb.16
        for <linux-omap@vger.kernel.org>; Thu, 02 Jun 2011 16:53:58 -0700 (PDT)
In-Reply-To: <87pqmvn6gk.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

On Thu, Jun 2, 2011 at 18:45, Kevin Hilman <khilman@ti.com> wrote:
> Nishanth Menon <nm@ti.com> writes:
>
>> Due to a TRM bug, the current code assumes that channel0(core) is th=
e default
>> channel. With the additional explanation provided by the hardware te=
am, it is
>> clear that PRM_VC_CFG_CHANNEL register allows for flexibility of con=
figuring
>> for various PMIC configurations. For example, the I2C slave address =
on TWL6030
>> when using 4430 configuration could potentially use the same slave a=
ddress for
>> all domains, while in 4460 configuration, we drive MPU using TPS; Co=
re and IVA
>> using TWL6030. To allow this flexibility, we state in existing param=
eters using
>> a flag to indicate usage of default channel.
>>
>> In addition, the TRM update clears up the confusion on the fact that=
 MPU is
>> infact the default channel on OMAP4.
>>
>> We update the same here.
>>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>
> There's too much going on in this patch not described in the changelo=
g
> (extra error checking, volt & cmd reg checking etc.)
>
> Also, I don't like the USE_DEFAULT_CHANNEL_I2C_PARAM, mainly because =
it
> adds clutter without any obvious value. =A0To me, zero is a perfectly=
 good
> value to signify "use default channel value", especially since that's
> the value used by the hardware.
The reason is that 0 is a valid i2c register address. 8 bits is used
in VC and I wanted one bit which was further away, hence the 16 bit.
The usage could be that in .volt_reg_addr or in .cmd_reg_addr I could
set this up with the macro. and bingo, we use the default domain's
configuration.

This is esp useful if we had a single pmic reg for all domains.. I
mean the VC design allows for it, even though we dont use it
currently.
>
> Incidentally, adding this doesn't actually change current behavior.
> Currently, I use zero (an unconfigured value in the VC settings) to
> signify it should use default settings. =A0In your patch, you defined
> USE_DEFAULT_CHANNEL_I2C_PARAM as 0x10000 (17 bits) but assign it to 1=
6
> bit fields, which means they are just set to zero. :)


> So rather than take this patch, I'm just going to fold the following
> diff into "OMAP3+: VC: abstract out channel configuration" in voltdm_=
b.
> I'll also update the changelog noting that the TRM is wrong here in t=
hat
> it describes CORE as the default channel when it's in fact MPU.

I intend to post a new series including my PMIC changes as well early
next week(mondayish hopefully). Can we hold off review of any further
of my voltage fixes patches till then?

> Kevin
>
> diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
> index fba352d..fa48944 100644
> --- a/arch/arm/mach-omap2/vc.c
> +++ b/arch/arm/mach-omap2/vc.c
> @@ -33,21 +33,20 @@
> =A0* - command configuration address (RAC) and enable bit (RACEN)
> =A0* - command values for ON, ONLP, RET and OFF (CMD)
> =A0*
> - * This function currently only allows flexible configuration of
> - * the non-default channel (e.g. non-zero channels.) =A0Starting wit=
h
> - * OMAP4, only the non-zero channels can be configured. =A0Channel z=
ero
> - * always uses the channel zero register values. =A0Therefore, the
> - * same limitation is imposed on OMAP3 for consistency.
> + * This function currently only allows flexible configuration of the
> + * non-default channel. =A0Starting with OMAP4, there are more than =
2
> + * channels, with one defined as the default (on OMAP4, it's MPU.)
> + * Only the non-default channel can be configured.
> =A0*/
> =A0static int omap_vc_config_channel(struct voltagedomain *voltdm)
> =A0{
> =A0 =A0 =A0 =A0struct omap_vc_channel *vc =3D voltdm->vc;
>
> =A0 =A0 =A0 =A0/*
> - =A0 =A0 =A0 =A0* For channel zero, the only configurable bit is RAC=
EN.
> + =A0 =A0 =A0 =A0* For default channel, the only configurable bit is =
RACEN.
> =A0 =A0 =A0 =A0 * All others must stay at zero (see function comment =
above.)
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 if (!vc->cfg_channel_sa_shift)
> + =A0 =A0 =A0 if (vc->is_default_channel)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vc->cfg_channel &=3D CFG_CHANNEL_RACEN=
;
>
> =A0 =A0 =A0 =A0voltdm->rmw(CFG_CHANNEL_MASK << vc->cfg_channel_sa_shi=
ft,
> diff --git a/arch/arm/mach-omap2/vc.h b/arch/arm/mach-omap2/vc.h
> index f0fb61f..c216b57 100644
> --- a/arch/arm/mach-omap2/vc.h
> +++ b/arch/arm/mach-omap2/vc.h
> @@ -84,6 +84,8 @@ struct omap_vc_channel {
> =A0 =A0 =A0 =A0u32 smps_cmdra_mask;
> =A0 =A0 =A0 =A0u8 cmdval_reg;
> =A0 =A0 =A0 =A0u8 cfg_channel_sa_shift;
> +
> + =A0 =A0 =A0 bool is_default_channel;
> =A0};
>
> =A0extern struct omap_vc_channel omap3_vc_mpu;
> diff --git a/arch/arm/mach-omap2/vc44xx_data.c b/arch/arm/mach-omap2/=
vc44xx_data.c
> index fe4f4e5..5844b20 100644
> --- a/arch/arm/mach-omap2/vc44xx_data.c
> +++ b/arch/arm/mach-omap2/vc44xx_data.c
> @@ -58,6 +58,7 @@ struct omap_vc_channel omap4_vc_mpu =3D {
> =A0 =A0 =A0 =A0.smps_volra_mask =3D OMAP4430_VOLRA_VDD_MPU_L_MASK,
> =A0 =A0 =A0 =A0.smps_cmdra_mask =3D OMAP4430_CMDRA_VDD_MPU_L_MASK,
> =A0 =A0 =A0 =A0.cfg_channel_sa_shift =3D OMAP4430_SA_VDD_MPU_L_SHIFT,
> + =A0 =A0 =A0 .is_default_channel =3D true,
> =A0};
>
> =A0struct omap_vc_channel omap4_vc_iva =3D {
>


Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
