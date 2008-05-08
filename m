From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [PATCH] ARM: OMAP: add RTC support to beagleboard
Date: Thu, 8 May 2008 19:04:58 +0200
Message-ID: <E0DD11B5-7C21-4B77-A980-BFB116BC1A96@student.utwente.nl>
References: <6996A016-47DB-45BF-8F78-8AD0051C4695@student.utwente.nl> <fb249edb0805080955h5222acdcy1fe8f3d83f251d43@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.utsp.utwente.nl ([130.89.2.8]:55731 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764153AbYEHRM1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 May 2008 13:12:27 -0400
In-Reply-To: <fb249edb0805080955h5222acdcy1fe8f3d83f251d43@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Beagle Board <beagleboard@googlegroups.com>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Op 8 mei 2008, om 18:55 heeft andrzej zaborowski het volgende  
geschreven:
> Something must be missing here, omap3_beagle_devices is not being  
> referenced.
>
> The missing line probably looks something like
> platform_add_devices(omap3_beagle_devices,  
> ARRAY_SIZE(omap3_beagle_devices));

You're 100% right :) I forgot --amend, so the patch missed my second  
commit

> You can also add the #ifdef around omap3_beagle_twl4030rtc_device to
> avoid a compiler warning, or drop it in both places.

The idea is that a next patch (rudimentary lcd support) will add  
device in there as well. I can move the ifdef for this patch if you  
want.

thanks for the review,

Koen

Updated patch:

This patch adds RTC support to the omap3 based beagleboard

Signed-off-by: Koen Kooi <koen@openembedded.org>
- ---
  arch/arm/mach-omap2/board-omap3beagle.c |   12 ++++++++++++
  1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach- 
omap2/board-omap3beagle.c
index 626f004..0c0cbfc 100644
- --- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -58,13 +58,25 @@ static struct omap_mmc_config  
omap3beagle_mmc_config __initdata = {
  	},
  };

+static struct platform_device omap3_beagle_twl4030rtc_device = {
+	.name           = "twl4030_rtc",
+	.id             = -1,
+};
+
  static struct omap_board_config_kernel omap3_beagle_config[]  
__initdata = {
  	{ OMAP_TAG_UART,	&omap3_beagle_uart_config },
  	{ OMAP_TAG_MMC,		&omap3beagle_mmc_config },
  };

+static struct platform_device *omap3_beagle_devices[] __initdata = {
+#ifdef CONFIG_RTC_DRV_TWL4030
+	&omap3_beagle_twl4030rtc_device,
+#endif
+};
+
  static void __init omap3_beagle_init(void)
  {
+	platform_add_devices(omap3_beagle_devices,  
ARRAY_SIZE(omap3_beagle_devices));
  	omap_board_config = omap3_beagle_config;
  	omap_board_config_size = ARRAY_SIZE(omap3_beagle_config);
  	omap_serial_init();
- --
1.5.4.3


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFIIzK8MkyGM64RGpERAgE7AJ9meokVhJ/V/iR3PfwNbf0ZeR0aDACcDP2/
2kdpcssXcbftzzC5o6D2mLU=
=dk6K
-----END PGP SIGNATURE-----
