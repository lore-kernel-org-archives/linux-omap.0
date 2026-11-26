Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.64.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795707945;
	b=WJFUt7wXgaqpRWF9lJvWAr9lHE67S74+2Af86SOhkIg1orAfNXt+QPdaTbYNCAH/Vzts
	 mKqrJlKxNoFTnEelMP+uEk/W7k7dFMYwV8B4h1fT/2d8WmTQkRS5P9/iH+HMSBuGoh97n
	 P8pIqA94ATc9rxBzPR9hzVTY74CnhUi+IQr7HlKgD+I1GsNGP+GYL5sN+83+WbFYx+Qo5
	 Hp4PB2vrUd11J7/mWSkBmqid440QkgDc5MFMvm72skqG60k3MMplgmZwMKE/fFCYU27SU
	 2eO2OALBUfPUili03kz3pkQj24Ck+4nyfGPE0q/jY04BEk1QTkGKXMdOdoN1bhsGaBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795707945;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID;
	bh=XFBIvew0Tv+rRG9MYjkheT9FNvu3wnKl3fi7Xx846GE=;
	b=RQmkHJvYca4hgk9EXwm45PjFLbOuWq/emXli3H1hZp7mvgons+7AePsPFjPzvQWFm4rs
	 w07gvPABuHG/L//EBoHIb/grt6ZWco9fzYOovfMJlJ9josS4EPZNUHdaLJ+uy4lcenyZj
	 yB+RF2u9JuQ/PlulC852A9wywv7MwFZyUbs7IavtCaFNXjhjKNWYKFjAAPnkT7hDYNHcI
	 L02wDwl91e2Dmlitn8oOQn4lSsauEvEy41Olrour6lYvtuxeXHPVjV2oCgV/r0WKVCpj8
	 KWNBffcOIZYLCJop71MlYSvXAiqLOHYRF/BjK6zBpIT6/urrQtync9Eyf66Z6VTzWEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=hZcfPMrq;
	arc=none smtp.remote-ip=185.136.64.225
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663FF606A33D
	for <linux-omap@vger.kernel.org>; Thu, 26 Nov 2026 15:45:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 663FF606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=hZcfPMrq
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20261126154534137b12b19e0002074f
        for <linux-omap@vger.kernel.org>;
        Thu, 26 Nov 2026 16:45:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=XFBIvew0Tv+rRG9MYjkheT9FNvu3wnKl3fi7Xx846GE=;
 b=hZcfPMrqsx+JvPqEunZOHTnsEenTq2Pzs624VK/Bdh3XCTk8mwcakiuhawnIqowKtUK13V
 r+xCBiltQmpijsRH1HbMoOoUqFIzLnLz3xyhrn5Z1FLCuznmY/yuDvZBvVORrUoMQig89pfL
 v/93XbAGrjfUZBgG3T7n0cpG6wWpe9UvvYHZtVljDrCXmwgsvYnN6dHr4EibFSEHgXxMrKuU
 6SJ4Qjpn3ycKiUszIyXjcUee1mKny26n/wLCRR5oKZa0Ob3Pva3txTlUq44JSwiRtNv7nuX1
 qr/P2a+Hbai5+s4YTdXjx+s/1w0pxj9fZMHcK6FdweC210OGQAzFmzXA==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: linux-gpio@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Tony Lindgren <tony@atomide.com>,
	Haojian Zhuang <haojian.zhuang@linaro.org>,
	Linus Walleij <linusw@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>
Subject: [PATCH v2 0/4] pinctrl: single: follow-up fixes from review
Date: Thu, 26 Nov 2026 16:45:21 +0100
Message-ID: <20261126154529.1599568-1-alexander.sverdlin@siemens.com>
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
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

These are follow-ups to commit ad2093840ca3 ("pinctrl: single: don't leak
group/function tables on consumer re-probe") in pinctrl/for-next, which
this series is based on. All three issues were found in code review
(partly while reviewing Lee's recent pinctrl-single series [1]). None of
them was reproduced, so the series is compile-tested only (W=1, ARM).

Changelog:
v2:
- added patch 4/4 fixing Sashiko finding [2]
v1:
- https://lore.kernel.org/all/20261119232806.4093754-1-alexander.sverdlin@siemens.com/

[1] https://lore.kernel.org/all/20261119205013.2563811-10-lee@kernel.org/
[2] https://lore.kernel.org/all/sashiko-outbox-224208@kernel.org/

Alexander Sverdlin (4):
  pinctrl: single: Also free the pinconf table of a duplicate function
  pinctrl: single: Don't remove deduplicated groups and functions on
    error
  pinctrl: single: Reject bit-per-mux without a usable function mask
  pinctrl: single: Drop unused fshift and fmax

 drivers/pinctrl/pinctrl-single.c | 37 +++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 15 deletions(-)

-- 
2.56.1

