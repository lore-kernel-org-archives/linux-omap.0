From: Koen Kooi <koen@beagleboard.org>
Subject: Re: [PATCH v3] ARM: OMAP: board-ldp: add regulator info to get the microSD slot working again
Date: Tue, 28 Apr 2009 21:43:20 +0200
Message-ID: <210E7912-04E6-4CF7-9970-243570FC6A6F@beagleboard.org>
References: <1238489589-12216-1-git-send-email-koen@beagleboard.org>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-5-647595864"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f176.google.com ([209.85.219.176]:64007 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751853AbZD1Tnc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Apr 2009 15:43:32 -0400
Received: by ewy24 with SMTP id 24so817741ewy.37
        for <linux-omap@vger.kernel.org>; Tue, 28 Apr 2009 12:43:30 -0700 (PDT)
In-Reply-To: <1238489589-12216-1-git-send-email-koen@beagleboard.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap List <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-5-647595864
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit

Seeing that a similar change to the pandora board went in, can this  
*please* get applied as well now?

Op 31 mrt 2009, om 10:53 heeft Koen Kooi het volgende geschreven:

> The ldp board was left behind when other boards got updated. The ldp  
> info was copied from the beagleboard board file and s/beagle/ldp/g
>
> Changes since v2:
> * fixed email address
> Changes since v1:
> * dropped vsim portion since only 4 pins are hooked up
>
> Signed-off-by: Koen Kooi <koen@beagleboard.org>
> ---
> arch/arm/mach-omap2/board-ldp.c |   32 ++++++++++++++++++++++++++++++ 
> ++
> 1 files changed, 32 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/ 
> board-ldp.c
> index 30926b0..19a5c15 100644
> --- a/arch/arm/mach-omap2/board-ldp.c
> +++ b/arch/arm/mach-omap2/board-ldp.c
> @@ -22,6 +22,7 @@
> #include <linux/clk.h>
> #include <linux/spi/spi.h>
> #include <linux/spi/ads7846.h>
> +#include <linux/regulator/machine.h>
> #include <linux/i2c/twl4030.h>
>
> #include <mach/hardware.h>
> @@ -450,7 +451,16 @@ static struct twl4030_script *twl4030_scripts[]  
> __initdata = {
> 	&wrst_script,
> };
>
> +static const struct twl4030_resconfig ldp_resconfig[] = {
> +	/* disable regulators that u-boot left enabled; the
> +	 * devices' drivers should be managing these.
> +	 */
> +	{ .resource = RES_VMMC1, },
> +	{ 0, },
> +};
> +
> static struct twl4030_power_data sdp3430_t2scripts_data __initdata = {
> +	.resource_config	= ldp_resconfig,
> 	.scripts	= twl4030_scripts,
> 	.size		= ARRAY_SIZE(twl4030_scripts),
> };
> @@ -474,6 +484,25 @@ static struct twl4030_madc_platform_data  
> ldp_madc_data = {
> 	.irq_line	= 1,
> };
>
> +static struct regulator_consumer_supply ldp_vmmc1_supply = {
> +	.supply			= "vmmc",
> +};
> +
> +/* VMMC1 for MMC1 pins CMD, CLK, DAT0..DAT3 (20 mA, plus card ==  
> max 220 mA) */
> +static struct regulator_init_data ldp_vmmc1 = {
> +	.constraints = {
> +		.min_uV			= 1850000,
> +		.max_uV			= 3150000,
> +		.valid_modes_mask	= REGULATOR_MODE_NORMAL
> +					| REGULATOR_MODE_STANDBY,
> +		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
> +					| REGULATOR_CHANGE_MODE
> +					| REGULATOR_CHANGE_STATUS,
> +	},
> +	.num_consumer_supplies	= 1,
> +	.consumer_supplies	= &ldp_vmmc1_supply,
> +};
> +
> static struct twl4030_platform_data ldp_twldata = {
> 	.irq_base	= TWL4030_IRQ_BASE,
> 	.irq_end	= TWL4030_IRQ_END,
> @@ -483,6 +512,7 @@ static struct twl4030_platform_data ldp_twldata  
> = {
> 	.madc		= &ldp_madc_data,
> 	.usb		= &ldp_usb_data,
> 	.power		= &sdp3430_t2scripts_data,
> +	.vmmc1		= &ldp_vmmc1,
> 	.gpio		= &ldp_gpio_data,
> 	.keypad		= &ldp_kp_twl4030_data,
> };
> @@ -530,6 +560,8 @@ static void __init omap_ldp_init(void)
> 	omap_serial_init();
> 	usb_musb_init();
> 	twl4030_mmc_init(mmc);
> +	/* link regulators to MMC adapters */
> +	ldp_vmmc1_supply.dev = mmc[0].dev;
> }
>
> static void __init omap_ldp_map_io(void)
> -- 
> 1.6.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux- 
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--Apple-Mail-5-647595864
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: Dit deel van het bericht is digitaal ondertekend
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJ91xaMkyGM64RGpERAq64AJ4wnnInn0TP9FNy2szzzypMrh9D4ACdEldq
jzhgGWaAp6nRtUf+TiUTV4Y=
=hL5x
-----END PGP SIGNATURE-----

--Apple-Mail-5-647595864--
