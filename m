Received: from mx.prosyst.ru (m2.prosoftsystems.ru [46.48.77.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFBE489865;
	Fri,  2 Oct 2026 11:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.48.77.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790941022; cv=none; b=tN1vkAVlZyGpTVKB+843VnEzx8pRPsmNAiWrugM69h5VKuIqMOGxyHOQIl/ML/0jalibmweipC9ZFA1sdJML78EsVB39ElpZPCcyoF8+oX8dcSmp/KVwPd8mRIdleLoTAscxcdk52B0zC66jLAf1KBoNBje2zGGF6IlQDU7auWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790941022; c=relaxed/simple;
	bh=3UqOQkUuZFqW4EVMKhPVLtIWz+osKtafrzPkTRLGJs0=;
	h=Content-Type:From:To:CC:Subject:Date:Message-ID:MIME-Version; b=HGv+2mdqdLelqbn7A62oo52HipQjhrwb2oK3TpQbt5cpnj4VSzHhWSQ+CiuUTc9VFe7Ki3FEkv3AjBKKCrKBDLamE6Y03snscZKUlSEjQnZfj8A4cl4Ov69GLX6Ij3z0ECl/K07GEEkCAjVG/N7XH50dPrzitss/TXKB3FTRKPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru; spf=pass smtp.mailfrom=prosoftsystems.ru; dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b=gPVu2JRA; arc=none smtp.client-ip=46.48.77.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b="gPVu2JRA"
Content-Language: ru-RU
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; d=prosoftsystems.ru; s=ps;
	c=relaxed/relaxed; t=1790941013; h=from:to:date:message-id:subject;
	bh=4JuSFXpxIQnJtNY6p3yyyo8wmjBBkRtwX43dZdW8E/g=;
	b=gPVu2JRA6g58ihG9BGUrmZ2o8UpQTAJv1/e0AorMyB0tDrX3NwHub64T7YvJbuGns+44D0EmXcf
	SES6HgaN+4fRL4cFliJAnwCfOupYqy/wbaSxGuH1lj/pioUZL10S5NwxQhKRm2+20h3kdCLR7euTO
	fVcizMOEWYh3BvbAKs4yW2VHIyNe8NKTC3qw+83PcdsyWiKnY05e47+wb358fIrBT+C6NtKsQPN55
	XpD52M5Z6bKR7IBD8Q/zLb0v/6F+yvaFyLYCDV/tujIcQR0C1EeGLk3U9M31fZJRflisCY/HnpGV5
	kbtCnZ4LayzWe1MlYTL3BUIPMHladJN5uFzA==
Received: from ECHO-3.prosoft.ural.ru (172.25.100.229) by mx.prosoftsystems.ru
 (172.21.240.33) with Microsoft SMTP Server (TLS) id 15.1.396.30; Fri, 2 Oct
 2026 16:36:53 +0500
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by
 ECHO-3.prosoft.ural.ru (172.25.100.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Fri, 2 Oct 2026 16:36:49 +0500
Received: from echo-2.prosoft.ural.ru ([::1]) by echo-2.prosoft.ural.ru
 ([fe80::c1a2:90f7:8820:c669%17]) with mapi id 15.02.1748.039; Fri, 2 Oct 2026
 16:36:49 +0500
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
Subject: [PATCH v5 0/3] mfd: tps65217: Handle IRQ initialization errors
Thread-Topic: [PATCH v5 0/3] mfd: tps65217: Handle IRQ initialization errors
Thread-Index: AQHdUmJPmt9a3h8hpE+l7Lq+rbmdsw==
Date: Fri, 2 Oct 2026 11:36:49 +0000
Message-ID: <20261002113624.178588-1-r.zhambakiev@prosoftsystems.ru>
Accept-Language: ru-RU, en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

From: Radiy Zhambakiev <r.zhambakiev@prosoftsystems.ru>

The TPS65217 MFD driver does not validate the outcome of IRQ
initialisation and failed write of the interrupt mask leaves=20
the software mask out of sync with the hardware.

On top of that the irq_domain is torn down in the wrong order: the
remove callback disposes the mappings and removes the domain before
the MFD children are unbound.

This series plugs the probe error paths and moves the domain and
wake-up teardown into devres, registered right after the domain is
created.

Changes since v4:
  - No functional changes; more code-style fixes requested by
    Lee Jones.
  - Reword cover-letter as it was repeating text from the patches.

Link: https://lore.kernel.org/all/20260917103312.92624-1-r.zhambakiev@proso=
ftsystems.ru/

Radiy Zhambakiev (3):
  mfd: tps65217: Fix NULL pointer dereference on IRQ init failure
  mfd: tps65217: Check return value when masking interrupt sources
  mfd: tps65217: Use devres for IRQ domain and wake teardown

 drivers/mfd/tps65217.c | 69 +++++++++++++++++++++++++++++-------------
 1 file changed, 48 insertions(+), 21 deletions(-)

--=20
2.53.0
