Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792442248;
	b=CSqAG3RFafjdUJAupyMu0JTZ5iYxACAtX4PWqGm1l+4knqz5kyMUFR11B1W8h/EQFhJa
	 z4nwHe5LTd5MinJOKXjw5hLo2p/eXwSUC2o8o5RvDPPw/8QGoRf3AqNfqScw7j1ta+iZ0
	 mhmF6byoOJQU/C7DZeA6FeVDXfi3FIx+3ksrIT9hE52Cr/XegnfNm0zMPkFoDS9iiZWf4
	 l3ZLv4GPDgwaSEUpoQgGuk7GVlU5O7GZ5ZXSDRiL7orywKM8Hn4V25HLWEz9FjzTddCFq
	 s4ZXOTa/HJIID3cvMmMTX+F6c/SSQxBB5tVMSoqeMIXaX3GhYBdw/IhWhf7rduZM+Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792442248;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=OlQWf86SXokSuh4SBBMFiqlQD7tg29+MR0deKhyYBLU=;
	b=DfalS4xYR9v9VlT8Heu9LYxupi3F2+nK2Z7wEb96r8WazDWZWDY28Q1mLnVFnTGS2Qcg
	 z+dnrMyWOyZOlzBANWCzn5JNPYQmxnuXjZ5mTgkjsUcCUHNlDVpK+SKXi7XRTme5svFjW
	 kOMxAUrL57a9j5RHJJEbTNeeFitUmODX8YkfXn8m52V9tHz4IbRpEs0dhWXEmSXXagHow
	 uqlBM+R8jZ/pKCu8rn1HN54SompybjCnLVwugnAvhrQHEbaeC0htyF2ltmvNIgY7zhzOY
	 2IUADh9FAEfcmQjtFQeP3xVQOu5/7+3mjN+OBhMEZsHHsq3iThyJb/zK+ybjgTVOsmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TbdVKbnQ;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03035606A321
	for <linux-omap@vger.kernel.org>; Mon, 19 Oct 2026 20:37:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03035606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TbdVKbnQ
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a021c809e3so22302825e9.0
        for <linux-omap@vger.kernel.org>; Mon, 19 Oct 2026 13:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792442241; x=1793047041; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OlQWf86SXokSuh4SBBMFiqlQD7tg29+MR0deKhyYBLU=;
        b=TbdVKbnQRRp9vEsLOXaAXOe8RCtxTDKUbwKg9QY2mqDPSPar/3P4WhNaodDxDY+BkL
         z5fhNg+9YEHPJPYwu73YuJ24D3oaA7K6HDZKf5aH+c1Pe/B7GdlWJdKoI7eTwRUs+eNR
         XWTT2Bvx1AyIFnoplHVTcghLleDAmLt5NYnTajZ7eY321BIDTd3dT989KlGwDKD9NDGP
         cr4C9uSJVWcYwgvwncn6c7MjZTP1GInixxG1DDJuJeIPCWhUwBxCX3CPl8BcL+65FzdA
         UkvSpS6m+3pS+D/8aBkplRzK1r/Qv+7uSg5JACP5SEL+A+he8lOE68px7ghnG77sVgpW
         fEuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792442241; x=1793047041;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OlQWf86SXokSuh4SBBMFiqlQD7tg29+MR0deKhyYBLU=;
        b=CufZasc4fd/1V7ebATf0NIA6kFS6NNFD4Sm2MT1wOsmgp1Q+K6B8g93TZm2T23aD0Z
         PDNMS+BIyWikC/L5+mmpmNctvbW73o+KimZU6Gcc9eCN/DWwSmrd0wtHAzWfSK5scgU9
         /qTFNKtlmGlNCdTTe//CDVKN5qm3v0GEkA4Mp6k+ToTGhqpVKT9udPQPoiH2QiO7Zaiw
         cJ9SDpiS2QAxWnl47QBydj4TjzfdAYiAKo8lE53m1gS/bCHcOHDkdfj8atziHtUXneJQ
         CUsa1u8e7QPBzmt8sUzc+RQ1/cToD5eHKK8jbG/nYGhOc2nO/84qBTvpIYgnq62K/wVq
         EvAw==
X-Forwarded-Encrypted: i=1; AKwUvByM9yHuw7c4gQrs0gHai6sZ1KngqLsMQHBO3BFDYWkRsq6Sa+DhcWpn7vk8L9kWUr2CLBEfE8Ztp+Xp@vger.kernel.org
X-Gm-Message-State: AFq9FYIRcznbl12zgBByMzZ0Viy3m7kLNboHFm1l8wNxxAPVzYEOY2rg
	w9IakwrlAd6eBOUlY2ofb50HzdRs0EfUskgBko6SL1KLRK/zB8bSbRuN
X-Gm-Gg: AYBFou1UPHaaHXkwnL7KjF/gERB2rZEmET/8lqsqKfyaK8gU9nq6hI2M8iCkFnEb1Gg
	nLNGgev4JnAvW91MaMtf1FT5LDNJZAJXBZtAiBsoVAywwno+BlZRv4zp9+haEsD203Alwn1P569
	qAi4P6e2cCF4Ei5Iqd+v1ZlwQzkAZdyyIZVh2NTr6TnLd+iRaoAFqlzs67NM5noHN92AWhLiwaM
	S/rEhd5ngwOg0G1wJOVdmKP1SorSAKJJ62WV6fNct4recTvPskiH+lxa3X7UpvDi44ywT/mjy9f
	Q2zJ1adr1Kjy7XVlLcn8EKdVFifniEyyopb+WUJ6biT6rsYRkWE031qL8prLA29iEcj+3QUOzL9
	rI7jzAVtkw4cUhHH6i5DTSNMTjsyyWZ1jPRKuJt4Q9ofJTdM3D9HAfDr1sSl0vhp12C8h6cvRsx
	XNpNodMRxL3XkXgGjjZxdG/kkKglU9W7HY92flGK6TJkd3cAFUXHg6rZ4Si1vVLs64LypOw8IIX
	FcnAboWuR4zIKkDKH/ra4L6b19PC/Z9UTPlMbrJQmufWWnRL1ovSxWpjtxEWJ/5Fi1W5/+mHGje
	q8vHpx6866vSDx714SLrTzBBK1vubuZjCk5GkUFczN+SnsYv9dWNd4jCp2GQlSWyz+Bel1xM8oE
	eg56jH/e+
X-Received: by 2002:a05:600c:3e85:b0:4a1:d798:b08a with SMTP id 5b1f17b1804b1-4a1d798b0d4mr175531195e9.21.1792442241144;
        Mon, 19 Oct 2026 13:37:21 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-a4e0-4601-c43a-536a-04a3-af7d.310.pool.telefonica.de. [2a02:3100:a4e0:4601:c43a:536a:4a3:af7d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2c9e9c3sm15967405e9.3.2026.10.19.13.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 13:37:20 -0700 (PDT)
Date: Mon, 19 Oct 2026 22:37:17 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: netdev@vger.kernel.org, Roger Quadros <rogerq@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Keerthy <j-keerthy@ti.com>, Kevin Hao <haokexin@gmail.com>, 
	Alexander Sverdlin <alex@sverdlin.org>, Arnd Bergmann <arnd@arndb.de>, linux-omap@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: cpsw: fix netdev cleanup on probe failure
Message-ID: <atZ8lCW0VVPzoHwb@gmail.com>
References: <20261019060430.33254-1-kmehltretter@gmail.com>
 <c20d708a-f4d6-4e66-a516-056d93264825@ti.com>
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c20d708a-f4d6-4e66-a516-056d93264825@ti.com>

On Mon, Oct 19, 2026 at 12:19:11PM +0100, Siddharth Vadapalli wrote:
> > +		unregister_netdev(ndev);
> > +		disable_work_sync(&priv->rx_mode_work);
> 
> Although the above code is a refactor, it appears to me that the correct
> sequence should be:
> 	disable_work_sync(&priv->rx_mode_work);
> 	unregister_netdev(ndev);
> RX Mode work (cpsw_ndo_set_rx_mode_work) does have a 'netif_running' check
> so it might still be fine if the sequence isn't followed.
> 
> Please correct me if I am mistaken regarding the above. Rest of the patch
> looks good to me.
> 

Both orders are safe here. The worker and unregister_netdev() serialize
on RTNL, so a worker running after unregister exits at !netif_running().

This matches cpsw_new, so I'd keep the current order.

Thanks,
Karl
