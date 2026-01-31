Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C789B1F4C8E
	for <linux-omap@vger.kernel.org>; Sat, 31 Jan 2026 12:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769862183; cv=none; b=HLky+EfX6HIYHWT3k6LbFSFTcB8R0/uE7C7YUWsWa056auof1XxqTaCh2/9GWQXm3iFLvDQXXb4PNiKsY5iHR2nzku5M/uQKf2x7tL05yTHMMgXLUyuZstetgZnRbdd7Hn5NXehfNLorsTuvhhRSJbC7qNG+bjuLW1xUZjyR2Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769862183; c=relaxed/simple;
	bh=W8hMjZKDh2gVhowF6rziH5njV1kt7R2YbYEkCM3K52A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PsVEwybYkfY//nZ/Pe6PBlexyL9gFxjoGKw/uK8tgghMx6I+0brcU27UTjxoEAG4HQAZR0JyLsUhYMq4zky7re1nccjBxcV31g2bShXaEzhQF1GQUBV0BiD4OtLu9t9QAQenCK3gp+ncAD2svhkBvjNU23g1qDXY6zIYXMKOPuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bg7z/PTw; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bg7z/PTw"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769862179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=y4AG9zjQxz1mJY9gQSxvPqo/5V4VjR3fM231VFwrTGg=;
	b=bg7z/PTwc4qua1wW0MAZwmr5FSsIqt1hmGJTCIWppfvAlM9aPaKVR1ITYERObFMngp/u6a
	H1jVASNfm8PqTwfY4LSTni472BUBIzaNuZmTu3vywfsU+MFq82V6UTrB3GgFoglS2aUei5
	e+KtB8FM3o5ef/YelmtMrOcQHYR6epw=
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
Subject: [PATCH] ARM: omap2: Replace scnprintf with strscpy in omap3_cpuinfo
Date: Sat, 31 Jan 2026 13:22:38 +0100
Message-ID: <20260131122238.493577-2-thorsten.blum@linux.dev>
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
index 7f387706368a..068c6dfa3a48 100644
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

