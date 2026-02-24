Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959013806A6;
	Tue, 24 Feb 2026 14:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771944383; cv=none; b=D/S39aE5NXLD9OPWm16ZFuiPZaLRbwr1pS9mHP7SDVrJX0L3QI0S6mlGiJpZfSRov7a5IOSrts7gnAOa36+5bSYv+VDXPbx6CLoh+eez5+dTObLNXghIWVpniFGx6plxphd20JEzn0UX/mj2Frtiy2wiFpnJ6yKqB3SX4ykCJlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771944383; c=relaxed/simple;
	bh=STOXsCiRItxsdJtrG6ARf/HUegRZfgF+Gf1abAdESy8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uBgCxQBb4PyZ4S4EO4JDCCvPFWM6Hl1UgfE2THAmOIG5zepPxJDZi6UQGIU89jAoEDh3KCG0gR34OMWRbpfKFeoG1jQhrCuRcZCmAEj093JzIRA5yfAYLUgvxw0zaEqqiQLKFflYRdTfhlWG4L8gY5AQkI/L0Vw9sOHc4nCTft0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TZ+Lvq3B; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TZ+Lvq3B"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771944379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=k32KDyySgUbuIjVNpXCTKNsbzVwcn3SEN2eNfGW1Vc8=;
	b=TZ+Lvq3Bjl1uyl+Khx8qDEg3z5NRhBeax5hYW2kYjgGWVVbpxEPWc2YNQFKgPZ0fapxYT0
	/cvmPCLZLbkyej5uElyVyB1ybUrJhsK9C/eQ0Q9q167utnS1JPdoN5wePNHu1BpWH70Pts
	zfMS6dWjC5DQy1b7CDE0iSlio/xsL60=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] ARM: omap2: Replace scnprintf with strscpy in omap3_cpuinfo
Date: Tue, 24 Feb 2026 15:45:51 +0100
Message-ID: <20260224144552.585272-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace scnprintf("%s", ...) with the faster and more direct strscpy().

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/arm/mach-omap2/id.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 43f5944850e6..cf2bfb447ee2 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -17,6 +17,7 @@
 #include <linux/io.h>
 #include <linux/random.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 
 #ifdef CONFIG_SOC_BUS
 #include <linux/sys_soc.h>
@@ -250,7 +251,7 @@ static void __init omap3_cpuinfo(void)
 		cpu_name = "OMAP3503";
 	}
 
-	scnprintf(soc_name, sizeof(soc_name), "%s", cpu_name);
+	strscpy(soc_name, cpu_name);
 
 	/* Print verbose information */
 	n += scnprintf(buf, sizeof(buf) - n, "%s %s (", soc_name, soc_rev);
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4

