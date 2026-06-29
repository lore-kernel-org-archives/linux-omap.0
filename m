Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8406F38B7BC
	for <linux-omap@vger.kernel.org>; Mon, 29 Jun 2026 20:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782764381; cv=none; b=LmwcuUJanL4WU0ltxSIlFiVIEQoDM1fRURfkL1FuOzzlpllVYZPxBwZ19F1e+v7bPvLiQpw/9rSiagveE8VFw222LF1almZ/JKVQGrrsEr03v1zY0bUfmejxEEEE9d5o5cuKUvwGCOm/lchXfwTzrorNF1upiAYN8b96bJcOd/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782764381; c=relaxed/simple;
	bh=99WKfdqZoi1+9ylSQNVVCW06vQ25p+lbTWGbcCvQBW8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=M+R3xneKZ9q6Ek5mP3Xs62PQ3J4TX3dzsu5MFSGBSj0clsbX9yWsPZ55nKldIR2/5rFlvmOn/gWhHSiYekT5CHM2xkOBFnFgbIjRqhJ4Oz6LfWwTJKKoTFSJ3Z4vp079u54BvzZlBib8y5yn2m6tm329dTu/vr+HtPCpdmLeD5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=f9D6ryyv; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="f9D6ryyv"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84794e800f4so479351b3a.0
        for <linux-omap@vger.kernel.org>; Mon, 29 Jun 2026 13:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782764375; x=1783369175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tiWkzSXLrg0x2FGE/eIO2X7UZ5sYnOvtaeA8i0STfAs=;
        b=f9D6ryyvdXnvVuX+Wyr7ate0AiJRDrButbjp3k/IOAzXYyYWeLBQINdGwlz1lecJyI
         itthAY/k2FRsbMvI2s2RZWbuS2lyUvjNVUYkX5YuEOE8c8szFtNBZY1fZAiYGYTGa1Jf
         Jm18HqW498HAwjiTYvvo4erYbCwoM2gNcFCszWZs2gg1Trxr4yj1rxVMIk3jHLhKv54c
         8tK0FN6R2blnc0c7fQdhknXE41zSA6wwTyMLI4bdE4tSdc67Bum9/ousg/cR4scLBlCL
         1ZMyVrlAAYcB92j5ftjxVuFDSHq6KdFv/LIGwdu8tkpDmxquVEmz10o8/uw0j8iT1J2S
         Y5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782764375; x=1783369175;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tiWkzSXLrg0x2FGE/eIO2X7UZ5sYnOvtaeA8i0STfAs=;
        b=eIBb/3Nr+MBZLAZtrJyRnsuckK7fSR/bkLetpmcp35z0NGFcP+quj9XFb+fRop4P2q
         +8lIwbIoMyVARQkD8w/nQxa+Y8QyvE3C5wx8TpCy9Sp+1p2rroDtNAnv0+Zyh45sdg/e
         5lu6/RFE+QmG3vkfH9qUohxkxkhbXASDPdKUncDcMJNd4mLtYGT+CI/wqBtDlm/qLJ0E
         yIFSCsEiy1Kwyo2Q7aYJIBdtC9IE76/wBqtNoH/IvYoucw17iWasj6bv5Oo80jZiNfog
         gk8dTjxGFKaqw/a6gO9w70GCBBQD9TrKP2lavINS+KL7DJRvFz93fTZ4Z+nadK2jRkE3
         E8rA==
X-Gm-Message-State: AOJu0Yz93FwJY+Pjx5iFUT7QVlXkcepCfnVqppujR4tQpIgGxjQ596zB
	BGboh8RTW17jHk88AIk6EVIA3SNih029R8IZ58N5NuzL0sM+fjzjv4o4ZYN1JfMwmCg=
X-Gm-Gg: AfdE7clcyhh764ANsbLl9wO1hNUY/4TRAqA8LqZMknJ9155cxC1RhMnIRI9C4hv6gi4
	cDVHtDXpFtT73sdQhZ2qnVEAbTppIDf75zWWrF3ot/M3z5vkSuG9tAkG4x3QwCzAaW92B/McnPM
	P99/3spX9Xl67cpexoRYkVBzmbTduzIaS/nfiHtHGWtnfXN5dxU2QgQvpWT66fPS8etCKKFgmph
	3pKDwcknF84ADxBtQVaPyY/xIK+s/ngoR9yAgB+ZX6cxxwiUNJfSZDj31/mtNR7iLS5H5JYMgEK
	4ZeMq7xwmLe3s59Lw706ErDyUPitZ5Qr00z+5AF6oeCQHOIkO0b06W8VTcldVeVjtgs6ID4q4SP
	JURSWTNP9hJ2YpY5/knmGjY/O6FiwDmxG+eXfO/Bi4ATwpTkOf9eIcXze2h0EQVpJpd/mbBvCxB
	7PM8HHPIwGBw==
X-Received: by 2002:a05:6a00:1814:b0:847:98cc:a347 with SMTP id d2e1a72fcca58-8479f2ce28bmr712007b3a.61.1782764375358;
        Mon, 29 Jun 2026 13:19:35 -0700 (PDT)
Received: from localhost ([71.212.202.210])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-847a0007464sm316121b3a.23.2026.06.29.13.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 13:19:34 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: paul@pwsan.com, aaro.koskinen@iki.fi, andreas@kemnade.info, 
 rogerq@kernel.org, tony@atomide.com, linux@armlinux.org.uk, 
 Haoxiang Li <haoxiang_li2024@163.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260623072534.1997680-1-haoxiang_li2024@163.com>
References: <20260623072534.1997680-1-haoxiang_li2024@163.com>
Subject: Re: [PATCH] ARM: OMAP2+: Fix a reference leak bug in
 omap_hwmod_fix_mpu_rt_idx()
Message-Id: <178276437440.1055800.18333324347324908320.b4-ty@b4>
Date: Mon, 29 Jun 2026 13:19:34 -0700
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev


On Tue, 23 Jun 2026 15:25:34 +0800, Haoxiang Li wrote:
> omap_hwmod_fix_mpu_rt_idx() gets the first child node with
> of_get_next_child(), which returns a node with its reference count
> incremented. The function uses the child node to translate the MPU
> runtime register resource, but never drops the reference afterwards.
> 
> Add the missing of_node_put() after of_address_to_resource().
> 
> [...]

Applied, thanks!

[1/1] ARM: OMAP2+: Fix a reference leak bug in omap_hwmod_fix_mpu_rt_idx()
      (no commit info)

Best regards,
-- 
Kevin Hilman (TI) <khilman@baylibre.com>

