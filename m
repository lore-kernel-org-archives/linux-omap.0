Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB943BB9E1;
	Mon, 27 Jul 2026 07:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785138124; cv=none; b=jv7JN5Eyr1DMBGJ0W8uZJGJaKDqCyRvVQarvRBkKwPBENJWbZZNXYGv0mDl4c1Bq4XDMmowA9JrUVuOCxcMtPviHOcL+cb0MYJ/wUY6jjPPl5N9TPS2sNkuRJXRRhOCIYbQgYPSJS3wzhp34NClsuiLLJNMMRHEAz4ENLvcGq8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785138124; c=relaxed/simple;
	bh=PC7KqKTOG1lIITed6bfez7FNmuX3Icze4gQUt5JUvHk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=my2zj/0ukhiJTmO+IaEOw8iCLfpznUJJs95/Fgpdmv4wbzmARbTbpk+cBd1SBjbqAVCnvwHqM6PLGqtR8zlO/VTDvneh8xM7X+ttpZ5PGzPDaadHVjiI/geIz8TkZs+KisL0XdBQPEUuqkqmhPqo9WNaXjMQDOCoUGZbP+333zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LsCxpqDG; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LsCxpqDG"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 499351A1282;
	Mon, 27 Jul 2026 07:42:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 16385601BE;
	Mon, 27 Jul 2026 07:42:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0396611C10E5D;
	Mon, 27 Jul 2026 09:41:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785138118; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=EPyJancB1LkgAX6RkDstpBf3jWrLJyO0T0EVK9Nckuo=;
	b=LsCxpqDGC1Vrv/AyOgy4tgGYj+UVaUW2AXmmZsKuV4LmpKzrp661IZ9BCsAkHSLuAhfufo
	S59+2ybBNw1lRmnKeNmvFv8Q0kNWs5ShHdFiHG2y27FN/HKK3C3pRYEVBnzPcxc4zgxbep
	SnLwiPOUXWpkYvQ36o7IKK9GNCPpJ65h+sxIKBfDIBnmz/2eXovgc64JyRyuPAnd5T9NO6
	gP2OEhuCAxet4pjRx7GupZoamb0XkOHaczy9knWUjq81ty7qUrBW/RICGKx8YWKR4oFt4F
	gb7D9TbMkfbs3I15gaLbEVmDEz1SAuMqXqTFgIxGTjAFcH07LMTVbhwxvuHVGg==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: [PATCH v2 0/2] clk: ti: mux: resolve parent clocks by DT index,
 not by name
Date: Mon, 27 Jul 2026 09:41:39 +0200
Message-Id: <20260727-mathieu-wdt-clock-theo-v2-0-c048a6394436@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALMLZ2oC/3WNQQ6CMBBFr0K6dgytKTauvIdh0ZbBTgTGtBU1h
 LtbSVy6fC/57y8iYSRM4lQtIuJMiXgqoHaV8MFOVwTqCgtVq6Y+ygOMNgfCBzy7DH5gf4MckKG
 vvXZWG1TaiDK+R+zptYUvbeFAKXN8bz+z/NpfUv9LzhIkdLbRzllplHFnx5wHmvaeR9Gu6/oBh
 mHpKL4AAAA=
X-Change-ID: 20260713-mathieu-wdt-clock-theo-f0c5ba58e258
To: Tero Kristo <kristo@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
 Tony Lindgren <tony@atomide.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785138115; l=1162;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=PC7KqKTOG1lIITed6bfez7FNmuX3Icze4gQUt5JUvHk=;
 b=2jXN5EP7AZ9gudDX2r2sAdrOJSEt3PFCi9YO2LsA24K4B/bKkg8oL38L1tr0qfEXBsFEym7Aa
 0Ph7noeadxdD2IadOfDcAhEems01+zSimzQXO32cpWPepDEMY1ZUWlY
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3

This commit aims to solve an issue I've been describing a few months ago
on AM335x SoC [1]. I believe using the parent_data field of
clk_init_data structure is now the preferred way to convey that data,
and it should be more reliable than string comparisons.

[1]: https://lore.kernel.org/all/DI4RUFQNSSNP.2QMSSQWJW9I2O@bootlin.com/

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
Changes in v2:
- Also use clk_parent_data structure in composite.c.
- Rebase on v7.2-rc5.
- Link to v1: https://lore.kernel.org/r/20260715-mathieu-wdt-clock-theo-v1-1-da65bba1828b@bootlin.com

---
Mathieu Dubois-Briand (2):
      clk: ti: mux: resolve parent clocks by DT index, not by name
      clk: ti: composite: resolve parent clocks by DT index, not by name

 drivers/clk/ti/composite.c | 26 ++++++++++++++------------
 drivers/clk/ti/mux.c       | 20 +++++++++++---------
 2 files changed, 25 insertions(+), 21 deletions(-)
---
base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
change-id: 20260713-mathieu-wdt-clock-theo-f0c5ba58e258

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>

