Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CD6285058;
	Thu, 12 Feb 2026 16:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770915517; cv=none; b=rqtnY+uk7aizjvNmAroVjstwzy+4ytPmrZhrIhtc1Kp7k6487RIlGEhf5w0zfjqYbXlgJA4wKi0yyZXgH+ddMux2QMLJwqDIB9obEJmJJm4HTkcLKW1qd8i/q+MEBbfpZejJM4gyg1mYtJQEKxVVVHSb/07TBigjVgosoLhLQ0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770915517; c=relaxed/simple;
	bh=arbeKzskpaZ6m1Z7FnnQ5xEvGj02M4ftvyLatuv7G9I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WMeUpaUoGipNv7SGb4TEHHzJ04sozQOu28L7BRDL38QTHBCuk1JKH/xZs+/4V9RK2Gd30vZAQ87yYu/IMVH04I6udbJ+if+c4fDC/eGHOFlvbbLCh/IGDRtT0cwaxp0JzXg1M2BZJqzc0BQ95FjZozwB3X8BPvDB3XMrD0Fioro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gCSGMQvz; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gCSGMQvz"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 2CEA04E40CE9;
	Thu, 12 Feb 2026 16:58:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 022FF606B8;
	Thu, 12 Feb 2026 16:58:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6ADAF1036888C;
	Thu, 12 Feb 2026 17:58:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770915513; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=arbeKzskpaZ6m1Z7FnnQ5xEvGj02M4ftvyLatuv7G9I=;
	b=gCSGMQvztYNe3eC6uQzYgHoD6EATkzqZfYyeAU/f3/I9mXJ8PbJkqMKFssqdEWLygsQCMS
	dYrt25axvM/8/jIlSwmcqnULBvPi4rAISiPrVLkxj+YNEZTVWSY3gcy3odJN18qPrYzf8n
	GUEK3R/XDWveteemwNH9tm5rP1yNIdo/25iGkr3yTQ1epIZ6Aa21mha9pU11JMO2E5suI3
	o8ATdKYJ79w2ge2A/kv3XrBmj0T8KdxtMVnj65EQecDiqS3moyAdyGMWghXgRt6RQyOit5
	iOr13cSb6aZ8i2HZk9yS4D076cyXKJiePiNrSYjOCrMokOGShyEW1/xObA/TJQ==
Date: Thu, 12 Feb 2026 17:58:28 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade
 <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, Roger Quadros
 <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Russell King <linux@armlinux.org.uk>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, linux-omap@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, Luca
 Ceresoli <luca.ceresoli@bootlin.com>, Bajjuri Praneeth <praneeth@ti.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Louis
 Chauvet <louis.chauvet@bootlin.com>
Subject: Re: [PATCH 4/5] ARM: multi_v7_defconfig: Enable ITE IT66121 driver
Message-ID: <20260212175828.380fa3ff@kmaincent-XPS-13-7390>
In-Reply-To: <d786d817-e97d-4270-a3be-4778730df35e@kernel.org>
References: <20260212-feature_bbge-v1-0-29014a212f35@bootlin.com>
	<20260212-feature_bbge-v1-4-29014a212f35@bootlin.com>
	<d786d817-e97d-4270-a3be-4778730df35e@kernel.org>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On Thu, 12 Feb 2026 16:40:14 +0100
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 12/02/2026 16:26, Kory Maincent (TI) wrote:
> > Enable the ITE IT66121 HDMI bridge driver to support HDMI output on
> > the BeagleBone Green with the Seeed Studio HDMI cape. =20
>=20
> This is not one option per patch. All three patches should be squashed,
> because are logically one change.

Ok, as you prefer.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
