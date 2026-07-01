Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F1343637D
	for <linux-omap@vger.kernel.org>; Wed,  1 Jul 2026 15:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782918401; cv=none; b=gl317Q6Zws9kE/Gm5Z9QYoXRi7QDYK48WH+NNsTJXNRTGhSW3hmdqIhUW/7j+5BWmc6QlrF1imE23LEQ9ZpKyw6sxEWDrIy3US70+Kl8gR1ZjThMWXzSJDLn+PK2MbIVYq3eq3eTbYW1fP1s72aXmfvEuYfhS9L5m4dCXzKJ8KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782918401; c=relaxed/simple;
	bh=B1KLfxqZc7VNnr3/5F6pKI2LR1JslYubJtfNHtAUECE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AHAmAs62INFaqz493lrNqYCvk6Y+hxDIoST6WDZ+QW+sKHxqvd+kKeL7dnmPPMSrH6Zsu2NA9gZ0VagofBMQikA/RZl0abmToKeLco+fzwiErmwpNxzb/mzhCnF/JlQlCxocAgl6/HNNcHkN8Xy54azN0xwcF1+WBLwpmFmGyFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TtI1NB8w; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TtI1NB8w"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 657EA1A0DA0;
	Wed,  1 Jul 2026 15:06:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2F4C860288;
	Wed,  1 Jul 2026 15:06:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0D2F8104C9645;
	Wed,  1 Jul 2026 17:06:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782918395; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=OJZ+bRR/5vHeCzoVjWEL8tNwXwe+b//XD/OJdfUFeuw=;
	b=TtI1NB8w6taN1xX/KBgOl7Gd8TAxTN4SPEeO5I07Qx2rJr++dDez5zjO5jQhBTIq9AUpwN
	1uDZjPoNkBes5gZDFC/ur04qZEY3KJ/lCbyZ1B8jrfHHVvVSun2sBGS6DCB7EfuxQbt2Jq
	8kIiApZER9Dk4jX+og51TMVWOFgYYOeYhBESgcaCFhBS5GKzmc2R0aqqKTPV5AXYx8gkoV
	LZQ4ayeVlXfrBhQq6dlwnIsQ0Bjq5tCA9CwWIdDSrSMH6QQWc+s+zFoFXkbdCnH0agURZ4
	Krp/dHoj6nLGtwfNaJL8kfiqByNHzwlaCk1BwC4CPNNIY5x8IFJ9Wa+jlePGjQ==
From: Thomas Richard <thomas.richard@bootlin.com>
Date: Wed, 01 Jul 2026 17:06:28 +0200
Subject: [PATCH] clk: ti: omap4: Initialize DPLL_USB_M2 during the boot
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-clk-ti-omap4-dpll-usb-m2-v1-1-02d8a3845a55@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAPMsRWoC/x3MQQ5AMBBA0avIrE1SDSquIhbVDiaKpkUk4u4ay
 7f4/4FIgSlCmz0Q6OLI+5ZQ5BmYWW8TIdtkkELWoi4UGrfgwbiv2pdovXN4xgFXiUaRFZWioTE
 NpNwHGvn+113/vh9X3OkjagAAAA==
X-Change-ID: 20260617-clk-ti-omap4-dpll-usb-m2-c7ed057eb8c8
To: Tero Kristo <kristo@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Thomas Richard <thomas.richard@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Initialize and lock DPLL_USB_M2 at boot to make USB devices work.

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
Recently a series [1] adding back OMAP4 support in U-Boot has been merged
in next branch. While testing it, I noticed USB is not working on
omap4_var_som.

usb 1-1: new full-speed USB device number 8 using ohci-platform
usb 1-1: device descriptor read/64, error -62
usb 1-1: device descriptor read/64, error -62
usb 1-1: new full-speed USB device number 9 using ohci-platform
usb 1-1: device descriptor read/64, error -62
usb 1-1: device descriptor read/64, error -62
usb usb1-port1: attempt power cycle

The USB_M2 DPLL was previously initialized by U-Boot, but [1] lacks USB
support for OMAP4. This patch initializes the DPLL in the kernel to avoid
relying on the bootloader.

If you want to test, as U-Boot does not handle pbias regulators, you also
have to apply the patch series "[PATCH v2 00/11] Add SIM pbias regulator
support for USB on OMAP4" [2].

[1] https://lore.kernel.org/all/20260608-omap4-support-v3-0-8595ccd203f0@bootlin.com/
[2] https://lore.kernel.org/all/20260330-omap4-fix-usb-support-v2-0-1c1e11b190dc@bootlin.com/
---
 drivers/clk/ti/clk-44xx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/ti/clk-44xx.c b/drivers/clk/ti/clk-44xx.c
index 9b2824ed785b..3944c50b7cd0 100644
--- a/drivers/clk/ti/clk-44xx.c
+++ b/drivers/clk/ti/clk-44xx.c
@@ -811,6 +811,11 @@ int __init omap4xxx_dt_clk_init(void)
 	if (rc)
 		pr_err("%s: failed to configure USB DPLL!\n", __func__);
 
+	usb_dpll = clk_get_sys(NULL, "dpll_usb_m2_ck");
+	rc = clk_set_rate(usb_dpll, OMAP4_DPLL_USB_DEFFREQ / 2);
+	if (rc)
+		pr_err("%s: failed to configure DPLL_USB_M2!\n", __func__);
+
 	/*
 	 * On OMAP4460 the ABE DPLL fails to turn on if in idle low-power
 	 * state when turning the ABE clock domain. Workaround this by

---
base-commit: d247142d038d06514de633de44db8faf17227752
change-id: 20260617-clk-ti-omap4-dpll-usb-m2-c7ed057eb8c8

Best regards,
-- 
Thomas Richard <thomas.richard@bootlin.com>

