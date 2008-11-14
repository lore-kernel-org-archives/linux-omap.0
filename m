From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [PATCH 1/2] HSMMC: Make loopback clock configurable
Date: Fri, 14 Nov 2008 19:54:51 +0100
Message-ID: <DEAAB714-FF17-41B0-994C-63130A672772@student.utwente.nl>
References: <5e088bd90811132241i3a8ccdc3ua30d941e0315dc6f@mail.gmail.com> <1226659752-21741-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-21--726411221"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx1.utsp.utwente.nl ([130.89.2.12]:40120 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752027AbYKNSzX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Nov 2008 13:55:23 -0500
Received: from [172.20.1.5] (vpn006013.vpn.utwente.nl [130.89.6.13])
          by mx.utwente.nl (8.12.10/SuSE Linux 0.7) with ESMTP id mAEIssij017449
          for <linux-omap@vger.kernel.org>; Fri, 14 Nov 2008 19:54:54 +0100
In-Reply-To: <1226659752-21741-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-21--726411221
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 14 nov 2008, om 11:49 heeft Grazvydas Ignotas het volgende  
geschreven:

> On Fri, Nov 14, 2008 at 8:41 AM, Steve Sakoman <sakoman@gmail.com>  
> wrote:
>> On Thu, Nov 13, 2008 at 3:06 PM, Tony Lindgren <tony@atomide.com>  
>> wrote:
>>> * Grazvydas Ignotas <notasas@gmail.com> [081113 13:40]:
>>>> Some boards use input clock from external pin for MMC/SDIO
>>>> modules in OMAP chips. Make that option selectable instead of
>>>> forcing loop back clock on everyone.
>>>
>>> Thanks, pushing both today.
>>
>> Hmm . . . not sure if it is related to this patch, but I now get an
>> oops on Overo.
>
> Oops.. Haven't thought to try it without gpio_cd set up, in which  
> case c->mmc
> is not set initialized.. Please try the following patch:

This also fixes mmc on omap3evm.

regards,

Koen

>
>
>
> diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/ 
> mmc-twl4030.c
> index 0ea6ba6..626d668 100644
> --- a/arch/arm/mach-omap2/mmc-twl4030.c
> +++ b/arch/arm/mach-omap2/mmc-twl4030.c
> @@ -239,6 +239,7 @@ static int twl_mmc1_set_power(struct device  
> *dev, int slot, int power_on,
> 	u32 reg;
> 	int ret = 0;
> 	struct twl_mmc_controller *c = &hsmmc[0];
> +	struct omap_mmc_platform_data *mmc = dev->platform_data;
>
> 	if (power_on) {
> 		if (cpu_is_omap2430()) {
> @@ -250,7 +251,7 @@ static int twl_mmc1_set_power(struct device  
> *dev, int slot, int power_on,
> 			omap_ctrl_writel(reg, OMAP243X_CONTROL_DEVCONF1);
> 		}
>
> -		if (c->mmc->slots[0].internal_clock) {
> +		if (mmc->slots[0].internal_clock) {
> 			reg = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
> 			reg |= OMAP2_MMCSDIO1ADPCLKISEL;
> 			omap_ctrl_writel(reg, OMAP2_CONTROL_DEVCONF0);
> @@ -293,11 +294,11 @@ static int twl_mmc1_set_power(struct device  
> *dev, int slot, int power_on,
> static int twl_mmc2_set_power(struct device *dev, int slot, int  
> power_on, int vdd)
> {
> 	int ret;
> -
> 	struct twl_mmc_controller *c = &hsmmc[1];
> +	struct omap_mmc_platform_data *mmc = dev->platform_data;
>
> 	if (power_on) {
> -		if (c->mmc->slots[0].internal_clock) {
> +		if (mmc->slots[0].internal_clock) {
> 			u32 reg;
>
> 			reg = omap_ctrl_readl(control_devconf1_offset);
> --
> To unsubscribe from this list: send the line "unsubscribe linux- 
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--Apple-Mail-21--726411221
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJHcl+MkyGM64RGpERAnqAAJ9a2EbPxK/2sO904eSYpluexAHSVQCeLa+g
I1yfa3UkAIUcDbOjrlJR1nc=
=SUWN
-----END PGP SIGNATURE-----

--Apple-Mail-21--726411221--
