Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36AC318EEE;
	Wed, 30 Sep 2026 07:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790754033; cv=none; b=UeYcTAbIbsnBEKeEiuy5jy5WRCSVICDNa9/wyO8WTCWSkA+i6GHJwSDh/NR4FpOfcgPucR3X7/SoJdoS8EXaSlvXLNKgkpOFRlbtJo3aZjqQN2QHTBPdVoQFJ90eaCV9wHPuKT9sFaxd5+46UOqI4vwxXBEGx3dquAr7EaJ62L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790754033; c=relaxed/simple;
	bh=/a+o5SVv2KpXfJ74qvmES6DYcke7aJf6hODVlYKxKIA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Message-Id:Date; b=YTp4XterVNgDJ15o2gGrABVcJa/v8FOBbPoPk3r7jmkk1l0m/pyI3BI6FqCMat60G5pE9zKg9NjJOIFqazNN6aDwIQyG32U2Zu6WWIP4rtsgy6709AeSF/0L0vKvUHV66rzT3Jl4HTeZqa5pjyvZvB19A/rrZYfsoch+rMWicCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VmFlGgfp; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VmFlGgfp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Message-Id:Date; bh=PL4Ft7v/JyB4yYo
	qsmQzVyzNnO5ByprM+v3I7ZTprvE=; b=VmFlGgfp8gE8FB0JR0Z3rfh9AZPDsNK
	EkJ6eBaZx/EPOC6SDdwF0Kkw0erHDF2IDq23HES6YCcZYa1FvcnbKpFTrzWh4MIF
	rmSAVglnORX2ecAoF5+5IWSAEgXegKYKVGZzuY4agdii9Oo6siMOAweqsjR/yT7d
	+qK1ExZ0hJHY=
From: Chaosheng Qu <quchaosheng000406@163.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Rob Herring <robh@kernel.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Eduard Bostina <egbostina@gmail.com>,
 dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org,
 linux-omap@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: display: ti, tpd12s015: Convert to DT schema
In-Reply-To: <20260930052925.GA931211@killaraus.ideasonboard.com>
References: <20260916015833.112753-1-quchaosheng000406@163.com> <20260916123210.107841-1-quchaosheng000406@163.com> <179028680032.1886779.12172352669683602550.robh@kernel.org> <20260930052925.GA931211@killaraus.ideasonboard.com>
X-CM-TRANSID:_____wD33_7YvLxqrVnvBg--.1786S2
Message-Id:<6ABCBCD9.079C08.00008@m16.mail.163.com>
X-Coremail-Antispam: 1Uf129KBjvdXoWruFyfWFyktF4kGF4DAFW7XFb_yoWkZwb_u3
	WDGrZ7Jw18Crn7Ja17GrsIva13ta18urs5XF1vqFWI9ryrZFs8W34xZrn3WF1kGw4rtrs8
	G3s5JF1ku34akjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRErb1DUUUUU==
Date: Wed, 30 Sep 2026 15:40:10 +0800 (CST)
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC5BkvpGq8vNmTeQAA3v
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>

Hi Laurent,

You are right, and the two extra entries should not be in the binding.

Both drivers take exactly three GPIOs:

  drivers/gpu/drm/bridge/ti-tpd12s015.c:150,157,164
  drivers/video/fbdev/omap2/omapfb/displays/encoder-tpd12s015.c:237,246,255

They ask for indices 0, 1 and 2 -- CT_CP_HPD, LS_OE and HPD.  Nothing reads
index 3 or 4, and neither file mentions scl, sda or ddc.

The text binding I replaced said the same thing:

  - gpios: CT CP HPD, LS OE and HPD gpios

omap5-igep0050.dts passes two more, and there is no pinctrl group for them
and nothing in-tree consumes them.  v3 raised maxItems to five only so that
dtbs_check would keep passing for that board.  That was the wrong direction:
it wrote a defect of the DT source into the binding instead of holding the
binding to what the hardware and the driver use.

So it splits the way you pointed at earlier:

  - the conversion keeps gpios at three entries, which is what the driver
    requires, and
  - a separate patch drops the two extra entries from omap5-igep0050.dts.

My earlier question still stands: would you rather have that as a v4 from
me, or should I leave it to Eduard's series?

Thanks,
Chaosheng Qu

