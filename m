Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE27331EB7;
	Wed, 23 Sep 2026 02:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790130694; cv=none; b=O4aTvZReWoBSUbbkxMBtNB+mDy69u+Bf4k1DKQJs8hlgvL+FVJIYbk2Dl/QaCAnuMLAPsa+nA7Y9+oYIQQDfAJR/3sGDhom/taYBltnGHZAzlhcR+Afv7t2gfRZ5I17civJP5ehXVKiSje7bGP1t7HR6QMco3vX1EAxGQrtHD8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790130694; c=relaxed/simple;
	bh=OhfymdJln9OE7r+FniGZ7W0monMkJyMBEPLhtJsVU/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qeloE/8dIF/riTkiQkTPHi/PS+8G/j6QjNDoahzjUCryuIH/15GxOq13v9x+lcG3hl3BG5OAId8W6PxRfH0RLx9Su835yAGzrb62suQIuhDHP8DTLjBWi6Uxndyv23ubTAV2b2eA/lg1w93xOZy7UpwgaZJOS5a33Q5mBNaDr8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QLwiQBXr; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QLwiQBXr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=vS
	VPHuHrUkL51UPG382mmuvFtW0RKjV7Xs34RRuVjd4=; b=QLwiQBXr0bluuCqXd/
	joxI1295RlePrkVqLaTPNbog2ZsogoWRYMbmNvNEzWPjj5g8zxdayYQrI2erMkHg
	lXA2i5AiKFNf7wctYCfmpZ4XxAywm2ze2W9MngrwZvCAq4HQoga4PQ5WmK2QCulg
	ssjK1LDmG1jfC0IHdzdUizmb0=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3v_XEObNqGdr1AA--.62171S2;
	Wed, 23 Sep 2026 10:30:29 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-omap@vger.kernel.org,
	quchaosheng000406@163.com
Subject: Re: [PATCH v3 1/2] dt-bindings: display: ti,tpd12s015: Convert to DT schema
Date: Wed, 23 Sep 2026 10:30:18 +0800
Message-ID: <20260923023018.352035-1-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916123210.107841-1-quchaosheng000406@163.com>
References: <20260916123210.107841-1-quchaosheng000406@163.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v_XEObNqGdr1AA--.62171S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw1xXrWruF4xtF47AF1rCrg_yoW8Gw18pa
	98tFWxCF1vqr1xC3y7Wr1jqw4rtwsxXF45GFyS9r15A3Z8G3yIkrsakw4qqrW2krZ7Zw4j
	qr1Yg3srtwn0qaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JU_73gUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC-wYHfGqzOcZSUAAA3m

Hi Tomi,

v3 of this series went out on 09-16 and has not had a comment since. I do not
want to keep reposting it, so this is just a nudge in case it fell off the pile.

  1/2 dt-bindings: display: ti,tpd12s015: Convert to DT schema
      <20260916123210.107841-1-quchaosheng000406@163.com>
  2/2 ARM: dts: ti/omap: drop unit-address from tpd12s015 endpoints
      <20260916123210.107841-2-quchaosheng000406@163.com>

Where it stands:

 - 1/2 replaces ti,tpd12s015.txt with a schema. The one thing that changed
   after v2 is the gpios range. v2 capped it at three on the assumption that
   no board passes more, but omap5-igep0050.dts passes five, its DDC SCL and
   SDA lines following the three the driver uses. v3 allows three to five and
   says so in the description, so igep0050 keeps validating.

 - 2/2 drops a unit-address that has no matching reg property from four
   endpoint nodes on am5729-beagleboneai and am57xx-idk-common. That is the
   only reason the two are in one series; 1/2 does not depend on it and it
   can go in separately if you would rather.

dt_binding_check is clean on both.

I have left aaro.koskinen@iki.fi off this message. Mail to that address
bounces: the alias forwards to musicnaut@musicnaut.iki.fi, which discards it,
so he has not seen any of the three postings. If the igep0050 part needs his
input, someone else will have to supply it.

If neither patch is wanted, say so and I will drop them.

Thanks,
Quchaosheng

