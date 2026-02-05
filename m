Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027A21DF254
	for <linux-omap@vger.kernel.org>; Thu,  5 Feb 2026 19:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770318223; cv=none; b=S7UPoVxpJarMLbQWp/ETk9JzZXL/xhLKo3P//IM3NwNTAJhS8usCMYKO/qUozLmyw1p1VgaEn612Jtu+elhXW+yRkSoTp1gsfCmvtml5BdFzaNmCbi7OMqD0+j4zlytz3iGQ8B9xQHxpoN7ZAYXsHr8IHZVkhAEntqz1+bVDlaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770318223; c=relaxed/simple;
	bh=mTvvcXgDBvcbR8q3T6BKAKNhHRfSg1JBnMWu7iWUrgE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u8G92CP9CtX/+FvS2jeKMpB30Og8AEVp82guNrMaFiwlUxJ+rwrwPnNlZsWuYWNIdjM/Z0vG4uLLUgNrcKgxCVaILmxkAURGGVYEBiOl3IQLXr9hjfMvxPBp3Nvn4TKR9FX0/2CRHV50cRhKa4fE+hCOcJgCW1eInskBe4/hS0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fK4lD3Ew; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fK4lD3Ew"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43596062728so1737854f8f.1
        for <linux-omap@vger.kernel.org>; Thu, 05 Feb 2026 11:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770318221; x=1770923021; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GtNGjTQpUi+skXrIS19K/ys+bSMRdS9DMijYI8S5F3k=;
        b=fK4lD3EwIiiK2/QUVPnYjNHV9gCm6zN48hBR3/s5jrQPxsDEl+47PJW9RBIj2dXOfm
         WuV6MQaGKlulMIm8KGHMAKrlv407WMDDFcTAb7IJrf7PXH4JgGiffXWrLkgf3uLIBKo/
         NQaw0IdVxr1TFP9HXo7S5ruEhgpgRi1+eIGDIzaX2A0tR8r4veyipocTnoc34FfiwMBQ
         nYHJsFunr8AGio61NCC00PFIigz9+8RweCBtXhDh/FHxq8kLTP0Cxm6ede2tHxZ9cKFZ
         GMCqrCPOS7b1iqziYOyh6pCNqa+v3Wh+jSy8gRcZRJ+uJ6igwPYi+yKa006aUFl02Yhr
         e/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770318221; x=1770923021;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GtNGjTQpUi+skXrIS19K/ys+bSMRdS9DMijYI8S5F3k=;
        b=fzjWSmLfKTlQseA4NCpIwq+rCtWmjYX6uK53K2u8a6IM1xc0ItxdopaHu3YS51wslo
         KwBoGief2G02pMR0vCSdZ96cQNTOgOuslLy5/z+VhFdE6zzPkyQSdfcFwaHog12nnwtp
         Jl1qQC/SavLM7dGvpt6hx7Ivnx4bwT9tITOtMMbl4qioHjD/ZuwjXXOxqIm5/jFuyOag
         TKf1uNezBjlsEcD49J8dkgaLNnrH6dazJhyCpfDWeNIEXxkGcHduPLBCf7MBqjuxeHuX
         LBtHf0utlH6oqrtRspPdoIUiEq51Lb/hCXnwapEWOidb1NNctubwOrc/Bt53D7odISf8
         ZzWg==
X-Forwarded-Encrypted: i=1; AJvYcCWkYis2P3NwdQcguqXdPNA/69cxWj2ivLsC4Nz1orm+ASFrzQ1brIuiLaV4lNIEZ7KX9u2IDRK7tPw1@vger.kernel.org
X-Gm-Message-State: AOJu0YxEnWbmDJng1nvwB6y7FVaL/tGe+ofduTx7DB2FjatcIJ89BlLg
	DSM4wKfn5bdBtIHgCOe9jp+16/BAampENX9wYUanlAWP6ldqf5hqO/XM
X-Gm-Gg: AZuq6aJ8xH0WfWtNqF13b5vIUUOmmW37jU9iIgRas4pA4HhBIqOrMBthjUzpJLXdCFU
	JUUEDIK9l4oZBeThV5C9hLSsfAlwtRXAmfWmHf/yanVpUttctxzBVvX+YzxoFVPwOj2OC49848e
	p4Ltv3nKfrLoCO3Xvr8vNARkPCYgIxpEVoIATh2Tl3G5DRUBnViJxoZb3zk2uKYpPMmdFIkscDA
	9uM1CR2XwdyycagXzcfnQtuth5npn5DGr64kInxrJHZGuWbk9pDOpB3HOVjBmd5W4G0c+oGRn8L
	EZOXL3K2ZZp5E1IoVS6XlFl/lsEmx+AWHtZ62SVWVty0FWh5lxv30EliBQM0dpA7eE+Cdb/9gVg
	0zoYuy82ynZpKCc7LniNRu9M52nzit+4ejXxcj5U+0vIS5qT2hCEfNt2RuxYc6WWJj/jURrFVkP
	Xoin+tPTEdxu1NPqVVOoCZXJgpl6+0
X-Received: by 2002:a05:6000:2210:b0:435:96a1:ee4d with SMTP id ffacd0b85a97d-4362933f3e9mr435562f8f.14.1770318221215;
        Thu, 05 Feb 2026 11:03:41 -0800 (PST)
Received: from giga-mm.home ([2a02:1210:8642:2b00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296bd4desm239733f8f.18.2026.02.05.11.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 11:03:40 -0800 (PST)
Message-ID: <a7bd135730919a8a5c5d4b2ccaae945c76c7376e.camel@gmail.com>
Subject: Re: [PATCH net 1/2] net: cpsw_new: Fix unnecessary netdev
 unregistration in cpsw_probe() error path
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Kevin Hao <haokexin@gmail.com>, netdev@vger.kernel.org
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros
 <rogerq@kernel.org>,  Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet	 <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni	 <pabeni@redhat.com>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Saeed Mahameed	 <saeedm@nvidia.com>,
 Daniel Zahka <daniel.zahka@gmail.com>, Lorenzo Bianconi	
 <lorenzo@kernel.org>, Nicolas Dichtel <nicolas.dichtel@6wind.com>, Murali
 Karicheri <m-karicheri2@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Grygorii Strashko	
 <grygorii.strashko@ti.com>, linux-omap@vger.kernel.org,
 stable@vger.kernel.org
Date: Thu, 05 Feb 2026 20:03:40 +0100
In-Reply-To: <20260205-cpsw-error-path-v1-1-6e58bae6b299@gmail.com>
References: <20260205-cpsw-error-path-v1-0-6e58bae6b299@gmail.com>
	 <20260205-cpsw-error-path-v1-1-6e58bae6b299@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-02-05 at 10:47 +0800, Kevin Hao wrote:
> The current error handling in cpsw_probe() has two issues:
> - cpsw_unregister_ports() may be called before cpsw_register_ports() has
> =C2=A0 been executed.
>=20
> - cpsw_unregister_ports() is already invoked within cpsw_register_ports()
> =C2=A0 in case of a register_netdev() failure, but the error path would c=
all
> =C2=A0 it again.
>=20
> Fixes: ed3525eda4c4 ("net: ethernet: ti: introduce cpsw switchdev based d=
river part 1 - dual-emac")
> Signed-off-by: Kevin Hao <haokexin@gmail.com>

Reviewed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> Cc: stable@vger.kernel.org
> ---
> =C2=A0drivers/net/ethernet/ti/cpsw_new.c | 12 +++++-------
> =C2=A01 file changed, 5 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti=
/cpsw_new.c
> index 21af0a10626aaf0ce6ecb04837899801743f3894..b9fc31eb06134dae33427eaba=
06341c39eb4b41c 100644
> --- a/drivers/net/ethernet/ti/cpsw_new.c
> +++ b/drivers/net/ethernet/ti/cpsw_new.c
> @@ -2003,7 +2003,7 @@ static int cpsw_probe(struct platform_device *pdev)
> =C2=A0	/* setup netdevs */
> =C2=A0	ret =3D cpsw_create_ports(cpsw);
> =C2=A0	if (ret)
> -		goto clean_unregister_netdev;
> +		goto clean_cpts;
> =C2=A0
> =C2=A0	/* Grab RX and TX IRQs. Note that we also have RX_THRESHOLD and
> =C2=A0	 * MISC IRQs which are always kept disabled with this driver so
> @@ -2017,14 +2017,14 @@ static int cpsw_probe(struct platform_device *pde=
v)
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0, dev_name(dev), cpsw);
> =C2=A0	if (ret < 0) {
> =C2=A0		dev_err(dev, "error attaching irq (%d)\n", ret);
> -		goto clean_unregister_netdev;
> +		goto clean_cpts;
> =C2=A0	}
> =C2=A0
> =C2=A0	ret =3D devm_request_irq(dev, cpsw->irqs_table[1], cpsw_tx_interru=
pt,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0, dev_name(dev), cpsw);
> =C2=A0	if (ret < 0) {
> =C2=A0		dev_err(dev, "error attaching irq (%d)\n", ret);
> -		goto clean_unregister_netdev;
> +		goto clean_cpts;
> =C2=A0	}
> =C2=A0
> =C2=A0	if (!cpsw->cpts)
> @@ -2034,7 +2034,7 @@ static int cpsw_probe(struct platform_device *pdev)
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0, dev_name(&pdev->dev), cp=
sw);
> =C2=A0	if (ret < 0) {
> =C2=A0		dev_err(dev, "error attaching misc irq (%d)\n", ret);
> -		goto clean_unregister_netdev;
> +		goto clean_cpts;
> =C2=A0	}
> =C2=A0
> =C2=A0	/* Enable misc CPTS evnt_pend IRQ */
> @@ -2043,7 +2043,7 @@ static int cpsw_probe(struct platform_device *pdev)
> =C2=A0skip_cpts:
> =C2=A0	ret =3D cpsw_register_notifiers(cpsw);
> =C2=A0	if (ret)
> -		goto clean_unregister_netdev;
> +		goto clean_cpts;
> =C2=A0
> =C2=A0	ret =3D cpsw_register_devlink(cpsw);
> =C2=A0	if (ret)
> @@ -2065,8 +2065,6 @@ static int cpsw_probe(struct platform_device *pdev)
> =C2=A0
> =C2=A0clean_unregister_notifiers:
> =C2=A0	cpsw_unregister_notifiers(cpsw);
> -clean_unregister_netdev:
> -	cpsw_unregister_ports(cpsw);
> =C2=A0clean_cpts:
> =C2=A0	cpts_release(cpsw->cpts);
> =C2=A0	cpdma_ctlr_destroy(cpsw->dma);

--=20
Alexander Sverdlin.
