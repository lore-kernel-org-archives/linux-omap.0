Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4694364E98;
	Wed, 30 Sep 2026 02:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790735083; cv=none; b=Qv4UtEqgWT0qwBaVS6ajYhicjEpVHNT9EkNChp21Kj7nv4X/D6qRL82LpDmBqgSYg7sMgIuV3DeasXcJh/Otaae7O5wh/Jm105a8De82dsOp3/6jlUVW6ECzvmkOXOQyIIqiBvouSSdYetLs37QmOvpB/aLt1dMTdS4IrVZ3jX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790735083; c=relaxed/simple;
	bh=WPPBdDQDDm9R9R3SXF4S3/bBMH4L13wnTpOWwWZZqmY=;
	h=From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-Id:Date; b=twOEbC47Aj0EakLsx1mEABlf7XrHxhOvR07cQxoodU8yiepBZvINsA+WeP60DOf61vy0YOCAbfhIL7YA99ok222jM/Ns7MKdTqN6XeoQHrwWvzx1iUnY/eeRna9ZP2dn8l6wgcHNtC9LMW8VIaJi3OUGtzagH98R6V043LEGU6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jsjvCGou; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jsjvCGou"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:MIME-Version:Content-Type:
	Message-Id:Date; bh=ngyVwzlsuinhFCEe3hVM9MZeEyarwngLyBlfTxiJEC8=;
	b=jsjvCGoueL3koUTM7pGvXEPSMkEetmxKofViAd1ozOBr6uRHgZ9yU268xxoOFs
	OHoBDqnjFT6i3GQ+MZYYBMvCogp1iafwiFE8hVzRJyU1Hpg3i7DsMqM65Fc2qOKn
	FV5ve7hZjQviDpKUhNRWbWUtsRtAaoOcZ88Pi7cSvlS34=
From: Chaosheng Qu <quchaosheng000406@163.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Eduard Bostina <egbostina@gmail.com>,
 dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org,
 linux-omap@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: ti,tpd12s015: Convert to DT schema
In-Reply-To: <20260929121235.GF171869@killaraus.ideasonboard.com>
References: <20260929121235.GF171869@killaraus.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3J8zTcrxqxa_hBg--.51069S2
Message-Id:<6ABC72D3.0795AD.00008@m16.mail.163.com>
X-Coremail-Antispam: 1Uf129KBjvJXoW7KrWDWr15WF47tF1kXFWfAFb_yoW8uryrpa
	y3t3WIkrn5GF4Yy3WIvr40vaySvFs5KFW5JryFkry8u398Jr4xtrZFyF4j9a4DK3s3uw1j
	vFsI9w1ktF4YvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRsFxUUUUUU=
Date: Wed, 30 Sep 2026 10:24:20 +0800 (CST)
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC5BOaEGq8ctOW9AAA3o

Hi Laurent,

Thank you for taking the time.  Two of the three points came from the v1
posting, one of them is a real miss on my side, and there is a fourth
thing I should have found before posting at all -- I get to that below.

The message you replied to is the 09-15 posting.  v3 went out on 09-16:

  <20260916123210.107841-1-quchaosheng000406@163.com>

and it rewrote the commit message to give the rationale you are missing:
why "ti,tpd12s016" can only be a fallback of "ti,tpd12s015" (the driver
matches on "ti,tpd12s015" alone, so a board using the 016 has to list
both), and why gpios has to take three to five entries.  The v2 version
of that description had capped gpios at three, which broke dtbs_check for
omap5-igep0050.dts -- that board passes the three control/HPD lines plus
the DDC SCL and SDA lines.  Rob Herring gave v3 his Reviewed-by on 09-24.

The Assisted-by tag is a fair hit, and it applies to v3 as well: v3 does
not carry one either.  That is my oversight and I will add it.

Your third point also stands for v3.  The conversion and the gpios
semantics change are still one patch.  Splitting them is right.

Now the part I should have caught myself.  This conversion is not new
work.  Eduard Bostina posted the same conversion on 2026-07-30:

  <20260730092245.52034-1-egbostina@gmail.com>

That series makes the same two binding changes -- the "ti,tpd12s016"
fallback compatible and gpios up to five entries -- and its 2/2 renames
the same tpd12s015 endpoint nodes that mine does.  Rob reviewed it on
08-03.  It did not land: there is no ti,tpd12s015.yaml in mainline, v6.18,
v6.17 or linux-next, and the .txt is still in all of them.  I did not find
it before posting mine, and I have cc'd Eduard here.

I would rather ask than add a fourth revision to the pile.  Which would
you prefer:

  - a v4 of mine, split into a pure conversion plus a separate semantics
    patch, or
  - for me to drop mine and leave this to Eduard's series?

Either way I will not repost the current form.  If there is a reason the
Bostina series stalled that I should not repeat, I would be glad to hear
it.

Thanks,
Chaosheng Qu

