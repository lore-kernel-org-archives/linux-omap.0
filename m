Received: from mx.prosyst.ru (m2.prosoftsystems.ru [46.48.77.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D817A3CB2DB;
	Fri,  4 Sep 2026 06:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.48.77.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788504604; cv=none; b=CpG6bnx3AWcmqqhpcnAbQtInExyIPERpuMmRg5g7X66iymWW3zW4dWk1iLiGy28097an42k4PPDcUYBRtABdM3vx76oVH7ZGFa8CkSFZZRHGZIq0jL+DMaBLn0uC+O069g8Wf9qQKVlwqksGPKZCgyIlcSmASkn3he/gAEHLZiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788504604; c=relaxed/simple;
	bh=cMlkyw6dBSA3X79uqZhSEso1Pb/tjHLABQN9FiAjeDU=;
	h=Content-Type:From:To:CC:Subject:Date:Message-ID:MIME-Version; b=Ow+tu3Zkft007dOaqEyYwzwrr4/zABgc3SRAXSHC/AykmTs51qHVkdTAcItkyD6vgmYJy/k2sAS1mkKAuzavec92DhkR92OjSmVaAZuIjUSno7oWVc///uN04sOCgsLXMXM+16xLcjWlwLImgYE/lqNr+I5vr9MwuJtrZ3zlnxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru; spf=pass smtp.mailfrom=prosoftsystems.ru; dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b=TDutiDHQ; arc=none smtp.client-ip=46.48.77.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b="TDutiDHQ"
Content-Language: ru-RU
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; d=prosoftsystems.ru; s=ps;
	c=relaxed/relaxed; t=1788503686; h=from:to:date:message-id:subject;
	bh=DgNuEnnabOPimGd6vDQB0fodapWTKwvOXj0sTvPX5MQ=;
	b=TDutiDHQIYhyyqeE/+f9seR9c6rsqxoSLi3bmy+Zjs8PgwcPvZRbmhZB3r8MzFh0PBrRncDq69x
	gkBl21jRaGckmyqDphgC62pQjX2EZ4Tp3a/MMRgbfh0KafaEoSFJKzqOnc8+byXnx2eY1WLjWcZSQ
	kULXDMkEkNPdnIHQ7EY0tUewaStO4z1tKKjI8WKDgWlUDZTwuN639Qy/Mm4ckPkxb9tsOsYEfoeHP
	LFeLE1G/ZHpbmgMna2zLkfalP0KvoIgh+8Nz0wEy0EWprCf2MWsTuwONC7aJMjdpL4Lz2JDGnePBZ
	/BcrgkjQaMyxXbY/ImA1++yq1hX5wfpxOlWA==
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by mx.prosoftsystems.ru
 (172.21.240.33) with Microsoft SMTP Server (TLS) id 15.1.396.30; Fri, 4 Sep
 2026 11:34:46 +0500
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by
 echo-2.prosoft.ural.ru (172.21.245.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Fri, 4 Sep 2026 11:34:46 +0500
Received: from echo-2.prosoft.ural.ru ([fe80::8f12:4f85:56d8:13ed]) by
 echo-2.prosoft.ural.ru ([fe80::8f12:4f85:56d8:13ed%17]) with mapi id
 15.02.1748.039; Fri, 4 Sep 2026 11:34:46 +0500
From: =?koi8-r?B?9sHNwsHLycXXIPLBxMnKIPLJy8HSxMnOz9fJ3g==?=
	<r.zhambakiev@prosoftsystems.ru>
To: Aaro Koskinen <aaro.koskinen@iki.fi>
CC: =?koi8-r?B?9sHNwsHLycXXIPLBxMnKIPLJy8HSxMnOz9fJ3g==?=
	<r.zhambakiev@prosoftsystems.ru>, Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, "Tony
 Lindgren" <tony@atomide.com>, Lee Jones <lee@kernel.org>, Marcin Niestroj
	<m.niestroj@grinn-global.com>, Grygorii Strashko <grygorii.strashko@ti.com>,
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
	"mfd@lists.linux.dev" <mfd@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: [PATCH v3 0/3] mfd: tps65217: Handle IRQ initialization errors
Thread-Topic: [PATCH v3 0/3] mfd: tps65217: Handle IRQ initialization errors
Thread-Index: AQHdPDd6YR0OGak5OkeS3vOCbG941A==
Date: Fri, 4 Sep 2026 06:34:46 +0000
Message-ID: <20260904063439.69881-1-r.zhambakiev@prosoftsystems.ru>
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

Changes since v2:
 - Replace "Fix irq_domain leak and use-after-free on probe failure"
   with "Use devres for IRQ domain and wake teardown". The domain
   teardown is a devres action registered before the parent
   interrupt, so it is released after devm_request_threaded_irq()
   has freed the interrupt and stopped the threaded handler. This
   closes the window flagged in review, in which a late interrupt
   could run the handler against a removed or NULL irq_domain, and
   makes the manual disable_irq()/synchronize_irq() on the error
   path unnecessary.
 - Drop "Fix NULL pointer dereference in remove callback", now
   obsolete: the remove callback is gone.
 - Added "From" to the body of the patches to avoid checkpatch.pl
   email name mismatch error.

Radiy Zhambakiev (3):
  mfd: tps65217: Fix NULL pointer dereference on IRQ init failure
  mfd: tps65217: Check return value when masking interrupt sources
  mfd: tps65217: Use devres for IRQ domain and wake teardown

 drivers/mfd/tps65217.c | 81 +++++++++++++++++++++++++++++++-----------
 1 file changed, 60 insertions(+), 21 deletions(-)

--=20
2.55.0
