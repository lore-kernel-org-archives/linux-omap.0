Received: from cvsmtppost101.wmail.worksmobile.com (cvsmtppost101.wmail.worksmobile.com [125.209.209.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C8033F5B2
	for <linux-omap@vger.kernel.org>; Thu, 14 May 2026 19:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=125.209.209.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778785959; cv=none; b=NiYadMdOdONhvPJThy2x1DwarGOxDc2jXoFfXs/ZJS1Q9AxFrQrK+xjfBQn1jnXXnUNn5p9eXvu4T+veX+YuatfkGmewU60bYejcCBLUxh1HXem6chKgpyOOamHo46eD3Zx9PxR3ugzR/5eoQb1j5CTyluJ++kc5XX102usJ4g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778785959; c=relaxed/simple;
	bh=4ZgZ1jc5MZTVJWvr3jQ/Q+eroPwBgVQCOd4Bu0H768g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cwWbmmEus1oh6nW2ecQtNKWn3fcDAlgsJPEKTrj5bfPIaHI6V0TokQ4JVHzMLt5r23WDK6I7tuWjXaUsrDiSjLQFbq3Tt1NejvtIViIzGMYmnimzD3HuQlhZzT3nxPKecB8i20kSdriknmEeg96raIGFwR9IuhkrBIY1kix8viU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=korea.ac.kr; spf=pass smtp.mailfrom=korea.ac.kr; dkim=pass (2048-bit key) header.d=worksmobile.com header.i=@worksmobile.com header.b=wue2K4r9; dkim=pass (1024-bit key) header.d=korea.ac.kr header.i=@korea.ac.kr header.b=D+hOjGIf; arc=none smtp.client-ip=125.209.209.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=worksmobile.com header.i=@worksmobile.com header.b="wue2K4r9";
	dkim=pass (1024-bit key) header.d=korea.ac.kr header.i=@korea.ac.kr header.b="D+hOjGIf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=worksmobile.com;
	s=s20171120; t=1778784738;
	bh=4ZgZ1jc5MZTVJWvr3jQ/Q+eroPwBgVQCOd4Bu0H768g=;
	h=From:To:Subject:Date:Message-Id:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=wue2K4r9JGeu98SDXNuxLFU0uEBiZ5HKS8aJXaduu/Q3zaCZNru0+TKIZm2UpIkkn
	 h7odd6n1GF9a5UggVg5YfOCfJaa/6soTKfuMt1vlpgkKsHdthGsjAEUkLGWwurmv1c
	 IkL1Ao3XUgZn6gZVwA2NC3EIpmBjk3hEqTBOVgj8rK74jkOWzyFeXFOo7fDnRKDXNW
	 UvCwcuVduJEFkLuO4r9UlGofPO1qyjCoC6NrA0hns4+vlyyxYBq/p6tSAODelTbL2a
	 CYljl+hssbaJdkvBC5IVoasmgPUvGsMovkbFSSUeAs+it40Qde239cVhA6ZiN/KPMM
	 i3zBhziTNUeDQ==
Received: from cvsendbo006.wmail ([10.112.11.111])
  by cvsmtppost101.wmail.worksmobile.com with ESMTP id xVy2g7BfSASG5QlKvX7AXg
  for <linux-omap@vger.kernel.org>;
  Thu, 14 May 2026 18:52:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=korea.ac.kr;
	s=naverworks; t=1778784738;
	bh=4ZgZ1jc5MZTVJWvr3jQ/Q+eroPwBgVQCOd4Bu0H768g=;
	h=From:To:Subject:Date:Message-Id:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=D+hOjGIfWmfOrZZn+a47+wbANy2/yfDKV8RrzJC88fsUe+/PmvRMf2UADkjwJxPFS
	 hPeGvANTdCCqzmQwoXIflnwrFCjYNilEXkJT/HyU+U+fWMqy0ObtVZhpvqGwvKAPxz
	 yKLTvhCWIIcaVQ+EBjE8LuwwrzRpWFzOAIGr8pj0=
X-Session-ID: hkeWohAKTAe+OyJyNKSmDA
X-Works-Send-Opt: penljAIYjHm/FqM9FqJYFxMqFNwYjAg=
X-Works-Smtp-Source: AqK9Fq2XFqJZ+Hm/KqKZ+6E=
Received: from s2lab05.. ([163.152.163.130])
  by jvnsmtp402.gwmail.worksmobile.com with ESMTP id hkeWohAKTAe+OyJyNKSmDA
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Thu, 14 May 2026 18:52:18 -0000
From: Ingyu Jang <ingyujang25@korea.ac.kr>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Jarkko Nikula <jarkko.nikula@bitmer.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: ti: omap-dmic: Fix IS_ERR() vs NULL check bug in omap_dmic_select_fclk()
Date: Fri, 15 May 2026 03:52:15 +0900
Message-Id: <20260514185215.3753998-1-ingyujang25@korea.ac.kr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

clk_get_parent() returns NULL when the clock has no parent (or when the
input clk is NULL); it never returns an ERR_PTR. The current IS_ERR(mux)
check therefore never triggers - a NULL return falls through silently
to clk_set_parent(NULL, parent_clk), which simply fails with -EINVAL.

Use a NULL check so the dedicated error path runs and the prior
clk_get() reference is released via clk_put().

Signed-off-by: Ingyu Jang <ingyujang25@korea.ac.kr>
---
 sound/soc/ti/omap-dmic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/ti/omap-dmic.c b/sound/soc/ti/omap-dmic.c
index fb92bb88eb5c2..f6c393c9489d6 100644
--- a/sound/soc/ti/omap-dmic.c
+++ b/sound/soc/ti/omap-dmic.c
@@ -328,7 +328,7 @@ static int omap_dmic_select_fclk(struct omap_dmic *dmic, int clk_id,
 	}
 
 	mux = clk_get_parent(dmic->fclk);
-	if (IS_ERR(mux)) {
+	if (!mux) {
 		dev_err(dmic->dev, "can't get fck mux parent\n");
 		clk_put(parent_clk);
 		return -ENODEV;
-- 
2.34.1

