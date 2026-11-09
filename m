Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794231741;
	b=eUaCaHKu0pMBZ5X3IIWRsPRV49WfRUKjht67gtqk26TP0cRX9K+bLdiNUv35Tbp4S5be
	 9PSJ11UfB7VEJqweKxMA4sVBjblkI2JgR3mnDG1dGIOwY5AvBMKGmW/oznsZfzcfqREf9
	 rxREDXwastDsSOv5lNcUd+rcY8YpZJKi6bJsu8VQfKdKoQmemwrP8dx0Zm/ro18hsP24F
	 CVMpln6FCcMnFrJKLPx9m7m0u07ni90PrshWHdr36yvRVxOA4G6YKbziEShf+z4zTW/8k
	 8oEanameere7frzG2h+mcr5PCi46t1VbB0R8bp3sULkn5k924cYvnFhttrSMpj50dGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231741;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6phmPy2H01NAYhb3b/eLkioYVIAsUw/1Hbadvh+hcTs=;
	b=PFGYRUXkcAMqgwCfyhJVLlsF00khfkxefP1lR8/JznrocY9j4b1V2BZVmWMAK5oEYRnJ
	 rJOPC+V6hslan7krLTq/g324kqQQYuS8T+S+Tvq0Jcyqxj5TmyKHCUOwZChQuX13rJRfJ
	 NAEd0ppBA7LsvE2aGEw8+/eXyEQVxDL3pIPB4wVhzoXaCEZzy0STwuiEhfTj5NZbT03Ia
	 gkHSi3oYfLp//1Pk4+KV6y81Qmgbt2wd8p0himPz2d9AHvNmsHBSPn2GK3TwEBfnOLcBq
	 3GUpq9nJtDG8Vut7sxSaqtEUxj1fR5G+i7/aAosMTrBoxgmAOf14NgopXnIxgMpI1Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=iNcSm4+s;
	arc=none smtp.remote-ip=203.205.221.153
Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CBE606A321;
	Mon,  9 Nov 2026 13:42:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90CBE606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=iNcSm4+s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794231730; bh=6phmPy2H01NAYhb3b/eLkioYVIAsUw/1Hbadvh+hcTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iNcSm4+sTfMocQ7xCp7xvf3R21N0a5dDU00w8eiV2tqDRN2t6fBbCWnF+EtjybQDz
	 HuKl0u6CiihHthURon2de62IcvN0AjiWP9fMM1IQZQThX19QIdAe8IQvVljkAxg31M
	 zASNmMWBWQk50EvVgPFqtzy4LNa7/YDPULbtTrIM=
Received: from ws006419.mbzu.ae ([5.195.0.150])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id A853DE44; Mon, 09 Nov 2026 21:42:05 +0800
X-QQ-mid: xmsmtpt1794231725tjlhvo5oq
Message-ID: <tencent_D8A4B6EE90931660EB6F586543FD58110E06@qq.com>
X-QQ-XMAILINFO: NmRjDopJZVxOJnbfz4QUXrvG0eDdAQuvE5D4lCij5ZdC0bzR12Gg8CyXRQhg3M
	 wR9W6D3N+uwnDAQfoA3tvl5+3NJawpyvsXzl/79zfn0m/dozThPPakjLbib+4RFTkW7S0F9JHbNN
	 iscj/4zjRoIMUPtl97nO83y+XOoNymZJmjny/opBSKHKOHXSRv7FGWVa49nf700CDTtL1dyn8sdf
	 a6GfddiGsaWOLK+KR9FcEs/9PrMhyZlBWf51Ef+Q+1ju5vPm7NpPdGZ6FxaAYRSoYthy3YyqzGm5
	 xTahxRtMv2YYewaX/Xa4MsRYJikD1iq/20Ck94DmWC+tx61/YkLHPwE47+i5aX95VKdRym9QQlaz
	 iSIOWnWQjO/lSWM/tgnhFBOZTtRoRgQw1iy6AlYP4LN3N4f1Ffl3jMaYZEyTg1uXaCdiaYYD2Nyy
	 +ublPmTXGoo7OB5nYiJxgi5+7xzKYTyVFpOzRJhkFsi6w36X3Ov8vGrG515nwun+VnI3ezvrE5W4
	 I103PVx2LfnIq9CK99XHAoZiceygHKcohrVKiU632zoeZt9iIdA54DuyH3EECyAo2zFZlrubRM0j
	 u5SX5SGbOdPlV09uuFkwqgQfLBxeIgn+Rw3bbJhzMt5fG+EEPyG7fEPeddmRrZKgbj8fGcvCxBG0
	 v6bj5wN0XNZIAUbPZQxXDvwrRqFzue6AWadlzrSzNyMT/tl9FOzLKuVSWsbd5WbztZDC5Qx9CWjJ
	 GJ3AFIZ+VSr79nr3vnXz1TdH8YDMW8bx5e23HD/EIO8ljldGpexO2g4SUGeSN+NbYF6MibCCy+ZE
	 EFKZqbMY0yWvIl6VGdX+VBqzbXX4RkXCEBGayKrJRGZjcIOJw/h/e9V+bDbhRv7y5hxM2lsjf6Tx
	 EVgcQo1BzDzPW0D9t7+brToj12XUa5I95iPlQBlRwYqJilw1r1WTrBfO00EBF8sYPwLgQPelVg+R
	 JQG0iMOQys/u8Bk6yo1JOI1CkWp4WUvgJ5iWnLsWwNG+uLvXBPY3I3WeqKzGODU816bgI/7ccqz6
	 T/R0ZYwu4V+Mdf6/zIcx+XH3SeRIlYIamrwe8zZxl7iwB+eyDcgBxsB4NCSu8/1e1ybzHtCw==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: Jiawen Liu <1298662399@qq.com>
To: Grygorii Strashko <grygorii.strashko@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Kevin Hilman <khilman@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-omap@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andreas Kemnade <andreas@kemnade.info>,
	Dan Carpenter <error27@gmail.com>,
	Markus Elfring <Markus.Elfring@web.de>,
	kernel-janitors@vger.kernel.org,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Jiawen Liu <1298662399@qq.com>
Subject: [PATCH v2] gpio: omap: handle debounce clock preparation failure
Date: Mon,  9 Nov 2026 17:42:04 +0400
X-OQ-MSGID: <20261109134204.2087852-1-1298662399@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <tencent_B4F504456790E8BA3C4EAB80F4BFB6954E08@qq.com>
References: <tencent_B4F504456790E8BA3C4EAB80F4BFB6954E08@qq.com>
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

omap_gpio_probe() ignores the return value of clk_prepare() for the
debounce clock. If preparation fails, the driver still treats debounce as
available and may use or unprepare a clock that was not prepared.

Use devm_clk_get_prepared() and disable debounce if the clock cannot be
obtained or prepared. This keeps the existing behavior for clock lookup
failures. Remove both manual clk_unprepare() calls because the managed
clock is released on probe failure and device removal.

An earlier managed-clock conversion was dropped after a reported boot
failure. A follow-up removing the two manual unprepare calls was reported
to restore boot. This change also removes those calls.
Built gpio-omap.o with ARM multi_v7_defconfig and Clang 19; the current
patch has not been tested on OMAP hardware.

The original report was generated using BMC-Agent; source review and
maintainer feedback informed this revision.

Fixes: 5d9452e7c52a ("gpio: omap: fix clk_prepare/unprepare usage")
Suggested-by: Andreas Kemnade <andreas@kemnade.info>
Link: https://lore.kernel.org/r/tencent_B4F504456790E8BA3C4EAB80F4BFB6954E08@qq.com
Link: https://lkml.rescloud.iu.edu/hypermail/linux/kernel/2412.2/00414.html
Signed-off-by: Jiawen Liu <1298662399@qq.com>
---
Changes in v2:
- Use devm_clk_get_prepared() and remove both manual unprepare calls.
- Disable debounce on prepare failure, retaining clock-get failure behavior.
- Add the Fixes tag and describe the earlier managed-clock attempt.

Built with ARCH=arm, LLVM=-19, multi_v7_defconfig, W=1 and
CONFIG_GPIO_OMAP=y. No OMAP hardware test or current reproducer is available.

 drivers/gpio/gpio-omap.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index a9734b2a1..314bbb48e 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1446,13 +1446,11 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	}
 
 	if (bank->dbck_flag) {
-		bank->dbck = devm_clk_get(dev, "dbclk");
+		bank->dbck = devm_clk_get_prepared(dev, "dbclk");
 		if (IS_ERR(bank->dbck)) {
 			dev_err(dev,
-				"Could not get gpio dbck. Disable debounce\n");
+				"Could not get or prepare gpio dbck. Disable debounce\n");
 			bank->dbck_flag = false;
-		} else {
-			clk_prepare(bank->dbck);
 		}
 	}
 
@@ -1470,8 +1468,6 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	if (ret) {
 		pm_runtime_put_sync(dev);
 		pm_runtime_disable(dev);
-		if (bank->dbck_flag)
-			clk_unprepare(bank->dbck);
 		return ret;
 	}
 
@@ -1492,8 +1488,6 @@ static void omap_gpio_remove(struct platform_device *pdev)
 	cpu_pm_unregister_notifier(&bank->nb);
 	gpiochip_remove(&bank->chip);
 	pm_runtime_disable(&pdev->dev);
-	if (bank->dbck_flag)
-		clk_unprepare(bank->dbck);
 }
 
 static int omap_gpio_runtime_suspend(struct device *dev)
-- 
2.34.1

