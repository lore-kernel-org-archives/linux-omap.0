Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393AA352F88
	for <linux-omap@vger.kernel.org>; Wed, 11 Feb 2026 09:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770801054; cv=none; b=WCJ/L5jNqLnAY8SOF6BTI4GeGZ0EY3Q0eEfjFdmRZAmrSInWRkKsz47jWnD4lxBfWLtOt7qcO0XjwtCpys1rz2MsRB1xJGvTTS4SAp/G9zPm8XhvQeD6aUSRqzfGSqP3qdVbHdBcAJD4gtL3akfnNMK+gAAlAazYtU9uAZI0QZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770801054; c=relaxed/simple;
	bh=KacShDOWNOlO5H/VRA3buaVoCqG7ZDsYgx4xGNdyX8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ENwrvZqpSfWPYriRljo0Bz2oMK7Tg5J9ezZer9muDgUZqxxzrj1QitEsLeYNfo+0z8PlhFp4uRU/E2v04xXHTJpb4ySadwpJBMcphI2O13Ze8T+3LTxtxiaC6WVX+GOvQyUtgw3dx6gF04WpdqiV7oYpnjus3ELroNxf5gaPUpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AW/aXM4h; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=I7zpdHyL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AW/aXM4h";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="I7zpdHyL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770801052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S4wey9chVGopV4Q+iboK1zGvtP+HzRe8m12rmTHLNaI=;
	b=AW/aXM4hRW+KnB/u5HjIKfEEuuFojBOpaLpRLer1Jd56wOopiqvr5+iUBc823CiNZALzbT
	mNJp84TA956eWxIMRg6YuGzXofatuFX0x33C7nNBwnX2V7nzc9VKTPn94oF03/EkCyGKso
	//Sh7svK9oznC9GxZg1HMYO/el2PmaE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-GEN0wCyXNbqwzcRHSo4WFg-1; Wed, 11 Feb 2026 04:10:51 -0500
X-MC-Unique: GEN0wCyXNbqwzcRHSo4WFg-1
X-Mimecast-MFC-AGG-ID: GEN0wCyXNbqwzcRHSo4WFg_1770801049
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-435db8ebc98so1512805f8f.0
        for <linux-omap@vger.kernel.org>; Wed, 11 Feb 2026 01:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770801049; x=1771405849; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S4wey9chVGopV4Q+iboK1zGvtP+HzRe8m12rmTHLNaI=;
        b=I7zpdHyLB1ttY6xQNXvkTw+5i9XTYhhAtvFxbTtTSfGaSku9hFzLA3VwG6Zakcw0E8
         13HpcNnTSIG9+F2lSaXRTMj7KixEMDQwg3Mc9sTz/aNS+zVAOEmmggh6Q8N0wh8m16Ig
         3H+FTUACCXeukH5U8bxcpRp8g02uS13qKwCm3xmj5KQEN+STjRdH3Way7b/c/Hb6ERFo
         6wenZecQPjEGobsWEGKVN3Nq8MzJjVcUB2R94CqwO/bSbKnxa480ejOWkE9mwjXwIfPZ
         Bc7/QzFrxK+KCxLrbxFyp1UeZ7gmmk2Dw6trFbah2T9NrKUDZbFCsOEsG2hjMN+OM9xO
         oAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770801049; x=1771405849;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S4wey9chVGopV4Q+iboK1zGvtP+HzRe8m12rmTHLNaI=;
        b=T3ijZYzjssihcDN/nTIUU2lZ/NcB5Bsp1Z4vK01y3WVglv5vECyqpeOTORleiz0lyW
         JJ0X9amXRV3ipP7iU+4f+Uc+ttF7r3ol73v/dQPkjI8uHGDmjGLabMwwZmz17S3Q9Gm5
         CVQkhuG9WJQMOLuE+KO182NSXJ/+Ii3KuvmpXWtgIMYGlwZU+5Ybh5Bt8g0EZ6m49eHH
         eSTUBeWdbPHIaD8qoAO43ISVX9Ev9tVsQEc8KvYnVNGFz9L0DAsoBkLiKS0//5FFx5QW
         JAyGDeGY26E/nKRisuTC2pDC+cRJ99kEOJVAJLF/GVLTgwwwShZN6tw5ZzZdBlPfs9Ja
         hTdA==
X-Forwarded-Encrypted: i=1; AJvYcCUBHuelLANvZKIqzxcLSQNXPpaXSnWcBwy0YNXROt3q6LaA4SbeEPf7j9UEHDuph//XGRP68Jjrph4L@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Qb9WYI0ydw+lDiQN4EzpLCo5QCLHRfhUZWwtahLe29+nVZEr
	mVvO+GMwhbAzG+2vOnNO2J2SUgvMdvDlRYo7G1A/ckd0Wm85kKkVikFRiAKc3icJqflejfgvVcb
	hxlUX+c5zpb3mfccL9ueT6/xzr3HfQrjfOJuTtSYvhr08yhfINvj2L8+b1JNSX94=
X-Gm-Gg: AZuq6aK0oe1VgZof2mvSQLzXR/vM69b83tNaVYL40rbPcw7+XS3KyWJn9Mf/gGbeH6m
	KJynYQDIXCZA30KwpkEEfgi79k6WAn78uazh6q+fpuWIQ75XamdqlHKNsIkNzcGhjt391f/q+xL
	LIuPOOiDX3QRmj8ri66gN1+nHGqRKIigjNQV+Pvl54P3cxIznrwhy6CCXLjASxFl/c8YR/uPKjS
	DUEzQtysECj5EMjhU528uB2cskFSH+W6v01hFSuQo9kmRigKsLdtJ/glvQ1hsgEWLRwB7QTAVOt
	l3cTQGIbXOCFH5lELhVL8fmFWj+I0rtnDK5gtxPfc6q6Swx/wBHdRYEhKOuZ8+zMSo+q5hG9UlK
	MgJhZcdEnUsOPP2bcTeEKxmm1+A==
X-Received: by 2002:a05:6000:2890:b0:437:6b73:ffa9 with SMTP id ffacd0b85a97d-4376b74046amr18910065f8f.5.1770801048716;
        Wed, 11 Feb 2026 01:10:48 -0800 (PST)
X-Received: by 2002:a05:6000:2890:b0:437:6b73:ffa9 with SMTP id ffacd0b85a97d-4376b74046amr18910004f8f.5.1770801048244;
        Wed, 11 Feb 2026 01:10:48 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.220])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783dfda66sm3414895f8f.22.2026.02.11.01.10.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 01:10:47 -0800 (PST)
Message-ID: <76522b83-682b-4cba-bdb4-d4a922a49973@redhat.com>
Date: Wed, 11 Feb 2026 10:10:46 +0100
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ethernet: ti: davinci_emac: remove member
 phy_id from struct emac_platform_data
To: Heiner Kallweit <hkallweit1@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>, Eric Dumazet
 <edumazet@google.com>, David Miller <davem@davemloft.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 linux-omap@vger.kernel.org
References: <5bc19909-0fc7-485c-a573-4819eeea5b5d@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <5bc19909-0fc7-485c-a573-4819eeea5b5d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/6/26 10:53 PM, Heiner Kallweit wrote:
> b4aed01de486 ("ARM: davinci: Delete DM646x board files") removed the
> last user of member phy_id. So let's remove phy_id.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/ethernet/ti/davinci_emac.c | 24 ++++++++++--------------
>  include/linux/davinci_emac.h           |  9 ---------
>  2 files changed, 10 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
> index ed8116fb05e..df51441a2b8 100644
> --- a/drivers/net/ethernet/ti/davinci_emac.c
> +++ b/drivers/net/ethernet/ti/davinci_emac.c
> @@ -329,7 +329,6 @@ struct emac_priv {
>  	u32 mac_hash2;
>  	u32 multicast_hash_cnt[EMAC_NUM_MULTICAST_BITS];
>  	u32 rx_addr_type;
> -	const char *phy_id;
>  	struct device_node *phy_node;
>  	spinlock_t lock;
>  	/*platform specific members*/
> @@ -1418,6 +1417,7 @@ static int emac_dev_open(struct net_device *ndev)
>  	struct emac_priv *priv = netdev_priv(ndev);
>  	struct phy_device *phydev = NULL;
>  	struct device *phy = NULL;
> +	const char *phy_id = NULL;
>  
>  	ret = pm_runtime_resume_and_get(&priv->pdev->dev);
>  	if (ret < 0) {
> @@ -1502,8 +1502,8 @@ static int emac_dev_open(struct net_device *ndev)
>  		}
>  	}
>  
> -	/* use the first phy on the bus if pdata did not give us a phy id */
> -	if (!phydev && !priv->phy_id) {
> +	/* use the first phy on the bus */
> +	if (!phydev) {

AFAICS emac_dev_open() is invoked also on resume, and priv->phy_id could
be not NULL at that point, the new code could lead to a different
behavior. I think it's worthy to at least mention it in the commit message.

/P

