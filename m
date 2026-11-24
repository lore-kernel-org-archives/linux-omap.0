Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795512133;
	b=Xy9gbHIuWZoin+INvWQxPlWVY36IrFw0PkbVLijCQd0QIlf5yt0p2wAeMaGWoUHuF0BM
	 ipvR1wnBXPSkQZDQC7NwnwIn7fD67lhWB21aoHeCGtU4HTYINtIVdoT3b1slf02Ra2cAV
	 dRE7dvRc9SeEeyf3G9V7gcJng4C24Or60kMQ0SUhIi6qwrfyuDxjRSiEwbuJ7GGAikXiJ
	 rbPOX7u3zeMo2xCFxi0QzmAA/Sd08ytd48QhtPO0SX9yXBXeipRu++wD9+8HL5NYl1akL
	 C3r8lMijXisWn1wFH7PgiNHetCKbs6Fwe6u7s0MivD2Pk7cUXWyCUaaoLIrCrLEsp/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795512133;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jrYGP2NUS8MDFLO947LbBcMGV4wVMpRFW1toqHZsyiQ=;
	b=Us2PZppAlGyNEZApJlaGw1J9NjgeLtvjbI3WWysq811651dKPplKuTnsfx4JX2kjHtwA
	 nDmNnwjgeIZISAgPZ54+38QSZRGVW403xqrqaW26WxWGEEougOmga+BzrEPmZGIRp+IrV
	 rBKEYLWNvt9+y/FCZHNOpxw0MEre6Hy23U4fPEDT4SoE4m4zXfLAl9hEBCa/J2YT0s1WL
	 DUbE+fhmB0o/aH+aaSy9hQ7tjfXAODOWSDKdo9Bao3d+oSi1fISQta2KmgZKwRkca8vQ/
	 DINftzXZI3+aElOorJgEkHhZpCKapckTGLdxiUm6rLbV3nLc7299at2H9bRF2TuGI0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yHelgFAX;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A33606A682
	for <linux-omap@vger.kernel.org>; Tue, 24 Nov 2026 09:22:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0A33606A682
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yHelgFAX
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3869f03af6aso3508797eec.1
        for <linux-omap@vger.kernel.org>; Tue, 24 Nov 2026 01:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795512131; x=1796116931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jrYGP2NUS8MDFLO947LbBcMGV4wVMpRFW1toqHZsyiQ=;
        b=yHelgFAXHZlKvExHvczgHRjsBLUOzun6wvv98SQTI27ld6w0gqkFpdDqLZPkzojczO
         Tlw/xOZqjwWcfDKs3kzRys1VVO4NdDw/PXwWSZH0JTk1QltoBrVwBrilicExolBya0Na
         4m27JH0nxVIkJsCpvEZj+BVwq5kk98fyfFmjdlUt18W+ao1sUebf/QiW/Ap/10RSghII
         XOfPl8vbmPQyLuAbklXzAwt5ucs96Pm9ipadzRAQsH6gE4u1wZB0aBPX263P/YqncJ+g
         gD3bqiW9JTfzTN62bBJEeO7q9vVV/iA5EUGIPqwHG2WS5xxRkytsiJOUO2H35LpwKC0t
         km0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795512131; x=1796116931;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jrYGP2NUS8MDFLO947LbBcMGV4wVMpRFW1toqHZsyiQ=;
        b=qu0dadZP55fBLE7LOWB42lDKZZcLmLQ10uOvUIYEzr5b9IquQU2XSmsl4AnnXreBaC
         3upCnQe5XZJ/xcAUfjJN/6sR7O4P/fSveleAXpY57OHlIZMOFfNb2Wq8SskoK1ttEwfF
         rQJpV+ERdFFDEUtqnddJiXEuRvFE+7zYP7DVgSrMfwXG887FbAT21bexDPJYZs4DkQ3s
         g3u/iUjq+Z7XymRzX+Ka2KCJf5Gj6+ZLKocJQNjYryPkLhyqhjyJiZEfWbdzeTkRD9pU
         59Su7DK7Z8HjIvtZKNBNzUkguIeU9Nr/vJl65mOwmejL6eQlApGhhS2/PKAFxuqXIZUX
         qlHA==
X-Forwarded-Encrypted: i=1; AL+hErEDQ0m+M1wvUx99E4VAzfBcTQmlMbqs1XIfaksiPMQ5Hl4ViTCYDtUUA19q3HGgf7qICqIurXZK3Mcq@vger.kernel.org
X-Gm-Message-State: APuU4Z8Zn+iH8q2NfNaDoSjI0P7ekdVvE63j+sBA5I8x3aDoDKndRFeO
	udXinKlCe3vqEJKgGNsb5iIahzq7HfbC/EFrhM8QPW9ozjq/nTrll4+s
X-Gm-Gg: AZFdTZfhJ9QznGpwYMMRJlh8m7OeGxfNOgEW9N5OgzVGs/c1Uz3hqncA5JZmvyY1lMk
	HY1yk1IoI3edI6PCpBVf/vVVucwbf0NYMK4PMfzSiEWc/Cby6U6f2QoXf6Aqejl5j9Lp2czxMhr
	6rlBYOeDrkafyjB1nXr7sv+G6UBriCKJNs1jhFCq/4P7AjdHPggCl9oec4500PW1J1z87WorZIE
	HeaUjunBanbTEWcGQsV+bDycUH6EEg72ch0miAvwLV22xzu1PtS/oTIOzq+vPtJwZt6NZqmobE1
	YUGMZ+3sLP8JiQ9MjXTUYnJ2/B49HBv0CRorj4uWDOS8uaTo9NPpWHFvBRwyHLCZmfKuzDhlXpF
	8bPei980nccCws5Pw2bnVczF59DMwgkd6z+6CjCplgTHpaoibzhIkgF+/B9RGpWKWg851tek5+Z
	pnudI3MKHoI4M0N5u+O8dtlivlHvbz1l7lcjgCWnTnhX0JWrIgYrNb4iVZtzvsE/lEJsn7vMIOo
	tIMT7KiXZqsA7G5RNI4SAH85E90xj7iY3QFpErKTnd2E96C4LlGUqBgWZM5MwrVSwc943XrJ57+
	owrkYWEfnOhPjRsP669VXLNLvqAULeohfnH7+gV+nnRy/vg=
X-Received: by 2002:a05:7301:7187:b0:386:bd8:7abb with SMTP id 5a478bee46e88-3860bd889c6mr13672914eec.11.1795512130689;
        Tue, 24 Nov 2026 01:22:10 -0800 (PST)
Received: from SGN-LDSENG.tasernet.com ([2405:4800:5cc3:11a:1ac0:4dff:fe8b:4a69])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c349csm45902545eec.22.2026.11.24.01.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 01:22:10 -0800 (PST)
From: Cong Nguyen <congnt264@gmail.com>
To: Vignesh R <vigneshr@ti.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>
Cc: Josua Mayer <josua@solid-run.com>,
	linux-omap@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: omap: do not deselect the mux-state twice in remove()
Date: Tue, 24 Nov 2026 16:22:02 +0700
Message-Id: <20261124092202.3766910-1-congnt264@gmail.com>
X-Mailer: git-send-email 2.25.1
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

omap_i2c_probe() gets the mux-state with
devm_mux_state_get_optional_selected(). The helper selects the mux and
deselects it again when the device is released.

omap_i2c_remove() also calls mux_state_deselect(), so the mux is
deselected twice for one select. Drop the call from remove().

This issue was found by auditing the driver with an LLM coding assistant.

Fixes: 43c00f2bcff7 ("i2c: omap: switch to new generic helper for getting selected mux-state")
Signed-off-by: Cong Nguyen <congnt264@gmail.com>
---
 drivers/i2c/busses/i2c-omap.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 4dd111f77ea0..d3c576ca7681 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1520,9 +1520,6 @@ static void omap_i2c_remove(struct platform_device *pdev)
 
 	i2c_del_adapter(&omap->adapter);
 
-	if (omap->mux_state)
-		mux_state_deselect(omap->mux_state);
-
 	ret = pm_runtime_get_sync(&pdev->dev);
 	if (ret < 0)
 		dev_err(omap->dev, "Failed to resume hardware, skip disable\n");
-- 
2.25.1

