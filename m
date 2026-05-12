Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C77B3C415D
	for <linux-omap@vger.kernel.org>; Tue, 12 May 2026 16:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778604802; cv=none; b=MpFK+t5Rx20R3w65zvP8hFUJQBUtVQrNuSwfm2ZAiqCnqJk48DmSV8+nr/xnoAV6p8T64uSe4ChA0mcHT81vYReHBWca5WTPKaEAVlNLl4ArqD85+BXI4CTsQ/8170hlm4GCl9VdcmMkL7R5ZBp2m7HkjuW/JAAgn30c3fuLkCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778604802; c=relaxed/simple;
	bh=n6YqyFjOV2k/BlMKcyl+qVfbz76XL/KUqt3hMlw5D4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h9cvVZki7kkOEC4Nf+Mlq3GyhBUEsy9z8TGlXLkr+G2U/Arr8a+Zc/PMuZYnSlfptQ1PHdpb+ojIdlKLysduxK0n8r9BEcXBTrrbm6SUbon8VM3TqwY8gjUtdlZTn/PuQaFkdCN68q8eCr9QI3+HewFcgj/yRE9bnYqWq2eCyOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kubj3yN0; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kubj3yN0"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-899a5db525cso36338466d6.3
        for <linux-omap@vger.kernel.org>; Tue, 12 May 2026 09:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778604800; x=1779209600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dq4LCZrUHOBpWDtuS+ZDVNUh4OO0Y+T0F6gJsifopzA=;
        b=Kubj3yN0OAK/Mey2R3F1meyCA105xcYbIs/0drr0G+nEqWte4G78y0FhmcOuuqkgZK
         /wm/jnMZ1iiAGjPchXK0PkzIGaZCV6kzlT2R3C2LpYoQcD/CR8tOHm8K02Uqka1QQCGu
         cSLbt0ESZXLeBfNWnO2CrhaGkbWFf/bTcXpJocEcCqoo01VTuWMyM8oWYDBoAyshiaXC
         neC9qkckarZQORPtTD7wV1ph3Dk3aYM4xsQGd/ZQfMjUPKjn4UzmeWJPUiDf0+sXUjbN
         /Ur5rQiUF2vj9l1aN2NdOP519q/5rVKwCOBPe3J8T1lEh+BxT7N2qTvlEFFN314uUfgi
         veFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778604800; x=1779209600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dq4LCZrUHOBpWDtuS+ZDVNUh4OO0Y+T0F6gJsifopzA=;
        b=YopJvHJ6Fcnkbj66yXSiXBtpKlKmK0prJcmAM10pOAC8QqzJ/RV6MyDZWrmdxsCzLk
         fp68a8H+LDiZ6PGmIln6/LIny1PfbyjUjstD5M1tqthZx+Le3wYQHMs4Pv9oOSTirDBe
         9Lp8l74U84XuGKya/SOztZ62YiyDtKhm6Q1+5VChQffD5c28nNdOjKU3D5Xln/t/kNha
         ADNx7NG7LzJi1uWi+ZzzhzJ4bmZ9gjS84kFXSFLbDIH6tpK7IJElYZ+rk9fzzJc4FjaP
         FOaH9eU7+c7H3G0QEaBNWXCnio+hvAMyK73elkNcNJgP180wWYamjBgABh30Azp0yCCf
         3lQw==
X-Forwarded-Encrypted: i=1; AFNElJ+f26RuQnUuQYDX+pRD4IKNuZ936tGV1hkfSHp6YoZf0nY1Grs2E/heSZ5UZwctdsEWyFg196WWY5yu@vger.kernel.org
X-Gm-Message-State: AOJu0YxMPqJLrtghzSJ7QMI2FHMALI79oQuefrTsiiNBMgYAEXBe9qdK
	ybb8/QDj9/fhvA8yjJiLcyi0VjeKwIoFL10rtOYfcGuQXYWAqqpKnbbn
X-Gm-Gg: Acq92OEUWUCVfifyRoDPAZB09NNDC0ndF/Bbddanoco1os7c4sIQCrxN+Qea45XSgFk
	WauJp4cDEpjMbf+4ncwWxbMMNynCWJVKwckCmKJQuR07lVxHlfuPQbo9UBzElGn6tAoeSwQYmOQ
	tne+mcoSHbCf3sKvZy2B42a09O7FI0K+auBFOoeXJrNXI2S2EimcSvNNEOCokCvihRVbms+3272
	r9WD7uTRVkl+I60rxFHSCV6D3T7ZLCxUYiggL+9O6j/cwyD2fvma7U5ZopKZDtf16axlDqiEHdv
	J+n7UnjCOw9P00REWVtLy6yBRINk9fNrzvIkbvpD6tCnnx/EknngbE5wmp888x59B2ensU0w94h
	7Ujz/v3ehQT3o6HwKnRq+ZpZrq5S/sdVeJgZyp45iETBEv4CHX4GbQgHZioX5SlS8AGhKoxIh0I
	QGY7VpRbAb9D1JI7yjFlhyI03R8s79dhc9CwdjwfSfrcmi92+KAixskrk+Z7WuE9IxKO+zVPAeB
	y9UtllmELEmKnecinKdO6DJk5jCCnydJZededca7CAF7L4=
X-Received: by 2002:a05:6214:4c48:b0:8a7:1498:5f67 with SMTP id 6a1803df08f44-8bc42f5313cmr414441406d6.18.1778604800418;
        Tue, 12 May 2026 09:53:20 -0700 (PDT)
Received: from mighty.tail79ce1c.ts.net (nat-130-245-192-1.resnet.stonybrook.edu. [130.245.192.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8bf39c7e032sm129797216d6.32.2026.05.12.09.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 09:53:20 -0700 (PDT)
From: Mithil Bavishi <bavishimithil@gmail.com>
To: nathan@kernel.org
Cc: aaro.koskinen@iki.fi,
	andreas@kemnade.info,
	bavishimithil@gmail.com,
	kees@kernel.org,
	khilman@baylibre.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux@armlinux.org.uk,
	llvm@lists.linux.dev,
	rogerq@kernel.org,
	samitolvanen@google.com,
	tony@atomide.com
Subject: Re: [PATCH] ARM: OMAP2+: Make OMAP4 finish_suspend callback CFI-safe
Date: Tue, 12 May 2026 12:53:18 -0400
Message-ID: <20260512165318.442-1-bavishimithil@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512135757.GB570003@ax162>
References: <20260512135757.GB570003@ax162>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> I don't think we have any formal documentation for SYM_TYPED_FUNC_START
> (it should probably be documented via kernel-doc?) but you can read the
> commit message of the change that added it for more information:
>
>  e84e008e7b02 ("cfi: Add type helper macros")

Thanks, I had a look at it and other similar commits like

c50d328 ("arm64: Add types to indirect called assembly functions")

I was not aware of SYM_TYPED_FUNC_START before hence the logical approach
was just to wrap the function. But now with this I'll send a v2 with the
ENTRY and ENDPROC changed to SYM_TYPED_FUNC_START and SYM_FUNC_END.

Best,
Mithil
