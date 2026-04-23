Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB6F394498
	for <linux-omap@vger.kernel.org>; Thu, 23 Apr 2026 17:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776964249; cv=none; b=TU/KG3r93YBJbBuw43pvqxV7HO/xlDHU0bvLWwmvhjZRUUevm1rWrTqCCS4/ju6XTnKlHYHdoevpwtmwNIehxb2Fc9Llv9RI/mTA7n+8XPntRqdBBAc/9gC8d2pjwlCeiloqeFF0zDS0DvQk6Fq62wNJeWqZJ5WHJF5Z3HIiuks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776964249; c=relaxed/simple;
	bh=S399qPfc3fYtVnsML3wnwFnGAv4N5R2jCgRwqlNXILs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BHOnDnhkGQjtBbyl/Tt4yTBDbWcDE7w9P7e3eFeX5WDw62RNMMQzb6JthQsCcbIt6ijPSlA936gC2uVjFvYhNP9f1z1EAG5/PlP2qFF55Zg5zx+Fb+iZrFLsoMJIF43x6LWk0F1B3Z3btwbKn9xlrYBX0lO2Gz2l03OsN7CzJ54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AcR4FlIG; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AcR4FlIG"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776964239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CejOpA//3B3kzcTx9lKKsdGKFOGdh+bbMIAHkF90ZqU=;
	b=AcR4FlIG1BitGu/ksaqQjCF19k1k9vA05DlDdCWnvxq2kLzn+fTJBSIjeOVnpUSRp//gdk
	LKutjOAePt0LOXeFVmB65molXyefy59DfIa61zL3svgymZ2PE1PVzzuyp1avo9f9JbWBUK
	WQhUEef+nKO1YAs0A7Wl6o/rYv/rk7k=
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
Subject: [PATCH 3/4] ARM: OMAP2: clean up string copying and formatting in omap3_cpuinfo
Date: Thu, 23 Apr 2026 19:10:19 +0200
Message-ID: <20260423171016.275157-7-thorsten.blum@linux.dev>
In-Reply-To: <20260423171016.275157-5-thorsten.blum@linux.dev>
References: <20260423171016.275157-5-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1112; i=thorsten.blum@linux.dev; h=from:subject; bh=S399qPfc3fYtVnsML3wnwFnGAv4N5R2jCgRwqlNXILs=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJmvgipFmPW2nVmc1n5j4fk3119wtHDHGtxrCiotOBb3w oAv7WllRykLgxgXg6yYIsuDWT9m+JbWVG4yidgJM4eVCWQIAxenAEyEpYPhv8uG/pXXD3v3LZu/ qPqggq+NaGfZf2lNu4nR8dYGPvElSowMq59OE1/9cPKBtWyuU49dk7qp35318sHjvfx6l/MFucq C+QA=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace scnprintf("%s") with the faster and more direct strscpy().

Remove unnecessary and inconsistent 'n' arithmetic when 'n = 0', and
when 'n' is no longer used at the end of the function.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/arm/mach-omap2/id.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 25ded74e4b01..126ffd87f572 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -255,7 +255,7 @@ static void __init omap3_cpuinfo(void)
 	strscpy(soc_name, cpu_name);
 
 	/* Print verbose information */
-	n += scnprintf(buf, sizeof(buf) - n, "%s %s (", soc_name, soc_rev);
+	n += scnprintf(buf, sizeof(buf), "%s %s (", soc_name, soc_rev);
 
 	OMAP3_SHOW_FEATURE(l2cache);
 	OMAP3_SHOW_FEATURE(iva);
@@ -265,7 +265,7 @@ static void __init omap3_cpuinfo(void)
 	OMAP3_SHOW_FEATURE(192mhz_clk);
 	if (*(buf + n - 1) == ' ')
 		n--;
-	n += scnprintf(buf + n, sizeof(buf) - n, ")\n");
+	scnprintf(buf + n, sizeof(buf) - n, ")\n");
 	pr_info("%s", buf);
 }
 
