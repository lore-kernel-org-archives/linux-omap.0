Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795095666;
	b=Z0Zc0NRDn5+l0NAGQKjxRiku5VAO9ljRBIBRvmdddKbVNuYH5uItN9pmLd8BlxEtqcs5
	 8AbIFRWlAYfGel3gXD7sc1pN0BpaZiTnyJ8+RSAYdp3uHUaHYJSswv+hlRga4jxK3BTiU
	 CpIWnSWmTlXiOrLmo7vHXJwSRjZ40+IqYTey6ALu4eFMfT8nM02AWgMzCYTYG8Ttv2pf9
	 YN5vqRY2//Arw++yXrhKHBlJFHY1kRCSIrU1zHhJ2tBlo0QGcaIepbxjHPItOyYQgyGQK
	 6TEbKiSnUsDgYEsdRjobUelGSHcKPevUr2Xzag5wSwfPV0qqXkUQqp8x1or0POOAvSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795095666;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=JNoGiAXrJ60xBE/k7TEkv9UmJyufTjNbXQCoGMPMOGQ=;
	b=HHIsEjuRAh5/+xYky3HnO8wLFNBwuj3hBsyf/Fh4Y8ertJNMORN3qNqOEpuqRZXc7pUI
	 HqlXV1qc7wn+qsOMnKtCV0E3+b1p810MxNM3RPNnRdBoglA57gScBWXsD5+oDYxWD2uvL
	 tjl5WL00hhMwF98Ot8SRC6gFUqPRr6cTUTU6paRDfFTJrcejc3d83Y4j9LOOCrO+mf2/r
	 /UBXFO5Z3H2rATtB+wBNLcDs9tORLiSLNgF8uXY+Pf09bHuL8AGfHSfn82p7rYJCh+XBh
	 j38L3b4ca3TrWGILh+bxNqoEKy5yMRb6SjwlTdE+13MRd7myhqpWzCsmgfcpq+ufOgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF92606A332;
	Thu, 19 Nov 2026 13:41:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B091F000C4;
	Thu, 19 Nov 2026 13:41:01 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Russell King <linux@armlinux.org.uk>,
	Paul Walmsley <paul@pwsan.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andyshrk@163.com>,
	Ulf Hansson <ulfh@kernel.org>
Cc: linux-clk@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	dri-devel@lists.freedesktop.org,
	linux-pm@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/6] clk: renesas: Convert to dev_clk_get_from_provider()
Date: Thu, 19 Nov 2026 14:40:36 +0100
Message-ID: <55d67b95c675924fb67d13ecbab47bb45c8af372.1795094688.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795094688.git.geert+renesas@glider.be>
References: <cover.1795094688.git.geert+renesas@glider.be>
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

Renesas clock domain callbacks use of_clk_get_from_provider() to obtain
clocks used for power management, so the latter show up as "deviceless"
in the consumer column of the clk_summary file in debugfs.

Fix this by using dev_clk_get_from_provider() instead, letting us pass
the consumer device, too.

Sample clk_summary change snippet on R-Car H1 Marzen:
    - sata 1 1 0 62500000 0 0 50000 Y deviceless    of_clk_get_from_provider
    + sata 1 1 0 62500000 0 0 50000 Y fc600000.sata dev_clk_get_from_provider

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Tested on R-Car H1 and H3.
---
 drivers/clk/renesas/clk-mstp.c         | 2 +-
 drivers/clk/renesas/r9a06g032-clocks.c | 2 +-
 drivers/clk/renesas/renesas-cpg-mssr.c | 2 +-
 drivers/clk/renesas/rzg2l-cpg.c        | 2 +-
 drivers/clk/renesas/rzv2h-cpg.c        | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/renesas/clk-mstp.c b/drivers/clk/renesas/clk-mstp.c
index 1bd2acb7e175f9c7..79d3a0b9cf7bb08a 100644
--- a/drivers/clk/renesas/clk-mstp.c
+++ b/drivers/clk/renesas/clk-mstp.c
@@ -276,7 +276,7 @@ int cpg_mstp_attach_dev(struct generic_pm_domain *unused, struct device *dev)
 	return 0;
 
 found:
-	clk = of_clk_get_from_provider(&clkspec);
+	clk = dev_clk_get_from_provider(dev, &clkspec);
 	of_node_put(clkspec.np);
 
 	if (IS_ERR(clk))
diff --git a/drivers/clk/renesas/r9a06g032-clocks.c b/drivers/clk/renesas/r9a06g032-clocks.c
index 871a915c24b8b609..9ae716dc6ede3438 100644
--- a/drivers/clk/renesas/r9a06g032-clocks.c
+++ b/drivers/clk/renesas/r9a06g032-clocks.c
@@ -748,7 +748,7 @@ static int create_add_module_clock(struct of_phandle_args *clkspec,
 	struct clk *clk;
 	int error;
 
-	clk = of_clk_get_from_provider(clkspec);
+	clk = dev_clk_get_from_provider(dev, clkspec);
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
index 1ed11ce4a04c8b44..1fc12132acfe4a8b 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -641,7 +641,7 @@ int cpg_mssr_attach_dev(struct generic_pm_domain *unused, struct device *dev)
 	return 0;
 
 found:
-	clk = of_clk_get_from_provider(&clkspec);
+	clk = dev_clk_get_from_provider(dev, &clkspec);
 	of_node_put(clkspec.np);
 
 	if (IS_ERR(clk))
diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 06ae7228a95480fd..fb57d26947e1647c 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -2557,7 +2557,7 @@ static int rzg2l_cpg_attach_dev(struct generic_pm_domain *domain, struct device
 				goto err;
 			}
 		}
-		clk = of_clk_get_from_provider(&clkspec);
+		clk = dev_clk_get_from_provider(dev, &clkspec);
 		of_node_put(clkspec.np);
 		if (IS_ERR(clk)) {
 			error = PTR_ERR(clk);
diff --git a/drivers/clk/renesas/rzv2h-cpg.c b/drivers/clk/renesas/rzv2h-cpg.c
index fabeaef8e62fba33..4b685f7250f661bd 100644
--- a/drivers/clk/renesas/rzv2h-cpg.c
+++ b/drivers/clk/renesas/rzv2h-cpg.c
@@ -1483,7 +1483,7 @@ static int rzv2h_cpg_attach_dev(struct generic_pm_domain *domain, struct device
 				goto err;
 			}
 		}
-		clk = of_clk_get_from_provider(&clkspec);
+		clk = dev_clk_get_from_provider(dev, &clkspec);
 		of_node_put(clkspec.np);
 		if (IS_ERR(clk)) {
 			error = PTR_ERR(clk);
-- 
2.43.0

