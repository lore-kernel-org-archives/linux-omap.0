Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FCF37EFF3;
	Sun,  6 Sep 2026 03:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788666138; cv=none; b=Jd2bnEBMpIxfsrHBBCqiDiRTjmquKbC/mS7VNQlNdoSRpqxki/kCoifYkYw0QeoAyTk6uR1utfvENvrESiycviV7tJRaWshj4qKLFiHUfcOZFpFFTe/zPVy2CvV+iQYnh8ZItlp2Y2pt+Fwgc3S0rZ5rrQLsNFygM2E2wMhgdag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788666138; c=relaxed/simple;
	bh=ZmAbydasfdgO2QZAJ5qFQTkaNDMAyPZTzyXONl61g0w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V9nh84U/QkhPio0wF0hdd54mI0XHK+74Hu080EM4DDlDBBkM1s5bE009WTJzxtCffwjyDuRZDzIMoto4AoQTz4HDDZJcAZ8sA41sK44Vb8PzgPDvb6ijSBb+3N5G9ERBESRznKTfX8YwLyl5PunTfJ4rTRc8cakeiunvlEOOcNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UcYq0wPm; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UcYq0wPm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=S+
	tPJaF2kQ2CFjuzL8SKPPVtypqqhmYGJ4s8qNVyANE=; b=UcYq0wPmyafRuM4E2N
	31HqZE5tJT2lxYuRHvJuuCUKXjqjASvMWmGSbbbexqCxZkaWTNVtwV5YkPar8Cn1
	5WMNaUPCm5+RSPMW5m7poA2TcPbeNVR5taCrvgNUqoDgIg9Ez7go6kBDvfQ4b4tm
	oSZ/NyTrrJTB/lVQzB7cysKIw=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgBXhfz_4JxqO+zERA--.30741S3;
	Sun, 06 Sep 2026 11:41:53 +0800 (CST)
From: Pengpeng Hou <hppiscas@163.com>
To: Bin Liu <b-liu@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Pengpeng Hou <hppiscas@163.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Felipe Balbi <balbi@ti.com>,
	linux-usb@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] usb: musb: omap2430: Propagate PHY errors from init
Date: Sun,  6 Sep 2026 11:41:47 +0800
Message-ID: <20260906034149.85550-2-hppiscas@163.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgBXhfz_4JxqO+zERA--.30741S3
X-Coremail-Antispam: 1Uf129KBjvJXoWrZFWrWw4rJw18AryxZrWDArb_yoW8JrW8pa
	9rKay5ArWktrZrt3ZIy3Z8XF95Cwsakry3C34Iywn3ur17C3y7Cr1UtFWYyF1FgFWjyFWU
	tF40yayUuF4YgrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U-eOXUUUUU=
X-CM-SenderInfo: 5kssx2xfdvqiywtou0bp/xtbC7gE6A2qc4QGrNAAA3f

omap2430_musb_init() ignores phy_init() and phy_power_on() failures and
continues to access the glue registers.

Return an initialization error before touching those registers. If power-on
fails after a successful initialization, exit the PHY before returning.

The issue was found by our static-analysis tool and manually reviewed.

Fixes: 3e3101d57c50 ("usb: musb: omap2430: use the new generic PHY framework")
Assisted-by: gpt 5
Signed-off-by: Pengpeng Hou <hppiscas@163.com>
---
 drivers/usb/musb/omap2430.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 6e749faac33c..52fcbd209c66 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -222,8 +222,15 @@ static int omap2430_musb_init(struct musb *musb)
 		return PTR_ERR(musb->phy);
 	}
 	musb->isr = omap2430_musb_interrupt;
-	phy_init(musb->phy);
-	phy_power_on(musb->phy);
+	status = phy_init(musb->phy);
+	if (status)
+		return status;
+
+	status = phy_power_on(musb->phy);
+	if (status) {
+		phy_exit(musb->phy);
+		return status;
+	}
 
 	l = musb_readl(musb->mregs, OTG_INTERFSEL);
 
-- 
2.50.1 (Apple Git-155)

