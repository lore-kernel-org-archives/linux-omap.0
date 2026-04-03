Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100F9386558;
	Fri,  3 Apr 2026 22:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775254505; cv=none; b=OSdWMr4timhOVtFjOEMXps2HXD1z26FENWxk1gisJ0Az6KXO82wetR9gKGFPkPs6lSIgrUW+AKGSjzIDhPaHvJ+Ox695RJqSpoG/9hcBEpGbdJwW7CYNwlSLtph6Rbo8gZpwAy7+5WoZ7YzvvpEbmjA0Q7VhFFu6Qy0P2Yw+NRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775254505; c=relaxed/simple;
	bh=DV/fEv4d6JULP025y0k9iv5cbC+nqpVKoVRORHG8UJM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ny0/xowWSl6kXjjmvc4cQcMXvT7aTcQVYIaNCfHSNslSGA42XxBBsYR74c1HTSXhMNYO2Ke71yuedPpFtrZKHZxmD6l/Yi/GI3TQ9SfgXrk3JBGGAO+I/S80Lpo8YiVnNeueNy4NFbLo1ZfEINril3HXmevqPAKyTy4U9Q3Q3Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1Fz4Zdo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1Fz4Zdo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F07DCC4CEF7;
	Fri,  3 Apr 2026 22:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775254504;
	bh=DV/fEv4d6JULP025y0k9iv5cbC+nqpVKoVRORHG8UJM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K1Fz4ZdoZK04q6iFJkDDfXCHJqNY2UA1KVrUiUzxuH5B34Q5tmcjIAXrNxrrTtC+2
	 vHRBFlpggXmEgCMt0Yl/ZHxREXFtz7qpNm8CZJ6dAi4+K6b7SQ4RQp8RAAe2wLijU4
	 lTm1BQMcPokzk85DLPWLAOIBjOFPRKvT9XxnGrXQl7gcIJzVMD0m3itetbAbWXuYFQ
	 Db6AtM63En8kAU09rVQivt3xM65Ij+cXJ8FRKfLOPiUWLoRUdup55HZ7SBNeKx2nak
	 9QsWWtsE6jvHqzNTpu+iG2Fyy0TFWOD7Ox5uDdSiWryr9eFGkpglv8m1t91jDzCoYj
	 g33KjMB5ig9zQ==
Date: Fri, 3 Apr 2026 15:15:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Thomas Richard <thomas.richard@bootlin.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas
 Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, Roger
 Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org
Subject: Re: [PATCH 0/2] Add USB Ethernet controller (LAN7500) node in
 VAR-SOM-OM44 devicetree
Message-ID: <20260403151500.5225681d@kernel.org>
In-Reply-To: <2f843cc38fce1c5df9291c2e4b064241@tipi-net.de>
References: <20260403-b4-var-som-om44-lan7500-v1-0-0dadde850143@bootlin.com>
	<20260403131801.359be561@kernel.org>
	<2f843cc38fce1c5df9291c2e4b064241@tipi-net.de>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 03 Apr 2026 22:33:26 +0200 Nicolai Buchwitz wrote:
> On 3.4.2026 22:18, Jakub Kicinski wrote:
> > On Fri, 03 Apr 2026 21:02:22 +0200 Thomas Richard wrote:  
> >> The goal of this series is to add the USB Ethernet controller node in 
> >> the
> >> VAR-SOM-OM44 devicetree in order to allow the bootloader to patch the
> >> devicetree and pass a MAC address to the smsc75xx driver. This was 
> >> also a
> >> good opportunity to create the schema file for LAN75XX devices.  
> > 
> > But there's no driver for it yet, right?
> > IDK what the best practices are here, just unusual to see a schema
> > without a driver, is all.  
> 
> The smsc75xx driver has been in the tree since 2010 (d0cad871703b) and
> already reads local-mac-address/mac-address from devicetree via
> platform_get_ethdev_address() in smsc75xx_init_mac_address(), so the
> binding should be covered on the driver side.

Curious. So USB core can tie the right USB device to the DT / OF
information automatically? I was thrown by the fact that there
are no matches on the compatibles anywhere in the kernel.
