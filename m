Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794203244;
	b=4shbgbidK96ynKaM/9g3uum9ixprKWK6ivlmCUApN8CBYA4fKjtYBeXm52TF5+rfTY0J
	 1wgaOoNHu5VZ1hw2St3r+7LUHV0qkg3d3ZztZxvLtEnjMyEOnaxrhx5bJtwPqwnC+mW02
	 U80ikkfv/POirtd9FKjZLPuYc2522QaTx4LYRrqD0+xEeuYKaxdHGFY3ZZA+wd2aDeSiO
	 yTvAm6WE6HoKsYA1Hd4uz2XMItwVG0avWo9ceg7mwy8+7cyyDGGw7x7GSH0/m3CfrFP5r
	 bsK15IitTizxV1LN5getPwGZ/Br6wTJE5HAbOK4QkgCGmv1gT3sLhqvEVoEcP0AggcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794203244;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=byaI0cUQu2T0+QBNSGRsOncWnFfV4y3lh2H71TsBHYg=;
	b=CeIRd4vlnreMytdicEB4XqCOSx+KdpePn3kWiNCq05hHartm8+PyWSoONJmbNMIsP0tB
	 Q44jhPq71FI3NsnZXdAf9QeiyB7sYZ2HRlOXf4s3IqkuDhvO6bCcW3NXbGIRVutuxCzkb
	 Tw1OwYvo3d2niPVYlursG56leikiMMTupB4607afIeavCoFOZW1SmGt/2ttfEyxrD6MHr
	 0en5sgBK8bkRKumnexFBasGxufaxecOAVoojUCZkoJXVfWKNheu8gtjcw1EsIFf7FBOKg
	 hO2VqTHiB5IfiVM7N1SGYQ/2LhX5WdbU76oHKCaKKyRKZd86/qUzcysZAsPxch1YU4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=06dYORPp;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E03F606A31C
	for <linux-omap@vger.kernel.org>; Mon,  9 Nov 2026 05:47:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E03F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=06dYORPp
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4b4571ff080so5537145e9.1
        for <linux-omap@vger.kernel.org>; Sun, 08 Nov 2026 21:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794203242; x=1794808042; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=byaI0cUQu2T0+QBNSGRsOncWnFfV4y3lh2H71TsBHYg=;
        b=06dYORPpzojU2j2eWqVP4SeEMOaYCTvlFbcfvSI2ITWvvxv1I/yXkxZQXoZ4VWAZxj
         xkkiVGsuZiE3KkukRPUwYlYbmaSWqi9S0WH7ucuIMsRY42DNbFP+E/+uFpUSNHOertRC
         oDq/DdqmYyTDvpZk0nnlrk2u5wIPKiDJlcBm7CcF1wTPtXqJpef16AQpu9tMIXBUcO53
         TdN/QbM5CWzBaCSV/FMJWYYYxpVLbmvzcdL0hS94Ho8X0hLUNMGNl/31Rq1yWBqvuLcM
         Mq7llBlAclB0TuNmx+QE4BRFloNgcdoAARTfIZM05QBOZyDBJOUWZzCZ5j5FXKqkZ7Gl
         Wz6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794203242; x=1794808042;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=byaI0cUQu2T0+QBNSGRsOncWnFfV4y3lh2H71TsBHYg=;
        b=SWnqORmVJb4X9zkPhoF4eawwX4QBq1hWe338UG6PqPb7IkQsnKIZ2M5r6IsIqeGNEh
         86aVntrHDkw06zraZJfX+Zam5/D5hxdUOxQrSqlz1GPZtjYxqXyJOSWvCUsOH3gxahVn
         vdV0pvMdi7T6SWHmb8+msP0xergb+zuGkjRF/uX0uQlr76wJ152gFlp7ZnvL6odGPg7p
         jbxowGlNg0Oj/1uJAeT9D2wIKb7vSXSh1lrFH8pySXmZO6cLZMU8F/OGGbKXFjTGM22T
         OidZKgOweSUs/rzMVXN3wGNP3t29rOZDGUfndlV8Qmlgu+AvWuxqqBIFm/B1XDkYF/pg
         gZQg==
X-Forwarded-Encrypted: i=1; AL+hErHUmz88XKXUzxZLwdRZKNrwI8dlMX9nyik+62Jt1dPWj3X/h4trnGo3LOqVNjZ5HOPzVDIzWotbRNWT@vger.kernel.org
X-Gm-Message-State: APuU4Z934xaagtyCUw3zHZxttccfV7GrM/U/+PC6xzrTmKBSSiRxIrjk
	Ho5zkXRI/ME4f49wsqKkbcLiHGHfbmUUxLnQUMjO555aV9Ky7bLlaavb
X-Gm-Gg: AYBFou1HsBfQlrFQjuirq9RhZBrWeQEkE1tH/RxAYSiTw4Tw5PaVkmHr9Yr16+FFDMF
	Zxw32Fg453yQ/QTbMBK2cGwGLghseDOXLhQRN2XKVcP8J4/lvfsxrgUmFS7Iuu43p38t5vzGoK3
	vTs6eT0z579M+7u9JKSf2ik7jHdoUj2AcKKaixhx4aBa6FMfiDqJuwfIRacdBllCkeFbkD41NIC
	p2n3DOcfaqsukelOm5HvRho6j4kAFO4Ne5o8vPMb200XzrYz+sfiHI81tjuokETLyqFUl9HMWzT
	vCAP56kc/AKdx9PFbIL6D9PuQH0xdLhBFPv9m2Nc/mPd1zqNQrrVmWF0WkA1mmzY9232/Jjgd7f
	HCPuIIKnrIG2f/46824Irb1mRb+eGFKLFCslnJM/0ybyEnufVdkoAf+Deak+fD7dwwEYJceNM78
	Y5P287fPlpu/rOhBLRIwxc5h62tUugeVJr/xkDalVqhM/YMFmvxH5eJu6WK0DA0eP8n6SmkaQqh
	d9SA2oRcg3cNnuWzep8AUbEh+Mrz7khn89t4quh12GGwCls0grmgr3aDNB4tNSbhHKrkqUpR2ch
	+EsSd2ltgIyNgipvCefzmZJxTYiDx5q02YyyzQGSCb1rHHJp/09kgcMOkm8DoXOy3nS7ikr9xuR
	nbITvgFBdUdXWzqYSmMCBr7/T9tsn44+zMf7z1vNiXgvWekiaY+3lmIn039RRK+baoW3MHJELqb
	bC3welV9GBELo=
X-Received: by 2002:a05:600c:83c4:b0:4a2:a9:ed87 with SMTP id 5b1f17b1804b1-4b963c6a8ebmr57095265e9.19.1794203241970;
        Sun, 08 Nov 2026 21:47:21 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b79501bdedsm130008445e9.3.2026.11.08.21.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 21:47:21 -0800 (PST)
Date: Mon, 9 Nov 2026 08:47:17 +0300
From: Dan Carpenter <error27@gmail.com>
To: Jiawen Liu <1298662399@qq.com>
Cc: Andreas Kemnade <andreas@kemnade.info>,
	Markus Elfring <Markus.Elfring@web.de>,
	kernel-janitors@vger.kernel.org,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Kevin Hilman <khilman@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-omap@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: omap: handle clk_prepare failure in probe
Message-ID: <avFeZWgJgID5XA43@stanley.mountain>
References: <tencent_B4F504456790E8BA3C4EAB80F4BFB6954E08@qq.com>
 <20260820154323.0a7c7929@kemnade.info>
 <tencent_A1BF4495D1F5E54524907BBA2A4ED480FC08@qq.com>
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
In-Reply-To: <tencent_A1BF4495D1F5E54524907BBA2A4ED480FC08@qq.com>

Andreas is the expert in this context, not Markus.  His suggestion to
use devm_clk_get_prepared() was a good idea.  Add a Fixes tag but a
CC to stable is not required.

regards,
dan carpenter

