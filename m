Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F76126F0A;
	Fri,  3 Apr 2026 20:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775247483; cv=none; b=l0+Z0LqHsKa8uK8eeKOnreyKHR9akaskNEiFFAnICpKGivO0Iu3+eKkDRemQ6t++lf4hZePQd+cBDiFFjfey3IYfzXEQQT9nWi2y7Mnz4ris6TgA6GLZn1x7t/1MMV8WjA0shZc33v35YKf8TN2e8JOOzyCuLzr9qHhGprkco2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775247483; c=relaxed/simple;
	bh=np4QvMzHzjSPV1FjKEle86q8kP2+pB1r0xtzw0nDitA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kMnn+lfx0ooX9TmW1T/ayHFBmVPHl9iRTLLO/x1UGl5XMKqcGnB8uwfPcaf+daPYb7B6O5kNQdORRiR7JGa523wK6Idxdn+mMIi2aaAYH3j99tb3jRJTFSAVZYPOlCPYqM3GawwgZ98XL1UVg9P49+uoeY4IkaJxk3+u8jbxHH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qhq2y9k/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qhq2y9k/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0BFC4CEF7;
	Fri,  3 Apr 2026 20:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775247483;
	bh=np4QvMzHzjSPV1FjKEle86q8kP2+pB1r0xtzw0nDitA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qhq2y9k/GorufvWWtboi+BetnPdVNvqip7aZtyC4qITeYeORrpIO7QpS9ZuLISE/I
	 Zka/n0v209uSgbn8IhLXTw71wYYtpGrb+W3ipbsuePy7+mGsazq6Y9Dd3Nb1NA072X
	 xFZDV62N3NLvSP7vuqxw27FzvyZl6OpxemXk+jHk1+TcHEDdzEZjCw7QFP0slQYdD1
	 Wuw+Cec8KcvMRwLlchaTL12RNP+bAI2eUYxud6ytgnGj+YGdXeuBTKVRLXePOcMb8T
	 akReaFiPn6xWXVvjzmcjrvs3Z3klyNBWzCLfK+pgqFX3jiYG1BKntKSgzP20ZldAES
	 DaSYu3JnPTz/Q==
Date: Fri, 3 Apr 2026 13:18:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Aaro Koskinen
 <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, Kevin
 Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, Tony
 Lindgren <tony@atomide.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org
Subject: Re: [PATCH 0/2] Add USB Ethernet controller (LAN7500) node in
 VAR-SOM-OM44 devicetree
Message-ID: <20260403131801.359be561@kernel.org>
In-Reply-To: <20260403-b4-var-som-om44-lan7500-v1-0-0dadde850143@bootlin.com>
References: <20260403-b4-var-som-om44-lan7500-v1-0-0dadde850143@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 03 Apr 2026 21:02:22 +0200 Thomas Richard wrote:
> The goal of this series is to add the USB Ethernet controller node in the
> VAR-SOM-OM44 devicetree in order to allow the bootloader to patch the
> devicetree and pass a MAC address to the smsc75xx driver. This was also a
> good opportunity to create the schema file for LAN75XX devices.

But there's no driver for it yet, right?
IDK what the best practices are here, just unusual to see a schema
without a driver, is all.
