Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2690419D07A
	for <linux-omap@vger.kernel.org>; Sat, 25 Jul 2026 01:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784942566; cv=none; b=o8u75phJEcnYoMGbRWrv0cbAfRCPLkwWZBjaQFiutAN0LiELW/5iVs0NmSj0369ynCOly0f1dk6Q0lGah2zSqoz9fHbGUfXcQ92FLhVQkx7Ty2yoGkeOfSspO1bi1iFbU9kc/Jp5f8zCBCT3cY6m0ty0bkZf28SV1x6s4x10YiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784942566; c=relaxed/simple;
	bh=Z9QXS6xGrKf+qCy5+yj/0vWiDbZXZ5ugExXA6xy0B7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/+rO7M8EYduj7xkuA0a6pECoCDMY00AeRLc05zF5VABsSv1Ka7eoSp2NxeQ/JF+Mw367NqcZ+evbo72rFxmO73kiuj9dboKXenC0yyOkyYft3A7jd3H2YZMrqa13c56EGJnyKL4mc4ukMbd/htsE8i03ZaDi4p5wpydL6udGFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ApfGXoKL; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApfGXoKL"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-382ef647e20so1063845a91.1
        for <linux-omap@vger.kernel.org>; Fri, 24 Jul 2026 18:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784942564; x=1785547364; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=evBctyG9uOAPggGOtV7ej6S8jtXBTYTc0DEyRDvPdb8=;
        b=ApfGXoKLoxH36oQl9LPirR/bcjNUIAzXBsyE9CRN1c50OuGMqZvpzkPLLiIqf7n1na
         X6pH8/bmWeqXW3qJDtfbsfdyWN7GrRYXymp03cfHP9JqVnHomAEpqG9rsMtsFeKLxzSS
         rKf6pwr0YzJK7Ye53tWoU4ugASp4bYvnUBnwMFbovt2lzzOhQyfssfgOwioSMwzlvjYX
         hTSPzQsGpMAzZczc8CR3Ww3D+PHu9FIN4eDrB1wbAYlG/viHoUTn6d0MUG8riYAJk26u
         o6BjBd7bU2qs/1ZM38PyEgQl+wJIAfbThekFRRU7/5zwNCdxxC5z3oFTvSipdANnzUSU
         omkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784942564; x=1785547364;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=evBctyG9uOAPggGOtV7ej6S8jtXBTYTc0DEyRDvPdb8=;
        b=qLgTdSUJNGU3pR7PLQp8lj3EEO1xfEowKjk353a6KtxA+QSWX7Kq165b7A/VUCadwd
         jbWRsaZBz7iu1Qd5gWgHCygjjFwtuZdhllzo84t9O4e9zK7twXs4vT+1fxDvMB9bW24g
         bRZAsk6pteP/zcy43OUvrFsPns6L3GYqsVdILrlrosgI0DrCS168vmzNNJFs87Vs/Ws+
         1zDgxISMnzW5ipWLlmd+uWgnEq5qxu0WpVA8pbFWimqbX/A/CH3Y88Y4ac56pM9L9Xpj
         y5w19eZuoEMR7edXzF9vaLmkSnYI3+D/y6rsLTUlROry92qGvDhH3W/i8WUnd6fiY6Hl
         IB4w==
X-Forwarded-Encrypted: i=1; AHgh+Rp5wZWj2uwXnRZIHJSqYad6VrxBsrF9Kk6RhFqGrH1uU4SW1VYpD4WlYJ+7/Cy9aBScVGYN/6E1cqzZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwTZlBJMztIV0s8YfZ3EglNvDPa70AnPi+lb3t2EuHQFxWWXhdg
	sckC5zCiiaBMC1bpjbvTdNAHWIuKFPbd1uBKDnmVZmJgY+Xe6Ddzw5At
X-Gm-Gg: AR+sD11dhA1PvgJfWe9RdhfEmqnNzq/6LL+mJYEkPbiH2ZJClSnNkhW51oWLf3SWmLU
	SswUxmEu1r3MkI1ksTCE0Ago/t3NDOh5mKPzWgY55P1nUyb6XOGUUvh5IXQs0W9AvE/jHoLUnWj
	xGEq0gg5Nv174PQQGKDMOJckWzx5wFIYaBeUNLIu0rxovzqE6uJ22Dv/7icUtXN3s2kbeReNH54
	iVX04qpFB02ntayeBiGquuaEZxNXBUuaq8a8zndH/8e+GLZo1iwPOW+t0HvD8CB/CM9IzWNdKGm
	Ig1Hyh/jrmeWhBfCot3UOMcY8hBWMGADptotOjMUbpE+DDe5Vmli/uae3j1dOSg1f88LxPH50tx
	6KYUYvKPGR3dGJzs54fgZhZfe+3p9Yr06ElhqqLSQ8uqW1VyQh08G23K4lnYnXX8t4bmP4GGmtn
	d5QcNMLHBTDWiggE+wP5Rqs3H3C6rje5TqwFPmSKZcSlM=
X-Received: by 2002:a17:90b:254c:b0:387:e0db:3d8d with SMTP id 98e67ed59e1d1-38f298859c2mr719734a91.40.1784942564547;
        Fri, 24 Jul 2026 18:22:44 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:40e1:40e4:dabe:543e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc5cb670sm5037501eec.31.2026.07.24.18.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 18:22:43 -0700 (PDT)
Date: Fri, 24 Jul 2026 18:22:40 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Eduard Bostina <egbostina@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Conor Dooley <conor+dt@kernel.org>, 
	Daniel Thompson <danielt@kernel.org>, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Jingoo Han <jingoohan1@gmail.com>, Kevin Hilman <khilman@baylibre.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, linux-omap@vger.kernel.org, 
	Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, daniel.baluta@nxp.com, simona.toaca@nxp.com, 
	goledhruva@gmail.com, m-chawdhry@ti.com
Subject: Re: [PATCH v2 2/3] dt-bindings: input: Convert TI TPS65217 power
 button to DT schema
Message-ID: <amQPyzm6P4BUUGHk@google.com>
References: <20260718215632.3295049-1-egbostina@gmail.com>
 <20260718215632.3295049-3-egbostina@gmail.com>
 <amP4csGgdg51VRZw@google.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amP4csGgdg51VRZw@google.com>

On Fri, Jul 24, 2026 at 04:42:46PM -0700, Dmitry Torokhov wrote:
> On Sat, Jul 18, 2026 at 09:56:31PM +0000, Eduard Bostina wrote:
> > Convert the Texas Instruments TPS65217 and TPS65218 Power Button
> > bindings to DT schema.
> > 
> > Signed-off-by: Eduard Bostina <egbostina@gmail.com>
> 
> Applied, thank you.

I actually picked up v4 of the patch.

-- 
Dmitry
