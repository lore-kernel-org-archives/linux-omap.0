Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795533016;
	b=HbtB94HowvFQuvzsMPuN6r7dfU23Llpz8WMERfHY6gmv9e8LIKO9AHlQ763AjAev6MNI
	 snZBoNQM2xlf3QPMoHSoWmRv/7HYT3PGNaCt7IGu3GpTRl20WFJE3N84760oVcmB3V1vr
	 ojqg4E5P2PMPhzXqiJf2ys7CDZNBD+azLQkrfOQPsJnENlr2pWx06+AbppOLSZaEUMoGA
	 3IXOo769qGwnmvGj/XJ7Wt2sJB0s2YROW0gNMKLcs2iDVld5WGVKErjL2Jk42tzufNPrk
	 hi/s3ks+9ie5H3ONeBvvVrNy6zURr+iUchcFQaT2NAoByXBIk6lBJ8DX1t9eU7/tryw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795533016;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zLnilNtv6TgFtWLmY0P+M7M3ZbXmBZe4pPd+K5XLsr0=;
	b=wodGL0THjvBHfba0EJGw5X2nF3z4yWZ2zJEeu3XQvMlpl4tsgVvLbAWHcXY8F0+Bzho9
	 escD7O5nRg2XAa1EWHmDT80MeAVjfpWBuVjVvQ11sFESOgXtyFr2mOv4czNxB2Xmhj8jM
	 gwdloqB1qZpp1Y2T6cZ+R0DT5JXjyXHihmc3s5UbJA99hdPY8MDEJEJc04PnAxmtON6rN
	 qKsAgaY8yP827c4k8I7aSMHgr0XTHn3AJKJ+9sqYIh0jC/YcDPu7yWHwLpqxa32GGeR19
	 o/W/KxnJJ7cHx9fMj9tsy9elIvN7Al4I44o+TRKyI4nl89EdCOynn5GxuYhNtYeA41A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GZhksYgP;
	arc=none smtp.remote-ip=209.85.160.46
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35580606A32C
	for <linux-omap@vger.kernel.org>; Tue, 24 Nov 2026 15:10:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35580606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GZhksYgP
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-451a49abd8aso4665919fac.3
        for <linux-omap@vger.kernel.org>; Tue, 24 Nov 2026 07:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795533015; x=1796137815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zLnilNtv6TgFtWLmY0P+M7M3ZbXmBZe4pPd+K5XLsr0=;
        b=GZhksYgPAY37clzdNFEqyPrcq+rItQ+EVlz/36uIp3ryGtUoXq8xDuF4cWnp10gT2o
         rxY+ULkzgcKT3fB5LzP/kSaffBYJyosXsvGzGbfFH6MGmdxT67wPCJIuQc6kgcPUms4w
         G35rYL30SbviZK91LmanaBszRXyqM18C/kcxhalrfu1XALe1DdLlesnCi2frXlvbfRbY
         QUGRLXDOUpk96Zfp+A6cbEmqvBepmzrR55oX8yEfhCk1pIuyIp2zsnFPNqUqXt+HnUZf
         ldozSwEDdiRogUdvz2RehJZknxR8U0VUsuLI80/zWIBA16xzxdqem8qw7Cezu9NCU3Vs
         Q1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795533015; x=1796137815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zLnilNtv6TgFtWLmY0P+M7M3ZbXmBZe4pPd+K5XLsr0=;
        b=VpGXiUB3CjOxbjWCKb7cQDFYXrfB/djud2696Ftq8RCChaIezAnOSRgDxYPWG36UdU
         eXWWqHE1mvCziMrwUdX72WWurP2Oi75FBZgzifrLAr4NkKNJK75AmW/xddmJmgIU7OLg
         ugx0Dwa7rHozih6iw+0bjClP1lDJGUsyxDHnK1kLMaS7vja5fD/mwYC/zEPMjtMIVYfp
         nsOWgsu2PvkqwRxHxpsX3RdU1wdmhJE2YJXetAX44F0MpBMObPkNKwoGj9jPn76UQ9i0
         3bV7csWZGtTvehwhBXbM2o7N7bW1RXt7tk79zvCDg1MteItLBXONT3pgmE3+PFGJtDi/
         tK9g==
X-Forwarded-Encrypted: i=1; AL+hErEd4nGjkSspA/2U2Je8tYVKy6jqM9iwU/I02AwOcyyPLGy2W5n3xZqIDphEFv55Itw/V9cneKfp1e/X@vger.kernel.org
X-Gm-Message-State: APuU4Z+0xGgGf7OPw5NX5mH5F5diDal4fHSjS2My0J9fP+KyQ9afTPSs
	Ihucgxn2AqkL37g58CGo3nfWA6MVDF6W105XDTRmRgg1GF9k3GnYIczv
X-Gm-Gg: AZFdTZcDJReAGXpmsE5IzetDYLCG3SMJSjDlVkfbE/kk5g9pKPDZB+bQnO8h6eOTsF6
	XtiEC6oFDyawHBy34Mo0yWuXWCdgWxrZmQevTkmgAzLHx6QIRO+Yh4BUp2Q/8UlgHX2miQgl6nx
	X9zcl5KzEc0ENCwxM5E8gE5OmzmrvZvEM+J6hKdiS10hI41H2MbDjCDYFnDEADSXBYFKo5L0h9c
	6Gz23A5h+ZqfEaVhZ7EfuQEPM5Unonmmj07mbC4FEC+swH9tdCwAnPtqmuUvg7Pa4Iuo/UTeTtU
	g3FTBYs6qILx64NFej3/HzdqW/i164oXkrhAntKQmhZcsFMuqu491FtmMXkAfsNBuAToyWAjlNH
	3eJQGCQeQZuFK8L2sVHdakdB5E+dcH7pr+VwfTMICNsmtpoq4vqHKzBNAa8TfMvSUqvLeCZxsEe
	/kOV0f7bceQOKFun9Rv6wGuIjF0QtZjYjS+/t/Y/mqJKgZ3uqjtnBhmornZHU6pRkQZoJfFfJGt
	1oC9ERbkDc3YX4ky3juJGEpV3S+nu/UpY7gf2X82zzn8Wnlw4siIdwDxQIFIVm6KoKGp9IP6Gvr
	mW1LXIBMl/Ig87hudeDu8fwtADi6BJny173hmYQvRh8RfMjGoexDIh3qTaz2jdErVirMBkAaFp5
	10s6aauSp5nOK5DOQUIPbVHUveorcVUbWYbqBbaOvMfMXQjcScGPvDTpbBtcPvW6eo2o=
X-Received: by 2002:a05:6870:b0d6:b0:43b:b245:30ac with SMTP id 586e51a60fabf-4bc81aa21f4mr13572490fac.16.1795533014780;
        Tue, 24 Nov 2026 07:10:14 -0800 (PST)
Received: from tempest-testimage-cc-centos9-stream-server-1191361818 (chi-dyn-129-114-108-164.tacc.chameleoncloud.org. [129.114.108.164])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bd3008160dsm14404091fac.16.2026.11.24.07.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 07:10:14 -0800 (PST)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Kevin Hilman <khilman@baylibre.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@armlinux.org.uk>,
	Pavel Machek <pavel@ucw.cz>,
	linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH] ARM: OMAP2+: Fix CPCAP node reference leaks
Date: Tue, 24 Nov 2026 15:10:06 +0000
Message-ID: <20261124151012.333306-2-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.56.1
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

omap4_cpcap_init(), cpcap_late_init() and omap4_twl_init() call
of_find_compatible_node() to check whether the device tree has a
"motorola,cpcap" node. of_find_compatible_node() returns the node with
its reference count raised, but the callers only test the returned
pointer and never drop that reference.

Put the node right after the check.

Fixes: d44fa156dcb2 ("ARM: OMAP2+: Configure voltage controller for cpcap")
Fixes: ccd369455a23 ("ARM: OMAP2+: Remove bogus warnings for machines without twl PMIC")
Fixes: 7397daf1029d ("ARM: omap: pmic-cpcap: do not mess around without CPCAP or OMAP4")
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
Compile-tested only (ARM omap2plus_defconfig, W=1). I have no OMAP4
board with a CPCAP PMIC to test it on.

 arch/arm/mach-omap2/omap_twl.c   | 10 ++++++++--
 arch/arm/mach-omap2/pmic-cpcap.c | 11 +++++++++--
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/omap_twl.c
index d4dab041324d..e103088bb34f 100644
--- a/arch/arm/mach-omap2/omap_twl.c
+++ b/arch/arm/mach-omap2/omap_twl.c
@@ -213,11 +213,17 @@ static struct omap_voltdm_pmic omap4_core_pmic = {
 int __init omap4_twl_init(void)
 {
 	struct voltagedomain *voltdm;
+	struct device_node *np;
 
-	if (!cpu_is_omap44xx() ||
-	    of_find_compatible_node(NULL, NULL, "motorola,cpcap"))
+	if (!cpu_is_omap44xx())
 		return -ENODEV;
 
+	np = of_find_compatible_node(NULL, NULL, "motorola,cpcap");
+	if (np) {
+		of_node_put(np);
+		return -ENODEV;
+	}
+
 	voltdm = voltdm_lookup("mpu");
 	omap_voltage_register_pmic(voltdm, &omap4_mpu_pmic);
 
diff --git a/arch/arm/mach-omap2/pmic-cpcap.c b/arch/arm/mach-omap2/pmic-cpcap.c
index 9f9a20274db8..2f487ad41685 100644
--- a/arch/arm/mach-omap2/pmic-cpcap.c
+++ b/arch/arm/mach-omap2/pmic-cpcap.c
@@ -238,9 +238,12 @@ static struct omap_voltdm_pmic omap4_fan_iva = {
 int __init omap4_cpcap_init(void)
 {
 	struct voltagedomain *voltdm;
+	struct device_node *np;
 
-	if (!of_find_compatible_node(NULL, NULL, "motorola,cpcap"))
+	np = of_find_compatible_node(NULL, NULL, "motorola,cpcap");
+	if (!np)
 		return -ENODEV;
+	of_node_put(np);
 
 	voltdm = voltdm_lookup("mpu");
 	omap_voltage_register_pmic(voltdm, &omap443x_max8952_mpu);
@@ -264,8 +267,12 @@ int __init omap4_cpcap_init(void)
 
 static int __init cpcap_late_init(void)
 {
-	if (!of_find_compatible_node(NULL, NULL, "motorola,cpcap"))
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "motorola,cpcap");
+	if (!np)
 		return 0;
+	of_node_put(np);
 
 	if (soc_is_omap443x() || soc_is_omap446x() || soc_is_omap447x())
 		omap4_vc_set_pmic_signaling(PWRDM_POWER_RET);

base-commit: 8dac6df92a2e66e2098bbc69061964cfe7e8375b
-- 
2.56.1

