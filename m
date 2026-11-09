Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794268102;
	b=uf5Si7bGFY4B8a9Giw2FcK5y5gXL6lUJopHgyGdtiHegXDwygNPSq6KwcBvu0qqzCVWp
	 ZwZYXsZzLAek5FMLEwtLnmzdGwmVTfsA+AvOjdWLLuUZlPwSex/4Ugb7oEgWqg79cYMLx
	 miibbFWogC+FLeA7HcISdCGfuHT5tLqInxVS23jlwJ8ZpaSiQUrpg20p5nsMd6Am4M6Oa
	 2yoo2+v1Er6WNWKo9eYqOGuD3gyb6NoTEBv8Lod+NwnckzGPV+MsYN9ouEeul8TkkV2QR
	 tKqDBWXSpxNAPTKF/Cx+JbNYovB+Rt8jngtVHN10/bHDGyittxj01GqYoOx2BxRJvxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794268102;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=IppNhVX5WQCSwvqxwHiKEP05fP8li4vwyY2eexFMjDs=;
	b=Gz5LkKWzCfEDjvvxhIldtqpe08mGDsQGsrBOyN6+3LZdsskYMfrPFOJNU8URBLeQHPc6
	 S/oIqXizCFMqi8oS74KJDcA0lJKmIY2ZZdKR6BgF/sW+XDXBVBNUh5dhLYfBiLIeZRigK
	 EKrUbfw5Vm+mGyNo6HKIt4YBVBcNHCgTE2p1u4plT1ksDaQKrwVw/ETctE0GQZfUb4UH9
	 u8uKWhuX+wGXXPRvzjK+pFF7c8jO9ZPlxRhW5j3v/qDSZBU9r4zeVual16CQ6d4yZzpmF
	 BOFM7gxqkw+HazoTsHPbAQAXFjcMGtQg3NJta6zIRnG9xKd4V+E6OIm3x3nQyDFzx9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=pRG68NOM;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE54A606A335
	for <linux-omap@vger.kernel.org>; Mon,  9 Nov 2026 23:48:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE54A606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=pRG68NOM
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cdab9e9761cso710060a12.2
        for <linux-omap@vger.kernel.org>; Mon, 09 Nov 2026 15:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1794268101; x=1794872901; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IppNhVX5WQCSwvqxwHiKEP05fP8li4vwyY2eexFMjDs=;
        b=pRG68NOMZ/f28pchMXhs4pk+9Pxc2LAdL5XRgHwZird9D2ijjySTURWf6uWFmqwa0u
         J9PAZCYsLHlfYlUnIcClJEzOd9rZEcN1H81ojhFrJ0fYfH59sbNPBXAuEAiA4LiWAgHo
         dYPxBpFdCkNxq6Os5w6ml6GGuRB3ej50dakATcGxtqfJcXhE0+klVIXkOYZUBwFAngpu
         UpKUtGoE8RyrkuekaWpRSwSwU3CFKapY8+I43i/Vv0JQFB6/MJgT5E1ACVITEqeI/9NB
         mGWU9MMisVFAzAqiFZ8KovoOUxwgHw+cwIY4kEfNyuKPXtqRIin7DXZPaij7uaivIr9X
         dyEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794268101; x=1794872901;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IppNhVX5WQCSwvqxwHiKEP05fP8li4vwyY2eexFMjDs=;
        b=UwWWLRFRHf/xCh3pDc8Jsy7qvKi9MLxY52l/27LcvqqReokKMM0qciCNF/eTA3fie3
         ezEUokXpCgtcRy0a3vHs8K/UOAEXFYxDktDNytYB/neyBnU8koq8Xutgg/V8wSTPBorx
         KRCNZXtaf/DbYAUr1XQv2bTHxhZ2tcod1N8JPonF+bggvpQFNNWCFAAwyev3EfTlV56l
         F/z5uE5WRRJjN1yTPmHynyYTF1XJc/k972eFspngcBVCO0kG4vXGlf1hWMD7cWhfvT0L
         ljDET7Tb0B72XzxJ57jXJT9dB6nc4m84pZxekWX9ejw139PUmo0ugNBHP01FGpg6uR/C
         6iNA==
X-Gm-Message-State: APuU4Z8gfyXk5HByElEmn5WUWN0tDrL93kN/uWQJ5TLXmAV7z1sCTYEt
	pqPxCFPVhyBwRq6UG/LPqdm8jxZt9M7r23SMXfdDB7OO+HNOoz8hJpnk8MgqLMmYrMc=
X-Gm-Gg: AYBFou2VaB/VPFUBnccu8q+VEYvzqMXgp9iN6CKvuX8TxcUYKuQSabdOFTtEaLBx2r4
	zVtkKu8ya+ETmy9EFvo/rfZe0EbZQbiD7rytlcUqvdxRUWP3LqX3MR+riXoyLWy8L+9YAiayQF9
	mrp0O+qdg7fCgKlV/e94co2F8md2DVhp9QwzBcncphJzrpgs1plAq/9mpdGggTOYjVvj/44R1Nh
	J9BThJCJqiGsblWyrKEQNQ6/ECOFhCcVYTw0omnTCe0Y91bFoDE9DlliozmjbZDUkwDoWP4VQCy
	oeYI2+9U3sQlDF+2cOGlDfly83mf3QNTPwQ64tAj/itXNguThdBjF7LFLKZ8Ls1mG7ALLjF4Ma+
	OtG6pFJx0zJ4c1fyZ/5Ltga0nxNtD36uO2FtzmaVflNS4RbphvoW3AmcBF71ktSvD+kIEsY2heq
	ONwA/Mc3W03veTjjEzBAuquJOV3pN1aCHLmT2YHyT6Zazj2IV/HjSOcS+2iXg8KjmgA4+hgX9Bx
	+Rgltyz/o6yyAbdzRXMhzwG/P8yiZ3ErtplyUXSNwzaKEV3SGcpYIcJZ7FfQ0ESe5yNczqemnSD
	ZwC2a7H0fiMsM9OC1lIv2JBuQDG9MI3BD16PTkQ++PyL2g==
X-Received: by 2002:a17:90b:4a0f:b0:3ac:a203:e0a5 with SMTP id 98e67ed59e1d1-3b166cc0352mr1249763a91.11.1794268100946;
        Mon, 09 Nov 2026 15:48:20 -0800 (PST)
Received: from localhost ([97.126.173.69])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3b166f542edsm1433378a91.0.2026.11.09.15.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 15:48:20 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, Roger Quadros <rogerq@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, 
 Andreas Kemnade <andreas@kemnade.info>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261028-susp2-v1-0-174b52857d89@kemnade.info>
References: <20261028-susp2-v1-0-174b52857d89@kemnade.info>
Subject: Re: [PATCH 0/2] ARM: omap: cpuidle34xx: Fix unbalanced
 cpu_pm_enter()/exit() and cleanup
Message-Id: <179426809959.2265990.7562894927493541429.b4-ty@b4>
Date: Mon, 09 Nov 2026 15:48:19 -0800
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
X-Mailer: b4 0.16.0


On Wed, 28 Oct 2026 20:15:10 +0100, Andreas Kemnade wrote:
> Fix unbalanced CPU pm calls and delegate the question whether the
> cx pointer contents could change to the compiler.
> During research for some spurios FPU issues, this oddity come to
> light.

Applied, thanks!

[1/2] ARM: omap: cpuidle34xx: balance cpu_pm_enter/exit()
      commit: 97e0f6eb6112788e7a46376998e797b4d7d6f524
[2/2] ARM: omap: cpuidle34xx: Constify state info
      commit: 6d6f135fb1c38fc833e4189e1db47eb7060c0b1f

Best regards,
-- 
Kevin Hilman (TI) <khilman@baylibre.com>

