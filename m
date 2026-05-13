Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBB23EBF20;
	Wed, 13 May 2026 09:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778665423; cv=none; b=kqSS+J3bhXLtT/Nj4z6o2TdPhSD8ZC0/7Ins7oLSFcsT2TFTBzmYk3WY389Z0sultAkDeoYf1JY5Ju9gsUlHzpP3n2X3Y2P9a1M2C6vvnB6bjnV1j1D8qzzZ2jx7xhzfa1DcYQpBEqyVsVr9dG3W2YIdzyPozMkc9BKFn/mfxis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778665423; c=relaxed/simple;
	bh=viZXwdy5zdB3wBSfzB+Dud53THV6EDNQICF5hmV/Iik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SeHjNT1CgAH+ywtN4Db47XM/Q+Et4qL+2Yqqnr4MrbTNpmo8DKB9RhPDThrXnfbvhwqKzbvFg/L7f71WbqixZ1aknxx+AI5lxo4PVKkMbnjyDMeG3dFObKNbvH17i6oS7tlaHuu6+875JXSQ4CkCMzttaTydU9jia4dw+OxiqoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ORhkuwSu; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ORhkuwSu"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 9F14C4E42C8B;
	Wed, 13 May 2026 09:43:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6D1B8606CE;
	Wed, 13 May 2026 09:43:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9920F11AF8998;
	Wed, 13 May 2026 11:43:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778665414; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=K9d4EM9iJwvUfsuSVeCdeyxgSWZHO0grg4+wXYq5uJ8=;
	b=ORhkuwSuIvEXIu8TOeh++BnE3vZJMg42hvYgL3VzcQuK0qtP0wT2DhxLK0cNl0Scbm6X3s
	r1Hu9kx9yvBRfono0WqqemQgzYYMTqyz7NeZR8QCe7asrshpawRSU9d+ItL/4G8C4UvPFy
	NUVrjlkRlX4nJPzawigXteKI8tDFRudu1ejHjnrYPWd8UL3VXZ8q22ONqp4vnbKrQxy00E
	S7eWNepfPo6GxzdPMXuMIsV+S8lbN72MIJANFJzWnAF5s+1I6HifJK+YHwDMhIUwQIbi0g
	aHsmL/J00mIkPzw9GONgJ5TRnl9NIOoI25+WA4nPnjy2/AdeLMQSgD0epqzrfA==
Message-ID: <f3280b6f-7cf1-410b-9711-6dfaae2596f2@bootlin.com>
Date: Wed, 13 May 2026 11:43:26 +0200
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] ARM: dts: ti: var-som-om44: Add USB Ethernet
 controller node
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>,
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>,
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org, Nicolai Buchwitz <nb@tipi-net.de>
References: <20260506-b4-var-som-om44-lan7500-v2-0-b8af59ab877c@bootlin.com>
 <20260506-b4-var-som-om44-lan7500-v2-2-b8af59ab877c@bootlin.com>
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <20260506-b4-var-som-om44-lan7500-v2-2-b8af59ab877c@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hello Kevin,

On 5/6/26 2:13 PM, Thomas Richard wrote:
> Add USB tree description, including the Gigabit Ethernet controller
> (LAN7500). Adding the LAN7500 node will allow the bootloader to patch the
> devicetree and set the MAC address.
> 
> Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> ---
Could you merge this patch? Or maybe you have some comments to do.
Jakub already picked the binding part.

Best Regards,
Thomas
