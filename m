Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AE03A6F17
	for <linux-omap@vger.kernel.org>; Mon, 30 Mar 2026 21:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774907600; cv=none; b=ilYFxKdBnMvumaTEkAatACU1MKZjB7T/aPbh00gGhJrYMPsBID06b5Ia8ca8rVSsNnUohDXwRPCpFvU/Dh8UaOjczxNbIwoU9zjHvH8WN5FPlJVKf9Dmo0j0mVIFmPvnD9e53TWXnYKKkQjpcMT54lpjW/Sqns8/DFOhBHixcUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774907600; c=relaxed/simple;
	bh=u+GD/euz/zBGUAdgJKuwponAH6MVIUcpwMw7ztjWV7Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kPvniyTb/HXR+GqG9X6TFFqZbGLfmBdWmt/2ghFeFAhKIlk+rMMaoOuJS/OTW9hNOm8qDwKq4qPc6W2zPJi8MkFpvmcn3C8uoDCfVkUgvW9XNtRIvVASOpf1LWVYEd/SJSH/nkcAuTEtK5TH90ZClb41TQuDQ8vcBvF8fKwsRWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=W0wZ+12T; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="W0wZ+12T"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35d971fb6f1so1963040a91.0
        for <linux-omap@vger.kernel.org>; Mon, 30 Mar 2026 14:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774907598; x=1775512398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhrLf69lwijmXhLU7sx2hxgwSuSk5Rjz6KB9T5JxPlM=;
        b=W0wZ+12T1mBQZIDX72DTpJVkruHPHb6E7LHfYQWZ/rCN6dPh7Urj/CjU9CBnA2BcZW
         66pnWSjCBcd3ECx1YpuTQjY4vmVw4X2MiqrNIuJIc9o50kx0XJzh+BYL/eQq5/NqVEid
         /YhD0pDZVFEk47NNzej46LFUX1rxMjPNO/SG+4ZKnuX6WGmRSUJM+yTdnyHQkrY4TwpG
         SMDPSJACJf161OL2oXACxksHfPloy7BdVWwyBRO+vTNX1bN+poLbdlOVSZUC0s/HMce/
         wFraGKVei/tQnr5pflv9Lep2L9Cu5CNJ54ICABYBWuj0WWRyH3T3ItLI2wHZu1Ln8y1n
         oOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774907598; x=1775512398;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mhrLf69lwijmXhLU7sx2hxgwSuSk5Rjz6KB9T5JxPlM=;
        b=rJlc7YtBAiZ26EgttxmYN3YepTkudcKEeb1YSibAX0dDCwK+CZlyUvYbAAbGBaCjIU
         sjsXqpqjVuBdyhR8rb9NC3dr2cxgclhePpCqBhG4hoj1fBe9lG6Hrj5Me8TCf9Ve3Tt4
         MkfQE6Dwe/huEf9kmKTdFW+La4G9OH0MB4kB/dFXIXK4BRR8js5MBvZAS3kOA9lqPRh8
         NNrJtVch+hKbVJZVvYL6ufiBxd2CajLqgKvhFVxnoyTUU6XuDsN5EzMKqdHAvZMxXABj
         p4GzhiOfgWMY7b0Mtq+7vmDqHNgc5VLNqOYGtfR/WOU1mue/gUPV+cgg2uS3dS6z1C31
         WzRw==
X-Forwarded-Encrypted: i=1; AJvYcCUIY/4JUOVhX1xYrILmgciBWi5gnBy7r23CFuiYR+DtPEyDZjuTV/kgy21IpRj6/+ZuI1+e54jwOaAt@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Ax5+mBANlowaCFHz8cmQXNHepdPjK9ZD8c/TWQB24PnA7KRV
	y3n03XSa1/0xn48HEl7qEwPFgLf4yeObsxOhtG3NJUQZVdH55PD7v9MHdzxi9NdBOQNR+86oQO0
	rP3OLJKM=
X-Gm-Gg: ATEYQzzHId5bApupfkyVdBhcZUK33PUyq6K07RAKvJqgELgNSyYAfRrat13w8cjzWuX
	DuYa7TGENweqE+wrNJ8ZoeynjfiVTz2WyY/LMBsx0xM9CO4KZZCw/ahTcKqGzBMsOirHK85sria
	kG58zsDOAgyK+UPuYhVxpRLk2Sgvb+srlEvIOQ5quMLahF2z2LoCymQGFq0Vr4hm6+b3cBNbXf4
	azREsgwh34mfKigLY+eeTn8KShIKmId6YPJE856/O+GX6eohKP8Brrn38uFzp1fbCueVN6BJCep
	3b4U1VTbUi/1+SFWbfOXzMMtY02u+301b4Y0RJz4KcyeWNyAATacZ9wB+MsEIBHMHNLiVC8qJCn
	PKPF9dG9jRnF6E+1bZgKDvlqX7Hzqqqq+IP0bNhymcMSeq9lFJJ2D496+jyWwsRMB1wS+7V6EkB
	CRtY4mXFV/9IiBN5OKrV8=
X-Received: by 2002:a17:90b:4ac3:b0:35d:a557:e44 with SMTP id 98e67ed59e1d1-35da5572530mr6144809a91.6.1774907598192;
        Mon, 30 Mar 2026 14:53:18 -0700 (PDT)
Received: from localhost ([97.126.187.42])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35da9ef1b70sm3940792a91.16.2026.03.30.14.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 14:53:17 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: tony@atomide.com, Julian Braha <julianbraha@gmail.com>
Cc: daniel.lezcano@linaro.org, linux@armlinux.org.uk, arnd@arndb.de, 
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Thomas Gleixner <tglx@kernel.org>
In-Reply-To: <20260329183018.519560-1-julianbraha@gmail.com>
References: <20260329183018.519560-1-julianbraha@gmail.com>
Subject: Re: [PATCH] ARM: omap2: dead code cleanup in kconfig for
 ARCH_OMAP4
Message-Id: <177490759740.2030917.5758134874095517532.b4-ty@baylibre.com>
Date: Mon, 30 Mar 2026 14:53:17 -0700
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev


On Sun, 29 Mar 2026 19:30:18 +0100, Julian Braha wrote:
> The same kconfig 'select OMAP_INTERCONNECT' appears twice for ARCH_OMAP4.
> I propose removing the second instance, as it is effectively dead code.
> 
> This dead code was found by kconfirm, a static analysis tool for Kconfig.

Applied, thanks!

[1/1] ARM: omap2: dead code cleanup in kconfig for ARCH_OMAP4
      commit: 9ceb17ccd15ea32f19c9066f5f1b340d8340bd0b

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>

