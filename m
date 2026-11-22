Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795369834;
	b=4Y3MKmbgVgj2cPra7VkUo4nkGtRKsSjohpjDoXXHiu5BX3Aghch64LT2DWQls1Zs6Fq4
	 1TqXIvgr0XhfEQHGK9HHVYjMa8Q5Qza84PR3IzYnUf2lS9ZwAy2g28MaOh22OaYnZz4Dk
	 nEFfN/t1Nt9QNgrzE6l8hZYfHx3hgP3uyKKH3aEuurGzix0XwybbjMIVBmieAAAlSsoca
	 +clSGhK8GuAHKEYCryAqUa7oaPqS60iFV7MLzOABWbezmmL/YfKn2KYz7dP1+JnM5xp/G
	 RSFXTxgwClwWZEKLsKk1Ivzg31kAxQ8ZwFtAKuDS0irnG+mMKriv0S+M7KML8LebCLw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795369834;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=vg5mqRfKEizGuvpEqsvZFuLvCHSXkGqnwv+4/yviyV8=;
	b=d4ropl/WGnLsbmdxeteOxCUVbDYX/MLy9pFBFADWr/+EMLj9whbXNtypYwuLQJc+U5YO
	 xnOlV6Cc/Xyps9NOBbe1TXAlddk+2jaqLLrFjoKLHMV4aF1dEpz4csXnOaccRMRcZ2tvf
	 hC2GrAEiSIY96hLCDaB+8xCHKAWuAwbhwmMYEUWc+KFTsj0lFtDP/BCjkr3XnZ+l3xjKl
	 jnzbbk8GB0l4HQOuLaNb9fII9xlO6kIPTtR7x+Ca3b8SFtjq3qeWvpDlUjphHzTTM/A3O
	 ZKaAWb/FaiyIXEmcrmEK3dyG5ZG6UVo/GCz9Yl5eRLHOaB4jc/m4T66t/lPX80WZ3cw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G7wzDdFN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00008606A33D;
	Sun, 22 Nov 2026 17:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G7wzDdFN
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795369833;
	b=mFwoIFT8+/NL4JLA5OCDeOMU7wSLgnwWyZNK+8KsXJcYgr8YzlvL1hWwLEgEWOz0Y2pm
	 imNtT31Pfz048tDA8+9IIoGd+h/ZTxT0uXrMS0T7dqaIaJF7/faX82l7ns22erN85nkmO
	 +nZ6tzs84adJvpeta3yBmvbll5D5lxeP0PnEnw6db0YHs6AU5xm4h4cif6d26EVOJc1Xk
	 q5qkKu1P/mhQbfhnil+7pcq/PsVk1HWLiwSB3GOMsSPYuEM4mrTNIF1T9Z18G1mY6+4GS
	 9sH3H2y/oB13gNVfzPzpozFw4xDA123jb2ZLfrcp5fRq52kVwPRDyO//8rU4rWRH2uA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795369833;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=vg5mqRfKEizGuvpEqsvZFuLvCHSXkGqnwv+4/yviyV8=;
	b=XSGmgSEWC5fvY1jge7uzpjNm1sI8TURCp7BDVi7jWlp3wtxad6d/I6EPHx/Yxw96Nrfz
	 iHJnxmYPiLnFITnjWC9aQs88OKFIf7emJEOa43Q2XPZdTFQeCkIgeAZ13FkS2IBKTV5ax
	 XL/dLdJ7RqTjgIEk7MxH0Wy1pvRdRu3jQiCwtjuDm6pke/Iw9sWqhmCnumt2RdVrl3Urw
	 H9YLsX/C9WRhAuJ6+nq7KeoLxRP1fCndXE1A0JF5MnAC6CSwo7MAVDrkWFbh4Xnurp2Rl
	 73eHFYYUtionu3djVayPb9VLg9st70RdZHUSCThut+jwbpBroeH0WAmRoEM0/4FGlng==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 039101F000C6;
	Sun, 22 Nov 2026 17:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795369833;
	bh=vg5mqRfKEizGuvpEqsvZFuLvCHSXkGqnwv+4/yviyV8=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=G7wzDdFNGrsF0uYtbxTF1Rhb9QLt69/jvzCykJNAbkSQvBCcWwgH+lzdRNdvcmuam
	 AjSUzHqRrZUR+EzJfz+vKqkfiYMMW3jip3jfhQOzUIHkakW+fNxmumGoiy1WLM28j+
	 zg3MRCwcR5TXRGa1h+oHXirx0DsG2+UIgOFHg/vvKFOUw5Go57F1+4nAFGUKGLpEyP
	 iZh2Lo+FYulPSWx4L7XZgGZYzS0FGHzvcY9hUxEkZW5OGzOa9zEM4zakG3y0oDJp25
	 b8o7vu71H8d9pT9zGI1NQuAO4VcymWuYF+1v6dIxVP4ntOJgUM/mV0MgiliGgZbrch
	 hMZzDSG6gcqhQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5774D4C159;
	Sun, 22 Nov 2026 17:50:27 +0000 (UTC)
From: Jerome Berclaz via B4 Relay <devnull+jerome.berclaz.proton.me@kernel.org>
Date: Sun, 22 Nov 2026 09:50:09 -0800
Subject: [PATCH] regulator: tps65910: keep external control of always-on
 rails at shutdown
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261122-tps65910-shutdown-ext-control-v1-1-e86b284e8c6c@proton.me>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQqDMAwA0F+RnBewATu6Xxk71JrNirTSRCeI/
 75uO77LO0C4RBa4NQcU3qLEnCrMpYEw+vRijEM1UEvWGCLURWznTIsyrjrkd0LeFUNOWvKM1ru
 ro9B33hHUYyn8jPvvvz/+lrWfOOg3hfP8AOVGYhqBAAAA
X-Change-ID: 20261122-tps65910-shutdown-ext-control-6a9792cb5a92
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Laxman Dewangan <ldewangan@nvidia.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Svyatoslav Ryhel <clamor95@gmail.com>, linux-tegra@vger.kernel.org, 
 Jerome Berclaz <jerome.berclaz@proton.me>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3138;
 i=jerome.berclaz@proton.me; h=from:subject:message-id;
 bh=JN0M5HQcPQw6/FlwvnDvfBLOUL9wzUHnN0zQax/4z04=;
 b=owGbwMvMwCVmvC9341tRgSLG02pJDNnM2kkXLp+XqzrA1T5JVj9XtGjRaa2e1XzLGVdH/BJh1
 DjA0pDXUcrCIMbFICumyMLaYJg6/wRbQKH+vEMwc1iZQIYwcHEKwESytRkZ5rz+JDr3oCd7wIWN
 eamT2lpUtx8PtHhQovjLbO8p11/LngBViJ7QnHPMj9FnQ5e7Md/5WUaGaWxuplu+RvaWWb/O2MY
 HAA==
X-Developer-Key: i=jerome.berclaz@proton.me; a=openpgp;
 fpr=058031659FC80650712F9EC233BE6DB1ED151072
X-Endpoint-Received: by B4 Relay for jerome.berclaz@proton.me/default with
 auth_id=1608
X-Original-From: Jerome Berclaz <jerome.berclaz@proton.me>
Reply-To: jerome.berclaz@proton.me
Content-Transfer-Encoding: 7bit

From: Jerome Berclaz <jerome.berclaz@proton.me>

tps65910_shutdown() clears the external (EN1/EN2/sleep) control of every
regulator. On the Microsoft Surface RT (Tegra 30 + TPS65911), the CPU rail
VDDCTRL is always-on and assigned to EN1, which is driven by the SoC's
CPU_PWR_REQ, with a 0 V sleep voltage. Releasing that assignment drops the
CPU supply while the CPU is still running this loop, so the system hangs
before the PMIC receives the power-off (DEV_OFF) or restart (DEV_OFF_RST)
command: the screen goes black, the PMIC stays on, and the power button
has to be held to turn the device off.

Skip always-on regulators that have external control. They power the SoC
that is still executing, and the final power-off or restart resets the
PMIC anyway.

The hang was traced with netconsole and initcall_debug: the last message
was the clearing of regulator 4 (vddctrl, ext=0x1).

Tested on a Surface RT with a 7.3.1-based kernel (libre-tegra tree):
poweroff and reboot complete, booted either through the vendor UEFI or
through U-Boot. Mainline does not have a Surface RT device tree yet.

The problem was investigated, and this change and its description written,
with the help of an AI coding assistant (Claude); I reviewed the change and
tested it on my device as described above.

Fixes: 1e0c66f49762 ("regulator: tps65910: Sleep control through external inputs")
Signed-off-by: Jerome Berclaz <jerome.berclaz@proton.me>
---
Found while bringing up Linux on a Microsoft Surface RT (libre-tegra kernel
tree, https://codeberg.org/libre-tegra/linux/pulls/10). The Surface RT
device tree is not in mainline yet; the maintainer of that tree suggested
sending this fix here.

Since then, one incomplete shutdown was seen once, with cpuidle enabled
on the U-Boot boot path; it did not reproduce in 16 consecutive reboots
and 2 shutdowns, and I am keeping an eye on it.
---
 drivers/regulator/tps65910-regulator.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/regulator/tps65910-regulator.c b/drivers/regulator/tps65910-regulator.c
index 6b14c39e42de..db1f637fbdc0 100644
--- a/drivers/regulator/tps65910-regulator.c
+++ b/drivers/regulator/tps65910-regulator.c
@@ -1237,6 +1237,19 @@ static void tps65910_shutdown(struct platform_device *pdev)
 		if (!pmic->rdev[i])
 			continue;
 
+		/*
+		 * Keep external control on always-on rails: they power the
+		 * SoC that is still executing this code. On the Microsoft
+		 * Surface RT the CPU rail (VDDCTRL) is controlled by EN1 and
+		 * its sleep voltage is 0, so releasing EN1 here drops the CPU
+		 * supply before the PMIC can be told to power off or restart,
+		 * leaving the system hung with the PMIC still on.
+		 */
+		if (pmic->board_ext_control[i] &&
+		    pmic->rdev[i]->constraints &&
+		    pmic->rdev[i]->constraints->always_on)
+			continue;
+
 		err = tps65910_set_ext_sleep_config(pmic, i, 0);
 		if (err < 0)
 			dev_err(&pdev->dev,

---
base-commit: 4843f6873f7c4835e62f2c73ba0fd538e57a2f22
change-id: 20261122-tps65910-shutdown-ext-control-6a9792cb5a92

Best regards,
--  
Jerome Berclaz <jerome.berclaz@proton.me>


