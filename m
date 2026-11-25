Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795632502;
	b=uWT2LuMJm45Pj8aGWnngw2EqCILl3fHOBrCTuX7aW6gRj8MFQsURxZcdoMNIWCIhXjGE
	 owpGu7IKCD4baXXtq1F78AehByrREHfMfqq35XErClw3Mip2T0TqCls0EqByVSWJo35I6
	 rMnbHS/H2VDrsWs6sa3oA59F5F7KYoyi7OvHv1LudgPfJnoRym6Hw9BlZ9Q7LkQjQyRgI
	 3fUcK0IouDCsIvylOY1M2L1JBePkY8oTov/G9NQU/krzoYnFaamFKFp8vkybfFD8+RSV8
	 n/w6PaNrN4q/Eo2tDmXpUXnc+aLi5s5WBDR9i7PiCLGDAi360h+NH6BuoKXYcSBUj7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795632502;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HLK3d7iXciTA3gYlWpBInCkheLbOB6EwrTlus+ykLsk=;
	b=x+8IClS/+8aimIJxEkA04hO2kL2n2TVH+JkI4xiHuckeC4cep6VdAtOoVBjm5uC0AJAZ
	 EFPR0Rl0U3EmHpYT+Ual5swpAORLvvyCQCRIuBzqWvg00WOjFsDeSBIXXIXpQvnIwpvvF
	 xabDMRK2H00jPxeKh9pICRFbKF/s968VdDvJ2lR7y93TOEhDK+fJw1niWbURKXcNZxUyk
	 6NJVKrOOUIYJrj0XNR7MSSLJXqM/x9tDC/lhIMUbIckdB5ZqbYYYXDzrUxB55VL7wBBGK
	 uTDBekofdGInmXyS9WzafAr55iSWrtr6Tkh6QCibjVJLGhT/Wqi4ro7T7gaqq7Kko7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jxwh8KOh;
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77779606A69D
	for <linux-omap@vger.kernel.org>; Wed, 25 Nov 2026 18:48:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77779606A69D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jxwh8KOh
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c50d3ac6b51so1294628566b.1
        for <linux-omap@vger.kernel.org>; Wed, 25 Nov 2026 10:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795632500; x=1796237300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HLK3d7iXciTA3gYlWpBInCkheLbOB6EwrTlus+ykLsk=;
        b=Jxwh8KOhQ3Dae/jpvU9vqBu1U4h7oCjt+9cRvOeg/9BA1/3ExI9swTZ/M0sYHqBBDj
         c2i4gWGAZ5RkbYoOU06qw3aQ7kan1huizoyKOfyhlPhyRswyCamHMI0WY7oTqtsoRsKe
         whb1zatqu7xCt7ksj4q4PPV5rutttpu5mlCJp2yyfSug3Ow5NWLyvQsshoMYAUqQK6ck
         OCby9sx0XRkeMEaZnUmqFeXuUl8e8QJ+tTASqBkSwbS4mCsoVUSJRDNEaMbh7STS2xwB
         Kebhf+L3FNSfhw4nebvnDhJmkqBLv+brIqP09suqGkbqM3oTjFyEpDzocjE13qUa1mKQ
         hJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795632500; x=1796237300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HLK3d7iXciTA3gYlWpBInCkheLbOB6EwrTlus+ykLsk=;
        b=E0z60943yP4DAAGDM2LsD2nQonKbARL9SuB3+z/H1ROeNXI6EZ8qsGw7Zxhh2UJcw2
         2pFFcuRhoZFyywn6qNpA0fRcFdYWTAlT6GZO8BUTy4l5LwkPBLrcKSmfMZzYBFCW/c3t
         Ixs4VzCMHFg3iuLLnk+t7OUcLPxZ8ArxU19kphe8ZOJHfq0xQ1mcUT9qKsNOAhOMzYUr
         7Drwib0cF21kmbliDMv3/gat46LBipMME8ySKAjlIn6A7wc/p7FfFtrRYWaLkLrcsh/+
         WnvmwHL21SS3BICPyJ/QHhIVGaMxRmLNl6LhZiOaUNN0/wqhp/pUpNqHeR9Qo0Pi2lQA
         KJtg==
X-Gm-Message-State: APuU4Z9fKES5pkQ8J2l64+g780OX8AiLiZg2flqaYSuWmdzfEy2TgUH8
	1vx+nzEOZhJqXZ3dJX8owHdmyAFJeI1FvP3YOMA6caJ/rebaIblyokQp
X-Gm-Gg: AZFdTZeyoTBwlB/LLCp8JxP0EwpNeTFvkqDTtVZaOBkt4C5ri0bFAHKXl4f+4CjthXY
	mYu+nJLsMgF4WcKcdwJBIn+L/oHKRc6ETvCKla8+XvtW6TkmarkXFYWcgnHc7b+AhXShmxlVu6n
	YLNaVJZQ/Ibh+GnvNQa/6jtZoFrDa+vx9NWNoserp9bsaSuvajUjEy+cO5uSj+98mehImmZ3k0E
	Gx6yINFLCNFtjRip8NJKHE0sVG1cbOqHU7eQGfzrZ5MkpiLjyxZzAqV7DNZzx/DdHlyPA6cNufh
	L0s/sizrdT6pyUd3NTjsaN3+m1n6g2nNGm3OyoQWYyn3GA6jgyVj/9hh6kbw8qxu3wzE8425+mM
	Uk7Y5/3P1mfgelMjSV0UgbwVSlmir5AcW8lQ4eKXRvpBL5fo2VJeQbimYVNAbMz3kBk5Uy7WVcN
	FA3a0q6ZSrVunZkba5GX2xPP/Pd3rpIsrU+x/5ivwejEFvWvzEa8HpSd+mgTEn5qOlaHEe3TvEC
	r6lhlDH4l8J/7sEeaD3PJN9zu2DemkmRExtr3RlEDm5YS/KXjJO+TcGdAuw1pcmN+dQXa/Vmri4
	WZup7H21g3DqtQo3GJd+InJaLOlaeqVKaFfV1mPQWELDzNboLSISjUxQTis=
X-Received: by 2002:a17:907:6d0b:b0:c41:1781:a2af with SMTP id a640c23a62f3a-c51317e3353mr1702989166b.9.1795632499856;
        Wed, 25 Nov 2026 10:48:19 -0800 (PST)
Received: from antoniarch (84-40-239-22.cgnat.inetia.pl. [84.40.239.22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afc73d3sm677226666b.64.2026.11.25.10.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 10:48:19 -0800 (PST)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: vigneshr@ti.com,
	andi.shyti@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	aaro.koskinen@iki.fi,
	andreas@kemnade.info,
	khilman@baylibre.com,
	rogerq@kernel.org,
	tony@atomide.com,
	jmkrzyszt@gmail.com,
	sumit.semwal@linaro.org,
	christian.koenig@amd.com,
	phasta@kernel.org
Cc: linux-omap@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v4 2/3] ARM: dts: am33xx-l4: Add missing DMAs for I2C controllers
Date: Wed, 25 Nov 2026 19:47:47 +0100
Message-ID: <20261125184750.57866-3-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125184750.57866-1-apokusinski01@gmail.com>
References: <20261125184750.57866-1-apokusinski01@gmail.com>
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

The i2c0 and i2c1 controllers on AM33xx support TX and RX DMA
requests. Add the EDMA request mappings and DMA names for
both controllers.

Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi b/arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi
index 57a45609f9f5..89fb1d1eb049 100644
--- a/arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi
@@ -239,6 +239,8 @@ i2c0: i2c@0 {
 				reg = <0x0 0x1000>;
 				interrupts = <70>;
 				status = "disabled";
+				dmas = <&edma 58 0>, <&edma 59 0>;
+				dma-names = "tx", "rx";
 			};
 		};
 
@@ -1189,6 +1191,8 @@ i2c1: i2c@0 {
 				reg = <0x0 0x1000>;
 				interrupts = <71>;
 				status = "disabled";
+				dmas = <&edma 60 0>, <&edma 61 0>;
+				dma-names = "tx", "rx";
 			};
 		};
 
-- 
2.56.1

