From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 3/4] HSMMC: Add support for the second controller
Date: Fri, 31 Oct 2008 03:00:24 -0700
Message-ID: <200810310300.24515.david-b@pacbell.net>
References: <1225418657-31775-1-git-send-email-tony@atomide.com> <200810302012.35317.david-b@pacbell.net> <5e088bd90810302105n1132c280ga39179c057e55c3f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp116.sbc.mail.sp1.yahoo.com ([69.147.64.89]:20649 "HELO
	smtp116.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750809AbYJaKA0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 31 Oct 2008 06:00:26 -0400
In-Reply-To: <5e088bd90810302105n1132c280ga39179c057e55c3f@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Thursday 30 October 2008, Steve Sakoman wrote:
> > Overo has its SDIO WLAN chip (libertas) hard wired to the second co=
ntroller,
> > as I understand things ... or maybe it's the third one. =A0:)
>=20
> Correct! =A0The wi2wi chip is connected to mmc2 with a 4 bit data pat=
h.

With the appended patch on top of Tony's four, I get:

 mmc1: new SDIO card at address 0001
 firmware: requesting sd8686_helper.bin
 ...
 libertas: can't load helper firmware
 libertas: failed to load helper firmware
 libertas_sdio: probe of mmc1:0001:1 failed with error -2

So, progress.  What's the best place to get that stuff?
Do we know that this driver behaves with SDIO yet?

- dave


---
 arch/arm/mach-omap2/board-overo.c |    2 +-
 arch/arm/mach-omap2/hsmmc.c       |    1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -214,7 +214,7 @@ static void __init overo_init(void)
 	omap_board_config =3D overo_config;
 	omap_board_config_size =3D ARRAY_SIZE(overo_config);
 	omap_serial_init();
-	hsmmc_init(HSMMC1);
+	hsmmc_init(HSMMC1 | HSMMC2);
 	usb_musb_init();
 	usb_ehci_init();
 	overo_flash_init();
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -340,6 +340,7 @@ static struct omap_mmc_platform_data mmc
 static struct omap_mmc_platform_data mmc2_data =3D {
 	.nr_slots			=3D 1,
 	.slots[0] =3D {
+		.wire4			=3D 1,
 		.set_power		=3D hsmmc2_set_power,
 		.ocr_mask		=3D MMC_VDD_27_28 | MMC_VDD_28_29 |
 					  MMC_VDD_29_30 | MMC_VDD_30_31 |
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
