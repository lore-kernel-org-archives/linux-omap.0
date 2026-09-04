Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7763D447805
	for <linux-omap@vger.kernel.org>; Fri,  4 Sep 2026 11:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788520209; cv=none; b=R999IgM8MCCj97Y1xPGYS+4PubLd39FeLs3x2sX4UaJyi6bgau7je0/H62wO6irZ/Ja5D/61aPQvzqqcvPNwaARDnrDEZ9p5BHQVgfpmGqad1mjarI4ih6EK/Rzw8YT7SPOiMyw3CPQzwOwk/xQ1AdkX530COWZ0QoQUXVYz7Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788520209; c=relaxed/simple;
	bh=GYR7vyanVJ8plJU01WoNFSGTHSYQC4WumzJhgIObNr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=avLnhgGVp3LNc5ihZ2IZ9BTPYab8wAYN6qUlqdaSrGoME/PTAon4o7uD2EconyQ1QNIwauAQ4BH3nSAi3yMO1uqiRL6TfD6p1FWDf8v6fz0hpsFGuCAnfyTqj6aSpc8f7rTZvlevIcnC9G5hybICY1MK3mIgEeU0xqxpUlXi0vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CXISd3ZO; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXISd3ZO"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6b1a0d75a4fso504293eaf.0
        for <linux-omap@vger.kernel.org>; Fri, 04 Sep 2026 04:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788520206; x=1789125006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zHrBvnDyQmGN2H5xjBYZYpnknekC9rCkGbvIkvPCYYU=;
        b=CXISd3ZOjTR0eHrmBwQpPnqqS9RhVQaEgTaAetkBnJ053K4FvYO3KVq0rwK5ecpmIz
         BrMhDLLACu0gxfF5nQtPVmbn95K5isLL1pMW6rbs3+KsR9JdueB0CAH4xSCngPdAI6+m
         gfAWjgq0vVlL3l+0MO0l5hB19RaAHJTvwrSDd1/b0tSpvudHXnDtMHe7hYlxPr6fbDuL
         IsXMYlO2uwVXk9FmgQeGgL0auAInH+fKzDrI0OU7AFZcoSehsXfWSOkWxJkRhx6x16Iu
         mp6qxXxNKaQ6M9e14XzF2zBe4hq8Vlbo5WV3lrqDsak/4I1hFsvSZKh3a/yvLeJlAfdz
         OhmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788520206; x=1789125006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zHrBvnDyQmGN2H5xjBYZYpnknekC9rCkGbvIkvPCYYU=;
        b=H7Hv4W/1CpqYepB7BRuAxaRzM8io+O/UQwygXUsE+wpGVcqSDVvMjUsUQHz1QRd6hY
         0PYXdsYRGi4s9TUogOFNxuyBk8+R5Dm0pfOuNwZE+9YvwupAXzUBBhEddglLBLQVHy4h
         AVDrE0EI0ljOVSkBzqBEmMu2xjMt44rxrjTrrEaMFXRbZNbUkjs6yQuB3dR4Zb9zk/70
         HBjr9W18t9aDXJOzHK9WosVpknjFx2dI48gWz/zhaMPB2LcOU3XLgCSLnEMvQS3mjhJC
         gT+hlnVds1kYSXVem7YAXMR5VwMs1m2G4kl2jFqYBda7iRa7nncqW1a66iMGNpgIAU1+
         sO6A==
X-Forwarded-Encrypted: i=1; AKwUvBzyvurcG52phgaU+w5C9XGNihRS8+ZvVVkO27pNqm6awHdpgXq5PpBegRhvv5CBlHQlp3tbR79gcnLq@vger.kernel.org
X-Gm-Message-State: AFuF++kyNmP8TY2yKXJxeCSwBQg5x9xOP5wKh8RF+jbDXTCpxDmATY52
	tMivOQdcRjiXb4p3q1CXUb7FY4HBBIlQD3nRopmEuUeeEHfJNC+y4XxT
X-Gm-Gg: AYBFou0bJBV0mcpjoCnUONSaiXpnaltiVC+AS5ceD6BLkQdOXRC2szVQCU7mhoISNyx
	8wCHr7J1/ZG7sTh/Fl/Ht4UW+hTh73eNljRmoEFLT1JZih+UY+qTzqvJbI4Bj41LOiBRGrsEk07
	fZ0FdzVg5omynyQtsASJWbnVjrKAhrV6/TsXM3TM5c9zGDIfQTivmdUp5L9ERqZLaH08jDkOEkI
	nf0R1ChYrX8xc9pEqEz8vs2LEbLSvgIoHCVxmj60+rVE56FvF7ip9PP0US/zDqv0uqmkf19gy7L
	wKBqiMR/os21ZG2OdlpQVTjwaP0fZgBASYp8AeZnnMgLaO9mcrhFW8cm+LEfCu5v3/8DWGO3AMZ
	wrzLM2Ma3IT296OCELV6ukQHn0kNInibDaiMjvR8wTMw1wlmpRG7QtyONCmgiq6Jx3xhVgxbOy2
	r7p4D891AE8HnKdIqdfgQm10Bt9O4XusCBoiMXfj2zM0VW9j9rnVJsPC4BhkJpPI8rXKEFntYaL
	tnnO0CyKkoIj2Y=
X-Received: by 2002:a05:6820:162a:b0:6b3:6444:46e with SMTP id 006d021491bc7-6b6facde170mr3834718eaf.8.1788520206216;
        Fri, 04 Sep 2026 04:10:06 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33450e140d3sm2492230eec.4.2026.09.04.04.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 04:10:05 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Prashant Gaikwad <pgaikwad@nvidia.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Tero Kristo <kristo@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-omap@vger.kernel.org
Subject: [PATCH] clk: tegra: fix typos in comments
Date: Fri,  4 Sep 2026 16:39:57 +0530
Message-ID: <20260904110959.21527-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in comments, reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/clk/tegra/clk.h | 2 +-
 include/linux/clk/ti.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
index 73efd2ff37c9..afa93ba505ab 100644
--- a/drivers/clk/tegra/clk.h
+++ b/drivers/clk/tegra/clk.h
@@ -255,7 +255,7 @@ struct tegra_clk_pll;
  * @set_gain:			Callback to adjust N div for SDM enabled
  *				PLL's based on fractional divider value.
  * @calc_rate:			Callback used to change how out of table
- *				rates (dividers and multipler) are calculated.
+ *				rates (dividers and multiplier) are calculated.
  * @adjust_vco:			Callback to adjust the programming range of the
  *				divider range (if SDM is present)
  * @set_defaults:		Callback which will try to initialize PLL
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 54a3fa370004..61c4abf19995 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -51,7 +51,7 @@ struct clk_omap_reg {
  * @autoidle_mask: mask of the DPLL autoidle mode bitfield in @autoidle_reg
  * @freqsel_mask: mask of the DPLL jitter correction bitfield in @control_reg
  * @dcc_mask: mask of the DPLL DCC correction bitfield @mult_div1_reg
- * @dcc_rate: rate atleast which DCC @dcc_mask must be set
+ * @dcc_rate: rate at least which DCC @dcc_mask must be set
  * @idlest_mask: mask of the DPLL idle status bitfield in @idlest_reg
  * @lpmode_mask: mask of the DPLL low-power mode bitfield in @control_reg
  * @m4xen_mask: mask of the DPLL M4X multiplier bitfield in @control_reg
-- 
2.48.1

