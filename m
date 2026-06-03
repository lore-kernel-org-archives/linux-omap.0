Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003773DC4CC
	for <linux-omap@vger.kernel.org>; Wed,  3 Jun 2026 02:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780455256; cv=pass; b=qXhtpXOsYFmOA6kBz/xqT3q2XYHR6PeFm0LSjDoioyxLyfxovOFH+Em2RCdhorbIJqh0tyx997YPvYj+HkZ4J9Y/fpDoIHI9TzZIw0d7sMKazx9RjoA4nF3/beg9oYyd2IcV1f403y/ETLbv0qrQKcyina35TZc7iFuBWKwOb10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780455256; c=relaxed/simple;
	bh=6YEVSweRiJIFFM92G7CI5lIVwON7XPQd0EAv/NVq7jo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EQwb6m8QnXGXBhfAEj5dslG7orBeB5Fnr1pS361+H8CUzhjhhLyFVjexmuVTQAFQNeWVKDe1RFowhHPKLPo7M/d/eeI1jnxDKf2O88Tmrl1HOYvMOHEtA8DPDN4pReFTVy42f8jWTjUe3/SdxCG187shm9izj4Mqs+u5Z1QbVyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3I6y3mb; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3I6y3mb"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3967726bc47so32666691fa.1
        for <linux-omap@vger.kernel.org>; Tue, 02 Jun 2026 19:54:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780455253; cv=none;
        d=google.com; s=arc-20240605;
        b=Bnn8PTI4xVKBgE7BUujDK+8orc+Q2VkVOveVEtS37fMc61PiPVMQp/0rGbKL7Yun3M
         n/R/MGIQKRah+clPbKO+eCPZjLD2iMUC23Wrsx2YuZnVIF3oemRfy1XQHED08DcFbwW8
         y44dJB4Yc80QudpeUmyDnPVbuRtfiVo/lJWpk1oB2YHItqzm/RX4IK9r2exRjIwG3/jg
         hDfyOfnuPE48vHvvoM/5KHWRevOquSHRB0eOW2qRc/dmS8VFbHzJitClDx3rwNdadoIO
         wnpY9rn92crHmn8E9CkWqBq0YycQhnllRKC+zGoXGWIo5UGRPJTFGx6AOodbFSpINN+P
         jwsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6YEVSweRiJIFFM92G7CI5lIVwON7XPQd0EAv/NVq7jo=;
        fh=XbOUaC28wWrbtKGPlfh3iurGFcoZtu462BEpdZssATU=;
        b=PjJBobTH1Xi1cikpTeU31jF41nX7dZBrtRVhsDfxfTCNXP3f0cHCt8IWH5EKv3Ponn
         BCOso7pMand5bU3+uHxNggiJ1Q+JqroYbIiL+7e3rAYUS4wjAiza3yz59oKjwEI+rok0
         0Ts8nada1V3JsJnHlIySdcmc6AM6jPgJZfKSWaYxDqpykKxcZ/Tt1wxAMlx31WzAcZOG
         aMrjIVV2fxAEffQUeLZRFywp823W4G+5H9B6WEPNKjSt7b7yKt+1elTQjkqkDVAWJKyd
         o4+foNcU0OOvKqI4DFvL1Grd1W5RBjWigVldBp5VvUiNGP5RLB+cp/GlqYc7QhdK1zRP
         XQvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780455253; x=1781060053; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6YEVSweRiJIFFM92G7CI5lIVwON7XPQd0EAv/NVq7jo=;
        b=E3I6y3mbGCZqEW+0z6L1B7m8wM/n9Wk4B4TWUSjqaVbMowqmiz/buAQyUSQXAqr+0m
         4kPUBiA0OHX9KtZWnpvqeBwcv/p7Fr/kkuuSx3Tpwg1lqfuF7M07BXh1lI7AllABeCCD
         CwuNfOUNCkmrnaHjO9czNtFP9xQUN5ZHderQo4g3We46+QjEFxW2V1nJuBHEcGDTAy46
         h8AkGg3h3k6L8E0mJli1D5eBZTiTIOpUtPTXbtjtxnTW8CJ/5mdTa20cSLvMiEgE5Wg7
         xTR8Xd2sj/bMvhjvsNCEGUqDa2MWB3qWm9+QA8FRZYUj2QCE1LUbZ43N0b50WADjjO7z
         qrpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780455253; x=1781060053;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6YEVSweRiJIFFM92G7CI5lIVwON7XPQd0EAv/NVq7jo=;
        b=q9kXqwml4zcWjRwdBMLd5cnYXA2w4tiDe7U2MrqEP4/Qftor0SVhbdflgGkdgAG9Gr
         AZpuntrPRVPOAxMdy+LQw42VBIj5uZcqMs6Wbira3CdA28JDIermMTPrOnHQr16QCy5x
         +aC7hFEjV6EAwezvc0c7KvC1hiyZvxbGqo2Z8lG4ia08WkODYTDqHoT4Q4bWg5OCvLCQ
         x+KAeV8cOFrmAF0cPN4C5PBAAkhLVYsX+yfpvLF9W94Z0se5al9eg7lXkqT/0Ej+CEAe
         g71FvivMx/1lAbJnXTGPjY/LgmoGMd9SnkpRiiT0xmfFIpDMxuzElJ3zT1Jzdp/1j+kx
         sO9w==
X-Gm-Message-State: AOJu0Ywjv0rIr6vSj67M0dueaSJI8ElNFckyaq8cfsOTjG62D66lzxk2
	oXR49tL/zmmKQD3QTeWTEIk3KrTL9Uq3mXLqiK7c89mwNcOp8uuY5cBSYPGFvlNrVcXeysh7slQ
	mcjwXrRwOtXZ5X1DXK5xRxsYwMu0wo2g=
X-Gm-Gg: Acq92OFgakzUY6OrEzy90alQBehDpFV3WGdqadnQxJ24qt6FyaxQNqSKrMK8bFvcOvX
	Xlof4VGCAQifExkdwImG0cbwZ9f4M3LBA4h2DToRwPp+X5rOl6Vk0wxDPLu73VlwvIod94bn4EZ
	NDM6kr2jEqY2nQJbi4A97heJ+auQhhg34+03PMWm+1mvGjfDw4xZHc+lTQoEsEMdpxURbcOZUW9
	7UpMF6Ts5qXerNjQQCw66dATE3iaViFLpGNRoDj5OdTB31gA54mxLNlaesnnd/3PqRk+ZXhDh8G
	WGxPZygjPYNDmayF
X-Received: by 2002:a2e:b8c1:0:b0:393:ba06:158f with SMTP id
 38308e7fff4ca-396af436647mr2834231fa.16.1780455253043; Tue, 02 Jun 2026
 19:54:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504164711.2854116-1-dbgh9129@gmail.com>
In-Reply-To: <20260504164711.2854116-1-dbgh9129@gmail.com>
From: =?UTF-8?B?7LWc7Jyg7Zi4?= <dbgh9129@gmail.com>
Date: Tue, 2 Jun 2026 22:54:01 -0400
X-Gm-Features: AVHnY4KNwoXo7QpfYN1PxgSWQeICNocegKeRauPpmBUxYtBRqMrv5QlOe5Fanmk
Message-ID: <CACrCO_Xw+xi1jjNGmVjV3-7v_v=9AZ1Nm_FHGvf_B7gOu6G4Zg@mail.gmail.com>
Subject: Re: [PATCH v1] ARM: OMAP2+: Fix OF node reference leaks in omap_hwmod
To: Paul Walmsley <paul@pwsan.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	Russell King <linux@armlinux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Just a gentle reminder regarding this patch.

I would appreciate any feedback when you have a chance to review it.

Thanks for your time.

Best regards,
Yuho Choi
