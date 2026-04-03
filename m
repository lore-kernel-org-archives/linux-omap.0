Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C3A2765D7;
	Fri,  3 Apr 2026 22:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775254896; cv=none; b=XJ2XOY5EoYFYCR9chHkQVib4NcV2GOwFmmP/HB42plSRY3Rc4qtXQpR18/LOEKWc4lblGKlstEebWWCe2B94o29BiUD5CDPPf4o0FIyiPwka/ePvlIhhrytiyVZFUSmuDtUW3dalk5VVb0EdtxmufQ7/M2a1iU15xsc+/obhtlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775254896; c=relaxed/simple;
	bh=k//gqAyAfRkF/zufsWKupqXJdQ266W7kPXaMFwSAh24=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=YylLMq9bD78U1+hPWLSpfkSqzT1QV4IgrRDF1XPefO1EXzlpQb8Ngf5sUzZvwQr5/z29gIg0k+e2ttXqfxnvDwHlbG2trCFyGABmoXwqG11JjB2CXmU7+W3JH5vohzN4zN2X3PD46/wf4dOMCqTU/1Hjh+arTk262AsC+GEul7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=SSj2t+P2; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="SSj2t+P2"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 31CBFA5889;
	Sat,  4 Apr 2026 00:21:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1775254889; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=A3VvB3z9hNbXI+VOhDK9RQbvHN9ZOugMlE+lSJYi8yE=;
	b=SSj2t+P2ApNx5obb7Of6jGHTFJ0mp7W5/M+D/o4y5Nry4eJV0dVCK8oSOaavXoPN46IbcA
	uAclCU34ZFnMvQpB0MBFeRIbdF5hm2dlhFnpSsBLRkJ8Kg2hd6REo/WvIYd7jW2mBhZomS
	9QkKwmTMSSnWVvAWqXlMkE44l3WAY833doLN0Mg5ncre91BUZcID0eVB81uUZaNAMr8dHP
	YSCV8K5XWE4Y5Fkfv3TJ/o6cuya0fwPOk3zONY9zE2ig7WzknaQGKbnMvMd0o3pcTPe0S3
	J/MUIuz3yZac27e05dwAltGx6pmUHmHKw1FtKTORTBS2gg8jaI9I3ZMLWcXMvg==
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 04 Apr 2026 00:21:26 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Thomas Richard <thomas.richard@bootlin.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade
 <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, Roger Quadros
 <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org
Subject: Re: [PATCH 0/2] Add USB Ethernet controller (LAN7500) node in
 VAR-SOM-OM44 devicetree
In-Reply-To: <20260403151500.5225681d@kernel.org>
References: <20260403-b4-var-som-om44-lan7500-v1-0-0dadde850143@bootlin.com>
 <20260403131801.359be561@kernel.org>
 <2f843cc38fce1c5df9291c2e4b064241@tipi-net.de>
 <20260403151500.5225681d@kernel.org>
Message-ID: <8ccec77dbf8b8c76fe41201735f0987a@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 4.4.2026 00:15, Jakub Kicinski wrote:
> On Fri, 03 Apr 2026 22:33:26 +0200 Nicolai Buchwitz wrote:
>> On 3.4.2026 22:18, Jakub Kicinski wrote:
>> > On Fri, 03 Apr 2026 21:02:22 +0200 Thomas Richard wrote:
>> >> The goal of this series is to add the USB Ethernet controller node in
>> >> the
>> >> VAR-SOM-OM44 devicetree in order to allow the bootloader to patch the
>> >> devicetree and pass a MAC address to the smsc75xx driver. This was
>> >> also a
>> >> good opportunity to create the schema file for LAN75XX devices.
>> >
>> > But there's no driver for it yet, right?
>> > IDK what the best practices are here, just unusual to see a schema
>> > without a driver, is all.
>> 
>> The smsc75xx driver has been in the tree since 2010 (d0cad871703b) and
>> already reads local-mac-address/mac-address from devicetree via
>> platform_get_ethdev_address() in smsc75xx_init_mac_address(), so the
>> binding should be covered on the driver side.
> 
> Curious. So USB core can tie the right USB device to the DT / OF
> information automatically? I was thrown by the fact that there
> are no matches on the compatibles anywhere in the kernel.

Yes, USB core matches DT nodes by port topology (reg property), not by
compatible (usb_of_get_device_node() in drivers/usb/core/of.c if you
want to have a deeper look).

The existing microchip,lan95xx.yaml binding works the same way.
For example Raspberry Pi models before the Pi 4 use exactly this
pattern to pass the MAC address via firmware -> devicetree to the
smsc95xx driver.
