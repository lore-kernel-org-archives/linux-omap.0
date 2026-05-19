Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDAB40962A
	for <linux-omap@vger.kernel.org>; Tue, 19 May 2026 13:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779197156; cv=none; b=hxkc3MFc2FPyAZHpzpFLCrGXWRpFOqVQS4lfYuaJmHDhMBC24nlbcfkdQtn/cura0K1ir6MEhGks2/8RIx9xksnR6gSzsosXlG66FI5J7u3qugG9bBgTWquFeAXEd+AbL58X9I4bWj/rJwTsvocacHEOtJHU8SEPKMTW6W53sIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779197156; c=relaxed/simple;
	bh=GDglPgcWhpHbpv3ea0myGcC0pw07Pvch0HH3aFDSKds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LT0WhIccQd4Xc0oVzOBTZFQ07NvD2hafIGacEGfULVF6ku24JS7v6vAYVgY44MdarG/5h4jCS8SaG7Ml0ZhDLVlvh3L5E/kyXvMkgiND68h/YQ7MYAg0CtCZCyL+P9etuRF/o6SSlWzT5g8DBLLuJWZoZGgp94VSwcs2X7dT45o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LuXhCkby; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hMaXwzWF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LuXhCkby";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hMaXwzWF"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64J8Hx071146715
	for <linux-omap@vger.kernel.org>; Tue, 19 May 2026 13:25:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=KZvWNF+yRKh/FFzbql4gl8+mQgXlWhOfjdw
	e9W7GeiA=; b=LuXhCkbycpwvQgcYHZcFhZ91XCzDzSdtMN/Qhkmq9TmdE3sgiBO
	Hbe0aBrQsFPkW31Y1sbs/ioaV9h9vUJIJ83gVvjDrrhxb7oqC17yCMGekvGSVii3
	TvFeVqH2FO1Eejo2k8H1IXzt7q5Hxajw3Wa6CvOqN4i01gXgWWeL4Ev0DO/Jn0ur
	AnESmic5fewrv9p8iOLPIkmhgsMlXACzMRuyudK80hb+kOycrNnH/7gN0TJEK2JJ
	HtheWiQReNAH0M9FA7/VnN4rvNt7Frc+JjDqEnE3CNlquGIh9vZGfvJct6IzAagG
	7k8cSmMp2DFJVrJyQOQVJhnQtlsTAHBl95Q==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8e7ejp9q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Tue, 19 May 2026 13:25:54 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-575231e4b89so3004479e0c.1
        for <linux-omap@vger.kernel.org>; Tue, 19 May 2026 06:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779197154; x=1779801954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KZvWNF+yRKh/FFzbql4gl8+mQgXlWhOfjdwe9W7GeiA=;
        b=hMaXwzWFbMWc517m5b+GdaMRdjXYn6G8dduz4ArK75ai9zA2Z1/thfYHo0Hxit/4Zc
         RYDlseu+7NWq55gNK0pHS5/qX4/k2ZwTyzLzfmxpr03/mjRoF+mpLf8NaNqanNLFXxyW
         MjfCBEOoftqmyHehTNg5qKO7LQuWR8tQQFg7PhNiEgRPuq+nwX8wHkO3qQQIVa7Ntp36
         7i/s2smNGixTi9MHaWBs3XAk+Kl4uwQp2DsO7hsGrXKidC+KzUxN5fvx1p+yF7+n+MaN
         nGTS4wqVFb42ubU9R9o6lMXPerX3o/a5E7gXQkByE1/Ejk09AyJ3WoUATPAbyRE4VJ++
         iZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779197154; x=1779801954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZvWNF+yRKh/FFzbql4gl8+mQgXlWhOfjdwe9W7GeiA=;
        b=M4Hs3LV0nx8VZcu5Y7GXBaVJjqmkaEoamSUeMPEWK55iQXzfDZZwnT/gXTe5MSBtZa
         4f5GfOxU8uNV8+SMG8HhpEoH7yxyOdufd/xpcvUeJX08NVx2Lhf3GsjJjvS0gPwLcvhR
         d1JrMYmnO8n5bMo0D4SKlgUs27TtTAF/lxlekKoArMWAuMVTNKdtB5o3VQClXx6E8/Ha
         9EuykodMLXk9d4bv9tvvOnIYxFb81ypsL8bhAQdkyoIirnrN+lhvQzGyqZM6Nff3zbXP
         BMMUazQDgulipBWK4UboCeWnIyaouqW1VzK7jfUoyRdlY8g3uSkdWUr+49n9XBqeWPI+
         DT+g==
X-Forwarded-Encrypted: i=1; AFNElJ9NTpSANNJ8wdDE+j35D2kaYCpT2mKBh+a0/86jt3KRsC3i3NdJwmfJjD9SoQVlfjDKLPniN2LpBrCI@vger.kernel.org
X-Gm-Message-State: AOJu0Yz801RQcqSk6coaU/I2g0B5c8KK/LJx4aVeK7sjm0wNI3w00blX
	GUO0um7CtjYGVBjW2NlbOjTUUgSpZ1xEU0rtR4WoYqszMBpfGVFVrUTDHRWQjJc+0wMTOTaDxoS
	32cgK48LB+Zq469gqRsjfGxtDvGE1ormX5Gnaew2MXkbHoVoUruPSH7LplsOX7RJ7
X-Gm-Gg: Acq92OFDuFBIwx0nuIC3i67qOEkN86mrtz9EjdMZ7WQxN5Bv4ejIM32Z/r0FeJOdDwq
	6Xv1pMuIXJ5JOFQrcegXubEVEGgpAw5AH8RQqqmmY5yvxSabNQkQ+Wcu2C9wOyYD2xdMSvcfNWf
	vGzGkbvUnYyUJO1x9PrnKfzZVoK1a7E23v/bVfy7XBva70XUoTp8G+w16/cejCuRGoaLlfj/zCK
	gb8sDVNkaNo+ETOkKS8zcu670XwVtcKClYq8wXjKa7MOnL3URpZmWFoiG61mGuIw288dNJ842cs
	dIVhZvfwYzK/L9EkR3625GZo61paMQuuOQ3uzbd+2zihJKr/WF5KamOwuC2ujkyFtUtR2a5uk0E
	vF7NSfiyY99TMmDrKsBpcpxLRiDcxMOfTqE36eVhArah9kyQ=
X-Received: by 2002:a05:6122:8f8c:b0:56d:b639:5c0d with SMTP id 71dfb90a1353d-5760c1f3533mr9339788e0c.13.1779197153646;
        Tue, 19 May 2026 06:25:53 -0700 (PDT)
X-Received: by 2002:a05:6122:8f8c:b0:56d:b639:5c0d with SMTP id 71dfb90a1353d-5760c1f3533mr9339756e0c.13.1779197153140;
        Tue, 19 May 2026 06:25:53 -0700 (PDT)
Received: from quoll ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe5cab818sm339086305e9.14.2026.05.19.06.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 06:25:52 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] memory: omap-gpmc: Silence clang kerneldoc warnings
Date: Tue, 19 May 2026 15:25:49 +0200
Message-ID: <20260519132548.315229-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1088; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=GDglPgcWhpHbpv3ea0myGcC0pw07Pvch0HH3aFDSKds=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqDGTcYCuJb0KMwnQbq7evgSD6wbOxhhWIztt/G
 A06SKFVh4iJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCagxk3AAKCRDBN2bmhouD
 17n6D/9vMOJP7A+ga93Y+kUWhCm9i7ZKVURsyw4ItuM6aQoSSmEuJlbidOhXDDkpC3vQzK5NFKG
 4tjK49JgM9pxKSWPs9zp9PiFlWKCTnAcBqYXaz7gfPvwz8jn9E6WNaMTKZPjaCVvY9J4fv66Crq
 HHPdw9xmr5NP5J/7+0YwUEPWNqaDGMA6jt7k/qN/NpcbRFwrJGDet1b2MDOdmqi1RLFqtxvPUGI
 7CDw9E6prjqOsdBGfI2vB9D8QW2+lxFrC+D6JyJG/coBkMTyKuDXAKwksuiBwdZculGBWy+wGf/
 fNGUwxC+ZE6OZrySQ0FxP49BcdgssG8Evq4F9He02wYVLvOPgCNAzjC1gywoaeY4BdWqiPhYP5i
 zuO/XnjBv99qv6nt3lxR4W8EjECXhFP4R128ZUWUpHiZFNMoRqeyg4qmBQugbAdq8Gq4ByrfAO0
 ADfFRnDyU6XPfsaATx/7Da0KQRp7rksFT5HqGt1t64/hZpq+A+xgvncFcPRGP+Ll2LDFgXEvGCY
 zQSBMG2lR4H1LcVIg93Hdbfb1dB1GI+e/pk4tWocxtQ9D8D4OomjGT7m1NH66XUBj07JC1wO0Dd
 3OHhyu8WbMAfLRrfg6GrGSQTgc77tfFGlTk+xCkALKK7kggWZ7/iKv1fUaNf4R1s2TKMwbVXoCB BCmdsh3eayoEx/w==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Rt316imK c=1 sm=1 tr=0 ts=6a0c64e2 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=2Dvqj_LvCoWKn3WZKIgA:9 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-ORIG-GUID: xD51hBqxRhAdW5itq7bPPdo0OpNdKYMJ
X-Proofpoint-GUID: xD51hBqxRhAdW5itq7bPPdo0OpNdKYMJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDEzMiBTYWx0ZWRfX13BF+FLeVT02
 ofHQhMdEUT8ZWzhEeIae3TLYN6hUSENZQbB0BeSwMPm40YHYSrWYO6iaPzvaJWOu6sMW5BeO9S6
 JNqi8O6fjJs9hC3acYNintMOpyxcb4Qdr6ti8HuDw5eX8p0rk/NBgzvCophrhK+BPU6O5zYuDht
 ALkoji5ks8964Yg3mhzEEl3Qf99X69yD4x5enOvtPWwkZr89Ro9uMg7fB4mWwbSrNoHXzmSVf+A
 S0NFZUeb6bAYdMqA6ooaVSVsHQ8pDwHhl/4CXcMlaHciIs2/iGCyUnqZpXUJIXEpsPMWZi48K0D
 JGuLDxZrxsvysC+zCG3kWYTh5D8KoTUP6fC1lNTcHMp3Td90jyaCMIuPvGoc/bmzkxjJWYK8XRn
 Nhaqt2bPieAqMifO6pVa7hKTGmMbkcFZ38SwY1PHa5eWph+Gwqyx6eEHf12WITNGQfdyHsQhHE5
 vdkmqFB/WNNkZVSnCqg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190132

Recent LLVM prints kerneldoc W=1 warnings, even though a correct
kerneldoc is there:

  Warning: drivers/memory/omap-gpmc.c:441 Excess function parameter 'cs' description in 'get_gpmc_timing_reg'

Drop additional inline comments for arguments to fix that.  They are
anyway not that useful.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/memory/omap-gpmc.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index d9e13c1f9b13..958d2b0ea54a 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -432,13 +432,9 @@ static unsigned int gpmc_clk_ticks_to_ns(unsigned int ticks, int cs,
  *
  */
 static int get_gpmc_timing_reg(
-	/* timing specifiers */
 	int cs, int reg, int st_bit, int end_bit, int max,
 	const char *name, const enum gpmc_clk_domain cd,
-	/* value transform */
-	int shift,
-	/* format specifiers */
-	bool raw, bool noval)
+	int shift, bool raw, bool noval)
 {
 	u32 l;
 	int nr_bits;
-- 
2.51.0

