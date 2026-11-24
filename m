Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795510360;
	b=30Iyp277oAFp2pk0B2NGGVDuX+YqXEzZSKbQFMpEFWz2ppAoF4O180TUSkH/1oseLZeb
	 r2WUvHF7QSRY4Iv0+AhrUI1xhh1jdHDk1oTQgTofBZVgPAdI52U50rmbq0/UYxpIY7I4H
	 w3KbE1AurK2w0qwLZeUclU7DWr5mqZE4sNEYwnB1kC0eG38wGLYrnoJNsN5cK+xLbd5/4
	 JIYTabM7kfOP2Ap7jr/k7+kCMG4fhw0TpsHq+QsPnHv4Kc0+yAuyd7cbJrBCrm80qUlSk
	 z3wLuB1Zts4NCzhGetzIXbXvAQ/IYBAVtBXLGltGst7GFa0VjbRHhVajYIAhvnbrjbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795510360;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7uDWlUAJr4F4CNK4r9GLKQshi7c+5aaomjZZmJZJIvk=;
	b=fifUvEd/IxHcTWVg6sPNrLax1bmGHC1ni2xMyLEDRcuctMD6XlMJ5qzVL/G1bS7lwSGP
	 MxQGEY6J7i1y9IhOYyoGK7xm/bgsTgLglbaxjJ/Mh1TABMj/q+T5NddMxy4MS4mcK6alE
	 /mpn0Fp+dRYvJUV9MjmPdl4HxRRIeoKseVx5S/rxubxJUGPojbFZl/2en2BCC93bqctYy
	 7LPR4agEpYloGf8VDggFzbZwumSCdi1AtseQsowxys4JvdI4htkRyvlPloCF6fI4k37kF
	 8DM2WZdDyYqG3KTiUeD5x+gejZVWfp7AWmak7oH+vbi/l2HmVCN8lKDL5h/RVPGkK7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X3DmwPyQ;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1A6606A326
	for <linux-omap@vger.kernel.org>; Tue, 24 Nov 2026 08:52:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C1A6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X3DmwPyQ
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-38644aedba1so6552213eec.0
        for <linux-omap@vger.kernel.org>; Tue, 24 Nov 2026 00:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795510359; x=1796115159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7uDWlUAJr4F4CNK4r9GLKQshi7c+5aaomjZZmJZJIvk=;
        b=X3DmwPyQf9VYf3na1eu5jUwYshDRMayIaxNQjKAMUANy8F8EWm+8IFJ33rAwMsK9bt
         I0VQYF+gLyeL4j9cu4seNwIUdV9Uz62KUfzdA0Nbq+xsuDy5nRv6UhqpG+Ar3xmo92Vs
         Cil3Cx2SRPrK7FRkTLH5PGipnklD+Oi+S6OjvH+Tz0lKLWdgGzvBe0FNkVK+oxlzM6WR
         cFR2CPLqURQgEoaV7ndLHVKQuXMpcweigODPKY6tRISWKn3RbkiCr6S6x/6cGr7yKk5W
         BO5WjNJm0Ox/Jd8DHuZiSE+Rn9IP20+fjm8tQyFMYbCh9Un66ngiV3O6YBMvZHWuLnh+
         Gckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795510359; x=1796115159;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7uDWlUAJr4F4CNK4r9GLKQshi7c+5aaomjZZmJZJIvk=;
        b=euzUO9Zsa52rUGJLoZNVCkV4qvuAd9SKOeR4A0q7oWQxcvKwINgdYDR1sjx1uaz9lm
         0CBS6PWpw7G0l3ChhTC7al5PlYbwA25ZHyti6M9ammZcmPmG3vVR0mIx5ax5E2GgjH0C
         Nxw5pg/IAp35JBMd9dCr8R2VM/1wyCyAtbwAidfZpmE7IpuXoXMGXO3Qgx3tOBO6WK5W
         FlIpYhSapSqiPxsEhHDud4ECMdg3kiFtaG+Z36RswfqypNXIS7EqvRG2pUbYOqVzpY2f
         lzGwgwYfVqZJU7wh42xv7OeJuXf5OMkKaqNvpIbrFO/o+VrWAdQaksMf8n3f/D39cIfF
         OAow==
X-Forwarded-Encrypted: i=1; AL+hErFNosXaYc3YazyF7V0v/z88mPYg5nv6+b5IYG58zyFoQlG8mxNGn8JaFw59L03AphysyHFKO+O1NbLC@vger.kernel.org
X-Gm-Message-State: APuU4Z9u8o5+lhOnSg/uK1TOPMResUdyl9UH8uW8egPUZ82t4iB9saHY
	BcFbqm2R7YBVWrPQjo5KTO2+7yW4y9Vw2np+bsGYNjmenoL51ibvZkLa
X-Gm-Gg: AZFdTZcjhV4IAdWeHq1pjgyqza46FXhdT5OryELO1GGulVpYdbxQreLA05i6besnwTQ
	lQJtxUKZ5iWYGMbsGIjrTrP03ua64CrY2jkQg0diwinkATV5qvqbQGz3FMggVuuYKPkd3sAfCbU
	UUKHxLu7UAojmV5x93IBRahOCcEBKuJpRhOR+1ouwuGfcqMzBOgf8W4AKGQvG9GH87U9yYtC80B
	/IWJsJ6stcRZ11mR9aRzdxqgFj1Qeuk/KP8Rn6xQ6YgLEVteSQLtgb3pwap6oihk+/ILrawsKDQ
	yEwoY2Q33vlhUqHcauy8x/80yv9LFDcslqGzS9/vCNSU19DusJ/2ghI2vJJEj6lvZOPKMOfVV7g
	vbRPoENXHUwYurIRCFE1EJO8iARteaRTGs9uQfSOiYVcY6sLXIYwG+D3Lvm/7xbJL1FDDnYrsYg
	cekFgCC/tQavU/vYJelMWPA2fxqgJTqHMxDHY5Z63DykEs+FPBwCna+ZVZkau/zijtUogTO1dHp
	eR9oeaIAsgAmVVIHz7IAuH8eBK0m1Ms8iWURYhqA04m2PgJqi9RJKuERE6OMDyZc+wDPisdEuL5
	CwSXDXkahaC4hz9evh0mhO2l3Dmg5yHoBMtYkUnnRsjp5rg=
X-Received: by 2002:a05:7301:d587:b0:381:d92e:ecab with SMTP id 5a478bee46e88-3856f25884emr13127421eec.11.1795510358951;
        Tue, 24 Nov 2026 00:52:38 -0800 (PST)
Received: from SGN-LDSENG.tasernet.com ([2405:4800:5cc3:11a:1ac0:4dff:fe8b:4a69])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e7fc3sm38060789eec.8.2026.11.24.00.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 00:52:38 -0800 (PST)
From: Cong Nguyen <congnt264@gmail.com>
To: Grygorii Strashko <grygorii.strashko@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Kevin Hilman <khilman@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Jiawen Liu <1298662399@qq.com>,
	linux-omap@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] gpio: omap: do not unprepare the debounce clock twice on probe failure
Date: Tue, 24 Nov 2026 15:52:31 +0700
Message-Id: <20261124085231.3696739-1-congnt264@gmail.com>
X-Mailer: git-send-email 2.25.1
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

The debounce clock is now obtained with devm_clk_get_prepared(), so
devres unprepares it when probe fails or the device is unbound. The error
path added for a failing pm_runtime_resume_and_get() still calls
clk_unprepare() on the same clock by hand.

When pm_runtime_resume_and_get() fails and a debounce clock is present,
the clock is unprepared twice. The second clk_unprepare() warns that the
clock is already unprepared.

Drop the manual clk_unprepare().

This issue was found by auditing the driver with an LLM coding assistant.

Fixes: 9df982f1f283 ("gpio: omap: handle debounce clock preparation failure")
Signed-off-by: Cong Nguyen <congnt264@gmail.com>
---
 drivers/gpio/gpio-omap.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 0da628ae77be..0af26c3f7197 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1463,8 +1463,6 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0) {
 		pm_runtime_disable(dev);
-		if (bank->dbck_flag)
-			clk_unprepare(bank->dbck);
 		return ret;
 	}
 
-- 
2.25.1

