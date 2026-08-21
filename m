Received: from mx.prosyst.ru (m2.prosoftsystems.ru [46.48.77.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA23418A28;
	Fri, 21 Aug 2026 07:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.48.77.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787298839; cv=none; b=q0O0SYq2mr3pVWcfr8q01smPbKf3RdkC1CuX2U84IcF+cDzMjBEtpP27u37Q+xHfHRjjucxO5asGlDhOAYAyL0Wtpsi/ed7jJk6lEMG4Q1QLF/Q0DAHZIe4qh78vv8yPX10Oyyt33yyW2OZ1p5k5nibIxPKYWUqXi/kx2n82IUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787298839; c=relaxed/simple;
	bh=CFxzLwU07XLMgXKJnD+XkPo9C6LwTw3O+mYWOeWQyxQ=;
	h=Content-Type:From:To:CC:Subject:Date:Message-ID:MIME-Version; b=GBT/u7mKS+c0wXq9nHgrsesKbL3OYy+jiaFHcNd2+OkiH0KnnTL4zBoqV1P0Ajmv7nozjWS8hC6d90SwGtMCF/RtCUSHEv/7Nf/XUslSeB07IOiZB1fxS0NVqnxZF++wmxVsTE39svlgN2F4SWeMPcuxp6qj6wGP2TdJNCsMeWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru; spf=pass smtp.mailfrom=prosoftsystems.ru; dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b=nqoxMtof; arc=none smtp.client-ip=46.48.77.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b="nqoxMtof"
Content-Language: ru-RU
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; d=prosoftsystems.ru; s=ps;
	c=relaxed/relaxed; t=1787298825; h=from:to:date:message-id:subject;
	bh=ZLea99dLiHEbA4B3RZ2uoLBFpdY3G4oabgwhQA/DgtM=;
	b=nqoxMtofD3BUyYpFWnuW82+7Pc7UseJs8++yc+hmx37Qi7KZB7E0DlYDtq6s6nvihXZpUNHCtz4
	zzCesUTvdgJnbto9wgiNNZl7X7RH3d9b/nQou6ztoLb/NIWmuiFdyk4y2Ld2U9DjWMW0RwDvaigAl
	3EqWA1pR4ptgorvucyVRVM2Omqhf3o9E2GhIUW3LiX+g5vyg76D9zvUpKR66FQ2ayHB7BlcTOpQaj
	NxSR/OsDpX5CIZib0Ulck1j01XWHGmY99K2CODOZGgdygrWqRzlsMGYusbA9lImXuYcRb/pkMN6Vq
	52ean78lNdaVfagHcLfmSrxyWCkBQuoPQ5hQ==
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by mx.prosoftsystems.ru
 (172.21.240.33) with Microsoft SMTP Server (TLS) id 15.1.396.30; Fri, 21 Aug
 2026 12:53:45 +0500
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by
 echo-2.prosoft.ural.ru (172.21.245.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Fri, 21 Aug 2026 12:53:45 +0500
Received: from echo-2.prosoft.ural.ru ([fe80::8f12:4f85:56d8:13ed]) by
 echo-2.prosoft.ural.ru ([fe80::8f12:4f85:56d8:13ed%17]) with mapi id
 15.02.1748.039; Fri, 21 Aug 2026 12:53:45 +0500
From: =?koi8-r?B?9sHNwsHLycXXIPLBxMnKIPLJy8HSxMnOz9fJ3g==?=
	<r.zhambakiev@prosoftsystems.ru>
To: Aaro Koskinen <aaro.koskinen@iki.fi>
CC: =?koi8-r?B?9sHNwsHLycXXIPLBxMnKIPLJy8HSxMnOz9fJ3g==?=
	<r.zhambakiev@prosoftsystems.ru>, Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, "Tony
 Lindgren" <tony@atomide.com>, Lee Jones <lee@kernel.org>, Grygorii Strashko
	<grygorii.strashko@ti.com>, Marcin Niestroj <m.niestroj@grinn-global.com>,
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
	"mfd@lists.linux.dev" <mfd@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: [PATCH 0/2] mfd: tps65217: Handle IRQ initialization errors
Thread-Topic: [PATCH 0/2] mfd: tps65217: Handle IRQ initialization errors
Thread-Index: AQHdMUIxQPouM8tBhEGKXbQDI4cOMA==
Date: Fri, 21 Aug 2026 07:53:45 +0000
Message-ID: <20260821075331.131315-1-r.zhambakiev@prosoftsystems.ru>
Accept-Language: ru-RU, en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

The tps65217 MFD driver ignores two error conditions when setting up
its interrupt handling, which can leave the driver bound in a broken
state. This series adds the missing error checks.

Patch 1 fixes a kernel crash: if the irq domain creation fails,
probe ignores the error and a later module unload dereferences the
NULL irq domain in tps65217_remove().

Patch 2 checks the error when masking all interrupt sources, so the
driver's software mask cannot diverge from the hardware state.

Radiy Zhambakiev (2):
  mfd: tps65217: Fix NULL pointer dereference on IRQ init failure
  mfd: tps65217: Check return value when masking interrupt sources

 drivers/mfd/tps65217.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

--=20
2.53.0
