Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC1D284690
	for <linux-omap@vger.kernel.org>; Tue, 12 May 2026 04:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778559830; cv=none; b=cEET+Jxwk71ZGOl5vt0DgSkMgxidb/7r5dZGkjYGl6WLgKnWcqXK38/OdZyBaMvZEDSmF2W+Y7ff5RKxCoeOrW8qfDmnak2B76Qm7rcIdAUD3/J6crXPKHkxDP4c25gu8hHfHqVr/0SsXOHjyin3X9jAqi2mB9mFT/IvbFf+7iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778559830; c=relaxed/simple;
	bh=G7ncsH/WY7d03+/5ipUlNNGfStAI/zSQoQNHBS29pO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wz07hIpzvDJMSxuGaQBWWWsdrK+413IApIdVFgVaRUaoEg8oQRQJ5HyBmjJjnMs0qm17HtH/mmKR/JQ1a8ALC7N2dM6oUOuGrQCgbPpw4Stgtk6falmdHquLAKmBZZJBuwJiwpb59a3gBsFX8wyA/PWaI6czOeFcl6pR/6Gn5ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UyP86qG1; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyP86qG1"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8cb40149037so478552585a.2
        for <linux-omap@vger.kernel.org>; Mon, 11 May 2026 21:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778559828; x=1779164628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zP/+2G+KQKp0jcs9Wp+FgRomWiwgmnqO7eeiRjAeLco=;
        b=UyP86qG1wwl9YJuljB9bV2gp7a5ARfgFNwu6o0y5fhSQIJPBxrrlpWjYIv+2EK6ReN
         BQuKQXB2IdqpNr/btAl3NX8QD6Bw9ep96sFFmfXEDCJ2XXAJtC4PiKeCw0kwXyC5LznU
         QMXKQ2lqh8k8DPQfQh1RZ9lZOnDF8IWQbm6HT2g/9recdTs4+BoEyrR14zKQjPqtAioo
         Yi3L1BTMedb1NX2ksp3JkeqOTnVphmppR+xSi+06ytPZGXVJot64DbjNrtEqevNtwaxx
         U/1UmaFfqKS6a1D7hxAyVPbVzol3JihahiQGWHrpX26ubl8WYwciJTxTXIJAuoyDjcTi
         oueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778559828; x=1779164628;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zP/+2G+KQKp0jcs9Wp+FgRomWiwgmnqO7eeiRjAeLco=;
        b=hengfi/y0C3ZO7j5Tv7aOiej4QYGPzGhGy4pLFafHEprxm4id2xxODyy8ivlPf7vSl
         H1sQnIpY1APXFSWebQz7FDuZv82UuVq7RHkMYZxI21y2ZBmE9KD41CY6p6K13MrqQuyv
         bzNSt5lNyyRkq6fu14yKE/oe4rtU/1UbAvV7bzOslumF5aSe6pfe1c73JUWKxnYO3T2A
         npDnGj572Opdb3CuVOPo5xwUm1iWCdjRJWKVusSiv8h2gJ/t1CbzhlRNzcPMFXfhKyZ9
         F6Jq0rhgVzUDwwdQV/2Gx6Q724srSluTAfbFTSgZBSjavTKVIeHm0OeU5sKmA4qCx7qg
         VZzw==
X-Forwarded-Encrypted: i=1; AFNElJ+jzr1Snwm+RzbKHroVFOG23iuy8+x809HAe8/B/8uggWYiXzZkD5nmapz2WdrKag7ANajowsE9EYif@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl6fYr7t7n4Esjywrg15Yk34BOeKqAeG6GCziOeQnZPOHqymq0
	UBR1VDPUCCHVkIgwcEr8s8AQiD73yKdOwu5Ly6Cb91cUo5ZeRkiIYjIo
X-Gm-Gg: Acq92OE0Lh8BfVU15zgKF5e3OdthF+e58iabZ8EMstQyJvlmnk851CPOGKjcjMTTfm0
	lyUtZZ4E5Pm2swtg6cHg3sRi32QAFjU04MrLTAzVc4Qs68TRlt+G/wCugsrrPUBx+kgsXVNhKdE
	NGwDKKiuIgS8L2fJC0D7+Y1JM8dd4yXjogIV96UKKXmS3vSIEET0+Y/OUKtJ7mQjGV0JxiBFttX
	NQCIEYFhw+PMdUgaNFYAtKvvM6kl1XGZOKfJUna81HdLAXh3tHpcMtznLoe5AxoQNka14PrgfcL
	FReoORfwtHGtIt3zLwQTRYzk6WlQ777Zqi3og7L76iYWq8kdWot2rwGUL6yAk6gbXk493WHeA76
	Zt88JPDQ0HoIfKjDQYZ8sCZbq3b7Fdr6/bhbTx6H1/IG6BSca8YaQVAFBz+vRWegQfNNFHad/Yc
	Nre9wMngA0WZPdWwnbFKnencNXpLqzIsAVkZMVuQH+yr7+QZFBY9pt0haP7Gc5Zg3B7fRGjcf2x
	9yqO8rJbWfvq2dsh6wHSEVKGek27+GS5pqRGAVvotWmhlU=
X-Received: by 2002:a05:620a:4888:b0:8cf:d717:c22e with SMTP id af79cd13be357-907badfbfebmr2504182785a.28.1778559827743;
        Mon, 11 May 2026 21:23:47 -0700 (PDT)
Received: from mighty.tail79ce1c.ts.net (nat-130-245-192-1.resnet.stonybrook.edu. [130.245.192.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53c7accddsm330162176d6.36.2026.05.11.21.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 21:23:47 -0700 (PDT)
From: Mithil Bavishi <bavishimithil@gmail.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Sami Tolvanen <samitolvanen@google.com>,
	Kees Cook <kees@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-omap@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Mithil Bavishi <bavishimithil@gmail.com>
Subject: [PATCH] ARM: OMAP2+: Make OMAP4 finish_suspend callback CFI-safe
Date: Tue, 12 May 2026 00:23:41 -0400
Message-ID: <20260512042341.1452-1-bavishimithil@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With CONFIG_CFI enabled, OMAP4 can trap in omap4_enter_lowpower()
because omap_pm_ops.finish_suspend points directly to the assembly
routine omap4_finish_suspend, which lacks the expected KCFI type
metadata.

Add a small C wrapper with the exact callback prototype and use it for
finish_suspend.

Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
---
 arch/arm/mach-omap2/omap-mpuss-lowpower.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index f18ef45e2..1c51b2f97 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -111,6 +111,11 @@ static struct cpu_pm_ops omap_pm_ops = {
 	.hotplug_restart	= dummy_cpu_resume,
 };
 
+static int omap4_finish_suspend_wrapper(unsigned long cpu_state)
+{
+	return omap4_finish_suspend(cpu_state);
+}
+
 /*
  * Program the wakeup routine address for the CPU0 and CPU1
  * used for OFF or DORMANT wakeup.
@@ -437,7 +442,7 @@ int __init omap4_mpuss_init(void)
 	}
 
 	if (cpu_is_omap44xx()) {
-		omap_pm_ops.finish_suspend = omap4_finish_suspend;
+		omap_pm_ops.finish_suspend = omap4_finish_suspend_wrapper;
 		omap_pm_ops.resume = omap4_cpu_resume;
 		omap_pm_ops.scu_prepare = scu_pwrst_prepare;
 		omap_pm_ops.hotplug_restart = omap4_secondary_startup;
-- 
2.43.0

