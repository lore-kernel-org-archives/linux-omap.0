Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA2A397E86
	for <linux-omap@vger.kernel.org>; Thu, 23 Apr 2026 17:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776964243; cv=none; b=epQubVpgXZ1qAWx3+OSaUfmpiENsUd5ywYnGX3SIIebX/M0Y04iDt1BneW1oP9eq2nZh9l1+D4iIAaH6ul+O/VBs3QyaVjr3h/u/IY35/fOy+hTd4WLUwjrCKzVzL33vPPXHFz7pl6nwphfOUXdKHdu0XZCivFBTgmiSs95p4nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776964243; c=relaxed/simple;
	bh=nFVfTyUGFt9QPrEWkty5n0OMahBfbSbjW1nFukqLbgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fu6Cqs9138ORCKZamGT4ICRPNLGh4zxMFiTpkVZWS9RfHTN6ljY7lk1cv0e8x+CLcD0t+NNiuK311AMMqXOAK7SP7a0KLkmAItJ0hZj8TeDYX2CgPdMwvllsc3UPBEhueX4rJJwM03sGdRxbJM9CQZ1mXZv3NIjlRdc1SWfNslI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Jzwwo855; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Jzwwo855"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776964236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gorBLGcbnPFGAH2/4QFeUbs8gefs1DDJEPZAI4a0IPk=;
	b=Jzwwo855EWXzIkAdC0rmcC5XJUNQQfSQ3Scfp2ZY/LrMrBGvXOkAsuZjcAN1u6r7TrFl4U
	veoTq+/k9xUFArkEbQullUQz4Hv+eqcHHj26tKvLXBhusfvECfsbH/41CJc7NjxCP3DdVc
	Zcc5/kz52Lfmj/QWIKSVfloDnOV+BE8=
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
Subject: [PATCH 2/4] ARM: OMAP2: use sysfs_emit() in type_show
Date: Thu, 23 Apr 2026 19:10:18 +0200
Message-ID: <20260423171016.275157-6-thorsten.blum@linux.dev>
In-Reply-To: <20260423171016.275157-5-thorsten.blum@linux.dev>
References: <20260423171016.275157-5-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=887; i=thorsten.blum@linux.dev; h=from:subject; bh=nFVfTyUGFt9QPrEWkty5n0OMahBfbSbjW1nFukqLbgc=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJmvgiq/s71a+cn07zfhLlkly2/fxNSDUpMkUyp//5ByO ZjF8+dxRykLgxgXg6yYIsuDWT9m+JbWVG4yidgJM4eVCWQIAxenAEzE7z0jw4Xq8gP7JH+JrbtT xfPop9FSmfDljapb720+KjVfNN08NZmR4YSU9zQlF+0Xp5O2ugncVtV/da9EUzj65I8Dgpm5wTN Z+AE=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace unbounded sprintf() with sysfs_emit() in type_show().

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/arm/mach-omap2/id.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 44d7471666a8..25ded74e4b01 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -18,6 +18,7 @@
 #include <linux/random.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/sysfs.h>
 
 #ifdef CONFIG_SOC_BUS
 #include <linux/sys_soc.h>
@@ -771,7 +772,7 @@ static const char * __init omap_get_family(void)
 static ssize_t
 type_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%s\n", omap_types[omap_type()]);
+	return sysfs_emit(buf, "%s\n", omap_types[omap_type()]);
 }
 
 static DEVICE_ATTR_RO(type);
