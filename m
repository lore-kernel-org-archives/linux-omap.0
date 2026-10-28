Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793215509;
	b=f4JL9fmCnGiZp/8FByhV375Q9uaYc5YrqwN+UFbtQiOWxx6sxu/MdQNP5z2frAaSBwwZ
	 VzncSx/58ajFuhIuSNB5iKzAAsJZhEHbJamzzBjjAtjFNe3vVE0A3lUIMN4qS6TGNTDa3
	 Il+qbYBqigk9aXk+mLSceYkz/0g4/Q6h7Muyo9U/+qJRk7ZOBJpVLoGShVf6Bexnx43LX
	 yqFh4Kl8MWHJJ9EA8BQLkTMvYvLYFoodLqFMeFg+qUvUzaBS46omHZaWsjQl5Kf/1r0yk
	 41yDYwrlTdnAblgZPeuHHrF9QNGh9bfntZHHYm17l1DSaVaxk/uWcNV7qYujCPVUYtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793215509;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=VWovsz25VQacJNQe16TtvfA1PaAlLh1xywDVn8vnffg=;
	b=CYNjNiz701hWAEnlnqOucLTrpOtSCEeGvEIls3nF12/0DE1vWxsDz8ilV7I4yXkIWKLj
	 ikYxaShNXT1Udn1kWpigEn2WtUdAkg7h6xM2P7qgVf+jEsgvRiwW5BEC09wl5PBDuNH4f
	 McNy5z/ds6Pk2/eNmoT7BVdRmriqb2n5mdw654FmnhLi3pbq07QJjsvDjFquOw3iezbEQ
	 ZvPTV5xlFlrQy5CIsdACxvyq+DH34c7Md9Wp6T3gBDrSu3D9tP1Ibc/nEWiknt6moh66k
	 UnnEJSkMkEzWdWePTUtSvxmueMFxHO/JDYCWrID9swRtDZ0usUO9FJ9hlVaMMI3L/NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V9hlITfa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B603606A31C;
	Wed, 28 Oct 2026 19:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V9hlITfa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9392D1F031E0;
	Wed, 28 Oct 2026 19:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793215509;
	bh=VWovsz25VQacJNQe16TtvfA1PaAlLh1xywDVn8vnffg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=V9hlITfawAG8Bwa7m5mAF7v0k8OX8N/+O8Og3osnROdQ6j8I97EIwuS48nFZSx25c
	 yhjhpU5rh0C0Z/DmJyYnWUO0OiO+mlZs9UEiAiUufMDwbykBy3yNmAL/4iGtdDvF/W
	 12UiTWCN8GhYbsHUF0OGDev7Rk/28MjyQAyCSwi/2W9Q4jV9Nd/Ggu3RFEKAAK267f
	 0ZPiKxER/1KpQIE2ftg09ys652VqX/Qkv1CemWQz9LhiJH6k8wO+RcD6vf6AKkltlh
	 J6yf92mCFlduzbG9qX5z/yysqABc09dLkUUwSmZkufyv9bcgtiMj8SV+p+MiV5WR6N
	 W6r9p5MOwLZ0g==
Subject: Re: [PATCH net] net: ethernet: ti: cpts: drop stale events before the
 misc IRQ can fire
From: netdev-bot+sashiko@kernel.org
To: alan.tseng.cs@gmail.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, s-vadapalli@ti.com, rogerq@kernel.org,
 richardcochran@gmail.com, grygorii.strashko@ti.com,
 linux-omap@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 28 Oct 2026 19:25:08 +0000
Message-ID: <179321550813.3134.2116221670679603156@kernel.org>
In-Reply-To: <20261026072314.663980-1-alan.tseng.cs@gmail.com>
References: <20261026072314.663980-1-alan.tseng.cs@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix narrows the window but leaves the NULL-pointer write in
  cpts_fifo_read() reachable.

--

net: ethernet: ti: cpts: drop stale events before the misc IRQ can fire

After a kexec, the previous kernel can leave a misc IRQ pending. That IRQ
can run cpts_fifo_read() before cpts_register() has set up the event
pool. This patch masks the CPTS interrupt and drains the CPTS event FIFO
in cpts_create() to avoid that. CPTS_EN is deliberately left set.

> diff --git a/drivers/net/ethernet/ti/cpts.c b/drivers/net/ethernet/ti/cpts.c
> index 2ba4c8795d605..3cc908ac90e2b 100644
> --- a/drivers/net/ethernet/ti/cpts.c
> +++ b/drivers/net/ethernet/ti/cpts.c

[ ... ]

> @@ -779,6 +780,17 @@ struct cpts *cpts_create(struct device *dev, void __iomem *regs,
>  	if (ret)
>  		return ERR_PTR(ret);
>  
> +	/* After a kexec the CPTS may still be running from the previous
> +	 * kernel, with its interrupt enabled and events in the FIFO. The misc
> +	 * IRQ is requested before cpts_register() sets up the event pool, so
> +	 * mask the interrupt and drop the stale events now.
> +	 */
> +	cpts_write32(cpts, 0, int_enable);
> +	for (i = 0; i < CPTS_FIFO_DEPTH; i++) {
> +		if (cpts_fifo_pop(cpts, &high, &low))
> +			break;
> +	}

[Severity: High]
Does this close the window completely, or only make it smaller?

CPTS_EN stays set, so the CPTS can keep queueing events after this loop
finishes. cpts->pool and cpts->events are still zeroed from devm_kzalloc().
Only cpts_register() initializes them, and it runs later from ndo_open.

A fair amount of work happens between cpts_create() and the misc IRQ
request. In cpsw_new.c:cpsw_probe():

    cpsw_init_common()        <- calls cpts_create()
    ...
    cpsw_create_ports()
    ...
    devm_request_irq(dev, cpsw->misc_irq, cpsw_misc_interrupt, ...)

In cpsw.c:cpsw_probe() the same window also covers register_netdev() and
cpsw_probe_dual_emac().

Several things could add new events to the FIFO in that window:

 - half-rollover and rollover events from the free-running counter
   (CPTS_EV_HALF / CPTS_EV_ROLL)
 - HW_TS_PUSH events, if the previous kernel left HWx_TS_PUSH_EN set
 - RX/TX timestamp events, if the previous kernel left port timestamping
   enabled

Port timestamping is only cleared by cpsw_soft_reset() in ndo_open, and
cpsw has no .shutdown handler. So after a kexec, a peer that sends PTP
event frames would keep generating RX events.

The commit message notes that the interrupt may already be latched. If
it is delivered when devm_request_irq() runs, the handler does:

cpsw_misc_interrupt()
  cpts_misc_interrupt()
    cpts_fifo_read()
      cpts_fifo_pop()

cpts_fifo_pop() tests intstat_raw & TS_PEND_RAW, so writing 0 to
int_enable does not stop the pop. Then in cpts_fifo_read():

		if (list_empty(&cpts->pool) && cpts_purge_events(cpts)) {
			dev_warn(cpts->dev, "cpts: event pool empty\n");
			break;
		}

		event = list_first_entry(&cpts->pool, struct cpts_event, list);
		event->high = hi;

On a zeroed list_head, list_empty() returns false, because NULL is not
equal to &cpts->pool. list_first_entry() then gives
container_of(NULL, struct cpts_event, list), so the write to event->high
lands near address 0 in hardirq context.

Isn't that the same oops the commit message describes?

Would it be more robust to make the handler safe to run before
cpts_register()? One option is to move INIT_LIST_HEAD(&cpts->events) and
INIT_LIST_HEAD(&cpts->pool) into cpts_create(). Another is to have
cpts_misc_interrupt() return early until registration has happened.
Either would replace the drain approach rather than extend it.

>  	cpts->cc.read = cpts_systim_read;
>  	cpts->cc.mask = CLOCKSOURCE_MASK(32);
>  	cpts->info = cpts_info;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261026072314.663980-1-alan.tseng.cs%40gmail.com
