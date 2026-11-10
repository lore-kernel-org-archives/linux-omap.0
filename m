Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.238.236.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794345400;
	b=xCQwqSBIO/EOzHuNYcsi+gcMmLyMH2u+ghIFBlWlg+/EeMguPSc8b2yLH1ejzSeuKlqa
	 DzpO5L1tcvgYJl1Tg3d28Spi39DFfa05ba7Ynvo4xHeQ9fI3U50p/stovGMOG13ruHl1O
	 bjrbKl3S250XoTq8nRugC+2N0Z0X0yxrlFb5raegJh8rkbZ4MeGch9WXsk4p4Grz4+EAD
	 QsCWM13AM0lrcWbXwraotSF+Usfa7YNlvIp5TkaH1V/Rp/9qs9Fk50J6UCiHwRKMJ2WRv
	 3V07RWzT68dPhFX2QiYFEI5GUEsAXXbJZ+AMK3hOSTVfv9paO+tewcWR/KtJg/ECtTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794345400;
	h=DMARC-Filter:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=8/IWgraaFSnxdS84ExstKXMYyxJKiP3P4ywpY9iliXQ=;
	b=e/W51vAe9xoXNEP4ogA78I/vXubr7XkheVv7f5UBArmTe7eGwqLAVj04spmn4e0lIRJr
	 h6YbgqDt+50IClD4uHgi9QP5LEVCwOhUiePRqhvU/WyLxwK76DnI92iLg7ZppJba3l1wE
	 zlifIPujI/zVxYWeUA8IYkONTfIz8Hytn9lMNc6uc3tI0avDPpqPkOdGteeA61w3GUCre
	 2PD7RrBhGnkTtiVtc81zH1kCbBqX6O6JEV6xNcV08Q/IlBEV0KmK6vkKeBeVtCNstF9LK
	 m9DpHHdy5axwskkQsaYaii8nlb48MEyFEeZ7WrGySUac99nOUpZ6MJ2CgIPvovm4QsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kemnade.info;
	spf=pass smtp.mailfrom=kemnade.info;
	dkim=pass header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=FH7avX+q;
	arc=none smtp.remote-ip=178.238.236.174
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A49606A31C;
	Tue, 10 Nov 2026 21:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42A49606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=FH7avX+q
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Subject:To:From:Reply-To:Cc:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=8/IWgraaFSnxdS84ExstKXMYyxJKiP3P4ywpY9iliXQ=; t=1794345400; x=1795555000; 
	b=FH7avX+qedYabVWgmnEyKjJvXmvimIEJJ0QsG3M+IhzP91G/A+o9QtTvkdhhJo6cLyuXDa55YiN
	OuNH7XhCkL/6ZuH1EiELppwpb9/VH/9J5bH4fjAz3+slu7lvV0jrWnHeTLud55Oo311jeyjN4kRS2
	928fCqtaN3zaty0Y3upCF863+EsnM99KCk0BTTbzfNJrUwgRY5SCgA4TugagEI6Eg63HkxIAQqc3H
	lrIYlPSWAEhshs5e5jaRi0/u+RjUWsd+CBXIKmFCmSx5xsb3hUu4s4tfPvY3mBaGijao/yrTyCUNe
	QXj8WVar9buorOv/1dVACv6spEbGLnGjsEDw==;
From: Andreas Kemnade <andreas@kemnade.info>
To: aaro.koskinen@iki.fi,
	andreas@kemnade.info,
	khilman@baylibre.com,
	rogerq@kernel.org,
	tony@atomide.com,
	linux@armlinux.org.uk,
	andi.shyti@kernel.org,
	thomas.richard@bootlin.com,
	wsa+renesas@sang-engineering.com,
	linux-arm-kernel@lists.infradead.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] ARM: OMAP2+: fix omap_device with noirq_suspend
Date: Tue, 10 Nov 2026 22:15:31 +0100
Message-ID: <20261110211531.679943-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.47.3
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

Fixes cases where device runtime gets resumed in _suspend but then
pm_runtime_force_suspend is used.  So the device is disabled, but runtime
active in _noirq_suspend leading to duplicate runtime_suspend calls. So
rather check for the device state directly to indicate if changes are
needed.
This relies on pm_runtime_force_resume being used in a balanced way.

Fixes: 7da7fd7e66ac9 ("i2c: omap: wakeup the controller during suspend() callback")
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
This really needs intensive scrutiny but might be a less invasive patch
solution better suited for stable and paves the way to get out of the
omap_device theatre without too much hurry.

 arch/arm/mach-omap2/omap_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
index 77a75b0b9ae69..52afc9089a5a0 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -393,7 +393,7 @@ static int _od_suspend_noirq(struct device *dev)
 
 	ret = pm_generic_suspend_noirq(dev);
 
-	if (!ret && !pm_runtime_status_suspended(dev)) {
+	if (!ret && (od->_state == OMAP_DEVICE_STATE_ENABLED)) {
 		if (pm_generic_runtime_suspend(dev) == 0) {
 			omap_device_idle(pdev);
 			od->flags |= OMAP_DEVICE_SUSPENDED;
-- 
2.47.3

