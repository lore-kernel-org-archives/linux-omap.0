Received: from smtp.smtpout.orange.fr (smtp-77.smtpout.orange.fr [80.12.242.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D1F288C2F;
	Sun, 17 May 2026 17:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779040699; cv=none; b=ZvLQxdAMg0D+9LODPusSYHNYD5VdenfkA+E+V3Ce91XteqI3hlEMfGdk2bth5+4g6C1HDtFZKKFzBD/Om2bH5ZpT6wN8d436/EwGQC0AwVOo2R8GOnpqY3oIU3TSAiPFnb2t1yUfl69Et7I1Dvs+JATY9b2bDH/nJygkvpcqeYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779040699; c=relaxed/simple;
	bh=LWTnidVdujpXDCET0XD2sD35z5sDM7Z4+zgy/ynfx+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XpcaRwh5Qo7PWXcXaMkM9waCfwNI884dZeTTgpXm9EHNUi6M89XRurxhepaNpLN0JF+h78GZAFDJfYXoCJyAUUplqZLHNTmkaeXh7MStLTtKNcqZqqmG699YZX0orEvM3y3ZyTLFG+Ik6VVImThFNF4XUd9Z7ZYadXxssa81yqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=ailayYQX; arc=none smtp.client-ip=80.12.242.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="ailayYQX"
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPSA
	id OfkXwwgseVLOXOfkXwXsK9; Sun, 17 May 2026 19:58:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1779040688;
	bh=kNu1D7hywVDU5R9dsOZKx9liIzf+kef4Z2xM1lYjNZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=ailayYQXgIZJ3RcUiE2DlGdBh2m7zqNxy/EpAVgQRpmAWHtkaIyormCafAPAXth2f
	 G5LrkIbMsb7LFRhkTZ/nzgncB++OJ8WYRz4DQSUPFKEsHy2LxQn0EiSkYr4NEeOeJ1
	 KXYwI/i3jDz+5q0BKRGt79jyf5rwZ0zUTXNfGCTtkU+2d86GwLCyC8JFmDXDFdbHBG
	 X68ALgph/fXz7aVZ9j7FF7uquSG31vjaaEHROhvfXUZ2fA0gTvKmD4uA9BQWRaNJ9/
	 hDh++/SiB5R2NpJdz7psV+pGfov2hn5a8KT+fq26sCX4ZMz2cM1MX70PKp9LV87Ts7
	 Ah9x/iQk9YaxA==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 17 May 2026 19:58:08 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <1e31a516-af18-419f-861e-db45511e7955@wanadoo.fr>
Date: Sun, 17 May 2026 19:57:59 +0200
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: ethernet: ti: am65-cpsw-nuss: remove dead vid
 check in slave_add_vid()
To: Alexander Vassilevski <oss@vassilevski.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Chintan Vankar
 <c-vankar@ti.com>, netdev@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20260515225715.3641804-1-oss@vassilevski.com>
 <20260517151611.393789-1-oss@vassilevski.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20260517151611.393789-1-oss@vassilevski.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 17/05/2026 à 17:16, Alexander Vassilevski a écrit :
> am65_cpsw_nuss_ndo_slave_add_vid() returns early at the top with:
> 
>      if (!netif_running(ndev) || !vid)
>          return 0;
> 
> so vid is guaranteed to be non-zero in the rest of the function. The
> subsequent
> 
>      if (!vid)
>          unreg_mcast = port_mask;
> 
> is therefore unreachable. Drop the dead branch.
> 
> With that branch gone, unreg_mcast is only ever its initializer value
> of zero, so drop the variable and pass 0 directly to
> cpsw_ale_vlan_add_modify().
> 
> No functional change.
> 
> Found by Smatch.
> 
> Fixes: 7bcffde02152 ("net: ethernet: ti: am65-cpsw-nuss: restore vlan configuration while down/up")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/kernel-janitors/aS_lhMwppbDHoEcX@stanley.mountain/
> Suggested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Appreciated, but not really needed. I just made a comment about a tiny 
possible improvement.

> Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

This should be placed after Signed-off-by:

> Signed-off-by: Alexander Vassilevski <oss@vassilevski.com>
> ---
> I agree, Christophe.

This part could be more descriptive.
You could for example have:

Changes in v2:
    - remove unreg_mcast which is now unneeded.

> 
>   drivers/net/ethernet/ti/am65-cpsw-nuss.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> index 77f59996a0..434a310808 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> @@ -302,7 +302,7 @@ static int am65_cpsw_nuss_ndo_slave_add_vid(struct net_device *ndev,
>   {
>   	struct am65_cpsw_common *common = am65_ndev_to_common(ndev);
>   	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
> -	u32 port_mask, unreg_mcast = 0;
> +	u32 port_mask;
>   	int ret;
>   
>   	if (!common->is_emac_mode)
> @@ -318,7 +318,7 @@ static int am65_cpsw_nuss_ndo_slave_add_vid(struct net_device *ndev,
>   	port_mask = BIT(port->port_id) | ALE_PORT_HOST;
>   	dev_info(common->dev, "Adding vlan %d to vlan filter\n", vid);
>   	ret = cpsw_ale_vlan_add_modify(common->ale, vid, port_mask,
> -				       unreg_mcast, port_mask, 0);
> +				       0, port_mask, 0);
>   
>   	pm_runtime_put(common->dev);
>   	return ret;

Patches don't work like that.

When you send a v2, it supersedes the previous v1.
So your dead-code removal, should also be included in the v2.
Otherwise, it is impossible for maintainers to know what to apply.

So, you should send a new cumulative version, as a v3.

CJ
