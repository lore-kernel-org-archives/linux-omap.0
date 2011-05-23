From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [PATCHv2] OMAP3: beagle: add support for beagleboard xM revision C
Date: Mon, 23 May 2011 19:51:11 +0200
Message-ID: <B1F920DA-1316-4DB6-B88F-C956C0708C41@dominion.thruhere.net>
References: <y> <4dd6498f.4b1be30a.2c53.ffffd0ca@mx.google.com> <4DD91E12.4020006@compulab.co.il>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:46449 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755478Ab1EWRvQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 May 2011 13:51:16 -0400
Received: by wya21 with SMTP id 21so4397868wya.19
        for <linux-omap@vger.kernel.org>; Mon, 23 May 2011 10:51:15 -0700 (PDT)
In-Reply-To: <4DD91E12.4020006@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: linux-omap@vger.kernel.org, jkridner@beagleboard.org


Op 22 mei 2011, om 16:30 heeft Igor Grinberg het volgende geschreven:

> Hi Koen,
> 
> On 05/20/11 13:59, koen@dominion.thruhere.net wrote:
> 
>> From: Koen Kooi <koen@dominion.thruhere.net>
>> 
>> The USB enable GPIO has been inverted and the USER button moved.
>> 
>> Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>
>> ---
>> 
>> Changes since v1:
>> 	Fixed more xM references
>> 
>> arch/arm/mach-omap2/board-omap3beagle.c |   32 +++++++++++++++++++++++-------
>> 1 files changed, 24 insertions(+), 8 deletions(-)
>> 
>> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
>> index 2de4b02..1eb1e8e 100644
>> --- a/arch/arm/mach-omap2/board-omap3beagle.c
>> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
>> @@ -62,7 +62,9 @@
>>  *	AXBX	= GPIO173, GPIO172, GPIO171: 1 1 1
>>  *	C1_3	= GPIO173, GPIO172, GPIO171: 1 1 0
>>  *	C4	= GPIO173, GPIO172, GPIO171: 1 0 1
>> - *	XM	= GPIO173, GPIO172, GPIO171: 0 0 0
>> + *	XMA	= GPIO173, GPIO172, GPIO171: 0 0 0
>> + *	XMB	= GPIO173, GPIO172, GPIO171: 0 0 1
>> + *  XMC = GPIO173, GPIO172, GPIO171: 0 1 0
>>  */
>> enum {
>> 	OMAP3BEAGLE_BOARD_UNKN = 0,
>> @@ -70,6 +72,7 @@ enum {
>> 	OMAP3BEAGLE_BOARD_C1_3,
>> 	OMAP3BEAGLE_BOARD_C4,
>> 	OMAP3BEAGLE_BOARD_XM,
>> +	OMAP3BEAGLE_BOARD_XMC,
>> };
>> 
>> static u8 omap3_beagle_version;
>> @@ -124,9 +127,17 @@ static void __init omap3_beagle_init_rev(void)
>> 		printk(KERN_INFO "OMAP3 Beagle Rev: xM\n");
>> 		omap3_beagle_version = OMAP3BEAGLE_BOARD_XM;
>> 		break;
>> +	case 1:
>> +		printk(KERN_INFO "OMAP3 Beagle Rev: xM B\n");
>> +		omap3_beagle_version = OMAP3BEAGLE_BOARD_XM;
>> +		break;
>> +	case 2:
>> +		printk(KERN_INFO "OMAP3 Beagle Rev: xM C\n");
>> +		omap3_beagle_version = OMAP3BEAGLE_BOARD_XMC;
>> +		break;
>> 	default:
>> -		printk(KERN_INFO "OMAP3 Beagle Rev: unknown %hd\n", beagle_rev);
>> -		omap3_beagle_version = OMAP3BEAGLE_BOARD_UNKN;
>> +		printk(KERN_INFO "OMAP3 Beagle Rev: unknown %hd, assuming xM C or newer\n", beagle_rev);
> 
> Please, break this line so it will be < 80
> and also all occurrences below.
> 
>> +		omap3_beagle_version = OMAP3BEAGLE_BOARD_XMC;
>> 	}
>> 
>> 	return;
>> @@ -278,7 +289,7 @@ static int beagle_twl_gpio_setup(struct device *dev,
>> {
>> 	int r;
>> 
>> -	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM) {
>> +	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM || omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XMC) {
> 
> There is no real need to make it > 80
> 
>> 		mmc[0].gpio_wp = -EINVAL;
>> 	} else if ((omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_C1_3) ||
>> 		(omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_C4)) {
>> @@ -298,7 +309,7 @@ static int beagle_twl_gpio_setup(struct device *dev,
>> 	/* REVISIT: need ehci-omap hooks for external VBUS
>> 	 * power switch and overcurrent detect
>> 	 */
>> -	if (omap3_beagle_get_rev() != OMAP3BEAGLE_BOARD_XM) {
>> +	if (omap3_beagle_get_rev() != OMAP3BEAGLE_BOARD_XM && omap3_beagle_get_rev() != OMAP3BEAGLE_BOARD_XMC) {
>> 		r = gpio_request(gpio + 1, "EHCI_nOC");
>> 		if (!r) {
>> 			r = gpio_direction_input(gpio + 1);
>> @@ -320,7 +331,7 @@ static int beagle_twl_gpio_setup(struct device *dev,
>> 		gpio_direction_output(gpio + TWL4030_GPIO_MAX, 0);
>> 
>> 	/* DVI reset GPIO is different between beagle revisions */
>> -	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM)
>> +	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM || omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XMC)
>> 		beagle_dvi_device.reset_gpio = 129;
>> 	else
>> 		beagle_dvi_device.reset_gpio = 170;
>> @@ -334,7 +345,7 @@ static int beagle_twl_gpio_setup(struct device *dev,
>> 	 * P7/P8 revisions(prototype): Camera EN
>> 	 * A2+ revisions (production): LDO (supplies DVI, serial, led blocks)
>> 	 */
>> -	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM) {
>> +	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM || omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XMC) {
>> 		r = gpio_request(gpio + 1, "nDVI_PWR_EN");
>> 		if (!r) {
>> 			r = gpio_direction_output(gpio + 1, 0);
>> @@ -625,7 +636,7 @@ static void __init beagle_opp_init(void)
>> 	}
>> 
>> 	/* Custom OPP enabled for XM */
>> -	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM) {
>> +	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM || omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XMC) {
>> 		struct omap_hwmod *mh = omap_hwmod_lookup("mpu");
>> 		struct omap_hwmod *dh = omap_hwmod_lookup("iva");
>> 		struct device *dev;
>> @@ -665,6 +676,11 @@ static void __init omap3_beagle_init(void)
>> 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
>> 	omap3_beagle_init_rev();
>> 	omap3_beagle_i2c_init();
>> +
>> +	if (cpu_is_omap3630()) {
>> +		gpio_buttons[0].gpio = 4;
>> +	}
> 
> can't this kind of check be used in all the XM checks above?

Not in every case, I'll see which ones can be converted to this simpler check. I'll respin the patch with your other comments addressed.

regards

Koen