Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795087564;
	b=k7eO61iRcje5pt4+YWJKqgx31S4+loFh59/LnYHegpNjwqy+Yogf029gtxUfrC81XgbY
	 gzGEpSpmstT/D+fJrLX6S7w2Oi9I/K4le4XFj+toxYQDEh9179GCA8UjrjaiqeRSC0yx3
	 vDr3hurXwTPx0n56Zs6vjPcgxrF7a1ZLb/cw8riMrJLWiy4un7gpcbQD8Agpnkctw3fsf
	 7TLSMwSbvCMUU9KdCj3dVgLLZrHoEalj2V2XeWxwoEMQe21nUOW4Jr7Twp5Gwc4KZ6nTb
	 BZhxDz+RjLjgToCxUU8zdxxaNPf4Hh/bem9S29zvLzTVuTg4Mb6uQGd0/gJEi2/ikMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795087564;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Date:From:To:
	 Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=WfFh9jMGZpN2Zx5ZJjyviQRI8RDYFWhI65HAjYk9vXw=;
	b=LCWeOTFInicFNJRxZFFTNVEzCOEYiYy+hsMNf0zI/x/6B41nJzsfNZeowMx6Pge8qcpe
	 0RJQ3qWSzLTQgMtdDZxzhLU1SA7P6/hTjg4v/J9xSIfEVCrwAQXtvkhlrufTpkXhC9Rmf
	 xDeSoXUPVsZDPfLdukPibalZGyS8lzbIJdzJMylgmIYcf+xKHDRoyesi8KiIA5SLc8VU4
	 izIxuNw9noEHxiKIQSRX9dqk+0Y6Q6/GIgaeW3L9+sbkOMdeVAasI67qwXqpNAayCvWq2
	 DT/ftQ4yRdet0A+d93qvwlLRQcGO/4FWiiqqafQV5Sm8EWUqwjDKTmf6qg+u6xLs+Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=uP4KQJVL;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E906F606A320;
	Thu, 19 Nov 2026 11:26:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E906F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=uP4KQJVL
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 428A3C4CBEF;
	Thu, 19 Nov 2026 11:26:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 06A3E60237;
	Thu, 19 Nov 2026 11:26:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 457F811BC1166;
	Thu, 19 Nov 2026 12:25:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795087556; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=WfFh9jMGZpN2Zx5ZJjyviQRI8RDYFWhI65HAjYk9vXw=;
	b=uP4KQJVLqzcetO1Nt/Nag/D9GG5LyfYd8vOtrrXeecJXr60KF6SUtzR/p46WPm8Vs0Tnrh
	anOu9uQ0I8uR4vZKEc/sjoQme9YSqbDUQIjjDouQrGDQqKTQGPFPoPDvniW3YtOrEU7/hX
	vZACI033wbhJeTczucp/030kpVDyq7wJDdbsuvnK9Kq7/HY3K2oqd79CAMs8+MjjyFwBF9
	ab+J8VJQN3bvmbwZcU0SdbICRzxDViegRD+rZMppdYrCK0l8HcsnCOHilDszRiBaTmYGT8
	7lR8I9gfO+qWBlkaMDT1CVxX1vlzo2xr5xAooPnXGiWO00cCMypiPlWtpMP+iA==
Date: Thu, 19 Nov 2026 12:25:44 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>, Saravana
 Kannan <saravanak@kernel.org>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Kalle Niemi <kaleposti@gmail.com>, Matti
 Vaittinen <mazziesaccount@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>,
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman
 <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, Tony Lindgren
 <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Johan Hovold
 <johan@kernel.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 driver-core@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, Daniel Machon
 <daniel.machon@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v10 0/5] lan966x pci device: Add support for SFPs,
 simple-bus part
Message-ID: <20261119122544.72e793f0@bootlin.com>
In-Reply-To: <20261119110014.582363-1-herve.codina@bootlin.com>
References: <20261119110014.582363-1-herve.codina@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi all,

Please ignore the series, I've mentioned a wrong commit in Fixes tag available in
patch 5/5.

I fix that and send a new iteration soon.

Sorry about that :(

Best regards,
Hervé

On Thu, 19 Nov 2026 12:00:06 +0100
Herve Codina <herve.codina@bootlin.com> wrote:

> Hi,
> 
> Previously, I sent a big picture series adding support for SFP ports
> available on the LAN966x PCI device [0].
> 
> In this series patches touch several parts and sub-system in the kernel.
> Reviews have be done and it makes sense to split the series and send
> parts separately.
> 
> This current series is the extraction of patches related to the
> simple-bus driver. It has to be seen as a continuation of the big
> picture series but related to this specific simple-bus part.
> 
> Patch 1 fixes an already existing issue reported by Sashiko.
> Patch 2 removes the no more useful remove() function.
> 
> Patch 3 depopulates devices populated at probe() when the driver is
> unbound.
> 
> Patch 4 prepares TI OMAP bus-only devices to be populated by the
> simple-pm-bus probe().
> 
> Patch 5 makes the simple-bus driver compatible with fw_devlink
> expectation consisting in creating its child devices at probe.
> 
> [0] https://lore.kernel.org/all/20260325143555.451852-1-herve.codina@bootlin.com/
> 
> Best regards,
> Hervé
> 
> Changes:
> 
> v9 -> v10
>   v9: https://lore.kernel.org/all/20261109140916.90625-1-herve.codina@bootlin.com/
> 
>   - Patches 1..3
>     No change
> 
>   - Patch 4 (new patch in v10)
>     Prepares TI OMAP bus-only devices to be populated by the
>     simple-pm-bus probe(). This fixes an issue reported by Sashiko
>     related auxdata lookup table dropped in simple_pm_bus_probe().
> 
>   - Patch 5 (patch 4 in v9)
>     Use of_platform_default_populate() instead of of_platform_populate()
>     for bus-only devices to fix the 'unpopulated grandchildren in
>     simple_pm_bus_populate()' issue reported by Sashiko.
>     Add Fixes tag.
> 
