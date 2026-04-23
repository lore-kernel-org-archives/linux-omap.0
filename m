Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40577397E86
	for <linux-omap@vger.kernel.org>; Thu, 23 Apr 2026 17:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776964254; cv=none; b=DP6MedDOa50e0bZo/P4Gz+cfcRUp20bWgFSg5WFbjeqweGa7GqFKwzmTQXqhK8/INQZrPG9K5cwqM43aGeZhYAUzIbKGxLOrgH0SAWDrxopKjfdtnEMqq9lW2fbJw4eGx+maqvUvVjQ8n0Ny3VherinYNr4qe5TOFtXSUqlVyrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776964254; c=relaxed/simple;
	bh=Tyy74BheUnS6akjxm10ICD3h+JaOsQInqTbh3L5x9oI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NFsnNDWAO+E7iL1aAWZ1QRIk9ySdI5n4RwJf3ZabV90YPTew9n6bBtkwtfyVbpsAcGUVY1+lSk/lwLOjkhKTgToPvUhzRdHfUOvhs7G8O3/1T0AG3jiJf06eiIpIh5lg51hNDy0zktrRNvxxIDFsqHtcmClKHbWddHJ0ntKvqRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N/VtlHkH; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N/VtlHkH"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776964246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MkAsnveV0inBO4MynCvtR90bs5VnmNkFUBU/ZEKVlgQ=;
	b=N/VtlHkHYcgebUNQw61PobUQEY++oATBjnCvBrmByqyWz1yr9+g/8m0iJZdnAOrZRr5Chu
	GGiDAw9OZ5F3mZJVdG/RPnMsbZsWnA/LebVzRLKv5jRfx9Emb+aisaQWgA94UBxly1HFji
	1t/ZcS/a+xKH4JIu4kck+1UWbxltbYs=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] ARM: OMAP2: zero-initialize local buffer in omap3_cpuinfo
Date: Thu, 23 Apr 2026 19:10:20 +0200
Message-ID: <20260423171016.275157-8-thorsten.blum@linux.dev>
In-Reply-To: <20260423171016.275157-5-thorsten.blum@linux.dev>
References: <20260423171016.275157-5-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=677; i=thorsten.blum@linux.dev; h=from:subject; bh=Tyy74BheUnS6akjxm10ICD3h+JaOsQInqTbh3L5x9oI=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJmvgqresC5k26ke5R7AdT9+2yYzz9mal3Zu+mwzQZdtX cZrv01MHaUsDGJcDLJiiiwPZv2Y4VtaU7nJJGInzBxWJpAhDFycAjCRt3qMDF/9GTZPUMlaxzYt +9aig373zs/4vuXV+8490tUzOxbKvNVlZHhgLq+29uavqG1Ou79cW2PQzbahtfx1+dbyvf88+jc VSPEAAA==
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove memset(0) and zero-initialize the local buffer instead.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/arm/mach-omap2/id.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 126ffd87f572..9a10e96e65e3 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -209,11 +209,9 @@ void __init omap2xxx_check_revision(void)
 static void __init omap3_cpuinfo(void)
 {
 	const char *cpu_name;
-	char buf[64];
+	char buf[64] = { 0 };
 	int n = 0;
 
-	memset(buf, 0, sizeof(buf));
-
 	/*
 	 * OMAP3430 and OMAP3530 are assumed to be same.
 	 *
