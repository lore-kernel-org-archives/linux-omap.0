Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6331C4BB298
	for <linux-omap@vger.kernel.org>; Mon, 21 Sep 2026 15:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790006034; cv=none; b=RWw1eu3rULI9tPK8tKZfjxCm9SzziZ40ZNkUreWiZg3bYTdqaWAbWyIqZeARQfZ7cVpY571eYrkpDBM1ZblhOeTTBKS+vxq0nnbaIkTroNDpUXzC720Uw1e5MFviNPpqSOxk1UcDnzq+apyDGZOBPuueM6Wko8xLoXaGhE9RgNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790006034; c=relaxed/simple;
	bh=kAV83GG8Wx3vs0tpxEdTxwn0XZCNc0tZOHUrR9Lz48M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CUNpiKZP4NV+lvdopoGqfEP1QnksAg+9fBEwz2HaCGizSx+Rvzjwo8nKwmlfiggHlvWkWxQZrJSdFfM8FYqO/yfrRp16CoF9HGPekOFBpUZbViM1tQK49THKqv+fTbXTmoe1W/hDfaKcyPLICdcDcp43b4L1Eo4ZmxYzGXB7rYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=eUb7/z9r; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="eUb7/z9r"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d9004a1ac0so20459915ad.3
        for <linux-omap@vger.kernel.org>; Mon, 21 Sep 2026 08:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790006032; x=1790610832; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kAV83GG8Wx3vs0tpxEdTxwn0XZCNc0tZOHUrR9Lz48M=;
        b=eUb7/z9rRboiBmTpaCl6lc21MbiVYTqZq2BkuHUXMy9Qx+fjnMZz4Bb7z8d/uF2Ae3
         sT6WmYODcw0JVzrx7KxrQz4kFJ9Q5QYBH/IqEiZzxeO41MWHpaxFo8uQ6gb/y83kY2pB
         NP90W18zDe72xDHSnU3kKG76OQ0wDcb+Aqiz/atuxwrXdcg5t8RjpSF24W6IiaDErE2t
         VPuD5uClKy+m5MRUoNey4jqUD9zOxYKXxKhK+bO/fRcrzUMWgASfP5k+MOb7EZPjLhIx
         IcHGBNFRnSA/UAPQF9SrtFbt5/FJfbtqF+YAgEjAIdhAB7Kz2EOGo2WCHtpdijCvkjSW
         bOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790006032; x=1790610832;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kAV83GG8Wx3vs0tpxEdTxwn0XZCNc0tZOHUrR9Lz48M=;
        b=KMNUFxwUPQhMrbaV8xWoSHoAME6UzrDrVKNl2wVPXRabTHbTz2bVCw7hKfnvqRlSxP
         DD6plaFWYj4IhBtQcF09NC4AjbQ7ze/lV93zxRUquBiCtFbLAh9VMqIwfp92fpoQxNJF
         DWbrkNJiVx5YlBdu65zCNGK3qEeKKLonLi6Tr/gRPPtBTja6HKCrYLhfpvHSipl2i+f5
         b1U2DEzoGop5Ii53xmMHW7D7DmZpH3svwDk3j7piBOyESMkOMdfQX0Gd6+JgSIUq4bbc
         1afX/7kIZApWdXT70QW8rQBMR0qnzxnsINNIY47MEU64XVxlYgjCieeDyqihsccMTuiZ
         BKPA==
X-Gm-Message-State: AFuF++n8Y6kpkzZUF5BMiaLA8Oq/X1fiRSlNL4DgZJh5i/cqUIIppwnM
	NVqe6KiWEgEWCLJR4IbpCuODhTJzTxDQX/RmauvLarBAnua5tHTeMpE/J9vPfo3G+2U=
X-Gm-Gg: AYBFou1seocSr5R0/7qB67lsiAWIm8yJIxBEP/hfx3Vbh+hxwdBKuEfpuMt3ebYoOiq
	90VL9v2128EGL2pbx8/DXr4YMxaaUESO8ofPmb12PRxeCO5w02qeqPrh07p9/lGctabMUhEYh6a
	BIU2F0mrpynmoto8kOAH/XqTJ2QW/AR/7dEPh7GI9BBwy52Lrxie61Xj8TafdfytYdzCTNvtyWy
	q4t8CjvuNqCPnMjwfa0UcfBT5gOyUNrgwSFJGzmESF7ZrnJwK/DaHOoqjFyp0h4kc3Obco29Q1F
	4h0yu+5TH8qi62YEv/2THKDd9JkswYbJZDLCSxPaXuM1hZupbgvWWnT4ZNbX3Aj48SVgcEACtR8
	joKFTaz0N9TkarahG0BpEqh4hCyrf2iHPJMBYAShqKMmS25G/ETw3ct5hMzbgD+m09Ks4w2gp5f
	bw3HK+grBDiuW9rhN+1fQ7qBtgi2I5Tj/+fygMcRKs/g6txqdo9svNEzSadCQm+imNG5w=
X-Received: by 2002:a17:903:98f:b0:2dd:c053:e0f4 with SMTP id d9443c01a7336-2ddc053e132mr114905975ad.35.1790006031634;
        Mon, 21 Sep 2026 08:53:51 -0700 (PDT)
Received: from localhost ([71.212.197.238])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2ddc178701csm36425795ad.13.2026.09.21.08.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 08:53:50 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Andrew Davis <afd@ti.com>, Tony Lindgren <tony@atomide.com>, Vignesh R
 <vigneshr@ti.com>, Andreas
 Kemnade <andreas@kemnade.info>, Roger
 Quadros <rogerq@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Davis
 <afd@ti.com>
Subject: Re: [PATCH v2 1/8] i2c: omap: Drop bit shift for I2C register
 addresses
In-Reply-To: <20260908154223.116074-2-afd@ti.com>
References: <20260908154223.116074-1-afd@ti.com>
 <20260908154223.116074-2-afd@ti.com>
Date: Mon, 21 Sep 2026 08:53:50 -0700
Message-ID: <7hzexad2i9.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andrew Davis <afd@ti.com> writes:

> The OMAP7xx devices used a register address shift of 1, but this device
> has long since been removed from the kernel. So now no remaining board
> device uses a shift other than 2, and no DT supported platform ever did.
> We can drop this flag and use the pre-shifted register addresses. This
> simplifies the register access.
>
> Signed-off-by: Andrew Davis <afd@ti.com>
> Reviewed-by: Andreas Kemnade <andreas@kemnade.info>

Acked-by: Kevin Hilman <khilman@baylibre.com>

Feel free to take this with the rest of the drivers/i2c/ patches.

Kevin
