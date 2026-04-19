Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35646DCE1;
	Sun, 19 Apr 2026 16:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776615669; cv=pass; b=Jyf9jWY0Jfv+6QKfPlBUyS9c3PuGvJogl07kusLKczIOqUZshT995FDzcc2Vie1pA/d+vcBIqWGOj4zrnWDaQqkmWLDcUsE5HZW/yLW5IenINn0u24ukSc9kKx21by9HLNNIsnNTD/Ks11pvphBNuDAhbb/4Urt10d4te7a4lSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776615669; c=relaxed/simple;
	bh=PsTMdfSMxyt9K8TwmwdA3w8nZKgupe/mR+VUWZzwpBY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FGoHgNnBerKMhHtWlrdUWTJH0ju7b4vp8EYLy+9Q+durODX0W6iDzMCfXk+1nxoMNm7dstD3R7UPisKiE+VArzTFByGWvkTUAwAbPms0daG5aluj+M+rm8I2i2B4fG7d/abMdVVSm7hzOXIaUOcTtUyHQoD3k+RgH+8ofVxw9hA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=QPevwJ9T; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="QPevwJ9T"
Received: from darkstar.. (unknown [83.245.248.121])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: aaro.koskinen)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4fzDPl06yzz49QF3;
	Sun, 19 Apr 2026 19:20:58 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1776615661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bYiQ5hGXgm+HMbo/PatFTbrrlx/IMrt/FiciBC9aug8=;
	b=QPevwJ9TI88Gmbdk8mlqKjJLyiUyFDBaWS7ceV4To0OXm0QD3PCgxze96TB8uqwirUjg/p
	y/R2c9gaZ/5XzDkCMIgG1f412+7dsib63zv4+FhrcPR9JYkDNkz2cdS+kqo9Vm9USaW5ZN
	C1P/wm1xuGYAgfwOUNJKUcMECOPqA3hhEiG1xJs7A2o2C+LCWdGQS6wCAb7gZxyoDnAD2e
	p/KDKJgV7QUdFSr+90p3Iry2qccxiVl96Gbsj0IVWGEa8SCin/xHlB1OzTxpfFPLrLCZAs
	VXzOUHfcWFgGShmIbcGKLag9VqBOLkP7LbK3bCHjEr76gxcWUNEyQTlsKB9+1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1776615661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bYiQ5hGXgm+HMbo/PatFTbrrlx/IMrt/FiciBC9aug8=;
	b=GdWfUUL7LWwFXyZeiEVeMW7R12KXmqNjEVwCVhFqjgVUPPt6X656DABI37RMX6IWT0q037
	OcjD021W8RyTdz58QlHmvFaoWwFRaXF9Ifa9ipYS9EtuIKNj4KNkUdHjyV3QRCQqKGPh+T
	IJWpXTojq+RyFWDcMHBxACg2FYYhNxsy3DxcKOmG+PKhur79BoV/ud9Dr7+3GSkEUX4Dnm
	DVdVialdcRFpnYksR03U9Ne/Hq0H8u2HEQ2P3UnkDfA5wmMLnXFH6jfV4l++xVFkJtMEtU
	t+iig4TgXW23zGVr6iFHvTGkxj0xS2a7JWuQj8SRcdE8K5jvifTdPlefTGfpjg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1776615661;
	b=L1n+eR6dKMFPFTd+cXEc/9tGxxiCuMcCePC+5QryDePk3NSjHN/wpaB4mRsvIseZajc9b6
	Wi/iHKnLenepSYB9/DEbrtZ1cRL5n5T1FidRVLuFzHuLL1F7NBdaUjBtLm84aAQB5V6wrn
	j/OfFOjVgS49XiegXS1rj8CluwjhKbg+gcjtuZdUkBzB9dtKL9WsqGbjVoo7M1an9MYuor
	xzNwehpQ+0OO7jOmuCdgmExty4va7xDzgZn/zo1zlKciMuREspPOBqdTVnN2Bh7kXW74ER
	0Qq4BPE1thEF1E2+xY3cKmxIgHAECWZ1ESvjIg2VeJlbCEzIZrv9icKs/Nyt+Q==
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Janusz Krzysztofik <jmkrzyszt@gmail.com>,
	Tony Lindgren <tony@atomide.com>,
	Linus Walleij <linusw@kernel.org>,
	linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH v2 0/2] Input/omap1: fix touchscreen functionality on Nokia 770
Date: Sun, 19 Apr 2026 19:18:46 +0300
Message-ID: <20260419161848.825831-1-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Another attempt to make 770 touchscreen work again.

v2: Unrelated fbdev patch dropped (already merged)
    GPIO setup fixed by deleting the conflicting descriptor.

v1: https://lore.kernel.org/linux-input/20250102181953.1020878-1-aaro.koskinen@iki.fi/

Aaro Koskinen (2):
  Input: ads7846 - restore half-duplex support
  Input: ads7846 - fix up the pendown GPIO setup on Nokia 770

 arch/arm/mach-omap1/board-nokia770.c |  11 --
 drivers/input/touchscreen/ads7846.c  | 180 +++++++++++++++++++++++++--
 2 files changed, 173 insertions(+), 18 deletions(-)

-- 
2.39.2

