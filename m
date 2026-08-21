Received: from mx.prosyst.ru (m2.prosoftsystems.ru [46.48.77.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA60647F2F7;
	Fri, 21 Aug 2026 12:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.48.77.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787315851; cv=none; b=dInGeJ2Y44RLj2Qgin6kSTZ7AYtuIV/j+dbVei8BV/fS2y6lUi0FIOQ4eAT6FZ1NdVY5iUHIgU6HWLWFfcwF5sXfM6vwcS5yZdRLAQdih/Y7cqMeQ2DkJfpwlamd75qUUBE2uubdDyybdMTN6spLG4/ODsi0xz1W/Jwf9WjNVBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787315851; c=relaxed/simple;
	bh=bhix0NoECY1U5FjlnhaDsTxitCZO62/NAhK8uAmFIdw=;
	h=Content-Type:From:To:CC:Subject:Date:Message-ID:MIME-Version; b=D6uD9IeFx/V8mBX3PnU5HcIeMxRGPOvss/EnupPMrvqwkGNLqNeWq8mrc89KdxWiieFDioX3n7sWqt1jjZuQBQ0GrtrRoJKGTPHcIRP55jR3P4gVtS4z2PleDm1hQiKDbrV64TpXcBCfed6scR4gZD3l6i1bEBSs7CIFvNqnIJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru; spf=pass smtp.mailfrom=prosoftsystems.ru; dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b=PTe9b0/Y; arc=none smtp.client-ip=46.48.77.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b="PTe9b0/Y"
Content-Language: ru-RU
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; d=prosoftsystems.ru; s=ps;
	c=relaxed/relaxed; t=1787315840; h=from:to:date:message-id:subject;
	bh=bu1SHAT7xs2VAk06+KdYv63N+oLn93/xM31KjZqEV/g=;
	b=PTe9b0/YsrsDTPkqxIa2VUEvOgKxzLP5PJle7DaI1k0pEuVHCBUiT5JHc4EbMASqSRkuoUWtYFK
	wnHjgECd6FgLHdFpRXVqC2j71OyUZlsveYgY+sfnzbHASRi6y/PQ+/HD+HR6W5hbpT21MNBzo0Xdf
	1PdNXhAz4LlhEI2BL0i3+Ye06sAxiKaw7atTlW07Ty5RyasLXb1BYn5HtgJeuU5o5Ty4W8SLH6WCK
	gR83SnWyRmX09v2GON1tuKu+hqsdp4k+IZa1aWybqA0JD1Vjn29Is9WTvh3rbcaJLZ8tVYRptbh//
	R/IRV5o8PxTe0VJ5CWCq3hPaePNsho+mWe+Q==
Received: from ECHO-3.prosoft.ural.ru (172.25.100.229) by mx.prosoftsystems.ru
 (172.21.240.33) with Microsoft SMTP Server (TLS) id 15.1.396.30; Fri, 21 Aug
 2026 17:37:20 +0500
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by
 ECHO-3.prosoft.ural.ru (172.25.100.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Fri, 21 Aug 2026 17:37:20 +0500
Received: from echo-2.prosoft.ural.ru ([fe80::8f12:4f85:56d8:13ed]) by
 echo-2.prosoft.ural.ru ([fe80::8f12:4f85:56d8:13ed%17]) with mapi id
 15.02.1748.039; Fri, 21 Aug 2026 17:37:20 +0500
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
Subject: [PATCH v2 0/4] mfd: tps65217: Handle IRQ initialization errors
Thread-Topic: [PATCH v2 0/4] mfd: tps65217: Handle IRQ initialization errors
Thread-Index: AQHdMWnOkQkgK2QPq0qFaGofPzFq+w==
Date: Fri, 21 Aug 2026 12:37:20 +0000
Message-ID: <20260821123712.260443-1-r.zhambakiev@prosoftsystems.ru>
Accept-Language: ru-RU, en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

This series fixes the error handling in the IRQ setup and teardown
paths of the TPS65217 MFD driver.

Patch 1 propagates the error from tps65217_irq_init() in probe, so a
failed irq_domain creation does not leave a NULL domain behind that
tps65217_remove() would later dereference.
Patch 2 propagates the error of the initial register write in
tps65217_irq_init(), so a failed mask write cannot leave the software
mask out of sync with the hardware.
Patch 3 fixes the irq_domain leak and the resulting=20
use-after-free when probe fails after the domain has been created.
Patch 4 fixes the NULL pointer dereference in the remove callback on
devices probed without an interrupt, quiesces the parent interrupt
before the domain is torn down, and balances enable_irq_wake().

Changes since v1:
- added "mfd: tps65217: Fix irq_domain leak and use-after-free on probe
  failure"
- added "mfd: tps65217: Fix NULL pointer dereference in remove callback"

Patches 3 and 4 fix the in-scope findings of the Sashiko AI review.
The remaining findings, in my opinion, are out of scope for this series and=
 may be
addressed in separate follow-up patches.

Radiy Zhambakiev (4):
  mfd: tps65217: Fix NULL pointer dereference on IRQ init failure
  mfd: tps65217: Check return value when masking interrupt sources
  mfd: tps65217: Fix irq_domain leak and use-after-free on probe failure
  mfd: tps65217: Fix NULL pointer dereference in remove callback

 drivers/mfd/tps65217.c | 68 ++++++++++++++++++++++++++++++------------
 1 file changed, 49 insertions(+), 19 deletions(-)

--=20
2.53.0
