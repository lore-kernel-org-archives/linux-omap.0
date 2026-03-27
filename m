Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112523783C6;
	Fri, 27 Mar 2026 17:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774631722; cv=pass; b=a+nShuMlmfEEIF7hTEaupWEbz/alJa9Bb91tthI3KVn39gOjPRjcZO3uSrWJkqesmWVH7oeCnl7f6g99iNkw3/DRnorJhwI9z/qDWDKXPKEPG2JkuTKyw0/RpAD9OO2Id59aAONGE0hpnZwvOwUlIsZ3uspNkcUvNq0Ck4wUD/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774631722; c=relaxed/simple;
	bh=Gxe1hAkOfPpii4wPCIQL5wHzsOLfV+OZ/aPMhNHWNzA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Kip8l2uz9nYRs90H0gu2E/StKzVBfoL/fhcjeduk+EV64sOwy2FK5hzG5W2uFX2szASSIsi+v2zNV3LXD7Op6m9oze4RTbeo0OHn54erlupQT5qHTWYhl247mywykPA44iwFNJxx7vlbi6nLlMc1pV9HYymBJK3CPrcLBZnp0ZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=iuN8x1bX; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="iuN8x1bX"
Received: from darkstar.musicnaut.iki.fi (85-76-0-165-nat.elisa-mobile.fi [85.76.0.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: aaro.koskinen)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4fj6hw1m7bz49PtJ;
	Fri, 27 Mar 2026 19:15:12 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1774631714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=4058XtpebnJNJ0w+uHtlDdeXOwVoOI6qmJqEKpILNDQ=;
	b=iuN8x1bX1Q1wJC+L0CibPUxnWESiQo8/OmyERfTJhNwLWT0Y7dWmnIXuV5oQ55oiVYTimF
	MUbrL0XqkVhtXBXhImO/FO2Elltiu+vt7yngEiqQNgwSbKCSfeIE6X65AMhx/YGS7sdLFb
	3AC4Pv/VVcpkrx/T5blr9zG8BOTW25ucj9wpr+Uk/4KWqAEgoeT4xflc4ln+Fx7JIgjz1u
	HTa6j+FdAbbYF9eLSNQhMY13EqNalGPRgPlf3jSbvciCHFEinaOp4Ch6J8CybxpVIQHp6n
	Ameh8ARzo/3inpHbeqiKb0rAg0m2/Hh7IvqyKikKWaSWqhi0hvmN6+LDCznIPw==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1774631714;
	b=VxBVYRVt4+sEM886Qmcvr1G3qr4SHSzFr4AITzSPUjLe/9Vgv1DuI/L2kBkdbAaIgCVvI4
	ylIZ2XrZY/5iTc5verBSLUsvmRW04pQRkY2+uXUfoUkkA9AaL8soy9W+OfIrhtYXVK3dJO
	c6vjNu20Kdv9P6gJAKFzvh9UqLo+0zVlh3yiny5HPoEiFz0UZb1XsUPw2QcFvw42VeXGKr
	HAER14RySdHODFY0CI123P6H+euop6Sbnu/PAvy53K1179lBbmResepQ6PKIoxWQXcmz8N
	yxWcpEHDng9vNO9Y97uwkCGaQHAxf5WVKsCKEAla4FmKQHUpnc6I0POwYUOLUA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1774631714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=4058XtpebnJNJ0w+uHtlDdeXOwVoOI6qmJqEKpILNDQ=;
	b=mOZGtSakUSgKFtinYZvLYm9BqJ/Qo+UkG1UV7M+rJqW8qL+PNGiev53EWJCvTgiBBEtVfd
	2FPAzo5p0TQlWuthUoTfaohd0QmZqjd2rEd3jk0djSNXBH/OZh7mec+Dx9EJKXDpA8GGcH
	500+JOTTGRQF3NOgheVI+So97BMqwV8G7qr/ME6tBS+sTOYOhu1ydfaIanYO3r27zqBbHq
	wiiieMGer5xRVY/2MREeuBZ5qUdims9z9raqFQPjjCFlkEpOLtyqHIbEkfAg08sLW8YKu7
	6zChMbrBDfraTRo4M7LtI/Qgu0nVi9bysT0fGcGMxuPVGLmPvfKq2lfPT3owAw==
Date: Fri, 27 Mar 2026 19:15:10 +0200
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>,
	Tony Lindgren <tony@atomide.com>,
	Kevin Hilman <khilman@baylibre.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: OMAP1: Fix DEBUG_LL and earlyprintk on OMAP16XX
Message-ID: <aca7HnXZ-aCSJPW7@darkstar.musicnaut.iki.fi>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On OMAP16XX, the UART enable bit shifts are written instead of the actual
bits. This breaks the boot when DEBUG_LL and earlyprintk is enabled;
the UART gets disabled and some random bits get enabled. Fix that.

Fixes: 34c86239b184 ("ARM: OMAP1: clock: Fix early UART rate issues")
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/arm/mach-omap1/clock_data.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap1/clock_data.c b/arch/arm/mach-omap1/clock_data.c
index c58d200e4816..5203b047deac 100644
--- a/arch/arm/mach-omap1/clock_data.c
+++ b/arch/arm/mach-omap1/clock_data.c
@@ -700,8 +700,8 @@ int __init omap1_clk_init(void)
 	/* Make sure UART clocks are enabled early */
 	if (cpu_is_omap16xx())
 		omap_writel(omap_readl(MOD_CONF_CTRL_0) |
-			    CONF_MOD_UART1_CLK_MODE_R |
-			    CONF_MOD_UART3_CLK_MODE_R, MOD_CONF_CTRL_0);
+			    (1 << CONF_MOD_UART1_CLK_MODE_R) |
+			    (1 << CONF_MOD_UART3_CLK_MODE_R), MOD_CONF_CTRL_0);
 #endif
 
 	/* USB_REQ_EN will be disabled later if necessary (usb_dc_ck) */
-- 
2.39.2

