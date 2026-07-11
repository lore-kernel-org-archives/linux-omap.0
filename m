Received: from mo4-p04-ob.smtp.rzone.de (mo4-p04-ob.smtp.rzone.de [81.169.146.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2873731D362;
	Sat, 11 Jul 2026 06:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783749769; cv=pass; b=e2pAqdVH7UpVc7yTiU6rQzypCZwqTYpTxa3fQiNibTyd5CYHjQQHU5i7rC/9SC+zqYPUX0EWZEClUttTPMYmQxe4RMeeH1dM0YASe5hyqAmuEONjhMtr86G9Zgy7nEdEI8GdBOP7VYIaAoP9n/GC6f7cu+H5gCC9JTaJgDSmHV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783749769; c=relaxed/simple;
	bh=k8TcFAtq5OzJ3ShLEbgL/dHs7mnwdxGIlUgLItpZfJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cK9qEmf92JiUxFSt2+ot1I4UKytZKbEvvcdjSirdwkoMLIQ3ETwPfUCpL9Qwc18BZ7m4SMuuhH4rMekKp+jEeh26ioDKTA7YQeaj2yOtPofxj2l9Yg2e2DvOvmArRUXLBiFyaJfPnWSuvOmJkIROYBuwhRFmgpZf36Q8ZPkZ2bM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=rz1xcUgX; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=8fCXSY9c; arc=pass smtp.client-ip=81.169.146.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="rz1xcUgX";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="8fCXSY9c"
ARC-Seal: i=1; a=rsa-sha256; t=1783749748; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=TwQnfT3mm1kEvuObLqPH26UYG9JlnWXuJEm4kkLExiYeF2ITQRRyvAmjz+RFzYzbz8
    oH7pXl9wIj6nyfDIWt3eZ2QFING/+AaK0StdVkNmVaK8U+cmolfy12LLsyVFXmi2zWEy
    Sm+NE5bmhhExGCcEuv3tSK9L2okCTrAVccjj9PiwWI9mKP5EPW0E3m2jFo8yBmSb4TVB
    HsqoS9B27maxZmSIxSRIxOw/q0tMEEJnt48uD3HiItjJQ9Do6sNXw52+jQkMDVAMIlho
    IXJbOvmTVvEupOus0KUL0UfQQGuKYN2651qlUKTibpnBArkwXNEN85V4IgeLOVDPJnKy
    hcpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1783749748;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=cPc+/CQe6kjMaEdJWNjK4a7APvXUbTuseVN/eSOqRFw=;
    b=sAKoWEC1jnAcNNC298HRqiXR+voHv8x7alycw5gAyhMegt7Xt2kJfxJL5Lg8nzhq1L
    ElvUJu031bdmnfcPnetnKM9ceKPC6zziCrB7ZYa0aWK6d9ylI8zGW563Mmm6Lw6BKA33
    WxG9/yXUnWWQWcx+xY6lu0PLEYgVy7H/FnvumgKtvjtqXxe4nOqq751gJkTyySOxCMKC
    h5Yb6wupre4S8JXFis+eeX9DhUEKvysdBKQMMoCIvwnyOHOmWQ9It5qk6TnfTOUJdEVv
    6J+Rt0W0MjDbchKj5kj3Q4+cKZYBsqOowKXs0XrOdojj3POZruK1MLcdRynitqZX/aSm
    qM+Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1783749748;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=cPc+/CQe6kjMaEdJWNjK4a7APvXUbTuseVN/eSOqRFw=;
    b=rz1xcUgXG3oRwXWGuBq9YszLtX8ZK6SlaG17IH5YGrw3A7mrDOpTZAdcMhUxTxwCvZ
    WG24sV2w6GG8tUs96rLlTJfrmcyA0C2442CcDjyZktLAwPHJH1x+wKLxwSlx+KaUFfeb
    x3g3P4XCuqDy1XuDP3zt/c0SWmxoEWs8KzDG+upus9n0ArC9U2XaRsvNtZY+bQx1StBd
    sArlVmTF3cwaIvzb34IbieodXXRUo0W2iz0QW5I8RvLUw4uD/RUdY52Jntd187lkRE6i
    NFiy+im6XC1ahh5DJAQDthZDJk7cHrI53Tn69al0UEzzoAhG688PZB1f/hQkzCGNSOQF
    mmGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1783749748;
    s=strato-dkim-0003; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=cPc+/CQe6kjMaEdJWNjK4a7APvXUbTuseVN/eSOqRFw=;
    b=8fCXSY9c1lXBeUHph8ovftMufel8JVUOdBANz0/iwCW3aXTxsZf4vEfOCYgOzusoqD
    OHE3a0UTXw2vRS3huIAg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrT35oLmciNszeF4HOToVDOd6S1gdjuILE2MKVd"
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 55.5.6 AUTH)
    with ESMTPSA id Q4b76426B62QGi2
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 11 Jul 2026 08:02:26 +0200 (CEST)
From: "H. Nikolaus Schaller" <hns@goldelico.com>
To: Grond <grond66@riseup.net>,
	Stefan Leichter <sle85276@gmx.de>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	Grazvydas Ignotas <notasas@gmail.com>,
	Tony Lindgren <tony@atomide.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Jarkko Nikula <jarkko.nikula@bitmer.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Andreas Kemnade <andreas@kemnade.info>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Sen Wang <sen@ti.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Niranjan H Y <niranjan.hy@ti.com>
Cc: letux-kernel@openphoenux.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	kernel@pyra-handheld.com,
	mfd@lists.linux.dev
Subject: [PATCH 16/16] arm: omap2: remove remaining pdata-quirks for pandora legacy devices
Date: Sat, 11 Jul 2026 08:02:03 +0200
Message-ID: <d380941287c655a3d205ee8b08516d364c0ddec9.1783749722.git.hns@goldelico.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1783749722.git.hns@goldelico.com>
References: <cover.1783749722.git.hns@goldelico.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

After updating the pandora-backligt setup and removing the omap3pandora
sound system and defining related gpios by device tree, we can remove
omap3_pandora_legacy_init() and the related legacy devices completely.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/mach-omap2/pdata-quirks.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index b947bacf23a37..aca7097a692ed 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -268,27 +268,6 @@ static void __init omap3_logicpd_torpedo_init(void)
 	omap3_gpio126_127_129();
 }
 
-/* omap3pandora legacy devices */
-
-static struct platform_device pandora_backlight = {
-	.name	= "pandora-backlight",
-	.id	= -1,
-};
-
-static struct gpiod_lookup_table pandora_soc_audio_gpios = {
-	.dev_id = "soc-audio",
-	.table = {
-		GPIO_LOOKUP("gpio-112-127", 6, "dac", GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP("gpio-0-15", 14, "amp", GPIO_ACTIVE_HIGH),
-		{ }
-	},
-};
-
-static void __init omap3_pandora_legacy_init(void)
-{
-	platform_device_register(&pandora_backlight);
-	gpiod_add_lookup_table(&pandora_soc_audio_gpios);
-}
 #endif /* CONFIG_ARCH_OMAP3 */
 
 #ifdef CONFIG_SOC_DRA7XX
@@ -514,8 +493,6 @@ static struct pdata_init pdata_quirks[] __initdata = {
 	{ "ti,omap3-evm-37xx", omap3_evm_legacy_init, },
 	{ "ti,am3517-evm", am3517_evm_legacy_init, },
 	{ "technexion,omap3-tao3530", omap3_tao3530_legacy_init, },
-	{ "openpandora,omap3-pandora-600mhz", omap3_pandora_legacy_init, },
-	{ "openpandora,omap3-pandora-1ghz", omap3_pandora_legacy_init, },
 #endif
 	{ /* sentinel */ },
 };
-- 
2.50.1 (Apple Git-155)

