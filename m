Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793379283;
	b=wDRI+No793OSm31JPAwJ+DEapAH1MmMDvwqVgnLRqwJTGYrsmoe5oV1+uELBRntlLkbz
	 NCxKJ/BCxTLaRXH0Fv7XJisRHY9COCzOm0hM8Hxp/brxh2TInBsoyrfLi8wyN5yk8MpbR
	 h9ROTLucnD8KjDNJFp6c9nPDzdID3dvC6V1B3WhToBsGvL4NIw4QqR8hIg+rBj3dU1TLN
	 niwWFxYQTzWwPTLgPCXRtNYDdSHrUiP1WIxd8kBM2H88kHR1yY1HYoyphi+dEdj5mhnAs
	 CFO1KCLcS7ogdr4QC/3neQ9MpH0pgkHq8ExNipPJC14mZgxJMBDlYdTRXObpGRy27SQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793379283;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:
	 X-HM-Spam-Status:DKIM-Signature;
	bh=a6RTEwDPgAhdilYrf8wjCnLWqsORol90tQRE2MWrq+s=;
	b=fJHqPTMhmCdAWtKJhEb/W0xz93+HEAKTpoWll/nc9gJZDTW7p5mX/KEekv8B+7PkPZGB
	 1G84Fe93KAFbadR5P1DDphb+prTj0rIUfGPn5ttXTEagBUKjT2GJ3z8YISRQt83C0+g9/
	 84/BBml2coD76h+GhDm4gy2+6MtQbzNugS2suJWZEkAW3yMfDG0x2d6lnGlrXVUqDubYn
	 gIK9maTh9oL//yns6Xs/9Xbw04MYftOzA5gTEC18SmGtMfe9ONYF2aAOB53N+t6s4FCl2
	 J8IKHK3vG2YG600VFGyqd8W7UV6zGt9CRG2UfDB65En+Q1uHu1Ko3QQHs9nfZYDvXAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b="M/N7Y//2";
	arc=none smtp.remote-ip=45.254.49.198
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FBA606A31E;
	Fri, 30 Oct 2026 16:54:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0FBA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=M/N7Y//2
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 52f74f118;
	Sat, 31 Oct 2026 00:54:31 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Lee Jones <lee@kernel.org>
Cc: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>,
	Support Opensource <support.opensource@diasemi.com>,
	mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
	linux-actions@lists.infradead.org,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	linux-omap@vger.kernel.org,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	patches@opensource.cirrus.com
Subject: [PATCH 0/6] mfd: Fix potential cleanup ordering and lifetime bugs
Date: Sat, 31 Oct 2026 00:54:23 +0800
Message-ID: <cover.1793377422.mfd.git.liguangshuo@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
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
X-HM-Tid: 0aa18dbc01d703a1kunm46158e5a52a14
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCGR9NVhhPHkhPQ0lNGkgZTFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=M/N7Y//2w+bS3iqVYFocbiY54MBpictOm9+yTQ+dWyDEujrFIzKAGqly1DIKTffE8wCvwThHL/z+DKp0RIuquK7ZlQBbd18yu99VEveIfem2ePGrXORT1kj/vkVO7zyELW/VUlhuguHnOfQ3lNkPcGCY59pUTr3OeaZvDKEOzP8=; s=default; c=relaxed/relaxed; d=mail.sdu.edu.cn; v=1;
	bh=a6RTEwDPgAhdilYrf8wjCnLWqsORol90tQRE2MWrq+s=;
	h=date:mime-version:subject:message-id:from;

Remove child devices while their IRQ providers are still available, and
avoid deleting a managed IRQ chip twice.

The changed driver objects were build-tested. No hardware testing was
performed.

Guangshuo Li (6):
  mfd: da9055: Fix potential use-after-free during removal
  mfd: atc260x: Fix potential use-after-free on probe failure
  mfd: palmas: Fix potential IRQ action leaks on removal
  mfd: stmpe: Fix potential use-after-free during removal
  mfd: stmfx: Fix potential IRQ action leaks on removal
  mfd: wm8994: Fix potential use-after-free during removal

 drivers/mfd/atc260x-core.c | 4 +---
 drivers/mfd/da9055-core.c  | 2 +-
 drivers/mfd/palmas.c       | 3 +++
 drivers/mfd/stmfx.c        | 8 +++++---
 drivers/mfd/stmpe.c        | 4 ++--
 drivers/mfd/wm8994-core.c  | 7 +++++--
 6 files changed, 17 insertions(+), 11 deletions(-)


base-commit: d89e1d186ec9271bf78e62771779e9fc03bf0fc3
