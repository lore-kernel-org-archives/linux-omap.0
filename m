Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C0F39B48D;
	Sun, 18 Oct 2026 18:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792347494; cv=none; b=o1gIdYY27I4zR36KkAwmtplwKzL+htL9q/N3ux3G3e67KJw759preHXZhSM+0By+neY6GWxpLwHtmfg2wAmsLAWdG+/fgP0gitNrgaPfLhDOhBvGKVSV5Z1h72WuwDqShAiJoeWBzbr5XqPG5l6mA81NC0wqu4Wxez5V/CNTPCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792347494; c=relaxed/simple;
	bh=wfF20U5MreQNHz9FrFezfUpfgZX4o0Msnt6kSdZ4558=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SIjifBFQODXLsWDyfNhPFgjD5fm9QWYO9vklBLu7JZnhtOeV5QVoCD2FYmhw3TYVhAHjtC/pJxprAnG0539RTWwfwpKklkbu7LbEOX6gWIiyCHz+WaYsFQnPgK0s6kFfwhx8oaCZCPWPJN3ACAnmeX40h8Ej/2nEZZgzcgZN35k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=UlZ95RLD; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="UlZ95RLD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=ErZB2ZZ3XmQhb+Taa2wj1GmXp8EN7dNa3whRakTKL+M=; t=1792347493; x=1793557093; 
	b=UlZ95RLDl4Y1C6//8xHFjmjDBIL9o19mrDOySS0ySiT9q5DmJmSgzdGqivxJeTtIvy4RBr6PHZd
	MiFzn2Ae9FGzaqosryUFNkeETVdMj8FHgnWsVt6/Tywr/8zo+lY96+uQsgmXd92ZDFP5y46LYWUx6
	7l4oTMI1vaDmPtEjTLZ3MciiEwO1tWNBDZQLd9IjTamA+uu2MunYH4J3istBIP3CRRWB4VxP04IJN
	uYUOCeZ7W2vZoyf78FvO6RClFzTf8vTotLnrU6wHFej8j2KItQk2PEPqNBpl9lOEZbkzgnKH4u8NP
	42KXMsvqzPHpQnsYSzRqWpzutEAy2UZWbUxQ==;
Date: Sun, 18 Oct 2026 20:17:47 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang
 <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann
 <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Marek Vasut <marex@denx.de>, Aaro Koskinen
 <aaro.koskinen@iki.fi>, Kevin Hilman <khilman@baylibre.com>, Roger Quadros
 <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, hns@goldelico.com
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH RFC 0/9] drm: panel: Add support for Epson Moverio BT
 200 display
Message-ID: <20261018201747.0f1280f3@kemnade.info>
In-Reply-To: <20260922-b2-panel-via-bridge-v1-0-45ff36b364cf@kemnade.info>
References: <20260922-b2-panel-via-bridge-v1-0-45ff36b364cf@kemnade.info>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 08:16:57 +0200
Andreas Kemnade <andreas@kemnade.info> wrote:

> This series depends on
> https://lore.kernel.org/lkml/20260907-tc358762-fixes-v4-0-e3fc3ab5cd83@ideasonboard.com/.
> That series is still v7.2 based, but this needs -next material, to work.
> It compiles on -rc.
> 
just of of couriosity: I got no Sashiko mails here. So really nothing to
complain here?

Regards,
Andreas
