Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505C13C9EE9
	for <linux-omap@vger.kernel.org>; Thu,  2 Apr 2026 19:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775157221; cv=pass; b=ZIln/idxbEk2hAgjGGaMw8drokVuhxUFNk2Y865NDUjwN5hKImGd2TNI9I2QqihgP1Dtb3040DmHujVMD0iBbN6YzegA7KX0PGWDIAHP7CBMnYkNG4NPFIJN8kym3HqbZ1LK4N7h5dnexgEt8T+3C54F1L2r/bHr4xkRqEKf6s8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775157221; c=relaxed/simple;
	bh=kbdroWpZEMKTTAqDWbBammpetQN187fleojAyiGM9/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OqAojM7/bLmlYu/zTf89sQ5QyOfoJciOPqiM0XE9BHr1aUikfzXXDHhrVFeLEYVaxhqb074xooZjyDo7lTnUsH3VcFoaMeoj5g6MHkuu+6m5L3cJLHVYUbPRGLgm6R7XjdO6Frx7R5YFtd0hTrqezj71h++YFH31VZDz16JZ6lM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TpYatVaY; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TpYatVaY"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-65006c99d38so1346674d50.3
        for <linux-omap@vger.kernel.org>; Thu, 02 Apr 2026 12:13:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775157217; cv=none;
        d=google.com; s=arc-20240605;
        b=FhgHl7dkQivBcZ63USfqVMd5NVUOer/A3mGQPOwR6hUHtlQZ68W28EDP8uAGQ66etH
         RBLVo2HAFIwrvsCa9lpKmJESuYs/yVleU59IqWVDd+xCApVDr3M8e9gYT0ATfsssMuvn
         dfi7k1/FdlamqUtbdwB2QeJMKnAQRJDPKYSsLxK578MmdMK8p6WIQ07r9Pzrho0T13ty
         P6g8YBt7E+9dKCS7iFTg4KZ666BObrc4MONVMd6E+K/gJsUSI1XHT/i+86iVjOVOb/ON
         dmRCEm/wLHj054r1i1XlUUPvkKIiPfvH/zMn1lrUG7EQGvZebNjLXNW76XDoupXgQ8Us
         Rpww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=DTIBlLEpNAQHphhX4QRSQjCX/tO4T/H0V6TBXe0t2+c=;
        fh=PpnZiSJ7UDMT8kAhaV6cDtWZcSEBT9erqXMbVbCspXQ=;
        b=ARPo5aCrj1StYxxNLSybtY6ax70v07EKaDFAKua6nkhwpH+9ohng4qVtQd4CtWkm3Q
         1ctAfnHhVKFSOPvRvJgX3hht+wUbVff9fr7LsnYwHC1DcdnaMrRIJAhQexDYRQWYaJ5M
         Wr2cmpOC1tcgg5IkqfZ5Pw+q+JLXMCpzF1UDqKjPPDk+vlXbE6w0Jy5xmbcGSnxjONhX
         rW95G8e6ufyswdNkN2k09jwAe2Idpe2n2O4vIGWXqqIpfyJo4FXG7oZ/j560UxoM/eGN
         BqrQnpd+SxHzFmRwIk2tohsicG6Kr08pzRSHL4oIcgvDIXalAJiK0LlL0Cr5Iy+45van
         0T8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775157217; x=1775762017; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DTIBlLEpNAQHphhX4QRSQjCX/tO4T/H0V6TBXe0t2+c=;
        b=TpYatVaYkkQeIEdZCcGBDTWfoKuHi2HXU6TqpIt7ml8i5SOtJK1FWg0fOdGSVEU87s
         RRChXnic9ctQ6IZY53FxXZgajBsHs7tOycL6KRAQBqkmXn3qOkOgfJuZezx/He1S5h1U
         /O8aWJNPU3y8dE4/VrWSG4aPIs9lp5Hhr0FTT3SRVRr6RvXj9rY/i+fE10F1VwH4WfdL
         w9kUxJhm59bSqWHu/ek92WupZC1x0ILc7GHdkk8Bc+7P8fj7oAPGr5Mx66/wXNb+dtax
         5+BkDdfMd48QaAYT6lK3Kveu9C56pkqljzerxMuSkrVQ+fOxbCd1eUMhLAS/WUvFPQa/
         gbRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775157217; x=1775762017;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTIBlLEpNAQHphhX4QRSQjCX/tO4T/H0V6TBXe0t2+c=;
        b=ddqv/kn6J8ba0k/1fzmnqGA7xvfs0FmuMba+ywhse0T6QXF2gLPUow5DizbzLzeLzP
         XOLFBPrxKQD/jka8LV1y48PWRZgppU5pcbSmJDv0TujdtO8U9bzX/mSlPJ9z6wLFIbPQ
         LL1eFVnL57Ze/mbgupTTbTFdbZxrjQ/gWXeIfEb+cxZhYD9ZcOYeNrE92NyK3Uy0qNEt
         tyPikRieQkE+5Y+dIGbfpDYIfGq3IWD7L9jD6z6aPoDmZMQmta+kEKT7ftT3p7eThNui
         QW2txbJhWcrun4RsRWmHQeiceaHDSQyG5iHkT5c4gWhM5oxU22Lmibby5eKPNg7fh3YU
         2NEA==
X-Forwarded-Encrypted: i=1; AJvYcCX1XV6tMf+zBsdGmMJl16KizVf2bA3d422bAAazGIZg0JhGRpzKDByo26q9hA0kXuH4ypYsNe8id4Yu@vger.kernel.org
X-Gm-Message-State: AOJu0YzSp0Nqqc/XsDi83sjrDsdrsLioQUsutMgSF6RFwFBzxG8XgYBm
	7k7ba0O7JnvuISaJN4A+kzn+H+VdnvSuP3t+Iv5Iw+3hm4lHh7rmOghjNVmcwyEqG1NuFL3lwAL
	NBBWiuseW3aFIYmHVQ/rilgDn1SOQXO7tS/UrxgnUJg==
X-Gm-Gg: AeBDievqy1NX/zSC8hMBpYB4r0GvQi28pjxXVRW3QK5590gsq5oUE9Wt4hT+vbxgVzj
	5xVScsLmQxwpSPG+dc1ZQNkCeHPEWnu64oKNMosOuXyy5LiZA17MKkEJudly6hI4/7nx8Rn7j1b
	BMuEy1Mi4z++BfG+g544EwHwiAU349NsonPP0bu1qYIPneHorQSsipkF8YKLxXM+/kha50Rlj1v
	o0yTWtD6+EnU2Clhdpex4YEzHwegOQw4IZfldABLKScUGsVxwA2lH1auB69oksZF0XV7bIvnMhj
	tm3+cbD1OA162sFPbLpRQAYQcewSYY/ESPq7HX8FvKu98uCNFMC+MAAeGEB1BfygW9pSnEdAvfg
	LqN3krSBwZy38vZlxT3W4P8PtWTOGDvZpObuzNT/9hRWf2N4K1B0N8M9M8d2kR00rPd0MRTpHBE
	aTy6D/Y0DvnG94HL0dRj9IHDU4oJzn5JvSi88d2cSOE0dsmSBUx6Tp1iDGpcpX3IPQr9/+RYFlC
	u6U4uafqFllVo6WzUUquRaexCOuQmUYja2Lxr4dOqIGVbGA7pT2x5gGyJi26Afs6qKeV3vt/gCO
	74GO0CyxsP3Urs6Dqd/4CpnrT1qtn8DzCMEbTe58rH4=
X-Received: by 2002:a05:690e:4142:b0:650:367f:7f3f with SMTP id
 956f58d0204a3-6504885f0a0mr104144d50.50.1775157217199; Thu, 02 Apr 2026
 12:13:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402184726.3746487-1-arnd@kernel.org>
In-Reply-To: <20260402184726.3746487-1-arnd@kernel.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 2 Apr 2026 22:13:00 +0300
X-Gm-Features: AQROBzCYBRGvnozxFzTvK5IcNSvZvT_9cSUVFQZZjVD30n0NBtqh91pIYRAmGH0
Message-ID: <CAC_iWj+vjZ0WnKUuqeFfaPeSoj5ovxZiEmUD5R8hPsRfkqMihQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] [v4, net-next] net: ethernet: ti-cpsw:: rename
 soft_reset() function
To: Arnd Bergmann <arnd@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Grygorii Strashko <grygorii.strashko@ti.com>, Murali Karicheri <m-karicheri2@ti.com>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
	Ioana Ciornei <ioana.ciornei@nxp.com>, linux-omap@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, Kevin Hao <haokexin@gmail.com>, 
	Daniel Zahka <daniel.zahka@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Arnd,

On Thu, 2 Apr 2026 at 21:47, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> While looking at the glob symbols shared between the cpsw drivers,
> I noticed that soft_reset() is the only one that is missing a proper
> namespace prefix, and will pollute the kernel namespace, so rename
> it to be consistent with the other symbols.
>
> Fixes: c5013ac1dd0e1 ("net: ethernet: ti: cpsw: move set of common functions in cpsw_priv")

The patch seems fine, but why the Fixes: tag?

Cheers
/Ilias
> Reviewed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/net/ethernet/ti/cpsw.c      | 2 +-
>  drivers/net/ethernet/ti/cpsw_new.c  | 2 +-
>  drivers/net/ethernet/ti/cpsw_priv.c | 2 +-
>  drivers/net/ethernet/ti/cpsw_priv.h | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
> index b0e18bdc2c85..aa3531e844e8 100644
> --- a/drivers/net/ethernet/ti/cpsw.c
> +++ b/drivers/net/ethernet/ti/cpsw.c
> @@ -706,7 +706,7 @@ static void cpsw_init_host_port(struct cpsw_priv *priv)
>         struct cpsw_common *cpsw = priv->cpsw;
>
>         /* soft reset the controller and initialize ale */
> -       soft_reset("cpsw", &cpsw->regs->soft_reset);
> +       cpsw_soft_reset("cpsw", &cpsw->regs->soft_reset);
>         cpsw_ale_start(cpsw->ale);
>
>         /* switch to vlan aware mode */
> diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
> index 7f42f58a4b03..c5be359f3c66 100644
> --- a/drivers/net/ethernet/ti/cpsw_new.c
> +++ b/drivers/net/ethernet/ti/cpsw_new.c
> @@ -573,7 +573,7 @@ static void cpsw_init_host_port(struct cpsw_priv *priv)
>         u32 control_reg;
>
>         /* soft reset the controller and initialize ale */
> -       soft_reset("cpsw", &cpsw->regs->soft_reset);
> +       cpsw_soft_reset("cpsw", &cpsw->regs->soft_reset);
>         cpsw_ale_start(cpsw->ale);
>
>         /* switch to vlan aware mode */
> diff --git a/drivers/net/ethernet/ti/cpsw_priv.c b/drivers/net/ethernet/ti/cpsw_priv.c
> index bc4fdf17a99e..c6eb6b785b0b 100644
> --- a/drivers/net/ethernet/ti/cpsw_priv.c
> +++ b/drivers/net/ethernet/ti/cpsw_priv.c
> @@ -275,7 +275,7 @@ void cpsw_set_slave_mac(struct cpsw_slave *slave, struct cpsw_priv *priv)
>         slave_write(slave, mac_lo(priv->mac_addr), SA_LO);
>  }
>
> -void soft_reset(const char *module, void __iomem *reg)
> +void cpsw_soft_reset(const char *module, void __iomem *reg)
>  {
>         unsigned long timeout = jiffies + HZ;
>
> diff --git a/drivers/net/ethernet/ti/cpsw_priv.h b/drivers/net/ethernet/ti/cpsw_priv.h
> index acb6181c5c9e..fddd7a79f4b0 100644
> --- a/drivers/net/ethernet/ti/cpsw_priv.h
> +++ b/drivers/net/ethernet/ti/cpsw_priv.h
> @@ -458,7 +458,7 @@ int cpsw_tx_poll(struct napi_struct *napi_tx, int budget);
>  int cpsw_rx_mq_poll(struct napi_struct *napi_rx, int budget);
>  int cpsw_rx_poll(struct napi_struct *napi_rx, int budget);
>  void cpsw_rx_vlan_encap(struct sk_buff *skb);
> -void soft_reset(const char *module, void __iomem *reg);
> +void cpsw_soft_reset(const char *module, void __iomem *reg);
>  void cpsw_set_slave_mac(struct cpsw_slave *slave, struct cpsw_priv *priv);
>  void cpsw_ndo_tx_timeout(struct net_device *ndev, unsigned int txqueue);
>  int cpsw_need_resplit(struct cpsw_common *cpsw);
> --
> 2.39.5
>
