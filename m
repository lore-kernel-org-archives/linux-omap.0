Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5124831159C;
	Sat, 11 Jul 2026 06:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783749923; cv=pass; b=oyQY3IMMAr84b1MYoBgbB3CXME93oLH95EDLx0Ohs0vd2LYtg5RBl5hxY91Bh921aM2i/fQxTUAtfAtkyayX7nHsmUaFE9LSVZyleeTZn+9xgLIXoEn3WnypP6WmQpL34g0rO0b2ywgW+JdYIPbTCvm3kd889VX0OAJ05T02Gm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783749923; c=relaxed/simple;
	bh=dimLf08yaYuVTXwXLVmSUQtgyZHrl56dsYX4wDKhUfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ubgWuAeaUracbTkHWA3RzaJ7Nuznfyo+MEyY1jC2oOVzo7boRcAPJYPlnfRuSYKEN0PEvlU2NcvNVerES1q2xwAmNB7k73vXFHUJp7CAHGj8BYTfAPOiAfkPsVeoThS7U+agYgtRsvfFT+mymZxnVV6ZDJI6q/Iscq2Pc5g+tRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=XY7dnCSJ; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=hDVrjEmI; arc=pass smtp.client-ip=85.215.255.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="XY7dnCSJ";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="hDVrjEmI"
ARC-Seal: i=1; a=rsa-sha256; t=1783749729; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=UUOLd6ZyshpRymv4dMO+rXsVCXV2tZHyHRsZt7+F2cmqOcPlQnOcbv/LSWzLaNDgB/
    YNylaLvpItMRoF/TlLWQfY0AeqwQHyjViw6MRXXF/0RCvTe5vR/1vXCLSG3jEZNdHF+K
    iK5JSu/65A22CTSQsXAwTor+CE9wWmRpOoNsSh2+s0M7KhzCc4Mq3PLjdA96Od9zn7ai
    Zrrw5PoMJ06dQHAFe2ppTcHA2AqtYW4oGfmxs6LN3dcjEbB6A8LRss2t/31h/fe7QFhu
    VVJdiMcxyZQLEzc3qaDIQdejt+nBDFFt71gwhaXSkT4m0bG0CnTMgYaJmuPmSunE3ONm
    8vAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1783749729;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=5Okt1Bb33hbe5/L8F0+NBgH6ufNIVFYW7HZ0thAd5DA=;
    b=EOiIll0xUNOQO16tRr+AFZxfJKyD/dMmzbBK9pDwDM8iUEPho0teVtwsyY/dmxBJy8
    /ZkfclCgKDABxl6k9Hrg9rfw3+/FMnOuFN9AhoAS84SA/qaNbWpDNXgaRv2ReGkSluwe
    M/+z3p4tXw55Nsl393cMfgA+me91QxOzddKDiu+wNFWrxtjndyfYXvTrZHssWaC1V+D4
    ArROF93vwHJADQ52hfU3io1DEvXR8Sc20KIE2SGYLNghkjXefBsZP6rASsPOKxhdl9cz
    436vZEDGtUTtcMVT90HujVVbxUYRCgnecoUk+Ho5+lrVW9lSrlkyklHjxIoxm2eBdjSs
    R70A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1783749729;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=5Okt1Bb33hbe5/L8F0+NBgH6ufNIVFYW7HZ0thAd5DA=;
    b=XY7dnCSJueGYOy9UvXVGd6wc/nYTWW4OvK0E7XnuX+uFv5AaYufWrAVdAO8Sgw3zP+
    fJ5158HiEExFYOBnPgUgSjhH5fn62sU/w5ylGXg350dxNf4Hou6YLfVQlldraiGwEIPr
    dcZbh3DHadmjIVrBjhrcI0cKVGfgUNHTW5VJPdJ3nLyw/Ii6LmWyjyzfRLcyDH2UYSIV
    zzKfWcfkHoD05foa+8jVbnYuujJARRVAqXUgLU9K61zGsLEQm5eyw3tpiRoRKab2aCTI
    wgl2UI+u+QxxG7f/0jILfh6szUL7zFXiLXW4rs0XEoGsFHJTqk0P3nRk7OhDnoOHQK2+
    j7/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1783749729;
    s=strato-dkim-0003; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=5Okt1Bb33hbe5/L8F0+NBgH6ufNIVFYW7HZ0thAd5DA=;
    b=hDVrjEmIFOAJHf7Fq5bMo30S77ZameLirNq7/VgCssyuhHYXNrG8TlO2qfaxIuT8fw
    tWgU5Cx0gbYidKyBDHAA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrT35oLmciNszeF4HOToVDOd6S1gdjuILE2MKVd"
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 55.5.6 AUTH)
    with ESMTPSA id Q4b76426B628Ghm
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 11 Jul 2026 08:02:08 +0200 (CEST)
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
Subject: [PATCH 02/16] regulator: twl: Expose the TWL4030's REGEN signal as a regulator
Date: Sat, 11 Jul 2026 08:01:49 +0200
Message-ID: <1746667e5c17e2d39fc0747d7e098b32b3d7b479.1783749722.git.hns@goldelico.com>
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

From: Grond <grond66@riseup.net>

This is needed on some boards (for example, the Pandora), where REGEN is
used to drive external regulators.

Signed-off-by: Grond <grond66@riseup.net>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/regulator/twl-regulator.c | 52 +++++++++++++++++++++++++++++++
 include/linux/mfd/twl.h           |  3 ++
 2 files changed, 55 insertions(+)

diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index 5bacfcebf59aa..d883ee8abec32 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -451,6 +451,16 @@ static const struct regulator_ops twl4030fixed_ops = {
 	.get_status	= twl4030reg_get_status,
 };
 
+static const struct regulator_ops twl4030signal_ops = {
+	.enable		= twl4030reg_enable,
+	.disable	= twl4030reg_disable,
+	.is_enabled	= twl4030reg_is_enabled,
+
+	.set_mode	= twl4030reg_set_mode,
+
+	.get_status	= twl4030reg_get_status,
+};
+
 /*----------------------------------------------------------------------*/
 
 #define TWL4030_ADJUSTABLE_LDO(label, offset, num, turnon_delay, remap_conf) \
@@ -511,6 +521,24 @@ static const struct twlreg_info TWLFIXED_INFO_##label = { \
 		}, \
 	}
 
+#define TWL4030_SIGNAL(label, offset, num, remap_conf) \
+static const struct twlreg_info TWLSIGNAL_INFO_##label = { \
+	.base = offset, \
+	.id = num, \
+	.remap = remap_conf, \
+	.desc = { \
+		.name = #label, \
+		.id = TWL4030_REG_##label, \
+		.n_voltages = 1, \
+		.fixed_uV = 0, /* filled in from DT later */ \
+		.ops = &twl4030signal_ops, \
+		.type = REGULATOR_VOLTAGE, \
+		.owner = THIS_MODULE, \
+		.enable_time = 0, /* also filled in from DT */ \
+		.of_map_mode = twl4030reg_map_mode, \
+		}, \
+	}
+
 /*
  * We list regulators here if systems need some level of
  * software control over them after boot.
@@ -536,6 +564,7 @@ TWL4030_FIXED_LDO(VINTDIG, 0x47, 1500, 13, 100, 0x08);
 TWL4030_FIXED_LDO(VUSB1V5, 0x71, 1500, 17, 100, 0x08);
 TWL4030_FIXED_LDO(VUSB1V8, 0x74, 1800, 18, 100, 0x08);
 TWL4030_FIXED_LDO(VUSB3V1, 0x77, 3100, 19, 150, 0x08);
+TWL4030_SIGNAL(REGEN, 0x7f, 21, 0x08);
 
 #define TWL_OF_MATCH(comp, family, label) \
 	{ \
@@ -548,6 +577,7 @@ TWL4030_FIXED_LDO(VUSB3V1, 0x77, 3100, 19, 150, 0x08);
 #define TWL6032_OF_MATCH(comp, label) TWL_OF_MATCH(comp, TWL6032, label)
 #define TWLFIXED_OF_MATCH(comp, label) TWL_OF_MATCH(comp, TWLFIXED, label)
 #define TWLSMPS_OF_MATCH(comp, label) TWL_OF_MATCH(comp, TWLSMPS, label)
+#define TWLSIGNAL_OF_MATCH(comp, label) TWL_OF_MATCH(comp, TWLSIGNAL, label)
 
 static const struct of_device_id twl_of_match[] = {
 	TWL4030_OF_MATCH("ti,twl4030-vaux1", VAUX1),
@@ -570,6 +600,7 @@ static const struct of_device_id twl_of_match[] = {
 	TWLFIXED_OF_MATCH("ti,twl4030-vusb1v5", VUSB1V5),
 	TWLFIXED_OF_MATCH("ti,twl4030-vusb1v8", VUSB1V8),
 	TWLFIXED_OF_MATCH("ti,twl4030-vusb3v1", VUSB3V1),
+	TWLSIGNAL_OF_MATCH("ti,twl4030-regen", REGEN),
 	{},
 };
 MODULE_DEVICE_TABLE(of, twl_of_match);
@@ -583,6 +614,7 @@ static int twlreg_probe(struct platform_device *pdev)
 	struct regulation_constraints	*c;
 	struct regulator_dev		*rdev;
 	struct regulator_config		config = { };
+	int ret;
 
 	template = of_device_get_match_data(&pdev->dev);
 	if (!template)
@@ -615,6 +647,26 @@ static int twlreg_probe(struct platform_device *pdev)
 	case TWL4030_REG_VINTANA2:
 	case TWL4030_REG_VINTDIG:
 		c->always_on = true;
+		break;
+	case TWL4030_REG_REGEN:
+		if (c->min_uV == 0 || c->max_uV == 0) {
+			dev_err(&pdev->dev, "minimum or maximum regulator voltage zero in DT\n");
+			return -EINVAL;
+		}
+
+		if (c->min_uV != c->max_uV) {
+			dev_err(&pdev->dev, "minimum and maximum voltage are different in DT\n");
+			return -EINVAL;
+		}
+		info->desc.fixed_uV = c->min_uV;
+
+		ret = of_property_read_u32(pdev->dev.of_node, "startup-delay-us",
+					   &info->desc.enable_time);
+		if (ret) {
+			dev_err(&pdev->dev, "no valid startup delay set in DT: %d\n", ret);
+			return ret;
+		}
+
 		break;
 	default:
 		break;
diff --git a/include/linux/mfd/twl.h b/include/linux/mfd/twl.h
index b31e07fa4d516..d249b4b22c898 100644
--- a/include/linux/mfd/twl.h
+++ b/include/linux/mfd/twl.h
@@ -738,6 +738,9 @@ int twl4030_sih_setup(struct device *dev, int module, int irq_base);
 #define TWL4030_REG_VUSB1V8	18
 #define TWL4030_REG_VUSB3V1	19
 
+/* digital output signal for enabling external regulators */
+#define TWL4030_REG_REGEN	21
+
 /* TWL6030 SMPS/LDO's */
 /* EXTERNAL dc-to-dc buck convertor controllable via SR */
 #define TWL6030_REG_VDD1	30
-- 
2.50.1 (Apple Git-155)

