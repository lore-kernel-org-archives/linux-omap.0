Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9529A54CF6D
	for <linux-omap@vger.kernel.org>; Thu, 15 Oct 2026 16:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792083308; cv=none; b=k5tKHdcF00qmFOtkPq/GTwGyRrksUi8k+T/H/uWkkUEXDxW6YkFfmmnvWHOYDpP0u0fOL1Alj5l9vWwGxWCs3mj+nzJYcSVMYCNSfni8FHUvMsxuXjhbea6mUcICzgrP6YrtXWYHrHqyYuBVMYD2mv/RDyk+c4YtialfHrZcVrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792083308; c=relaxed/simple;
	bh=2inYdETjS1/0iXkUB93PtZKo6J17s5dPHUL/VIsncwk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cg1/w5e3omXpdSkJt8ABZOE+9ffIbo657VnVCL6TEyv0E2lublK8AwqsMUHgNcb6k2gQRNT+i19trze5oAfU4ILXNoyGWURuRhY+HIi4tVLMuJvRzdup7RYu+2odGcAgPT4Yrl0eWAv4RIUrYkNHZ/uK8f6EhhSXthVQrJYeGkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IGEslRki; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IGEslRki"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48de6a62a4cso2599510f8f.2
        for <linux-omap@vger.kernel.org>; Thu, 15 Oct 2026 09:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792083290; x=1792688090; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nOQQ4FV9ljkth31bB4LLMsIJDcvWTQeL1zQqaIAUkSI=;
        b=IGEslRkigK5qf5tPYJAaK2WsSFRbsNtb8EFl5Py9DCeE/I4VHBTlJAwbh6dvdqy6EM
         vaBmfY9X5OM6LEUIWk/A79d7DoVtTYSTddmsmfRuqQClXd0Ugh+RA1/Uw4O/nUaLsmdo
         2ciGx4yqcPMvbf2JOK1jbP9WTT+njoQxSxwEto8Fmw/ZQ/DAwXAOURwTBgLLw9ixnEHR
         bPqiaSpwUCuQyBSgguhqiVz9sfRWzlRy0IN5qbB43mtR4YpNtDacImnzTB1uw5f7Dgy7
         vsdyDDsL0hEfeWPqb1xk2NX45AsET2b43bl7BL9aNLH48eYl9fO5smN4g6sWCNxipROr
         6//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792083290; x=1792688090;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nOQQ4FV9ljkth31bB4LLMsIJDcvWTQeL1zQqaIAUkSI=;
        b=OH67LiSbjbgi69B93wANc8fpSIePIWOF+1W1JVtIa5VpQ1mvVKd75j2A0s84MK/C9K
         Ie5XcTmX5P9Y02qsapp2afgp09Xfc0sTB5EGobCs3hiASfGvpMzNSqahneQiXrX5htVJ
         yAS7Li4KxJVKVcq69kKM0FzyD7DmfOmUO4Y7A255mN2R7sXHMm5O53qm1jfktEBHLeZD
         DI2tGSE5uE1LFwF6Hh5XYgRBZon4Z3J4UQpvtA6RBEvZuzQZ+AZ8ZBoP1B1gQlKXbzU1
         IOaQ8KSEd2tNzfbHkr4ZE2xQVjdh0SPJ6LCTlN6s99Y86wp2MMo3COFdt5A2zsjKFEND
         6SJQ==
X-Gm-Message-State: AFq9FYL5IuqKDPHl6kg3xD1cNTu0mmV8a4kSqnUx0S7htm6xGJGNbFB5
	7ontQGJhNpY6bpEdtQ/hr+iqrBM7IB9YxNQSszvd016fp3jpmx90y7pLwqA1EHwWXEI=
X-Gm-Gg: AYBFou1u+VkHUKvnZMSbvJ8Y9cnnuK450Soy3KHGBoH8C9t1yQ4aVLOWN05dg3ckDwQ
	Occb9sg1JDgAKBLxlfns99ai8i26FR3bmglPlEV03ggsC9fglvYUJn56jY2S7Fq8XJn9WGR++pa
	poYE7/sJIzJDTZL8OGHhzofH2T9oEzRGqcbS3ClZP23YBhWWI2HThA3kF6ubP+d9yYhXAaFnhBD
	M0iAdTWzv0EKqh8hk8RcCHZS+6WRdNeKLIu7jJZCCQcVnUa85wq+EGVGIzJq9G5EgYAQq/xDbOg
	VpbeeY4hnKU1Hefzn7k95isoPnkn3DCCpwOg6A3aevNdyv76B8Dh0Fh5yFCbsJpEUZhEI1G8NaP
	9L29qTh4e5GV7z/FpQnejC0nOxQTt5OfPH0IsIc0BsKCj56r3osdAWxbL3gM1fFWIF6VT+eUaI1
	DvJUKjaZIMO1Owb/R7OrRlXYY7l7KQYUVJDxbl83SLCIsNOxNZFF/sriqRhhlVu0fGvhHOnN/O4
	PUnJHFFxW1htMSBZSotuP1sGeLkQkKoR7UK2V9I6g6pIexBtxycVazxjkbsZlW9QRfPSQ==
X-Received: by 2002:a5d:548e:0:b0:486:fb08:2353 with SMTP id ffacd0b85a97d-48dbaaeda2amr27025205f8f.31.1792083289768;
        Thu, 15 Oct 2026 09:54:49 -0700 (PDT)
Received: from z13-ek5.local ([151.41.28.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0aaa5dbsm20775664f8f.12.2026.10.15.09.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 09:54:49 -0700 (PDT)
From: Ettore Chimenti <ettore.chimenti@linaro.org>
Date: Thu, 15 Oct 2026 18:54:33 +0200
Subject: [PATCH 4/4] clk-816x: add sys_ck clock as sys_clkin_ck alias
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-patch-ektor5-dm8168-clk-v1-4-8b99c5cd5541@linaro.org>
References: <20261015-patch-ektor5-dm8168-clk-v1-0-8b99c5cd5541@linaro.org>
In-Reply-To: <20261015-patch-ektor5-dm8168-clk-v1-0-8b99c5cd5541@linaro.org>
To: Tero Kristo <kristo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Tony Lindgren <tony@atomide.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Rouven Czerwinski <rouven.czerwinski@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ettore Chimenti <ettore.chimenti@linaro.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792083282; l=1025;
 i=ettore.chimenti@linaro.org; s=20261014; h=from:subject:message-id;
 bh=2inYdETjS1/0iXkUB93PtZKo6J17s5dPHUL/VIsncwk=;
 b=1O5ZnXuEuCnMjVuOJ4/eQtTIjxT1rnz127MjHOzITCjBaKT4WFTMzwIdwSnN3JBq7HUuWeMkK
 TtnNlcvtqHgAr67OdDdCYKEthyZ5kv0y+0ALBbuBnHrA6OOgOB7mXzO
X-Developer-Key: i=ettore.chimenti@linaro.org; a=ed25519;
 pk=wCaUblFVaqhuBTQt/hAtysafsAaEsqj/yOD9SPlz6NM=

This patch adds a new clock alias for the DM816x system, mapping
'sys_ck' to 'sys_clkin_ck'. This change is necessary because the voltage
management driver searches for 'sys_ck' in these systems and fails
without this alias. By including 'sys_ck' as an alias for
'sys_clkin_ck', we ensure compatibility with existing drivers that may
reference 'sys_ck'.

Tested-by: Andrew Goodbody <andrew.goodbody@linaro.org>
Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
---
 drivers/clk/ti/clk-816x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/ti/clk-816x.c b/drivers/clk/ti/clk-816x.c
index 3b8e483aec92..fe6f66fc5a05 100644
--- a/drivers/clk/ti/clk-816x.c
+++ b/drivers/clk/ti/clk-816x.c
@@ -57,6 +57,7 @@ static struct ti_dt_clk dm816x_clks[] = {
 	DT_CLK(NULL, "timer_sys_ck", "sys_clkin_ck"),
 	DT_CLK(NULL, "timer_32k_ck", "sysclk18_ck"),
 	DT_CLK(NULL, "timer_ext_ck", "tclkin_ck"),
+	DT_CLK(NULL, "sys_ck", "sys_clkin_ck"),
 	{ .node_name = NULL },
 };
 

-- 
2.56.0

