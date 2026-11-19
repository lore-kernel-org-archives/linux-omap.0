Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795095680;
	b=0j4PxYCWeb4LwfVvkKszIMyVv6eBnbfBcW7nkh8s1xHtGL2qbexO5vq8CZ9KSIO1QxQ9
	 hTxq3FFxOliMj19pmSwMz/To5GaDxxRPNbNWzr0h3bs1DqejcrIB9Ch2EdQaU2mR3uG2/
	 UgoDkwkcgNk5yW2pfcZKK1tLAEtJHB5/saJaD1m5fME5bIcNHVUgojMXczYveVHoeJg89
	 gB9LysDYM8Z6emI3fXiqmqUyN9JDF6gCI/kDPuF1FemQTkcufIkV7LAv8Mvl424TmO/+l
	 GKBfMnEthiPaCGz63vrA37A2B74EH/W1H3EMCCxaCFfvfUY65ONRL0QPeDBwPKTQnmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795095680;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=zczQURdkD0wwkwD7Y44TgccHjIB8bGM2wiIzQ/0bd2s=;
	b=Aw4HSYggHmuVfH7uN8G+/30z7HydfoNKwWh7+yHKUjB5ApLjLwqRPmWVrVJx2HYKF6vR
	 HWG7mplF8BgcFyeljTO+k7oQWKmiwTBzfuLKie8kWxsLogaVXeGTtzXanKZyX9XUWd70h
	 AiIfrDIUO3NOLLqB339RmUIXCA4ikgoqoi9pPoECqUUnAjNnLSGqEF5WnldFf6lGP6HIs
	 8GWpLNpFnPcJgj6Fz/ihtgJEjqsbriNIEz/ZjBKS97eG63XJqVm/FaYkt7uLZEkOntMcn
	 NJMGEtyGu7icOsaeqvEmzgMSOxjIYvvssBmdrYiOsHxUV4duvTXY1E6aBF8Wuq8ORrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24ED560A262D;
	Thu, 19 Nov 2026 13:41:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C381F00932;
	Thu, 19 Nov 2026 13:41:15 +0000 (UTC)
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
Subject: [PATCH 6/6] [RFC] pmdomain: renesas: r8a78000: Convert to dev_clk_get_from_provider()
Date: Thu, 19 Nov 2026 14:40:39 +0100
Message-ID: <81de8a7aadf587377916763d24181c44b5d13775.1795094688.git.geert+renesas@glider.be>
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

The R-Car X5H clock domain callback uses of_clk_get_from_provider() to
obtain clocks used for power management, so the latter show up as
"deviceless" in the consumer column of the clk_summary file in debugfs.

Fix this by using dev_clk_get_from_provider() instead, letting us pass
the consumer device, too.

Sample clk_summary change snippet on R-Car X5H Ironhide:
    - hscif0 1 1 0 0 0 0 50000 Y deviceless      dev_clk_get_from_provider
    + hscif0 1 1 0 0 0 0 50000 Y c0710000.serial dev_clk_get_from_provider

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This depends on "[PATCH v5 14/15] pmdomain: renesas: r8a78000: Add SCMI
remapping support"
https://lore.kernel.org/e6816327da51f9fbeef67f13aac723b891e5042f.1795029012.git.geert+renesas@glider.be/
---
 drivers/pmdomain/renesas/r8a78000-mdlc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/renesas/r8a78000-mdlc.c b/drivers/pmdomain/renesas/r8a78000-mdlc.c
index 79f6f1a9ae95d245..bb8c9f2b68fbf746 100644
--- a/drivers/pmdomain/renesas/r8a78000-mdlc.c
+++ b/drivers/pmdomain/renesas/r8a78000-mdlc.c
@@ -232,7 +232,7 @@ static struct clk *scmi_get_clk(struct device *dev, struct device_node *np,
 	if (fw_id < 0)
 		return NULL;
 
-	clk = of_clk_get_from_provider(&scmi_spec);
+	clk = dev_clk_get_from_provider(dev, &scmi_spec);
 	if (IS_ERR(clk))
 		dev_err(dev, "Cannot get SCMI clock %d: %pe\n", fw_id, clk);
 	else
-- 
2.43.0

