Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794259230;
	b=vQUi2XEcdsb2KgWxSjwCk+lrkgRWY/Hokb7EoxzKtxVwScdWMCKkhPR1dq+sH1EHsd4q
	 0uSkuY4vPeZjszYXQrn3ASLe+W9BXvc2j6J2VBRdmfvc6YkCfOSefFdDaY5KVVbvkKna7
	 iNgMuxaFzqbE8Tfcr71l3gQKfxCk4MvHpI8eOBqhXOJAsRCCT2T8V9zIRbVcwhrjkInri
	 GdfcSp66TmEBcEqosEb5eH5La+DxEGji7u8U3e+OuJ/xjRDmkfnKHkP1fa5Qz7ogjMFhZ
	 xDPNAuASbkT/iQYwOrpBA1F19NFPPoSeIJVs8wzsUhIVKWXxxTfYGuQPJdFusYiooaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794259230;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=jhTFBrZbm1nKNNYaIDvPlXMHWrRMWNpq39pjf8IlDhs=;
	b=pU/R2hgwkcd56e2nQS/VpHdgWW4Ppt/rDJK967XVmZKRnoFI8gr2yHM+AXU7pgUzCXEa
	 V7JU+cMvU5VXVtu+nTWTUUUbtOL7JYfB4GZNc+CE8WDd94k4YdZvNuCx2eXdqZBMvdEku
	 ud230RL3v3Qz/yYfg2FSrqvYppcmn3qsgqFktzdbdUWgLEr6PCWVAsp4wyo9OEEbYcnhF
	 c0DOO/nvKaWwEnZQ2OKIpqwk4Nf/W9aE7QUi4NbRmoEqjFR31f7wkV6axrqDG2aK2h9kG
	 vBr7/fXjdJd4AwYwRNEY3VL8uGOSTDco/1nqojXHxAuIKUV3r7nZhooRq06Gm+iNj5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="g/Dodaq9";
	dkim=temperror header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=nvL4ojAW;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D3D606A31C
	for <linux-omap@vger.kernel.org>; Mon,  9 Nov 2026 21:20:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6D3D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g/Dodaq9;
	dkim=temperror header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=nvL4ojAW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794259218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jhTFBrZbm1nKNNYaIDvPlXMHWrRMWNpq39pjf8IlDhs=;
	b=g/Dodaq99jx9mwJyqrUEhAKUaEjGBGDre8t3/cqEp/Z5NduYxBsGnx7sTlWWbfevjHJc7U
	PMflXWIwUY8TD3ofwfVVi5VaAjglGF6hDcHLCd0Ud3iZhMyyQm0IzxMQYbu0YC9Gqn8QTa
	zEwkZFCEbKCxZGEbZaNnvdLsUBGzXoI=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-DaNfp5M1NiqJS0Eqb7QPUA-1; Mon, 09 Nov 2026 16:20:15 -0500
X-MC-Unique: DaNfp5M1NiqJS0Eqb7QPUA-1
X-Mimecast-MFC-AGG-ID: DaNfp5M1NiqJS0Eqb7QPUA_1794259215
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-8b342ff3967so21120027b3.2
        for <linux-omap@vger.kernel.org>; Mon, 09 Nov 2026 13:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794259215; x=1794864015; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=jhTFBrZbm1nKNNYaIDvPlXMHWrRMWNpq39pjf8IlDhs=;
        b=nvL4ojAWxrXG89Ui2evwQkpj4Vt0M0P4HWpUBwQov0ihCLpMM6dNoDqHWIasA0fyp4
         HOYZlTmGJXjZ6lEfq9VfTIFeUlBQcxqSRzn2XncQntUdL7A3MBjSt00y1xU4M5lnx8Cl
         YHGJF8HROCW9zVJvoZcZBdE7iR86exw61q36NzkHB4JtVmUjMXsp7p112M9PFZFytjON
         oB/CKDRkSBq3Pmhss5ZmbEjxSBeGkqMb7ozaWd4m4acgROrf4H14VZ1nw1YUWr+nGRHq
         V0bYcRyHqKe0dbU/MgM9aS1P/Zl0FfvlxEexbn49TtLsXe/N4auLRoTLOtppETb1nwyQ
         mwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794259215; x=1794864015;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jhTFBrZbm1nKNNYaIDvPlXMHWrRMWNpq39pjf8IlDhs=;
        b=EzN5GxcxSk/yh2x8qhJ0aElOBVMZaNHIKbl6wXK5i6alXXtKaHNKPVQicQ+DTh8Dju
         RG3Lrb4/eH6X16FjolDA/2FxzwMrj8qYArlG+1/BSByJMtgVfLf9ik9abubISgaQ6uS4
         j8vAGeEAFUNLa+Ou67rEE6A2F9+ORZrIbyxbMga3kpFD0eAwgKUQz4OJDU1PQ+hilSY8
         tSFWvCykMVWk1pJ+5610wvBBMho5/y5rewIvizx5TEcnQj7IvDp0UeCr0rOlydqrxo3P
         9CGLNm3v8es7l4QXdEoVQUSCDj9MNT0FkEcLi1LO9qcXDL18wwm9L+R6ijLZyEjs7iMO
         Df5A==
X-Forwarded-Encrypted: i=1; AL+hErFXFATWpGWBZtr9fqVDQKP/P9yht30xjfNAuvdYpmpcSeom7x6+Y1hmwqcwbo1sRjhxFvbAO32CEOXp@vger.kernel.org
X-Gm-Message-State: APuU4Z9lxU5RBPJiv6PtpoGg533HkV9Z7cdV9ymEXNWqd4WSt6F9AznZ
	Y7susIha4NF9ry/RvETc2v3O6QOuXojk7YHCYUHA2uycMSpYlKr4HINTSTpgAzXnlSAOZKrjEJO
	Z5h0gcM7Lt9temxzzmC0mCGFXFID9GDIxRQAQMjoJ5SDuQbYsVSQdapt6XBbBbYE=
X-Gm-Gg: AYBFou3+GqzKRKiTYLUdQ1xKD12QNaKeNOuF7AjbbnGBxmfYxj2L719YT/bcwzcmbYr
	MWFFkzWHOMiW2glp1pRqkN+RV5ltVbtIQ1JfelWHc+wsq8Ad6QwUHOs6KKiV1v2SUMr1TdYKP3H
	VO7JLxEPTnFIs3E4Ion4zVq1kLPBSFkDuhEKlv9Faa0zZz7Jr8cox+cmU/m8OjLzOCKEDQzYiGX
	pDHmpqfLKFddhCjeOcx0rKlc9ZpM3weMPIxieUlNizfgdra3IqTdbFhCX328deYtWh1JvzTrf1k
	5EFajSHkeRZi55WdTFt0vVzgovyCLKUsXy5qR19UAx24lQ7yeTPvW4jTOI9ZrRuIGkM5LblFUNa
	fkveN2KL8nHSvw3S7leJ2cB7rW5J3pcaDymairf9B0HlT/z2SHX7DgqbeKSiX17eFvfnLYhs+61
	SD
X-Received: by 2002:a05:690c:a055:b0:8b0:d468:e9ec with SMTP id 00721157ae682-8b392bd0c0emr2841657b3.105.1794259214835;
        Mon, 09 Nov 2026 13:20:14 -0800 (PST)
X-Received: by 2002:a05:690c:a055:b0:8b0:d468:e9ec with SMTP id 00721157ae682-8b392bd0c0emr2841517b3.105.1794259214432;
        Mon, 09 Nov 2026 13:20:14 -0800 (PST)
Received: from redhat.com ([2600:381:e227:64a:814:7bae:8aaa:cea9])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b3933c59cfsm3832747b3.17.2026.11.09.13.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 13:20:13 -0800 (PST)
Date: Mon, 9 Nov 2026 16:20:11 -0500
From: Brian Masney <bmasney@redhat.com>
To: Mark Brown <broonie@kernel.org>, Peng Fan <peng.fan@nxp.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Support Opensource <support.opensource@diasemi.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH] regulator: convert to subsys_platform_driver()
Message-ID: <avI5C2UFcxKF_LoG@redhat.com>
References: <20261106-regulator-subsys-v1-1-1f91f4204bf5@redhat.com>
 <1b56983f-f88b-453e-bd8f-8189c3f79d1b@sirena.org.uk>
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
In-Reply-To: <1b56983f-f88b-453e-bd8f-8189c3f79d1b@sirena.org.uk>
User-Agent: Mutt/2.4.3 (2026-10-09)

Hi Mark,

On Mon, Nov 09, 2026 at 07:14:12PM +0000, Mark Brown wrote:
> On Fri, Nov 06, 2026 at 07:28:46PM -0500, Brian Masney wrote:
> > Reduce boilerplate code in these drivers and convert them over to use
> > the macro subsys_platform_driver().
> 
> This doesn't apply against current code, please check and resend.

I see that Peng already posted a conversion for regulator. Based on
what's in next-20261109, it looks like there's 4 more drivers that can
be converted based on what I have in my patch.

    drivers/regulator/qcom_rpm-regulator.c
    drivers/regulator/qcom_smd-regulator.c
    drivers/regulator/twl-regulator.c
    drivers/regulator/twl6030-regulator.c

I'll post a v2 with just these 4 drivers.

Brian

