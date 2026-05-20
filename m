Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270013A4F26
	for <linux-omap@vger.kernel.org>; Wed, 20 May 2026 11:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779275808; cv=none; b=HUrmjPtUMVuysm+uRdJ1lQMiOSZq1H5Zr/GkQmZT3XjKFJWYZpBOmfj4hKlcmryKyDXq6XZ+j17x6opjTJPOGmWWRmjQDwdDVN3zdRfBr4+etfbmc6n+a+Rs5/YohZaJqEB9Cm62Noxt4E4wDeL7SYVBWkWqiU3OgGeYPFrGzRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779275808; c=relaxed/simple;
	bh=bpRfX7E/XCI4WdfVZIDJW6fSsGDUU1ccxHUq45Gn9qc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oAUL2yKY+2zTTNRRQ/p3OU96LreWveK8KxUUiK0R2iTUZ47vPGTPriXO3e+QEot9KkONtxE6SuNYikElpiuM7cZeQ5SxsVfQFjf3iIQa11dJTKEbTfAaTeDg0Ok/GZzR4Qsc+DpmK8GRk3Dp8AFOw/i2OCp6CjVuu2JzSjm2O7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B2LDmvKf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ecxHNvHb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B2LDmvKf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ecxHNvHb"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K7CUuK2065134
	for <linux-omap@vger.kernel.org>; Wed, 20 May 2026 11:16:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=n8LPO6eze8wVsYJxM9DPMdIT0bs2Yo8vf+8
	RsT33kuw=; b=B2LDmvKf5/GmERjsaC9w8Tt3KpwLjK/PGsblxGnTZXH56q33Ty9
	fMj6xMYxnegBu3Txqkp/CtcUiV/sX/KMxdgDAZsIDzko/nXL+GyWeHTTcIAKd1Py
	LeLGpcn783qcqIiwKF/lYocvTZYmeD3GPSUqFSkP5d2VWoVSsnN+tVQubH9AT4YO
	QHH2aWBiApb4VaEKZAfQ9m47mRrpv6jtGVFLBAP/p4ojxHNXHdfqeRkDHgpxqE36
	7lEsUloWqV8xUd5ELNhY21GhaEzHJ24vcop3SCTM5UTG3UfPV9rXua8qCEXl+9KV
	Y17g25+LAXDC6AWwbpwsFbgnmGQHVJxwyGg==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3t4cht-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Wed, 20 May 2026 11:16:39 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-960476ee6f5so1762768241.2
        for <linux-omap@vger.kernel.org>; Wed, 20 May 2026 04:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779275798; x=1779880598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n8LPO6eze8wVsYJxM9DPMdIT0bs2Yo8vf+8RsT33kuw=;
        b=ecxHNvHbGKg9DxjVh1pMRpx+ZHZPaiHgEIKn3VedFw5K2pl/oV/M2lE3Jx5K1xbqsx
         itfv1FNgQckdLa0q+cMOHQYGnjDnKnCm03N9VFhvO4SEANiiqStkNrFyWXNQizO4ah27
         25+2BerSYK/2t/msyewa6aiLFat6qElI1Q9kZeQuGUG7HzfXz8UAdgDIfasb0anZQ+X+
         zKpolUgiuwk70pRMqHySmMi2XFz1YjzOCf2c/3uFwpeFrZwmphkUGVyhKjlAtlbr7XkQ
         IQmwFx+0B1Zi1f3uUUSR027n0BRuQL08MCyC/YR8aqIRnTA/SsAqBsNPaqkf7zdnM9HL
         o3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779275798; x=1779880598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8LPO6eze8wVsYJxM9DPMdIT0bs2Yo8vf+8RsT33kuw=;
        b=MWZ0WJExLBk1b5MVwbKVmSqPzQd6Uv/W21A1rrztwAq7jGuwHLQ7e1TOqUz1ijzwjC
         CDqwqOF5n2AzOS0kFia9djAM8LTwzFOvzFMEbA7LQCZiK03JmwDhRE9sl/BH0LhYhmps
         TurBBqzo2hFxGDCCWdZe4JH3o2ndcOUd0iCORvlKev8K/Akohw1Ra0nIwOQ4gQsWX08O
         sAD6Py/F2G4Wp6ms2so1mDlty793f3sBQF4Q1Eh6Vg0a/xuTRb3shyaNFW7qLZP5NCXd
         9BBpkzf/GcEkf5EJDzPUrPf9hI/E3Pxui3Ucl14MgRRUmDs3ut9o9IV5gdf8nKQ1mQbA
         +t7g==
X-Forwarded-Encrypted: i=1; AFNElJ/7uu/camV1K28/Qym2JAxkyDaeKamZde1YqrC+ICQW2Rd4XLa+ZkdeFrDcExtN3qVVbVQ3UNanEGSV@vger.kernel.org
X-Gm-Message-State: AOJu0YxMcEP22JBcqY+meXGktbPcLeXi9nv3q0covxCCbAEH+DCqIpDQ
	Pfir8D8ONryRsOiWhhqQ43M2oxEK1DE7edb+N5p/X71YZH6fQVdaAd2+KJqiyOAmqDTyUtTaH8k
	/zbiI1pO1oPFCR2JqBOLx/O0gUDvKhaF0qvaMDeWn/GkO1KWxCA4mvHQ5g5fbwpOldh04ZSIq
X-Gm-Gg: Acq92OGLTr8ZxjMp3wgHa5ZQ2CHD5uT9lMp+jLbnk8F1AV35ZDeHYmNx5VR7kM7H0vo
	8BEo6hpaae0UlVsl+1ARF0del3NOQdWD+5WuV7XVesNTjbj5YWwAxrjiuNlub/Tpyfbz3ibqjVO
	4kim0bspivKTb/+p/1y/rZIHpdc0FLYdVluDvhtWJkApg7+z9mI6ISfrM29uV6vu6QtICGEiyrv
	JddoE7GwBd7NDRlTk+RIOsyFeggQPa5fgdct6VbgLn4TrKkPwkycUfPfk6umxTzn3KMM4kUJTg2
	xMIHpgTIbQ/LZa+2ZpQg61XaE06DX99aNFpuJMaXSrKifdJz3I5Q5sFs4qtn4cfmR2dcVQXTMyn
	zkGmZpBbnc49HJLJ0xvKlgPghlUZOb1m7K1o9
X-Received: by 2002:a05:6102:d88:b0:631:2472:e832 with SMTP id ada2fe7eead31-63a3ce1bbb4mr11402866137.8.1779275798148;
        Wed, 20 May 2026 04:16:38 -0700 (PDT)
X-Received: by 2002:a05:6102:d88:b0:631:2472:e832 with SMTP id ada2fe7eead31-63a3ce1bbb4mr11402834137.8.1779275797766;
        Wed, 20 May 2026 04:16:37 -0700 (PDT)
Received: from quoll ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fffb9aac4sm519463095e9.9.2026.05.20.04.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 04:16:36 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v2] memory: omap-gpmc: Silence W=1 kerneldoc warnings
Date: Wed, 20 May 2026 13:16:31 +0200
Message-ID: <20260520111630.89365-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1145; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=bpRfX7E/XCI4WdfVZIDJW6fSsGDUU1ccxHUq45Gn9qc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqDZgOhJGanrF4VU+u0it6gisGEiiblRZ0i9PVN
 A1ljkrnIr2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCag2YDgAKCRDBN2bmhouD
 165RD/4s6ylq3i1H6zWnYdYPCZ4sykHHKNKctsLXk7ozJfbpYs9VMrja1E9wWiMA2IOGEnJ6kmO
 DPZaIwmJjvXJ+RZjAhibQDSYWF66tjggsN2diVVwQcDak7sXueIi7unImkujskiKr9uVkpmrkFZ
 hATjNXnzsIE2HWVK1jcwPjnvpRQJfu32n9X8wD4lwbAY81A/aBEAPBTZZHPQdfOfuAYzPiO1dlv
 1zNydR9WZcJr5P7JMVjbzU3/8dVEnM1rbJDcacXKq4MZVkzYesljDA3VgWwukBtIS0IwGShs1b2
 j7c2g5fBSPDEsLQtu0KPZM0dL/mfElZELBoifj/weCMGmRanRK2z/oTcJAsERS2MAWli5jMdI+V
 By/9aCvADvIgOQjywqnaoWbPKGfzcjeoOQ3+qvoRzxlpO9ET/OCSAVJMAlhi1ixvj++7R45CFrl
 hfHCm08lY7marwvMOLE4vFOPmghuunYKwMOYIum+b8szau1cXP7Iv93Hs73HBM0PEII7w/nzFP0
 c9qGL3xg0KLUxm5Ri08H7KFmQThwq28MtbpAUdX4ojPuM9B12MdOqLo4S13xfGE69cci2hpsgso
 afX4Pq9b2nWxO9/l9Bqe678jbRzhpzEKtQcQb/lg5WdvON2nk9m6XYbJGgsiaA7lOUTdxybUsCd WO8YHIcJkQ6XYqA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: nveEWT9XDVm26VHm4JiYOpyPPM_QobMU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDEwOSBTYWx0ZWRfX/GVOPpUCb1fV
 uTH40g2Z2OML2cqjGyM1zHGI3Ehq1FN+Vu60Aaz5MkEvRLUyKlTmzUU07iMqsUjfzzn/C3q9H6V
 rEH0jWDQ578zTaDXCjv83Woc81k5nOG4hip/TYcz32Tt2MhshhXIQbty3lplNwEwIEb/d0yYIQV
 brRgSbZaORzLM88/nc98I8DLEwHLSNf+dLdOrkJ2PeIMq52Djbw+zo4qyjGA3OdIIMgR/R+OFJL
 +SoAKEQhcNwy5pRjq0TdUTwKoG6FVCwOSEcfeuV7IhoaeGSo64i9HNni8obFZ/ha170uVR0ELnz
 up49U85/IBao1xBSVUHB5ALGnvtcEV3y/uGDa2RT6xIfyCGewZEIipXpoUmvAUBCQ2w+7gvj3SO
 toLSnL3baLziJnLtRjp0sUC6w/qd9x91gn9soW9ttSyAAO6mZMYc4jwlLUjn9cA3v8RIQbe7B0i
 1y3Xj92VmSrDfnRZtCA==
X-Proofpoint-ORIG-GUID: nveEWT9XDVm26VHm4JiYOpyPPM_QobMU
X-Authority-Analysis: v=2.4 cv=C4LZDwP+ c=1 sm=1 tr=0 ts=6a0d9817 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=_sZAi5VIHEe3UkwORBcA:9 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501
 adultscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200109

Recent W=1 builds print kerneldoc warnings, even though a correct
kerneldoc is there:

  Warning: drivers/memory/omap-gpmc.c:441 Excess function parameter 'cs' description in 'get_gpmc_timing_reg'

Drop additional inline comments for arguments to fix that.  They are
anyway not that useful.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Changes in v2:
1. Drop clang/LLVM references
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
2.53.0

