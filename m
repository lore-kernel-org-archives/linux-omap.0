Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795095671;
	b=MlEwdYg585WOI1yTqvfzFQk1r6eCH41yUMWg0cM5Q05i0luEaf0FxVWTgHxpmAXiJin9
	 gxVXmnulush6YcdjazH4yf3xlwgXZ6uUXpUHJKxmc/aJeFgDujrR21Uueg3Tg8OkP8CcR
	 Vqm9UcdwcJ/rL+mwGt1Ug0T/aGoeEBjRgPVIHgBsL3yC0Z83OU7beHLhvG6PeJoB1XshK
	 Mpi9KQZoxH5ns6Fg7OMpegPs6sUUR3qQH+TrOJBFFgqiPsjsKNYkrp7Y0QexOaF4Yg2Lt
	 u+tVmS8bz06najXUl9VIV1XZD44wDaleBlJOsorVGpq8jFLf9Oek/wMP3moNkcE1vGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795095671;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=0tdTVZDX49Rm5CCnI7ZG5//mbJBXPyNRQMJJCRmwT94=;
	b=0fIUoWkLI37XDEL416o+Tu1KQAN2JrgsU3SYubGnwDdm8NSzyllfsQyj8zaZfBouSml7
	 EL5Eu2sykleVmZtaDJDhIWmGkDvjrS+lHXVC6bNQ7NoflImY30xDWWMsX4OaA2/Q8mub4
	 Yy8M0BJUBJ0yCZSAMrDYqgRELwJJPe9WsRqp1JhlviDYoo/7P1zsatCYTrtrdi4Qhtul0
	 lb3Y4yFhMtQ6Inf4Fi3LuetCfPgbtI4l5MFRiZKhmhO2WnJxtjYuxflFnWgXJAmHSpzQv
	 CQjbF4UD9iyKs4k+7etj2DS+CgDfDFiHCcUwJnRQwgguYVQ5+hD1vYJxOtuQWkuNfmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2123D606A333;
	Thu, 19 Nov 2026 13:41:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4DF51F000C4;
	Thu, 19 Nov 2026 13:41:06 +0000 (UTC)
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
Subject: [PATCH 4/6] [RFT] drm/rockchip: dw_hdmi: Convert to dev_clk_get_from_provider()
Date: Thu, 19 Nov 2026 14:40:37 +0100
Message-ID: <313d11bdd1dd46e895e34236191e7a3b175d0382.1795094688.git.geert+renesas@glider.be>
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

The Rockchip Designware HDMI driver uses of_clk_get_from_provider() to
obtain the clock for the HDMI PHY, so the latter shows up as
"deviceless" in the consumer column of the clk_summary file in debugfs.

Fix this by using dev_clk_get_from_provider() instead, letting us pass
the consumer device, too.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Compile-tested only.
---
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index b6e154c35e7c290e..a44e4b273924430e 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -633,7 +633,8 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
 
 		if (!of_parse_phandle_with_args(np, "phys", "#phy-cells", index,
 						&clkspec)) {
-			hdmi->hdmiphy_clk = of_clk_get_from_provider(&clkspec);
+			hdmi->hdmiphy_clk = dev_clk_get_from_provider(dev,
+								      &clkspec);
 			of_node_put(clkspec.np);
 			if (IS_ERR(hdmi->hdmiphy_clk))
 				hdmi->hdmiphy_clk = NULL;
-- 
2.43.0

