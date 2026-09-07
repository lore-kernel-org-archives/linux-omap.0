Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBF7403E9D
	for <linux-omap@vger.kernel.org>; Mon,  7 Sep 2026 06:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763662; cv=none; b=rdeeHU56bjfhppGPtzB7CtBmbA+vGgA4Txu2MR6LiS7herzlh6l4Yy6D23EQlYE+iyFjM0g+4X/wLekz/KWe8KlKep1VmCTCbTk94Z/GSoA9F3Z7SctKK7y1h4zbuIw9jgv6MJOuzpdF6h9k0l18WtPilQDit/ttKE7c2ivkdw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763662; c=relaxed/simple;
	bh=Q3bBIxz90yEEYsWH5ikWyXfUpYba5QGg5QwQbHT02IE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WcW7QqxIXcUyie08QGbmiQwdCti3YS0b0iYMGeIOgPcs4p6dZRw3CY96b+60c2g4o0ICxz6XmiSWe7mSDyL2gAhnwrXzsfL917CMWN0Lor698xG2RIM0zo7Tp3pp/HUxuHlVmzCYPn4qdGGBr5jVa0vTIUGb5L879QwWSmuY+as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KAZsVs8m; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAZsVs8m"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-39682983a0fso3467230a91.3
        for <linux-omap@vger.kernel.org>; Sun, 06 Sep 2026 23:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788763660; x=1789368460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rh6WnyF7wCSbyOvDJNwh7JY6+tMlKujEj6rsY7bD4mU=;
        b=KAZsVs8mh7GDKrQAO6O6sFD1lealyJfsfycKd4Cq8TDv5qJRo2Xv0wNqiSeksip3Jo
         bwaG3maYCK0tnc5KilVd1m53J6omDjYYFBn71RxoIQn2CjnFrZid49ZKQGlVORxQXQ4w
         3EuR+ppm5eOflUmC3jMnalDFXyARUu58qNYhC6WPGNF3VwWzx6L02Cx+4pq2qxgM6SbI
         GRZZgP026U+q7V9bSSs7Kb2SDFe+0hz87+JGgLz9N6gsHe4Cy7Xg9Uu/nYOxbahxER4q
         PD9R9MH5gP9ZU/kkKV1i5mf2HjR19R+PZXTecqVEkWMSuD7YDtCw/JMxaIZ3gYBTtH32
         0YUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788763660; x=1789368460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rh6WnyF7wCSbyOvDJNwh7JY6+tMlKujEj6rsY7bD4mU=;
        b=ErvxahxrgnGvS5ugKy1uzvkMNGgeMdQrq6VgL5MaZ+Yzl2rR/7RCuzct4P5bbR3msX
         vwSLZsNCPvsqj2DIPVY53HDJGBAkPPipQN9fwywzt2Eij4+hHNmVNtga2jkuoXt5qie1
         j2kTRSdInFSZ/DaaYuj/6XmlYwEQiP4dGIX/z3wyce6GuNTs+pcfctYpYCnD43a74yNT
         45it+9nTcnLszZRma7m3lDS95crg3c2wKPyMnaxgPsJaZjhWLPQuR/Oo20tpVG+JIltP
         YdsAfFutMGiqRejzdyFKHlgU7lUPulSuapDTWr9n/i7rxOhmMIdoyasLcGyH+ferAZbL
         ZiEg==
X-Forwarded-Encrypted: i=1; AKwUvBykVABFeOKFtHivCP08jMziKKJHQKlMAusii2DFrVXRwOyr7RjJqzFqetpwOdPKen7qsyanTpsoVeEd@vger.kernel.org
X-Gm-Message-State: AFuF++ln+V4+wYn3ePZ2G1hTFAg6Yv1QVZMLxrV+XqCLH+OT7PtWz45b
	xrzJebMwlWJvXuuQowCFIWbCRAsyZ77uxh/ls6INZyJfsZwmPJhjpjVu
X-Gm-Gg: AYBFou0+3lK2aaw6mcp9HjcHdw64KMDgw9y3y+baCdAgSj6LUMQb6lf6IcY5bqfR3MQ
	Z8KrRaIlA3no+XXaCRkrluiHZ2PoxSgiD38T/eYVgha4CmOMrWjm9C69rsSRcfMq1mPZZeVyrIX
	XgausmJZCu7apmGmc50HuDPnUmeClUePZ5Hv16gXYkDWfiio3N/GqgvXbz8JMgV5UqnbmFsGDR2
	bANnD/nevx/XvqqxaSW079EiaRQhapfKddMtiRhvFSfnfIxRZi9bXH/pjfxSlgxHWGqzddX0Mk6
	jL2qGLAUbHTvtiG2wa8ByKG2PG9uCmfJzeC+qBdzZccJPnICT+r2k5rjLRFlBzHXb1poV4WoJJg
	/1PEz655gu1R69sZUiGaSuwCy5NSZf0elln02o0xl2LhmHnYuFSE2Neym4S1SO4W+zMKvjd1dTI
	g5PU7pIHdVc/+ALK+dtfq+Ir/TPXnQn1x+g/Jm9H1uMPSnTUsIWN5g12gsxRM9ibPgRO9OmoRht
	rW/Iis3x6H0AQ==
X-Received: by 2002:a17:90b:5790:b0:398:9bd5:4910 with SMTP id 98e67ed59e1d1-39b2624f0ffmr31452068a91.23.1788763659995;
        Sun, 06 Sep 2026 23:47:39 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-333c9db92b1sm24811158eec.9.2026.09.06.23.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 23:47:39 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Eduardo Valentin <edubezval@gmail.com>,
	Keerthy <j-keerthy@ti.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pm@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH 1/5] driver core: fix typo "sucessfully" in comment
Date: Mon,  7 Sep 2026 12:17:21 +0530
Message-ID: <20260907064725.10686-2-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260907064725.10686-1-hemanth.selam@gmail.com>
References: <20260907064725.10686-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct "sucessfully" to "successfully", reported by scripts/checkpatch.pl
using the misspelling list in scripts/spelling.txt.  Only touches comments,
no code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/base/power/clock_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
index 59bb37e8244c..3b8ba27802a8 100644
--- a/drivers/base/power/clock_ops.c
+++ b/drivers/base/power/clock_ops.c
@@ -250,7 +250,7 @@ EXPORT_SYMBOL_GPL(pm_clk_add);
  *
  * Add the clock to the list of clocks used for the power management of @dev.
  * The power-management code will take control of the clock reference, so
- * callers should not call clk_put() on @clk after this function sucessfully
+ * callers should not call clk_put() on @clk after this function successfully
  * returned.
  */
 int pm_clk_add_clk(struct device *dev, struct clk *clk)
-- 
2.48.1

