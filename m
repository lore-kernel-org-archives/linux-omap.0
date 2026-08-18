Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com [203.205.221.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DFC2DF13F;
	Tue, 18 Aug 2026 13:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787058548; cv=none; b=dyf10MyuZxSMFs3O6FrmQryo+YC06QaChLRqC6QODegP9KlPwBmAt0zBomORKXqQVIZWkVPwKateE6Tb4eVVFFomwPm8UrzmT8Lva+1Y01yGOQofk23/uc72is3VL07i48cwzD1qi432SsGRYG9EWLytolB5JSCWUhzL+IdwalE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787058548; c=relaxed/simple;
	bh=+juvWBIX/kIABg/wShMgtpqIuOXfEvZMK6+hLRcDxeA=;
	h=Message-ID:From:Subject:To:Date; b=iR4qoUUJKrkiVCK8+Q+8LuWWEBIbBXQ0Oocc2EbpPNX1Tj04XdAqYP6rIzReSf1hm6Ur1dy1sQ1sp+fOh7BeiYQkscoEMPUJonDLJjPwoeaqNHJKqsPzmPGd6NxDFWE0yOqd8Uba3W8GRjMEw6jSZpESqPNEafbtrig9AxM5g4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=SMTRTXKD; arc=none smtp.client-ip=203.205.221.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="SMTRTXKD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1787058537; bh=QRbTcv4h+L3PjpFkC6bDmatYCA9Ha3mXWHFUhaD6pjE=;
	h=From:Subject:To:Date;
	b=SMTRTXKDbllIXNOgazi1LgR9fK+wgtWOj5+AcXVcnMYH5noPCdrC/so1cPoL82hgV
	 CsANn1TxXwjDJxecP9qdjWA9nLug8W7bBSm8lW78PFzF7lNqCNtoZT0Jvo2DLxBLOe
	 pYrlZiD7iaiZJDf6MtufCs8s/Mn8pUw8eNa/xr9I=
Received: from [127.0.1.1] ([5.195.0.150])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 1721C6D8; Tue, 18 Aug 2026 21:05:50 +0800
X-QQ-mid: xmsmtpt1787058444tb1fd9i1i
Message-ID: <tencent_B4F504456790E8BA3C4EAB80F4BFB6954E08@qq.com>
X-QQ-XMAILINFO: MllZffuBkEb5qp+5F2uNMnU7hzE0gdZA7OuXx+l1CzW49sJS0/ZhhASTNDLmQU
	 9qZWXSWLTnvNj8dTWWYXEBHwE2h8H3gX4epgoF9OXVsq5yVLMZwIWFOwBNeyYffpZ466+FhMcRL6
	 hBbT927/JZWX3bKaU0YV1YVy8h+lgEPPU444YPn5NG74BgFY8KMyYJkmPP2JGnXDN1P4JSvJ5Irw
	 XX9+bDVKchEFpaM6QVVlufRDcFAHdyJlblk1wsglIbRK+TZ6MD2oGLJP8iUhRxwbXkWhwBsXw2DE
	 wjUe+tnfvudFbjVAMgZBN9gy3UbCWCr9Md0zNx3gXO6uzFeH0nPb6MGf1bQFsTBIBQ0QhNe0dzR/
	 olXhVUUHcPJ+gm8Ir5t0yBEakydWKfAg0e3vnxC4ufLuEMjRgOgEbLaQjRj7iB20KXu4Z6ik6Q2e
	 /cW6xuHxL546W6lLMSUb5X8NyfYI3bVX9g+uVfXSSjObSLtc9RLvHrkqGHPB/4XePFgrD058J4AU
	 iAJ7w4CUhE84r7o7ImcMufLOBSW9m4/ukyyIUfGk7+3Q4wV/MbVl/dEpJ7K1qauOv8BJ0NYdF2Fw
	 LqaZFyFFogXPAXGEXdVcCLggA6gHd/bKrz9gJCuVkw6sGUthV5Uz+wgdiLPIITm4aaNTrYZLthwt
	 HMXGH1M1PvlcafyAVH3YS0/162mjGhmSzAw/9/z7rZMW2xeM2ZpwUvwEFbtq1XR9L6wA89M0Emiw
	 XVdiUaiM35nrzQ4EbvdfHmJrtjLLQDRiiXEIcFbP3ICZq0RmEGzUZhX+fzD8IPJTYTBL43wbJDwE
	 gFlC/J4ndLvomAsU2z1Nb7fyKcuvycvvy2QYHIiEZ8RBPViCE6CTzg23j7dnucwFoMXMnpJoaWhP
	 mdmPBxJicVLl4PdtPK/wx6UjCZUY49AvtqJFlRJCT5W2sCP6PS3vRwlDLnIk1wBCyHes4tGRXCO8
	 eEdQhZFGGumCwRcBAdcAkn6RS6MRFRZqh+anlLusMNjb8eG2uvKGvsaN2Ihtj5qzae1ogsAnLozP
	 whNIe4vOT93XJFPqrSF53Y0XtijXIwERJchaiJOIX0GU5oCbrkBcbvHP3bbkw=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Jiawen Liu <1298662399@qq.com>
Subject: [PATCH] gpio: omap: handle clk_prepare failure in probe
To: Grygorii Strashko <grygorii.strashko@ti.com>,
 Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>,
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 18 Aug 2026 17:08:54 +0400
X-OQ-MSGID: <178705853437.291840.3086278248298084071@qq.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>

omap_gpio_probe() ignores the return value of clk_prepare(bank->dbck).
If clk_prepare fails, the clock is not prepared, but bank->dbck_flag
remains true. Later, omap_gpio_remove() or the probe error path calls
clk_unprepare(bank->dbck) unconditionally when dbck_flag is true,
leading to an unbalanced clock operation.

Check the return value of clk_prepare in omap_gpio_probe. On failure,
clear dbck_flag and return the error, preventing unbalanced
clk_unprepare in remove or error paths.

Signed-off-by: jiawen <1298662399@qq.com>
---
diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1462,7 +1462,12 @@
 				"Could not get gpio dbck. Disable debounce\n");
 			bank->dbck_flag = false;
 		} else {
-			clk_prepare(bank->dbck);
+			ret = clk_prepare(bank->dbck);
+			if (ret) {
+				dev_err(dev, "Could not prepare gpio dbck\n");
+				bank->dbck_flag = false;
+				return ret;
+			}
 		}
 	}
 

