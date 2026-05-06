Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1A630595B
	for <linux-omap@vger.kernel.org>; Wed,  6 May 2026 17:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778088295; cv=none; b=pDqZ6EHRHYJrbuiMEsAmzWW26xvHCrsKRDPYUaoWsPKRYqAaWdtauJN02fzqalGeG6Qh2DtzRNTGabUvaC1zOhu+SUMbVhghr/d4D0GFOLSHxxJILIv+dmjLjs6AQE95VZ5DqghuqYzuum19qIAQzODQ7EtUENDjJ8pGKNHedK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778088295; c=relaxed/simple;
	bh=DQb4mZmtpmsl6S4rgxHyevHyGJltkbl3e83K1WBj2MA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rv5X6/O1paye/02njyhOL5Zc8yllPRlKO//yoZ8pFQvl4zcgO6pSZHbWs9Krd67BseDAPCdRLdJ8FClvSpDUFcQpycaJk7v3z1wM+v6dL9mZ/anEBgd/fp3xyyv4fA7x1WP09iWMDeDugPM3Q4FVXt8ZYsoKJx/VSc1qRNiUnp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=FEFAAO2G; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="FEFAAO2G"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b7d3ecc10dso62558165ad.2
        for <linux-omap@vger.kernel.org>; Wed, 06 May 2026 10:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778088293; x=1778693093; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3gVV/kfR/h1OysFK0qH9OZJa5FrVam8hK0PCgulO4EE=;
        b=FEFAAO2GU5gCOUvgM5Lk6i3k/mrJUnHG9B714t6yrPNYM6TncSs1FGBtJMvSNGZdu8
         NhA4q8J8F53SO8+PMuffOTqq9oYiFxQkeOyiaWSWAiyZFiqAfe1AtmfAdqMuVFhf4AGx
         5rjjZsf+a7k1808I3dNaHnrRidyiv+WJKmjDE5ThisOaiCqELHrJpTqH94glSPbV/Kz6
         y7bNESfqWRpH5a5/VupCdd6O0KkSVpVPlxTWH9qudpjbGsrFzIzK68HTT0iTX3f/+YMq
         whYr15ZWSQf5TKpVQPX34V29bD60lX1b+lmypUhvkTtasWfIObbnk415/xffzYt6tRmY
         OE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778088293; x=1778693093;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3gVV/kfR/h1OysFK0qH9OZJa5FrVam8hK0PCgulO4EE=;
        b=RYlc0MRjHpoOPrX57uHwVY3Y+k5XH8ZGl/Kp5/jdKk/ILBFLS4PjHFR/Xg2nGFjOmT
         tWE2GbVyqIYr5xrVFVc+eNoBNtDowi8Ua5A7BvCHZXEvLaIxhCcsD/HSan7Q9lb9EblB
         VgEMWuSWKsCzqIduO2+VEZ6wjigSrBKJnbqVR4gsNZsIOuF41alY+hjIuiY3FRSKR7Ei
         VlUfeoaoAB4q+k9ohQ/V+S7HOCzc+qVqSJQTBGp9WeBwqDroFT+g04tMvN72u0Fqm2De
         9cuqSAOS3rsMD0N4P8vNwqUcR7XkBZFGSv+tJ2yC5nMpCek0kqMfP8nkGxyrIGo8pMYq
         SFVA==
X-Forwarded-Encrypted: i=1; AFNElJ9I0b5H64kXj1CpJ6Z8ZoYZu88OH56RRw5tb4Mvf8hP6juuynvvCFs23V82v5BgI5KoZGMdJwdnk6k4@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7ydxQFJbFC50WvQlXI0fpQO+hZ6HJUasSfieVKrWVzB0XlnMy
	FyPK/uorgl1q+Aov4dPN4fvyOWHeT97mDHTO+rsCqiIuhG0mXT+yAbPeITbI5nufrag=
X-Gm-Gg: AeBDieso3kOt1WKbSglSoUPdPMCfSngsV+92Xpo5oZMlqN05GbeAx3Urised9Viwk4/
	IMDToEfHJaNZlvxPY+0BU3G8558qSxVwIY8Oo8O5pNpMUxAZZ2Fn4n5ON+UNNJVuSJ8pmlqguHE
	59PBg243XBXSAZuInK+n39/m7rCXB+OY/Uzpyf1350VCueCcRnWZl4ftsQK/tcG5suy7CCZkVNx
	TjxKtdgj492ROTCa721p8NsSVBI63zO8qvonTjCdit0xGko8eZS9SPcyh9iDo2mUBvHGj2mdw9U
	wXRIwk4rhHbq29xrxfGDw6Yna482tkEZbCaK4StJYdzJ/FHvohMu3c6ewdRgEeP7GwOGjhiq2ub
	0yy/pSiKSnqoXll+3pvLF5ZZnlz+JKx6bHZXDEA6yctfBuUoob+TA34Fpi2h7MsT+aLGhBz6Byo
	kUCh+Ffu8hOHntH30ARWz4R+yX5LjmRQ==
X-Received: by 2002:a17:902:ea06:b0:2ba:919:bbf3 with SMTP id d9443c01a7336-2ba78f54ac5mr48636655ad.14.1778088293255;
        Wed, 06 May 2026 10:24:53 -0700 (PDT)
Received: from localhost ([97.126.187.42])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2ba7b77cd50sm28311605ad.0.2026.05.06.10.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 10:24:52 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Jonathan Cameron <jic23@kernel.org>, akemnade@kernel.org, Jean-Baptiste
 Maneyrol <jean-baptiste.maneyrol@tdk.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?utf-8?Q?S=C3=A1?= <nuno.sa@analog.com>,
 Andy
 Shevchenko <andy@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Roger
 Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: ti/omap: omap4-epson-embt2ws: fix typo in
 iio device property
In-Reply-To: <20260506142044.6456b2d5@kemnade.info>
References: <20251231-mpu9150-v1-0-08ecf085c4ae@kernel.org>
 <20251231-mpu9150-v1-2-08ecf085c4ae@kernel.org>
 <20260111123200.6871a41b@jic23-huawei>
 <20260112094259.4648cfaa@kemnade.info> <7ha4yfzv2t.fsf@baylibre.com>
 <20260506142044.6456b2d5@kemnade.info>
Date: Wed, 06 May 2026 10:24:52 -0700
Message-ID: <7h5x50a1sr.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andreas Kemnade <andreas@kemnade.info> writes:

> On Wed, 14 Jan 2026 14:30:02 -0800
> Kevin Hilman <khilman@baylibre.com> wrote:
>
>> Andreas Kemnade <andreas@kemnade.info> writes:
>> 
>> > On Sun, 11 Jan 2026 12:32:00 +0000
>> > Jonathan Cameron <jic23@kernel.org> wrote:
>> >  
>> >> On Wed, 31 Dec 2025 22:14:17 +0100
>> >> akemnade@kernel.org wrote:
>> >>   
>> >> > From: Andreas Kemnade <andreas@kemnade.info>
>> >> > 
>> >> > Define interrupts properly. Unfortunately, this hides a bug in the linux
>> >> > driver, so it needs to be used with the driver fixed only.
>> >> > 
>> >> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>    
>> >> 
>> >> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>> >> Not related to patch 1 so if TI soc folk can pick this up that would be
>> >> great.
>> >>   
>> > well, it needs things fixed via patch 1 to avoid creating havoc...
>> > But from a strictly dogmatic point of view the devicetree describes the
>> > hardware, so it is unrelated.
>> > ... but from a more pragmatic point of view, I do not want to have interrupts
>> > enabled for drivers which do not handle them correctly.
>> >
>> > Of course this should be picked up by omap folks.  
>> 
>> Based on the changelog comments, I will pick up the DT patch when the
>> driver fix gets applied.
>> 
> the needed patch is in. So it can be applied.

Thanks for the reminder.  Applying.

Kevin
