Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2667D1DE885;
	Tue, 27 Jan 2026 03:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769483160; cv=none; b=pDSzU+5ngmAfbn+gp0oISOM/D7voku1RmMTey7h8KcLu2Mh6CcunNeexwMqRlpa9dAJL1m+rRqXteFpTydlcFe1o/A5oXS4YuT0P8/xe3NtVahrGPa5be6aeVTCHbSq5iOuZQAACFVkz6tBI11WvRAmNu/Vxo4/LRbDiGoV+ALw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769483160; c=relaxed/simple;
	bh=vmQk7HhL3DZwcCiINRgVxyQ9Y3lYtI2JaIc6QQOfV6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LrTol0vQ8dhSBuU3DjykjYCP9yFtxta2YeQts2xWe4qdoHgr3thvNLC0w6euaQqiTAoNf9c6628rpUadmX0E9z6vIG4u2z5+NkBzTjSEHGJpUSiq2V6mSYECw53qkJoL6oAVoJjPFHjuk72jvvqnQfRWYWqjCzZuSjOi7ueOyuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URUGqv88; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URUGqv88"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F63C116C6;
	Tue, 27 Jan 2026 03:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769483159;
	bh=vmQk7HhL3DZwcCiINRgVxyQ9Y3lYtI2JaIc6QQOfV6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=URUGqv88gWQOzn7dxySoG7ie1fqKDP7qD0rLENvJpDa+G8PzuytqOaDzyY5O4Jd/t
	 GVuMFhrOW4p4CWbHL8MdgSsivmyHjawL52RbkoagNnTi7FB2LszpWIElRZptp8ZVAE
	 Ydr/erkHQiSDQx+sKCmIUtfzTHV0QIt2F4OFIEHmz2nGdIfiKiiTwVSbwunCLPPVfR
	 XgkYhcgQM33vnrd38Va/CTjmacdfLM33u356o4AA54k8bbifd4PypE+mAGE8Q3Pmpv
	 /B3yzHT/IqHrH9pOUBN6URc1DL8WGk3+Hk0VH0VZ25ZXzpi4LwWnC8sQgiz7N/VybY
	 5VuIbeUcTRN3w==
From: Jakub Kicinski <kuba@kernel.org>
To: haokexin@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	kuniyu@google.com,
	andrew+netdev@lunn.ch,
	vladimir.oltean@nxp.com,
	s-vadapalli@ti.com,
	linux-omap@vger.kernel.org,
	rogerq@kernel.org,
	stable@vger.kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	edumazet@google.com,
	davem@davemloft.net
Subject: Re: [net,v2] net: cpsw_new: Execute ndo_set_rx_mode callback in a work queue
Date: Mon, 26 Jan 2026 19:05:56 -0800
Message-ID: <20260127030556.3839208-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260125-bbb-v2-1-1547ffabc9d3@gmail.com>
References: <20260125-bbb-v2-1-1547ffabc9d3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: cpsw_new: Execute ndo_set_rx_mode callback in a work queue

This patch moves the rx_mode processing from ndo_set_rx_mode into a
workqueue to address RTNL assertion warnings when vlan_for_each() is
called without RTNL held.

> diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
> index ab88d4c02cbd..a631df9691e0 100644
> --- a/drivers/net/ethernet/ti/cpsw_new.c
> +++ b/drivers/net/ethernet/ti/cpsw_new.c
> @@ -248,15 +248,23 @@ static int cpsw_purge_all_mc(struct net_device *ndev, const u8 *addr, int num)
>  	return 0;
>  }
>
> -static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
> +static void cpsw_ndo_set_rx_mode_work(struct work_struct *work)
>  {
> -	struct cpsw_priv *priv = netdev_priv(ndev);
> +	struct cpsw_priv *priv = container_of(work, struct cpsw_priv, rx_mode_work);
>  	struct cpsw_common *cpsw = priv->cpsw;
> +	struct net_device *ndev = priv->ndev;
>
> +	if (!netif_running(ndev))
> +		return;
> +
> +	rtnl_lock();

Can this deadlock during device close? The call path would be:

  Thread A (holding RTNL): __dev_close_many() -> cpsw_ndo_stop() ->
      cancel_work_sync(&priv->rx_mode_work)

  Work thread: cpsw_ndo_set_rx_mode_work() -> rtnl_lock() [blocked]

Thread A holds RTNL and waits in cancel_work_sync() for the work to
complete, while the work thread blocks on rtnl_lock() waiting for
Thread A.

The netif_running() check happens before rtnl_lock() is acquired, so
there is a race window where the work passes the check, then
__dev_close_many() clears __LINK_STATE_START and calls ndo_stop().

The commit message mentions following the icssg-prueth driver approach,
but that driver uses rtnl_trylock() instead of rtnl_lock() in its
emac_ndo_set_rx_mode_work() function, which avoids this deadlock by
returning early if the lock cannot be acquired.

> +	netif_addr_lock_bh(ndev);

[ ... ]

> @@ -813,6 +831,8 @@ static int cpsw_ndo_stop(struct net_device *ndev)
>
>  	__hw_addr_ref_unsync_dev(&ndev->mc, ndev, cpsw_purge_all_mc);
>
> +	cancel_work_sync(&priv->rx_mode_work);

This is called with RTNL held (from __dev_close_many which has
ASSERT_RTNL). If the work function is blocked on rtnl_lock() at this
point, cancel_work_sync() will wait forever, causing a deadlock.

[ ... ]
-- 
pw-bot: cr
