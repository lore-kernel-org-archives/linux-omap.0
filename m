Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779BA3242D9
	for <linux-omap@vger.kernel.org>; Tue,  5 May 2026 10:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777976863; cv=none; b=uEZ+Vs9gOQzFl0TgkyhSbIOOCYPqQiP/rsAkXL4FfbWIDLa26R/A3R8XfX3OoEngaAPHd6qgPMlcvoZ5PbbBUPbxOku39ZAmxJh+isjz6Dz5x4u4iFCp0Cd2gAu9Quq6vzoY6pMnxybhjxGgQLZ0JP3Efig7Iegt13TYgGbHu9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777976863; c=relaxed/simple;
	bh=mbjqQizgO//Sg5kVz3vzMVW54gSs2ePd1SPD7d/UFr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UZh3fXAPAwNX4eQDwe8CI+aX26jeu6GupPkIfD1jdf/vTQKSCJZBQvTzXNPoniaTmVOuVfFuYQiKmZm1EDP9hrlAcBz0xp24fA1ozrQkOQXcrRD5G74jQlCt0ET0FFWv5yFK4y5mMRfYMzfSWE+M1uBZmqvW9gt8AFrBcRhqeAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z8FG3kUh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WGqJqvWc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z8FG3kUh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WGqJqvWc"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6459VRjS2859177
	for <linux-omap@vger.kernel.org>; Tue, 5 May 2026 10:27:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=9yDHNo40IDdik5MunkT62uZkWbgJxAgYnBG
	EkKeYkfQ=; b=Z8FG3kUhNjIz/xBrRF1V/Xi4dD6c8fZFwhJ0gRE0h/cnBtsk/9Y
	4WWPSvXLBjkyW+k1Q0Li3AZizAVuRYjRopNqnmfCuF/J0Yaq95zBh+6qoEnMcTB4
	BcTKaREtHlYwicRxIyQKn9rY4OJWs3rmeNug+4c9a0u2h5B4cRgPNzKQgSWTNRTm
	KA2SXcRC/1AvpzEV4colJOlm81J65HX3dAmFBS/hJnxtq1fQt97Uum0k1/NU9S/c
	ortWxfWinL7aS6t5I//axdvJkgidUFIDsd3VOBcLQ2J3wnOM+WyAjv6YU2Y/TZb/
	l1Ri7M47aXOIK92A4QqW6cuSm1OrU25gpJw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dye0ag7xj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Tue, 05 May 2026 10:27:41 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50ff051e189so133548071cf.2
        for <linux-omap@vger.kernel.org>; Tue, 05 May 2026 03:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777976860; x=1778581660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9yDHNo40IDdik5MunkT62uZkWbgJxAgYnBGEkKeYkfQ=;
        b=WGqJqvWc7fwqQpPo1FXB1hzVM9Aq+3oLDs7umbwHDlk6CMFTVhIFEbBSprNf9E3AOR
         dNExj2oqkZvNn4NFMb/KjBGkYGgDpLANF96xeC+jSe9M8TpY5egQQS1vH0PN+YnuMjH/
         uEm7k5XVF8Ovpj9+HtA6w7M9F80zl7WOydkFTKBmpkxbspuy0YNgAaTr0mpuh694USUd
         rwzT1Ab0pMXIbEE67KKZAI4avR07TA6ck5FiN/EiUks1BJUHs8fWmKgZyDSRRMVAK3AD
         49Grruh9rKA70RpDepwTwZtaNOqmP0nsfEnsIBLPzSpmeFMzTpu2D9dNFl2PNhPo0135
         UUsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777976860; x=1778581660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9yDHNo40IDdik5MunkT62uZkWbgJxAgYnBGEkKeYkfQ=;
        b=EVxM3BoVVdYd0jXR1SqHKeJwq/AZNj9ctGXhAjgvRZzNf9fDCoZZNvX2t3gJU6ksJd
         qYOSg26JEj+eM/8PNaCToDGRRFUSwp5SFGkli+a5oj6nN9A6g00GVSi7PmkvXPSSLPC8
         rMM31CXWcyF7v7g6hqZENpZ6QCAw8QcbQLrCmP+r6vf81rLGAZ9sC9T2zufr3PerwuxW
         Bgbx0m/ItwI4LcTUqhJecDcdDHkeu/zOx+Tb8DYkXS4abj0YigSHTZZgLTXLIqaQQVVu
         /vy41ZLoKExKDs4L70JBYodG7SaO04iCah8NA4qXHKX34kd5WL3brTTtWGPH+t9dl1a0
         rGaA==
X-Forwarded-Encrypted: i=1; AFNElJ//X6Gn4zcUi1r6z1x9HftH8mVkNuBy9PjonKKdicaI0YQV6gDcB2OSGFe/52PW2obHvVhCjr2UBAXl@vger.kernel.org
X-Gm-Message-State: AOJu0YxEEuXBKe/2ZZrhos6YW1ZPV6axR/rrnQoT+gDvLs0ztpV/+TA/
	qglfIJcMTCU6akc3Mc2A98VugFOEyKBle0ILovvNkoEmA3BO1c0M7cYbM6c1et41DvfcB5a4M16
	bIUz2OMTvta22z583EFZ3bkI2gSPcWb83lO6OE7p2LOhwmsk6vbdbruq8jvyo4TcSo2IxLGGH
X-Gm-Gg: AeBDiesjjt/vmlb99q6k8M4uguMjqpv/PnCzxpKudGF8DtZRlzbooLzpTjYU0TdtMo7
	o/z0WWLM6tonNXrb2vjhAzLzFFgn7NuxHz5rRLW77bTRFPpgUx7YOHnOxKKACtqnwBgiBTN62zm
	Vsm4jDpQ8xMsmmJsstfxpAGSsro5GK9QQItpBIlP74wj2XxszDatvDpW2siUSuURHlZcdh+Rtrl
	UTZa/zBIq2RDNHBNYIv3iJKyQEPfQ9xdmyD5ILI7ru2gM65tEkIvmVjYSOarb1VWyZ0wUrOKEJ1
	S/29CGGQ43PgU+gFrdyfvCOoPFaj7rdChEQpxuuL7vSjuPUpNcMhOOddW4CQn40ONEhSh+cp4b9
	LnZ+UZJPjSWuCoN3UBdFYoax3cRcOnhnBhvnAuNN//lfx1uw=
X-Received: by 2002:a05:622a:1f88:b0:50e:5ffd:deb9 with SMTP id d75a77b69052e-51306a7ace3mr32018121cf.31.1777976860165;
        Tue, 05 May 2026 03:27:40 -0700 (PDT)
X-Received: by 2002:a05:622a:1f88:b0:50e:5ffd:deb9 with SMTP id d75a77b69052e-51306a7ace3mr32017801cf.31.1777976859768;
        Tue, 05 May 2026 03:27:39 -0700 (PDT)
Received: from quoll ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a822c3422sm363794625e9.8.2026.05.05.03.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 03:27:38 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
        Andreas Kemnade <andreas@kemnade.info>,
        Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>,
        Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] regulator: palmas: Move MODULE_DEVICE_TABLE next to the table itself
Date: Tue,  5 May 2026 12:27:35 +0200
Message-ID: <20260505102734.180464-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1206; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=mbjqQizgO//Sg5kVz3vzMVW54gSs2ePd1SPD7d/UFr4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBp+cYWdjHxF4heQ0PA/Pczg4+nEyNp2IB/fVAkA
 ov+uFfcLC2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCafnGFgAKCRDBN2bmhouD
 17pjD/9hJ7hNEPE114J8whmPZ4PFc6qhKUF848ZMIhAEp3K3fcwkodvoCPeCdpAfTqCG8hkrd6q
 NqI071MItBbnY1Nocbqx1yOgQfj7D0lB4cl54ICvLdHXdX/jb6QqhbEqvigPs92laOmJrOArqsk
 Dcp4PXOe8FFJRrhfiWKVVoWz7FnAQ4Hb34UnUIntLqtWxDZMQWilpuWSYCg/7ZGJAlg40PGMc0D
 axJcFQC5ITCzd0y1Y2uUx9jknKIF9LVE5SUf1XrVZROvhdZV2Rw+919TlYxxx2/BnEfC8rAC8VD
 IIFFbbfkQ6c7qZ++IFMhvGgrAyZRX9TGAmg5PzAD0Onr/+KVSOBDGJqkcyt3o/FAawQIzFQcody
 zSQifb7Ni+yeB2uVapLO9UJRrFnL138duhe1VsIEbVSqrE8RTqm2oWkjpqSWWTrmUvMMvPmkVRN
 IXCSa2nUtXQHY7aXVV2gtRyYczoRHF302mdMP21cwf8zDY4EENuEElAmj7qy7KBNRBEQi2utXH6
 51bJHmHCVdmIe1dsoyPlllrExIXliU7qYJkKnOZuj+yLsX21qh6ZMqxut24OAe0k9O1kW1zH29Q
 9eNF1Os/SS5Sl2BcHUDPvH7PYzTpn7CrlmFXGXK3+rfwx+i4+WX2ZsdP6bW2S47gzgqgH7nCbte Ec8SypQf0QJVlbA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDA5NyBTYWx0ZWRfXwCkIUhRas1t6
 kr2O8PEyFJ/nryRDNpN5WnMZUDvYE5inaDaqOzLMd3vEuRarpuNp5lI7fy0f9m9qOm/c94U6PeW
 eJfXcjtiM3jYub4Hg4WGrZ32uOpFVz7NqAI3RipArSIpMt26KQFVqBn5NWgh2Nz5MyvXn7H1rg8
 3FAm7mdt8Jy6EbRXIbDOI1OsYkxa1I3X5rIvq6JEASxlMKusPfluqEJ6wSzxyqHBU5ORqzc1hwK
 jNRgn70KzKIzJMCu/aAtzJV0jJThN6VqOMewaolQWbJogx/bCCDRS2KZ9PYF+DakGmiFwYrUGY5
 JjxSI68js/fMkveamg3sSMCx14dVoSmEsA39ilDAVVsDe6G+/wOpwrQ4Xiw/UXKZ45bWdXh893Y
 BFjlvq5ZrQ7U2l7Ed0knpnGBdG0jmIgMOB0mOsRfSj4ZfYooZuWp5Y9VNQ6GmGgw0BJYU0K4kd4
 rG2095u29zwg2YCat2A==
X-Authority-Analysis: v=2.4 cv=Wtkb99fv c=1 sm=1 tr=0 ts=69f9c61d cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=97mMdVoXAAAA:8 a=BzP98TPolLMEYMmIy-QA:9 a=a_PwQJl-kcHnX1M80qC6:22
 a=O7btbOjH2nnFfOvKVaza:22
X-Proofpoint-GUID: 8H6WUOWex9_cT_VScjnuVGDzUTFNybtZ
X-Proofpoint-ORIG-GUID: 8H6WUOWex9_cT_VScjnuVGDzUTFNybtZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605050097

By convention MODULE_DEVICE_TABLE() immediately follows the ID table it
exports, because this is easier to read and verify.  It also makes more
sense since #ifdef for ACPI or OF could hide both of them.

Most of the privers already have this correctly placed, so adjust
the missing ones.  No functional impact.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/regulator/palmas-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/palmas-regulator.c b/drivers/regulator/palmas-regulator.c
index 60656a815b9e..f82618a70106 100644
--- a/drivers/regulator/palmas-regulator.c
+++ b/drivers/regulator/palmas-regulator.c
@@ -1590,6 +1590,7 @@ static const struct of_device_id of_palmas_match_tbl[] = {
 	},
 	{ /* end */ }
 };
+MODULE_DEVICE_TABLE(of, of_palmas_match_tbl);
 
 static int palmas_regulators_probe(struct platform_device *pdev)
 {
@@ -1684,4 +1685,3 @@ MODULE_AUTHOR("Graeme Gregory <gg@slimlogic.co.uk>");
 MODULE_DESCRIPTION("Palmas voltage regulator driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:palmas-pmic");
-MODULE_DEVICE_TABLE(of, of_palmas_match_tbl);
-- 
2.51.0

