Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80A1248F57
	for <linux-omap@vger.kernel.org>; Thu, 23 Apr 2026 17:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776964237; cv=none; b=WFwHOaNG4YW9NqDRhA48EGrICeTO+cd7/mUiqXr+uOjcx6QOjplD7jB3IlaKDsR5OlQelgmfCAxiK6f8tAetjR78rsN0i47H3hneJnumucmXNzEBRyPahA7METFj7v/XyoTwxJtUSqFJuM8XGQljXm49cT/wP/wtZFB7sILPPk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776964237; c=relaxed/simple;
	bh=D28Kj9u8DhpEqyh/jTasmroDlK45kJPAKG9CzxmRkbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JtzlQ7kmbFs0GjCT9AE1A2CC7SQY4ZwXCCEbC3AXDvSDXsCaKJjgUssk06ravHJZPl3E7sTHU7bX7i8B00jFm+GGm7NJEfoyWjcMDA8lIRb0I8XdqzBw0/KKMneli4WLIOy0MQhHF1IJOw4+P9AaKHiQak2tLD5Pdwd1xbMdHAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XuBoKW+x; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XuBoKW+x"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776964229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3cS6NH9E8iMTfroFqTmMb96mOe5Oq4jySf9tVkSpS0E=;
	b=XuBoKW+xP6iSvg7To16oj7kI2BMDc2k+kahcJxzfuUNCudZzYkzfMBZtk3hk82hybl5+bU
	VRwtheiO87Wxii5zFqSt2FjxCYdTh2DU01XMufFTXghpOYW93mfLzMyjXOxoQM6LfTbfDW
	OIS52TtFOpJgdQyGVSnAUk5hNUZHMWk=
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
Subject: [PATCH 1/4] ARM: OMAP2: use snprintf() in multiple check revision functions
Date: Thu, 23 Apr 2026 19:10:17 +0200
Message-ID: <20260423171016.275157-5-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2520; i=thorsten.blum@linux.dev; h=from:subject; bh=D28Kj9u8DhpEqyh/jTasmroDlK45kJPAKG9CzxmRkbg=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJmvgirYdn8N+V3opn1HR1c0UNHFRSxsjr7gK4+m1KSb+ wUvSZ3sKGVhEONikBVTZHkw68cM39Kayk0mETth5rAygQxh4OIUgImIMTEyrKrdsanQaolZo+Jj 3cXtHa8d4vxj3X/NP7jdsLexILltPcP/vNC25ddKPKdstTqQHZjIuNlmKXP+Gfmn/213XhY6/SK SGQA=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace unbounded sprintf() calls with the safer snprintf() in multiple
*_check_revision() functions.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/arm/mach-omap2/id.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index cf2bfb447ee2..44d7471666a8 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -192,8 +192,8 @@ void __init omap2xxx_check_revision(void)
 		j = i;
 	}
 
-	sprintf(soc_name, "OMAP%04x", omap_rev() >> 16);
-	sprintf(soc_rev, "ES%x", (omap_rev() >> 12) & 0xf);
+	snprintf(soc_name, sizeof(soc_name), "OMAP%04x", omap_rev() >> 16);
+	snprintf(soc_rev, sizeof(soc_rev), "ES%x", (omap_rev() >> 12) & 0xf);
 
 	pr_info("%s", soc_name);
 	if ((omap_rev() >> 8) & 0x0f)
@@ -519,7 +519,7 @@ void __init omap3xxx_check_revision(void)
 		pr_warn("Warning: unknown chip type: hawkeye %04x, assuming OMAP3630ES1.2\n",
 			hawkeye);
 	}
-	sprintf(soc_rev, "ES%s", cpu_rev);
+	snprintf(soc_rev, sizeof(soc_rev), "ES%s", cpu_rev);
 }
 
 void __init omap4xxx_check_revision(void)
@@ -594,9 +594,9 @@ void __init omap4xxx_check_revision(void)
 		omap_revision = OMAP4430_REV_ES2_3;
 	}
 
-	sprintf(soc_name, "OMAP%04x", omap_rev() >> 16);
-	sprintf(soc_rev, "ES%d.%d", (omap_rev() >> 12) & 0xf,
-						(omap_rev() >> 8) & 0xf);
+	snprintf(soc_name, sizeof(soc_name), "OMAP%04x", omap_rev() >> 16);
+	snprintf(soc_rev, sizeof(soc_rev), "ES%d.%d", (omap_rev() >> 12) & 0xf,
+		 (omap_rev() >> 8) & 0xf);
 	pr_info("%s %s\n", soc_name, soc_rev);
 }
 
@@ -637,8 +637,8 @@ void __init omap5xxx_check_revision(void)
 		omap_revision = OMAP5430_REV_ES2_0;
 	}
 
-	sprintf(soc_name, "OMAP%04x", omap_rev() >> 16);
-	sprintf(soc_rev, "ES%d.0", (omap_rev() >> 12) & 0xf);
+	snprintf(soc_name, sizeof(soc_name), "OMAP%04x", omap_rev() >> 16);
+	snprintf(soc_rev, sizeof(soc_rev), "ES%d.0", (omap_rev() >> 12) & 0xf);
 
 	pr_info("%s %s\n", soc_name, soc_rev);
 }
@@ -712,9 +712,9 @@ void __init dra7xxx_check_revision(void)
 		omap_revision = DRA752_REV_ES2_0;
 	}
 
-	sprintf(soc_name, "DRA%03x", omap_rev() >> 16);
-	sprintf(soc_rev, "ES%d.%d", (omap_rev() >> 12) & 0xf,
-		(omap_rev() >> 8) & 0xf);
+	snprintf(soc_name, sizeof(soc_name), "DRA%03x", omap_rev() >> 16);
+	snprintf(soc_rev, sizeof(soc_rev), "ES%d.%d", (omap_rev() >> 12) & 0xf,
+		 (omap_rev() >> 8) & 0xf);
 
 	pr_info("%s %s\n", soc_name, soc_rev);
 }
