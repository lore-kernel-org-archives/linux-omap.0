Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2D2365A05
	for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 13:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771852348; cv=none; b=PDVJJlveBtUmpF0eTuIFDVCSdtEeL7NGX/hzs8disQXGXDfEi4CEFmfgTl3/OvwKl2bZzcycD4sNbeT8y2CFBi1xklnq1h8OrS2sBZDEzMQhNfcsB3NodkSB4VGpCkqna8Lqf9yQkgd30OSeuhXt5CB/i2HcEO3jLWVUmD4xLJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771852348; c=relaxed/simple;
	bh=UelqCIooRDzXzu6GGwJNPnHTqntDSLz5KWUuE06LKeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPQHfxAIqEkI9fDwC6wpY2vSp9OujpRF7UzwHKA1FBzoCeu0bHZJhpSy0JREP3vIJszCkbq698hwmzA9AgBBnr6Obvq8rz8JT6myFuOkHSRezD3eZ3towcaO8kcpz2q/S+HEdDglQewS4eSccAnzN10zgN8ZY0+DAqIHUyT7mNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KiUbJoDg; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KiUbJoDg"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4830b67aa6bso6148095e9.0
        for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 05:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771852345; x=1772457145; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zTyRvgzsFp6gxgHmcwTyuSKYelY9uTSe0Y6njaYUk74=;
        b=KiUbJoDgAy5LHc/Z2unOl01huhD5gypy7MemonxqkLwMvl5jhri2dAM2kzsUScb6SO
         IKJVD6jHk9CtP6lQ+2JZTULcLpZKpnQQrQIATfWmVsEiTIOqs3jnbt3fGn7KMTIJ7bTQ
         5+aajvXt7Gtj6g4ma1DpaJ7XJYrXY+NUJ6CAmQ2SM9I82zn+TQVbKjjOJ0vwARM/EiD7
         0zlzLr1fkNQNbGNTaP/3kJbje1Ei1nNFEthcixKlKiR6ia+kk5xsStM2NuB33L2vjEps
         tB6EyBDJEdpTGs0MUxQ/sMBwShV6HGmwxVMxqtxR5bYJ9cJK8DDEJbDnM1ufpG41NXyh
         MPZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771852345; x=1772457145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zTyRvgzsFp6gxgHmcwTyuSKYelY9uTSe0Y6njaYUk74=;
        b=Y20MhzArPtNEcVCfzlsiO6WTnXZE87Yww2jcw05fwGYoE7vse4qaS2HiYotnugPSJp
         rJMuRj0jizy3iD6UKmnPIy1XLYovjv3zDtqdaS1oCMyiwH6HSNV94XlINS7d3H+fUVYV
         8vMhq3hq3+OIodvqpxVY+lXDtxllOp9KBS/Q7lBreSpZPwM5wujZlS5ux6HVlg6WioEA
         ZAU7Jkh+Iqpk+0DsTeOAqdxdx7oFlv0w6qDcQpxxwHIXnilRg7qX145417CaGDYD88kc
         5i4DDdwCVU2J3cuzI8Nm4Uk9c6nDrM3iQYIWsKEodRUWxe5zooy1qBv1niMQekTdc6x7
         O/Tg==
X-Forwarded-Encrypted: i=1; AJvYcCW8Rb5eCsSY47AugjZK7WATqigecJClT3UIm1+AR5na/DAGLYKtGXH5m7HjEPTEyZu2rOMIKrcx850/@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4etUkWL0AQc31NtDlSP9yYA3U+77FxRwa6dged8iWCjUlcm1f
	9NS4J5tLxa7B8E03xbu7ZxHgFAX7qVCybGaxlSvAgqnaaJgF4L4b8gx/
X-Gm-Gg: AZuq6aLJsl4dTPKrMXT9CRUARQfQxqK54YtZPkvjAeI00UOGf5hxZrhMqFmEQvqFbgr
	FVlLJq8br6VOPc7S3P0qie6lbPmoMof0S0xVGADJsYQx3I/PcqmK3khrglV97GkM2RhnCPEyVHM
	FLT0At/7B5NzUAfH8oPwVuJ/7ajAhayxlKnOTrXxNKSAPnhDY7SNsFEtOEkjudSatRkJVIoOubF
	tkpl1QYGJZkFYe8XtHvvNfxEeJtc77wjZjzee2UDmw4fYN7fyxvzGDE59uI5UNhTlkSES5OGGJA
	oPt7Em4F/2cCvzS8M1r6pePswIwEimEt2D4dlkDCWor5SN6U+lLjSKUSP+aehSjN5Xaf0UjTFWB
	gv3l8qSjQKrZ+yH6UFCSalLXntODYOtOD9REWF69NGZCyHJBCnxsNY3EcwJujaQYcpGrHE7qnSb
	WDOS14vX5V7pa+tOk=
X-Received: by 2002:a05:600c:1d04:b0:47d:6f12:de57 with SMTP id 5b1f17b1804b1-483a95e2493mr74965915e9.4.1771852344731;
        Mon, 23 Feb 2026 05:12:24 -0800 (PST)
Received: from skbuf ([2a02:2f04:d809:4b00:a289:4e95:a726:c01d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a9b75e51sm195718605e9.5.2026.02.23.05.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 05:12:23 -0800 (PST)
Date: Mon, 23 Feb 2026 15:12:20 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Josua Mayer <josua@solid-run.com>
Cc: Andreas Kemnade <andreas@kemnade.info>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Peter Rosin <peda@axentia.se>, Aaro Koskinen <aaro.koskinen@iki.fi>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Janusz Krzysztofik <jmkrzyszt@gmail.com>,
	Vignesh R <vigneshr@ti.com>, Andi Shyti <andi.shyti@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	Jon Nettleton <jon@solid-run.com>,
	Mikhail Anikin <mikhail.anikin@solid-run.com>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v9 1/7] phy: can-transceiver: rename temporary helper
 function to avoid conflict
Message-ID: <20260223131220.evt33bzga5lafwzw@skbuf>
References: <20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com>
 <20260208-rz-sdio-mux-v9-1-9a3be13c1280@solid-run.com>
 <20260212164823.mbeycqwzsy2dfq6e@skbuf>
 <CAMuHMdVOqovkugmCnR4FOfk8VkQyN_dmyKFzbsOSN0mPKQedeQ@mail.gmail.com>
 <f9ede0d3-6a37-449c-b62b-a5c761ece097@solid-run.com>
 <20260216092914.kmvl7aep7dantcsd@skbuf>
 <20260216162406.0121dd91@kemnade.info>
 <203a36fb-6ac9-41f6-80ce-b137b9db4ad1@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <203a36fb-6ac9-41f6-80ce-b137b9db4ad1@solid-run.com>

On Mon, Feb 23, 2026 at 12:43:48PM +0000, Josua Mayer wrote:
> It would help immensely if there was a way to get the patches renaming
> driver-local conflicting helper-functions very early, before anything else.
> 
> Would this sort of patch be acceptable in linux-next now, so it can make
> it into v7.0-rc1?
> 
> If not then that mini-patchset would be the first one I shall submit after
> v7.0-rc1 is released.

v7.0-rc1 was already tagged as commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f.

Additionally, patches are not accepted directly *in* linux-next. They
are accepted in subsystem trees (linux-phy, mmc, etc) which are then
integrated all together in linux-next.

> 
> Then I can treat the actual implementation of the devm_mux_* helpers
> as a second standalone patch-set.
> 
> And finally patching all drivers with local helpers to use the new global ones
> can be patch-set number 3.
> 
> Any opinions on this?

From linux-phy perspective, I think in this particular case the following
would help:
- submit the patches at the beginning of the development cycle (i.e.
  now) while the subsystem trees didn't diverge too much
- submit the patch series *in full* (to get build testing of the later
  devm_mux_state_get_optional() introduction too, even if that is not
  for linux-phy)
- keep all patches pertaining to linux-phy (the mini-patchset) together
  and close to the beginning of the series, so they can be picked
  without other dependencies
- be clear in the cover letter if you require a stable tag for the
  linux-phy patches to be picked in other trees. You seem to be in the
  best position to be aware of all dependencies.

I don't know what is the exact status with the MULTIPLEXER SUBSYSTEM
which is marked as Odd Fixes and doesn't have appear to have a subsystem
tree. I have no recommendation there.
