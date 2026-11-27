Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795753068;
	b=zwfQqrK1ZJ3Sw+QLg5WcP0SOurrG1JamsLAC4oQdQuCQ2XxoZV9bnTyo4HJ0qr4/eWxa
	 bb6GcXGpUADeSZgKt9lAS8/DliUFeX4p12ALwwlKZbIYADGKsJffrQPwLq4HCXwU1l1VM
	 kmfhNvpzuo2z3+Wva0sw3gcyimNjrLPQ/NKIdQNT3HF+32pdUvWfx//NPz16T5bKI1M7b
	 UHcIQQNvNIIZDK9irLLI0IOySefSZ/FfA7BZFVl4m3WrcTToSJn9rQwQIDJM53z/RKWGO
	 4Pw/Ijk4c8uZKUzKs/kCg1ruysGUuY7/vFZjMBEOtO3ccH0Lyh+Y+GkEgOl7RbxKfgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795753068;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=o1kw6hnU8gQ+J8Jm4JcnrMKncUQkJVbhKvexy/6C0B0=;
	b=bYuwZt/BJv+78H4OXCDwC8q4Jkfl3e4+O1RbF0MNnF5sMXiLsmf6IRemnu8CQYq88S9p
	 uEwhDGO/K3Lmhy5iL67XqvqbQH/dnTdDZ+3SCbxiNBX08h70N2KPWQA9IQXlMzVLnZdqk
	 4yW2+ZoYzrkgrJPwBEQybXeOhz8yo/yUPcerNY2qGSge4WwTUuUQa9XI9n5vZNPOBTKJs
	 4Jj1MsM2Y7/8DKT4IdgaUCwSNHjeyQBfszOwG76okWRzpO+aq3/0CmC18wSL/GF8508Zt
	 g7QI4q0M6Flrplp9kacj7il2Y+bAXwsd7KABJUY+VS5Q7hw9Vhnm8TzotrTFJ0oqXsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=Uibfcc5W;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE917606A31C;
	Fri, 27 Nov 2026 04:17:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE917606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=Uibfcc5W
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jbKrm0cH2z5B7RQ;
	Fri, 27 Nov 2026 12:17:44 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1795753064;
	bh=7dWTAERmtLKdh6e3ZWD2pXBqw1DVo/eGxb4pzPC0wfk=;
	h=Date:From:To:Cc:Subject;
	b=Uibfcc5W5TJ/MOjPrYc4hG7NlhX/VYR+u8H6Jq+qhSfvydH9XotsnKTQ4Dwh3PAKv
	 2FwIvIMNqjvaG/U7sT9XNUunZ9D+0hcldgWPgH27A+FAuSgwqLtgT0jsD2Q99nQMVE
	 SpEGYYya/X0vlEpVCOzoviz6zgZ505xMHsOSLcuel2UEdYXchNloA/ic4JRMZibwux
	 d/wKJvB3k2hG0j6iF0PDjvUsiaUDpG+OWGsPaUQJJj5pZ/NiuZGCIX7OANxoQ28f6e
	 PDDYjTaTHEBC1oAG/zpEGaQ5FCAyot0hc2RCk4p+UtBYEfi0nz5Zx/pZnG0ZDSe04c
	 z7wWPquf7WR6Q==
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 6AR4HWeE090838;
	Fri, 27 Nov 2026 12:17:33 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Fri, 27 Nov 2026 12:17:34 +0800 (CST)
X-Zmail-TransId: 2af96b09045e879-0c192
X-Mailer: Zmail v1.0
Message-ID: <20261127121734430rp7P_HaHukJyZYs7OMQjx@zte.com.cn>
Date: Fri, 27 Nov 2026 12:17:34 +0800 (CST)
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
Cc: <tony@atomide.com>, <linux-omap@vger.kernel.org>,
        <support.opensource@diasemi.com>, <patches@opensource.cirrus.com>,
        <ckeepax@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIHYyIDAvM10gbWZkOiBGaXggYW4gb3V0LW9mLWJvdW5kcyBJUlEgbWFwIGFuZCBlcnJvci1wYXRoIGJ1Z3M=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6AR4HWeE090838
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Fri, 27 Nov 2026 12:17:44 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6B090468.000/4jbKrm0cH2z5B7RQ

This is the second revision of three fixes from the [PATCH 0/5] mfd
series posted on November 7, following Lee's review on November 18.
The 2/5 twl6030 change was not commented on and is not resent; the 5/5
gateworks-gsc change has its own history and is posted separately as v4.

Shao Mingyin (3):
  mfd: tps65219: Fix the TPS65214 main IRQ bit mapping
  mfd: arizona: Free only registered diagnostic IRQs
  mfd: da9052: Balance the parent IRQ wake reference

 drivers/mfd/arizona-core.c        | 49 ++++++++++++++++++++++++++++++++-------
 drivers/mfd/da9052-irq.c          |  7 ++++--
 drivers/mfd/tps65219.c            | 14 +++++++------
 include/linux/mfd/arizona/core.h  |  1 +
 include/linux/mfd/da9052/da9052.h |  1 +
 5 files changed, 54 insertions(+), 18 deletions(-)

Changes in v2:
- 1/3: specify every table entry by its hardware bit index instead of
  adding a placeholder entry for the reserved bit (Lee).
- 2/3: free only the diagnostic IRQs whose request succeeded, so probe
  rollback cannot free a virq that has no action.  Charles is asked for
  another look, as his earlier tag covered the unconditional free.
- 3/3: request ADC_EOM before enabling wake, and keep the conditional
  disable because an unbalanced wake disable warns (Lee).

v1: https://lore.kernel.org/all/202611071607376342uPiYA9rHRC7ZI9Ix-8xh@zte.com.cn/

base-commit: e8017d29067fd1310a65c3494ce1a1b492adbac6
