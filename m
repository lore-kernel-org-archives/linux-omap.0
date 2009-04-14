From: Koen Kooi <koen@beagleboard.org>
Subject: Re: [PATCH v3] ARM: OMAP: board-ldp: add regulator info to get the microSD slot working again
Date: Tue, 14 Apr 2009 08:21:04 +0200
Message-ID: <19D54AAE-F3B8-412A-82CD-582F0A5F243D@beagleboard.org>
References: <1238489589-12216-1-git-send-email-koen@beagleboard.org> <200904021158.11612.david-b@pacbell.net>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-15--610139958"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f165.google.com ([209.85.219.165]:54066 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751532AbZDNGVT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Apr 2009 02:21:19 -0400
Received: by ewy9 with SMTP id 9so2461812ewy.37
        for <linux-omap@vger.kernel.org>; Mon, 13 Apr 2009 23:21:17 -0700 (PDT)
In-Reply-To: <200904021158.11612.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-15--610139958
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit

Tony, can this to into git?

regards,

Koen

Op 2 apr 2009, om 20:58 heeft David Brownell het volgende geschreven:

> Ack on that v3 patch, FWIW ... but also:
>
> On Tuesday 31 March 2009, Koen Kooi wrote:
>> +static const struct twl4030_resconfig ldp_resconfig[] = {
>> +       /* disable regulators that u-boot left enabled; the
>> +        * devices' drivers should be managing these.
>> +        */
>> +       { .resource = RES_VMMC1, },
>> +       { 0, },
>> +};
>> +
>
> Purely for information -- as in, maybe *more* regulators should
> be disabled -- here's a patch I tend to run with.  Obviously it's
> better to set the resconfig stuff than to do what this originally
> tried to do, but this predates resconfig.
>
> All this does (now) is print some messages that highlight when
> regulators end up in wierd states after initialization.
>
> - Dave
>
> ===============
> --- a/drivers/regulator/twl4030-regulator.c
> +++ b/drivers/regulator/twl4030-regulator.c
> @@ -39,6 +39,9 @@ struct twlreg_info {
> 	/* FIXED_LDO voltage */
> 	u8			deciV;
>
> +	/* true iff regulator is set up for Linux*/
> +	bool			in_use;
> +
> 	/* voltage in mV = table[VSEL]; table_len must be a power-of-two */
> 	u8			table_len;
> 	const u16		*table;
> @@ -419,6 +422,8 @@ static struct twlreg_info twl4030_regs[]
> 	/* VUSBCP is managed *only* by the USB subchip */
> };
>
> +static bool is_4030;
> +
> static int twl4030reg_probe(struct platform_device *pdev)
> {
> 	int				i;
> @@ -430,6 +435,8 @@ static int twl4030reg_probe(struct platf
> 	for (i = 0, info = NULL; i < ARRAY_SIZE(twl4030_regs); i++) {
> 		if (twl4030_regs[i].desc.id != pdev->id)
> 			continue;
> +		if (pdev->id == TWL4030_REG_VAUX2_4030)
> +			is_4030 = true;
> 		info = twl4030_regs + i;
> 		break;
> 	}
> @@ -458,6 +465,8 @@ static int twl4030reg_probe(struct platf
> 	}
> 	platform_set_drvdata(pdev, rdev);
>
> +	info->in_use = true;
> +
> 	/* NOTE:  many regulators support short-circuit IRQs (presentable
> 	 * as REGULATOR_OVER_CURRENT notifications?) configured via:
> 	 *  - SC_CONFIG
> @@ -469,6 +478,64 @@ static int twl4030reg_probe(struct platf
> 	return 0;
> }
>
> +/*
> + * Make sure all LDOs are in the P1 (Linux) group or none; and that
> + * if Linux can't have enabled them, they're in no group (disabled).
> + * Unused-but-enabled LDOs are a constant power drain.
> + *
> + * NOTE:  something else must disable LDOs which Linux manages, but
> + * which may have been wrongly enabled during system startup.
> + */
> +static __init int twl4030_ldo_tweak(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(twl4030_regs); i++) {
> +		struct twlreg_info *info = &twl4030_regs[i];
> +		int dev_grp, new_grp;
> +		int status;
> +
> +		/* ignore the "other" VAUX2 descriptor */
> +		if (info->base == 0x1b) {
> +			if (info->desc.id == TWL4030_REG_VAUX2_4030) {
> +				if (!is_4030)
> +					continue;
> +			} else {
> +				if (is_4030)
> +					continue;
> +			}
> +		}
> +
> +		dev_grp = twl4030reg_read(info, VREG_GRP);
> +		if (dev_grp < 0)
> +			continue;
> +		dev_grp &= 0xf0;
> +
> +		if (info->in_use)
> +			new_grp = dev_grp & (P1_GRP | WARM_CFG);
> +		else
> +			new_grp = 0;
> +		if (dev_grp == new_grp)
> +			continue;
> +
> +		/* reset and report this; the bootloader might be fixable */
> +#if 0
> +		status = twl4030reg_write(info, VREG_GRP, new_grp);
> +#else
> +		status = 0;
> +#endif
> +		if (status < 0)
> +			pr_err("TWL: can't update LDO %s, err %d\n",
> +				info->desc.name, status);
> +		else
> +			pr_info("TWL: LDO %s, dev_grp %02x --> %02x\n",
> +				info->desc.name, dev_grp, new_grp);
> +
> +	}
> +	return 0;
> +}
> +late_initcall(twl4030_ldo_tweak);
> +
> static int __devexit twl4030reg_remove(struct platform_device *pdev)
> {
> 	regulator_unregister(platform_get_drvdata(pdev));
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux- 
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--Apple-Mail-15--610139958
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: Dit deel van het bericht is digitaal ondertekend
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJ5CtVMkyGM64RGpERAlwUAJwKuAmD5smOINT0BXf0fVUcC+Fw7wCfYJlC
kzuyluSx7VAlyigJhal3hT0=
=eXtW
-----END PGP SIGNATURE-----

--Apple-Mail-15--610139958--
