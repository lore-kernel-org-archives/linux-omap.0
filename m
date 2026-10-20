Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792510570;
	b=j6h1EofAT/kCqxf363NXLj7FykCgsXIqbcUHD92lOIGgfVfgRCv0Aiv7A7FIU9/Gk5fb
	 op0nXVnXg0qJfm8H+W3U25jeRoLjgVhm/qZ1KbLRNsUbJjsj4iTjJWbPPZNHE7rq13pcM
	 dAldeIqhraA9IOg0U9qJ2dkOtq0xEU23yUp6VcOGESBVMooOSFT37dr9Caj66Z2CPn7N8
	 FywQA1t4LxZcKTTqcko4E1s3JfgC2L7YTH4GpeTk0bmtXYNEsV+Ys7TBi8wNDkjR4CJ2X
	 DjctnVXpL2RkIiAEUDRlhPXvIk1KINTYBWRxqlcHO6eYIP7Wslqq31RiTqsAS3Lom1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792510570;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Last-TLS-Session-Version;
	bh=LFohBOrLJxnGJCYd3p6qNGOqsmehV4Rsw5Zp+Kdij5U=;
	b=splKrASZh6bSCQL1Lm8/3AUks/sxddO4otrrm2sk6NGUiVASIV5TYzxGHWax+sCE7rBb
	 r95lHxvbon9r/0N/TfCF8CH2Ql4uSMZNU2bmp+piECsw78ALI5qnqCvcTfRwXiA7fiQWT
	 1yi80LHaEF6iORwPCjxkvm/rRRzkQNBdeLrF8YZE3rQuOw1sC1u7it9PN2RctUCI5aSox
	 MMlv7wL3SyKa+tZZ2/nkbBGojV5YpqGYvZN/LG59wNObsWKFyahE1UkXCD0AUwpbXMWyn
	 /Yh9fCEQxtUGv8yV4/1QLaxg3ghJrkdlde1F14rTlMfZBzVckguA6eU0GkaUvso7tYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=VpRGFpTL;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE0E60A263F
	for <linux-omap@vger.kernel.org>; Tue, 20 Oct 2026 15:36:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BE0E60A263F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=VpRGFpTL
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D08CCC62200;
	Tue, 20 Oct 2026 15:37:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0D68B60393;
	Tue, 20 Oct 2026 15:36:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 10558103289A8;
	Tue, 20 Oct 2026 17:35:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792510560; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=LFohBOrLJxnGJCYd3p6qNGOqsmehV4Rsw5Zp+Kdij5U=;
	b=VpRGFpTLBDDiMTl6/NGSODWak25JpEcpjqfB+DUqvNA+YksPPTvVDqqw0N+dtA9sB08vcb
	vMW/GCyrPOP5GCgump/RzvYP7lSGI1qdKf430eAAza0RqQec7tFf695VDwP/z/4Ush3g3N
	VFWUOodkVNDN4b5YYkpmr1TY1Qt5w7Zpoksi2WAN1/7gPYcFVyex/MRgTBgeX6PNN1m7vZ
	DewqcpC1vXJzZmoq216k93sPY1F0Z08KPLex+bn1YlAtgEJvFdM9EOMr8+Bqjev++eTIYA
	JV7PsaDyBd2RiZiNn5cuNC0CgxVeYU44PC3ljOqQngNQqy36QokCKtQ5PhO+6Q==
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 0/3] Add support for BeagleBone Black RevD
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Robert Nelson <robertcnelson@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-omap@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jason Kridner <jkridner@beagleboard.org>, 
 Deepak Khatri <lorforlinux@beagleboard.org>, 
 Ayush Singh <ayush@beagleboard.org>
In-Reply-To: <20260901-v7-3-rc1-beaglebone-black-revd-v1-0-f521950b777a@gmail.com>
References: <20260901-v7-3-rc1-beaglebone-black-revd-v1-0-f521950b777a@gmail.com>
Date: Tue, 20 Oct 2026 17:35:52 +0200
Message-Id: <179251055253.74160.3565168560141526355.b4-review@b4>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

Hello Robert,

> The BeagleBoard.org BeagleBone Black RevD and Industrial (00D0/EID0) are
> redesigns of the BeagleBone Black Rev C3. They feature an IT66122 HDMI
> PHY to replace the EOL NXP TDA19988.
>
> Signed-off-by: Robert Nelson <robertcnelson@gmail.com>

Tested on a BBB rev.D, with HDMI output working.

Full series:
Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

