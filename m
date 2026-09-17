Received: from mx.prosyst.ru (m2.prosoftsystems.ru [46.48.77.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED072E282B;
	Thu, 17 Sep 2026 10:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.48.77.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789641249; cv=none; b=VMf9MkCzt6FkZZYhrqoUkJTZbniMnOyh75k+M3pKfuR7yEccYEBNDVnTCDIH6uHh86noZQlojsyfEjmFeJAch2gYrOwUQACMP21Z3KlgN+6g9r6AbeFWE2F2077gizVI1lDbnlPiHhJZZWm66wrDubiT7yqWveapYA9xuE9dVM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789641249; c=relaxed/simple;
	bh=AUXXhyt3bGetJItXyKCM7nHT0krOIxBk3ZBdNv9cCoc=;
	h=Content-Type:From:To:CC:Subject:Date:Message-ID:MIME-Version; b=BXQ9ekiaXglr4XrIp6oAknLEiz+caDs8BmPYaZX47+R95USPtuWYR7XUyX27MjatGUvSkFwFDVNS6ubE1QZAujjhF/diTQI5sbAmNXfDeS02a8SkyZ511OO+WML2E4vGDHGStihLPRsii6cxjLr8lx+JbcppHaYpMI7fsyxpnTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru; spf=pass smtp.mailfrom=prosoftsystems.ru; dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b=irllvP58; arc=none smtp.client-ip=46.48.77.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b="irllvP58"
Content-Language: ru-RU
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; d=prosoftsystems.ru; s=ps;
	c=relaxed/relaxed; t=1789641229; h=from:to:date:message-id:subject;
	bh=EgBQqAvkziZSC4if5GYgNa1XIGSJE0cOmghthV+RRF8=;
	b=irllvP588oCD8N4EoPLPDvqghYWDMzrH91fO0SD3qQjX2pkkFZNuHv5UPvFndSCnWvttyV8WRDC
	pdKfTISJrpmH2OIfZVhf+vThqSLa35EfepEjzkcb3Cq0hDB7kZ2m3eIJXhi7DI/3qVbYZFrnAt4tB
	+K+SXWc3ibFIWGUUHHiC1AN6itFXovUxRawDD/tZlKmILg6sAYWULsATkVBGKBKn1/1b3F3StahQ9
	cyIHZQt0qd6fwOw19tApPS92ahZX/nVuYbnqsZsJ/qsjGdINvZP7sMAoGo5FcVD2oa+7hfqF0wqcY
	Msiz/yaJBUpXoxtwnPwXV8v2aH0GI/Rpkf1A==
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by mx.prosoftsystems.ru
 (172.21.240.33) with Microsoft SMTP Server (TLS) id 15.1.396.30; Thu, 17 Sep
 2026 15:33:49 +0500
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by
 echo-2.prosoft.ural.ru (172.21.245.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Thu, 17 Sep 2026 15:33:48 +0500
Received: from echo-2.prosoft.ural.ru ([::1]) by echo-2.prosoft.ural.ru
 ([fe80::c1a2:90f7:8820:c669%17]) with mapi id 15.02.1748.039; Thu, 17 Sep
 2026 15:33:48 +0500
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
Subject: [PATCH v4 0/3] mfd: tps65217: Handle IRQ initialization errors
Thread-Topic: [PATCH v4 0/3] mfd: tps65217: Handle IRQ initialization errors
Thread-Index: AQHdRpAGpHT0ndxR306Cfla7HcDL1g==
Date: Thu, 17 Sep 2026 10:33:48 +0000
Message-ID: <20260917103312.92624-1-r.zhambakiev@prosoftsystems.ru>
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
initialisation: tps65217_probe() ignores the return value of
tps65217_irq_init(), so a failed irq_domain creation leaves the
driver bound with a NULL tps->irq_domain and the remove callback
oopses, and a failed write of the interrupt mask leaves the software
mask out of sync with the hardware.

On top of that the irq_domain is torn down in the wrong order: the
remove callback disposes the mappings and removes the domain before
the MFD children are unbound, so children that requested interrupts
(e.g. tps65217-charger) release virtual IRQs whose descriptors are
already disposed, and on probe failure the domain is leaked with its
host_data pointing to freed memory. The enable_irq_wake() in probe
is never balanced.

This series plugs the probe error paths and moves the domain and
wake-up teardown into devres, registered right after the domain is
created. Devres actions are released in reverse order of
registration, so on both removal and probe failure the MFD children
release their IRQs first, then the parent interrupt is freed and its
thread stopped, and only then is the domain removed.

Changes since v3:
  - No functional changes; applied the code-style fixes requested by
    Lee Jones.

Link: https://lore.kernel.org/all/20260904063439.69881-1-r.zhambakiev@proso=
ftsystems.ru/

Radiy Zhambakiev (3):
  mfd: tps65217: Fix NULL pointer dereference on IRQ init failure
  mfd: tps65217: Check return value when masking interrupt sources
  mfd: tps65217: Use devres for IRQ domain and wake teardown

 drivers/mfd/tps65217.c | 70 +++++++++++++++++++++++++++++-------------
 1 file changed, 49 insertions(+), 21 deletions(-)

--=20
2.53.0
