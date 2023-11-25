Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD0B10CB;
	Sat, 25 Nov 2023 01:29:53 -0800 (PST)
Received: from p200301077700a9001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7700:a900:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andreas@kemnade.info>)
	id 1r6oyw-006fpG-SQ; Sat, 25 Nov 2023 10:29:46 +0100
Received: from andi by aktux with local (Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1r6oyw-0004JV-23;
	Sat, 25 Nov 2023 10:29:46 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: lee@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	bcousson@baylibre.com,
	tony@atomide.com,
	andreas@kemnade.info,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org
Subject: [PATCH 5/6] mfd: twl4030-power: accept standard property for power controller
Date: Sat, 25 Nov 2023 10:29:37 +0100
Message-Id: <20231125092938.16535-6-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231125092938.16535-1-andreas@kemnade.info>
References: <20231125092938.16535-1-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of only accepting the ti specific properties accept also
the standard property. For uniformity, search in the parent node
for the tag. The code for powering of is also isolated from the
rest in this file. So it is a pure Linux design decision to put it
here.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/mfd/twl4030-power.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index e35b0f788c504..3ef892e63b88f 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -686,6 +686,9 @@ static bool twl4030_power_use_poweroff(const struct twl4030_power_data *pdata,
 	if (of_property_read_bool(node, "ti,use_poweroff"))
 		return true;
 
+	if (of_device_is_system_power_controller(node->parent))
+		return true;
+
 	return false;
 }
 
-- 
2.39.2

