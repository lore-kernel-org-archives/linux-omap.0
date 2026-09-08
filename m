Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD8747FB0C
	for <linux-omap@vger.kernel.org>; Tue,  8 Sep 2026 21:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788902769; cv=none; b=dMJRh9vY2gmalsHrySyxTNq7VaQKGVG39XK9gzAcfKwOBTzCp7EBMZcDdVUSYEx5AORI+sWtUTTQoM+NRFBZ72xop1qGdXzg/XDRBh+JixLhs+4GviEVUkfzJiOrxAa+wZCMafMqrNFZw3ECfWZA6xoTxmjCOxInWk5JNxv6Ntc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788902769; c=relaxed/simple;
	bh=RFvjS155ZvdGD2YVXxfuKxFce81xapOIJy4GCdmvshg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HG8RisGwRx0Kd3aVl3z6ewBF4uS3oPTvhaLYKnRRuulNB60jMSMAVT6jRl0FGIZmjhkG5F6ZfEE+y8DKbAff5sFmA1UMWAxc/eWY//DD5aFyXNWe8paIoyMSKqF4pukuwGYH0E7y4fQVV07NCnV/0ZAiUyYXDOKCmEXGYoZ0dPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijlytMWV; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijlytMWV"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49b392ccaacso75683555e9.2
        for <linux-omap@vger.kernel.org>; Tue, 08 Sep 2026 14:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788902765; x=1789507565; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Fo0YbEFL8wMrCYE2f1oBd51v/3oi28C2SOi3ZLEFoU0=;
        b=ijlytMWVXcWyad1ELpjX7YSxmV3pHCJODP7yGy8ZLFk/WebAQa3FJ5q+iZWD02Yt85
         lmaGgd1Dz5L8krBWEFd+eDgMcAZhuhLd1G82TOHATR4aPGCf65mhrsTPG45Gz3eOUhmb
         SF2huAzSL65Voek1nJ96x4XosjPs4Zj50KEtoofNLRjUZr1aS1ZEYiZ63De17KxC97Ys
         ZIqx91w46PniSy7EoqFfyJ8wTnZ6xIKXrJ0/GjeDm6kikvWc8jWvoldz7Z0LL0aDmZde
         bh4xFJRG6+/Ljr2nMmJg9QLvBFP9zRRlzn1IplOadwr2WbY3G7HjlzhwLU7IEXBOZdu5
         5zmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788902765; x=1789507565;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fo0YbEFL8wMrCYE2f1oBd51v/3oi28C2SOi3ZLEFoU0=;
        b=cEH3/Nr7XTiN72QXNIzlIWXZoKoVvqfs6sYT7kw3uiOZBoQTBkuJdSv0VXquDBl+nD
         1PLdLb+CfbAV4HPKWr/XTf4mM2WdZUbPoPHtePi5231ulObonDReJj2MD4MQx8KMUKYX
         MwxVPk/CgxilgTzQXksvn8jb08Y6XCSq+wL/b/d3Je+fiTD3sCBqRXPhFPMFXvW/YrAa
         rT7lID6rDBKUvX1Ymi1uYKIGV2ryTodBB6MO9nHss+4ZL2lAyZ8m9h1KfVO0yYOI1Wx7
         bWfnjjqFG3Cka6RroluD/IzFBdLO2voWCFCH9rS0uqUnUXQzrXW0nsj6IBlg7F4KnJLe
         0rxA==
X-Forwarded-Encrypted: i=1; AKwUvBz/5Ji9sKUvL4x8sLGKhBQcF78REbgwITwXg6MuHSRVVnfkbg2Jcsqf9vEbcUme/7HbNMtTqi7uArk/@vger.kernel.org
X-Gm-Message-State: AFuF++moBYp9AkVXHUDpVkseFSzWWhVuSzCEde96XuZ4Pjh/wvoQCHMw
	lZWRuqLu+qkJ23N2DBoHjOr3ULpuBQHAeXce/jfRQwv+4Xwht5qp+XQk
X-Gm-Gg: AYBFou3NUM0pQXqAgFdtugH24ZOsS6uLKk3l9ZBGFHBTVKwKdLSTj58DZrrHEQuBv4a
	Wf6OTu+ykNHDY+jq5BikI+4xmiCrOBBZeSeLxzDUrQL+IeYDJzGay9nDrl2wy2305CMARtQGHoI
	Bcm/pvN3PpMsi53LI+khjOt6TZsZ89v+bd7TXkLpRC8FUU7F2EfKyBHzl1jbl3LPSF2qzihJb51
	1praubB68TqmPmqnWH7PaXeyjNm0j8EB1faL8sisKQjZla3BlDUmq08iEf9FIIPe8bFaQTW6V4z
	sCi2XL6t6u/7IOlUjISexCu0vLz0v5tGpkuWEKCu8qxFB5mcXOYnQu0fClNzLoD4EaJTVL0fYdI
	RLsXNVFLUuLjq1W75WyC/VBWRLNWWZUgU79nWIxCRSTAcGWj/gi92GIT5/p1jLXGc0nLHcHLMMA
	/2ECWBaDLbjSMSrwjyzlnD1EdxaJ6ZsVfh7EoD5JjgXo9TzUk2SNpOzQnb+7mc8oYE9DrFEkBF/
	8eRX8gucENuvZlhwtnajbY6qA==
X-Received: by 2002:a05:600c:3495:b0:496:c1f3:e8f8 with SMTP id 5b1f17b1804b1-49cf8244bc5mr319923725e9.7.1788902765257;
        Tue, 08 Sep 2026 14:26:05 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883953cfsm32433704f8f.13.2026.09.08.14.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 14:26:04 -0700 (PDT)
Date: Tue, 8 Sep 2026 22:26:02 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Arnd Bergmann <arnd@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, Linus Walleij
 <linusw@kernel.org>, Russell King <linux@armlinux.org.uk>, Drew Fustini
 <fustini@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Rob Herring
 <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Liviu Dudau
 <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@kernel.org>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, Frank Li <Frank.Li@nxp.com>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
 <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Vladimir
 Zapolskiy <vz@mleia.com>, Stefan Agner <stefan@agner.ch>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Aaro Koskinen <aaro.koskinen@iki.fi>,
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman
 <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, Tony Lindgren
 <tony@atomide.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu
 Beznea <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew@lunn.ch>, Sebastian
 Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement
 <gregory.clement@bootlin.com>, Robert Jarzmik <robert.jarzmik@free.fr>,
 Kristoffer Ericson <kristoffer.ericson@gmail.com>, Ethan Nelson-Moore
 <enelsonmoore@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, Shawn Guo
 <shawnguo@kernel.org>, Karl Mehltretter <kmehltretter@gmail.com>, "David
 Hildenbrand (Arm)" <david@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-stm32@st-md-mailman.stormreply.com, linux-omap@vger.kernel.org,
 Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 01/13] ARM: remove sa1100 platform
Message-ID: <20260908222602.7b2aab1f@pumpkin>
In-Reply-To: <ccd58677-5e25-1f9f-2bb4-d1770fce8ac4@fluxnic.net>
References: <20260908152808.3928630-1-arnd@kernel.org>
	<20260908152808.3928630-2-arnd@kernel.org>
	<ccd58677-5e25-1f9f-2bb4-d1770fce8ac4@fluxnic.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 8 Sep 2026 16:36:47 -0400 (EDT)
Nicolas Pitre <nico@fluxnic.net> wrote:

> On Tue, 8 Sep 2026, Arnd Bergmann wrote:
> 
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > Most sa1100 platforms were removed a few years, with the remaining
> > ones left as a starting point for a conversion to devicetree.
> > 
> > Nothing ever happened on that front, so remove the rest now,
> > including the sa1111 and locomo drivers that were once shared
> > with pxa but are already sa1100-exclusive now.  
> 
> The SA1100 was the starting point of my career. Feels strange how much 
> time has passed.
> 
> I parted with such hardware a long time ago in any case.

I failed to 'steal' a J-Slate when I left Tadpole.
(a very early 'tablet' computer with an LCD panel)
So I don't have one either.
Although that ran VxWorks and rtx-windows (after I patched bits so it worked!).

	David
