Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794038870;
	b=3uOaBA4wPvEgHbatzEWmOXSe2Cq0IzH3UDAQHa3IePBr9EQ9iX8SyS9E+5mTDqSnIbI3
	 NnvPhMsPYQGO+0425aYURtXiZEQc99mpZnMqSmS5wh74BArICjIBQcQJTk7Q0X7TTlP0J
	 zrU6ekXmhpOGf3vWBgNINvnKVUefKb3mbi8cSTjXu5gVQEPan8upXAWFRh1TvHMni3Yd1
	 yTGT6SwIpa3W0DObHXLzBrXsBa5ter1UkdGnMfRmLC7BHxlXqmbTKnMLhFZ22Q7vegvBZ
	 WUi14lHYDTJ5ZpvETZUa8gkIUzvxXf2YQBSMQyOKrZ3YM6qlJ26ptNWod09NXZq+Y5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794038870;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=IU7XIeW+27oTxAoZZ5Rerjf37bEsa2qLvPurBR6fe48=;
	b=KuGsfdB5Dh3ATC+eI7fsclp8Uo+UuNxwtt/EpIzcZos9nRWIAf69lk1zvJgEs9UlaEht
	 jJ8D9ISWI9oH1cP+ZtA9VEbOkgP40jfYXhrV14FpUa5Tmb3grIX32c8/6usWpbNLYmISj
	 h7o+G+3zH+gIysZjN3QlAurQ7tvH8ge4HAwhX5vAqXl3R2ea1EPgm+sxUfIaDu2h7oTKA
	 ezbUiGtPsZW4rFQ0PyphupqDfiFAQLFuQc0BDOBTfM1KlVfS4kZ+jKKDgljGAMC17alC8
	 enAAPBWFdH6jfOH+VM8Afw/LzAzoYc+YNn2+gD7uyp3hQYWtqdsEg3tbYZyWDQfmBPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E652606A32D;
	Sat,  7 Nov 2026 08:07:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E652606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jM7vD0Sq5z57HRy;
	Sat, 07 Nov 2026 16:07:36 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 6A787Zp6096399;
	Sat, 7 Nov 2026 16:07:35 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 7 Nov 2026 16:07:37 +0800 (CST)
X-Zmail-TransId: 2afc6aeedc492ba-7fe6b
X-Mailer: Zmail v1.0
Message-ID: <202611071607376342uPiYA9rHRC7ZI9Ix-8xh@zte.com.cn>
Date: Sat, 7 Nov 2026 16:07:37 +0800 (CST)
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <lee@kernel.org>, <mfd@lists.linux.dev>
Cc: <tony@atomide.com>, <linux-omap@vger.kernel.org>, <tharvey@gateworks.com>,
        <support.opensource@diasemi.com>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDAvNV0gbWZkOiBGaXggYW4gb3V0LW9mLWJvdW5kcyBJUlEgbWFwIGFuZCBlcnJvci1wYXRoIGJ1Z3M=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6A787Zp6096399
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sat, 07 Nov 2026 16:07:36 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEEDC48.000/4jM7vD0Sq5z57HRy

Five independent fixes in the MFD core address an out-of-bounds IRQ-map
lookup, an uninitialized interrupt-mask write, an IRQ leak on a failed
probe, a missing IRQ-wake teardown on removal, and two unchecked
firmware CRC reads.  Each patch touches a different driver; they are
grouped only because they go through the same MFD tree.  Every patch is
independent and can be applied and reviewed on its own, and taking a
subset is fine.

The series is ordered by severity:

  1/5 mfd: tps65219: Fix out-of-bounds access in tps65214 IRQ map
  2/5 mfd: twl6030-irq: Don't write garbage to interrupt mask on read failure
  3/5 mfd: arizona: Free info IRQs on probe failure
  4/5 mfd: da9052: Disable IRQ wake on device removal
  5/5 mfd: gateworks-gsc: Check firmware CRC reads for errors

1/5 adds the missing reserved-bit placeholder so that a power-button
interrupt no longer indexes past tps65214_sub_irq_offsets[].  2/5
returns the I2C read error instead of writing uninitialized stack data
to the PMIC interrupt mask.  3/5 frees the three informational IRQs
before arizona_irq_exit() tears down their domain.  4/5 tracks whether
enable_irq_wake() succeeded and disables it on the probe failure and
removal paths.  5/5 checks the two GSC_FW_CRC reads and fails the probe
instead of printing a stale CRC.

No dependencies; all five apply directly on next-20261030.

Shao Mingyin (5):
  mfd: tps65219: Fix out-of-bounds access in tps65214 IRQ map
  mfd: twl6030-irq: Don't write garbage to interrupt mask on read failure
  mfd: arizona: Free info IRQs on probe failure
  mfd: da9052: Disable IRQ wake on device removal
  mfd: gateworks-gsc: Check firmware CRC reads for errors

 drivers/mfd/arizona-core.c        |  3 +++
 drivers/mfd/da9052-irq.c          | 11 ++++++++++-
 drivers/mfd/gateworks-gsc.c       |  6 ++++--
 drivers/mfd/tps65219.c            |  1 +
 drivers/mfd/twl6030-irq.c         | 10 ++++++----
 include/linux/mfd/da9052/da9052.h |  2 ++
 6 files changed, 26 insertions(+), 7 deletions(-)

---
base-commit: 7649ba73f9e7e1e04d0b46213e39c79ae09dd55c
