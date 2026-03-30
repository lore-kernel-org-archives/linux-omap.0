Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388092EACF2
	for <linux-omap@vger.kernel.org>; Mon, 30 Mar 2026 21:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774905652; cv=none; b=VHsSx+ME6VqF1zawVazbUFIC1Ws/WycwFrMGouSpMzhwRem6lmSxHmZL8ARPa0OM+h/X1c7Vp+eLKh+yq+HyySpaToQc5Yybjk3dSAE7+h+IiBq+26TH/eIvQa67kDprgtfFk02k79hHKLko1UJMS6ouSKCffOwIu1igRDRa+rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774905652; c=relaxed/simple;
	bh=xxGSfNEhIKCN3A5hPhCPaCefZunVyRLNKNOdvFsKOV4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ndMmnIkly3hNGpKPwBV1Bs/pMIXfbQCbA/LvOGcgL5CgYFY4B1ZE0/ZlyzMvkFS/tLmYBt0CWxVAemS3OPRycLbuk1Y7qKsgpBD6X1hNT98YHN5c0habg9KqaTRmk22QrzvgnYcjGZ6p/4O8SkpiYTHbj7WLY7SERwOLYi+ztvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1V29NqNJ; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1V29NqNJ"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82a07738118so2775932b3a.0
        for <linux-omap@vger.kernel.org>; Mon, 30 Mar 2026 14:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774905650; x=1775510450; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KFHVzUWvS3ADraojc1oAhG0Cf/0/o+VUJl7DBlABpGk=;
        b=1V29NqNJSgkLIRK/b7H1d392zMhCjUecWDnnJZEyvfCX7Bp8bdWElLpeXyVTlL9Gm8
         19mPbKECJ+WTjIAGczfofTS812wGE5v/sj6BB6mqRXptSyoNVL3M/SqKMkoOf3HFK75A
         fmK3MNUD9g20ELjJ/NSxdnvuxzxfaLf/JZCOLjZ3LGWwCgABPNwDQGMH1/ncGtEifBy7
         VIMfWKI++E5Lagi9jh2TcrWtJtYse6yv03KdLBRwUeotGWPxqz/SgHlbnP1BCzenS7Xm
         +wW6HwKaDOFgAVVfyamWPeUg32Xt2xU2H+51I2zh73HauNvKSlK7sxm4+/UeRRspZAmq
         O5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774905650; x=1775510450;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KFHVzUWvS3ADraojc1oAhG0Cf/0/o+VUJl7DBlABpGk=;
        b=HVYdvrhfq54wf/RrExIfLGdZOY7Cl+oG5U8rZr8rJyOp5QnsZVIYUPakcH3dScn05T
         X2lUff3Wgu0C2gB4wWH6XVRvpD20T17j826j/R/0R7LHlevSLLhxbzbPOaQpsqpJlxSh
         fX4gEFyQAT5T1FW1MJmC333jzB8XEMVsfJhD421TE7J2GXnl7KKsSsUWEeI6NLdcqAxk
         zbo4gIQoR8fV58qMqAFsjx4KFkGikDhyemLQs6g6Q0SqgPRGwKM6G5XkczGJy+GCd9r5
         +cBpjb/pmiv0ApW1tSeO+pnkkd/dQY1DsCVkiPS9LhdKxCPMGwh9obfeFDFnX1EOSOE/
         oznA==
X-Forwarded-Encrypted: i=1; AJvYcCW7JdCne5/gJ29aTswxKwOuJub+mVDOvAwW7oO8M3PW2xlFe4VNF9q6sAaMLG8S4lAEQ8M0y7K9b79H@vger.kernel.org
X-Gm-Message-State: AOJu0YyEDt8mw0bc8IpQoRrVz+8GWhBKoKwuwsP6T23l1Ps5Hb/8Sp5A
	5VwV8iSBD/RPYKq4eyiU2LApXhD5kK+uzoGVcz/pEHke0h3ilSpKgvuhRK5zRT14Z0g=
X-Gm-Gg: ATEYQzz4giLWEEsLCQKP4ZZnw0RvKI4O030wNajqLp3v+SrR2MTIESIyuV2mx7KmY2c
	0/TOPgY8R2oLsrl3/gM5sj9AtB5D8IVuDmiksKdz1sn5xJ3zjW/Tssx17KHufvIEYOQKrpyLo4H
	j/BI0BkNlViybIxVouqdvDHiwWr2EOqPC2UeMwgEdf0aVrAaFjonwW3XwJI2f2iUbGB+0jOYJD4
	IouA+WGXEPhyjyoGZVg7paA/r3xEggjw3YfXYiG76WR5WWIsQ7X+J8JnzvQRJQu8tt1uw7ldP+6
	phH3E1nILsm8JIG2MX7qQ12bTlHvyh4hFPhygY9mtYhBj+vJVwNHF4x1o4n9npY9QmH5xrDUU9h
	/LZVYqbzXPz2yyJHHQ0H6CKI6ckeIH8p1nRyV91cuNJsZmme7KzvavtC/BAim3vifz2IHO1hXZ/
	vwT76s4QknCiOZGCtN+9w=
X-Received: by 2002:a05:6a00:23d2:b0:827:3093:901b with SMTP id d2e1a72fcca58-82c960961d8mr12314711b3a.43.1774905650561;
        Mon, 30 Mar 2026 14:20:50 -0700 (PDT)
Received: from localhost ([97.126.187.42])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca85d030asm9550520b3a.38.2026.03.30.14.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 14:20:50 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Rosen Penev <rosenp@gmail.com>, linux-omap@vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade
 <andreas@kemnade.info>, Roger Quadros <rogerq@kernel.org>, Tony Lindgren
 <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Kees Cook
 <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "moderated list:ARM SUB-ARCHITECTURES"
 <linux-arm-kernel@lists.infradead.org>, open list
 <linux-kernel@vger.kernel.org>, "open list:KERNEL HARDENING (not covered
 by other areas):Keyword:b__counted_by(_le|_be)?b"
 <linux-hardening@vger.kernel.org>
Subject: Re: [PATCHv2] ARM: omap2: simplify allocation for omap_device
In-Reply-To: <20260327191104.206512-1-rosenp@gmail.com>
References: <20260327191104.206512-1-rosenp@gmail.com>
Date: Mon, 30 Mar 2026 14:20:49 -0700
Message-ID: <7hwlytui8e.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Rosen Penev <rosenp@gmail.com> writes:

> Use a flexible array member to combine allocations.
>
> Add __counted_by for extra runtime analysis.
>
> Remove goto paths as they are not really needed anymore.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Could you please add a bit more explanation about the *why* behind this
patch.  Your description tells us *what* you are doing, but is a bit
light on the *why*.

Thanks,

Kevin
