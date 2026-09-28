Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13643D16F9;
	Mon, 28 Sep 2026 05:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790574639; cv=none; b=FODKbTE2aTRgR2fxeFwXMlHsJ7Dm05RBh0PK1TF4yJKbe9vt27BRhA/BhR20a+aRWorCb4VNQr/5s+Wg5cloMPG5FwqFeaLHPoMOF5AZ3ihoMk7KQaaD/0fNCSKmVJQQzoQt9BjWeU/IHdcrlUmJS9WkZrV/mAK+i/TlSL3ocFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790574639; c=relaxed/simple;
	bh=kJcsH2niv1dwszNlEv2mo7fJBxwFUFJeBFdUjlGg2Zc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pDLyimcRr2S6FuF4yDkAF8e3GfjYRInvtMSwtXWg7Tk7c7PC30Vv4etZMuqmkzhr4pcG9cpwkD2vLhAdFFZXxcLZGxtgC2jZiucGd6023Ry4gr+YOpeTe+B3xt0vQUZmz/HWyimr19oBCs6uvfgkC0GA8/crQw2TAuMKKT5G/OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wau/fZwo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wau/fZwo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29A31F000FF;
	Mon, 28 Sep 2026 05:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790574634;
	bh=ry5nXhHymQ5z8JB19KnE1kjjIaemv8CwOfpIxSBXgcQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Wau/fZwosya3zh/hA29eiIzf74vjfg1JVwngMkZ1MtSfK0WeRNR5J7U2Z/Tvk0CaA
	 Fwv8XrLLwS9bLykRB+mu/r5A9hT838Y8foo531mHMLgRCZ6xMCtgW89djmrYs3VmPH
	 g0cfwq0ILioELo4skcsX5Hul+pCzywBX6j3COdd3h+H4D/jx34VxrHER+4X3lBqfmP
	 s3QVHn8Snqcm7aM6cn4Pdy0Kmay+0ZdCPIRH5yl2B8Ti49api7vqOcR9kZXj5JmQRy
	 rTDlh9OaNEGyqd8O92+1JsE4ySmlXYgKZhPVE5TSBs+tEVnEdmPghUhRX5HlLOEQi5
	 DnSGpdhRq6P5A==
Subject: Re: [PATCH net v2] net: ti: am65-cpsw-switchdev: flush dynamic FDB
 entries by port on delete
From: netdev-bot+sashiko@kernel.org
To: danishanwar@ti.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, s-vadapalli@ti.com, rogerq@kernel.org,
 kees@kernel.org, arnd@arndb.de, stefan.wiehler@nokia.com, c-vankar@ti.com,
 vigneshr@ti.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org
Date: Mon, 28 Sep 2026 05:50:33 +0000
Message-ID: <179057463349.3145.13175831323497920715@kernel.org>
In-Reply-To: <20260924052146.594157-1-danishanwar@ti.com>
References: <20260924052146.594157-1-danishanwar@ti.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 2 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch removes the `!fdb->added_by_user` gate from the
  SWITCHDEV_FDB_DEL_TO_DEVICE branch of am65_cpsw_switchdev_event_work().
- [Medium] Before this patch, dynamic DEL_TO_DEVICE events hit the
  `!fdb->added_by_user` break and never touched hardware.

Pre-existing issues:
- [High] cpsw_ale has no internal lock (no spinlock, mutex or lockdep
  assert in cpsw_ale.c).
- [Medium] This problem wasn't introduced by this patch, but the older
  CPSW switchdev driver has the same flush defect.

--

net: ti: am65-cpsw-switchdev: flush dynamic FDB entries by port on delete

This patch drops the added_by_user gate on SWITCHDEV_FDB_DEL_TO_DEVICE in
am65-cpsw-switchdev, so dynamic FDB deletes now reach the hardware. It adds
cpsw_ale_del_ucast_dynamic_by_port(), which walks the ALE and frees
non-persistent unicast rows that match (addr, port). When vid is 0 it frees
matching rows in every vid.

> diff --git a/drivers/net/ethernet/ti/am65-cpsw-switchdev.c b/drivers/net/ethernet/ti/am65-cpsw-switchdev.c
> index 53cdac272b58..0dc681748b0e 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-switchdev.c
> +++ b/drivers/net/ethernet/ti/am65-cpsw-switchdev.c
> @@ -397,13 +397,19 @@ static void am65_cpsw_switchdev_event_work(struct work_struct *work)
>  			   fdb->addr, fdb->vid, fdb->added_by_user,
>  			   fdb->offloaded, port_id);
>  
> -		if (!fdb->added_by_user || fdb->is_local)
> +		if (fdb->is_local)
>  			break;

[Severity: Medium]

With the added_by_user gate removed, does routine bridge software ageing
now remove live ALE rows as well?

br_fdb_cleanup() ages out dynamic entries like this:

br_fdb_cleanup()
  fdb_delete(br, f, true)
    fdb_notify(br, f, RTM_DELNEIGH, true)
      br_switchdev_fdb_notify()
        -> SWITCHDEV_FDB_DEL_TO_DEVICE, added_by_user = 0

This driver never reports hardware-learned entries to the bridge (there is
no SWITCHDEV_FDB_ADD_TO_BRIDGE). Also, am65_cpsw_port_attr_set() does not
handle SWITCHDEV_ATTR_ID_BRIDGE_AGEING_TIME. As a result, the bridge only
refreshes an entry when a frame from that station reaches the CPU.

Take a station whose unicast traffic is switched only in hardware. Its
bridge entry expires after the default 300 seconds, while traffic keeps
refreshing its ALE row. The ALE ages out untouched rows after about 30
seconds (AM65_CPSW_ALE_AGEOUT_DEFAULT with CPSW_ALE_F_HW_AUTOAGING), so any
row still present at that point is in use.

cpsw_ale_del_ucast_dynamic_by_port() does not check touched/untouched
state. With vid == 0 it frees every matching row for that MAC on the port.

Would traffic to that station then be flooded as unknown unicast until the
station transmits again? That would happen once per bridge ageing interval,
with a full ALE walk each time.

The commit message only describes this as a flush fix. Should it mention
the change in ageing behaviour, or should the ageing path be filtered out?

>  		if (memcmp(port->slave.mac_addr, (u8 *)fdb->addr, ETH_ALEN) == 0)
>  			port_id = HOST_PORT_NUM;
>  
> -		cpsw_ale_del_ucast(cpsw->ale, (u8 *)fdb->addr, port_id,
> -				   fdb->vid ? ALE_VLAN : 0, fdb->vid);
> +		if (!fdb->added_by_user)
> +			cpsw_ale_del_ucast_dynamic_by_port(cpsw->ale,
> +							   (u8 *)fdb->addr,
> +							   port_id,
> +							   fdb->vid);

[Severity: Medium]

Before this patch, dynamic DEL_TO_DEVICE events hit the break before any
hardware access. Now each one does a full ALE MMIO walk. Does this path
need a runtime PM reference?

On port-down the sequence looks like this:

am65_cpsw_nuss_ndo_slave_stop()
  am65_cpsw_nuss_common_stop()
    cpsw_ale_stop()
  pm_runtime_put(common->dev)

NETDEV_DOWN then triggers:

br_stp_disable_port()
  br_fdb_delete_by_port()
    -> one SWITCHDEV_FDB_DEL_TO_DEVICE per dynamic entry, added_by_user = 0

am65_cpsw_switchdev_event_work()
  cpsw_ale_del_ucast_dynamic_by_port()
    cpsw_ale_read()   /* writel_relaxed/readl_relaxed of ALE regs */

When the last port goes down, these work items access the ALE registers
after the last runtime PM reference has been dropped. Other ALE users in
am65-cpsw-nuss.c take pm_runtime_resume_and_get() first, for example the
VLAN add/kill and set_mac_address paths.

With CONFIG_TI_K3_AM65_CPTS disabled, am65_cpsw_init_cpts() returns before
it calls pm_runtime_forbid(), so the device can runtime suspend. The comment
there notes that K3 CPSWxG modules may lose context on ON->OFF transitions.

Could this access a suspended module?

> +		else
> +			cpsw_ale_del_ucast(cpsw->ale, (u8 *)fdb->addr, port_id,
> +					   fdb->vid ? ALE_VLAN : 0, fdb->vid);
>  		break;

[Severity: Medium]

This is a pre-existing issue that was not introduced by this patch. The
older CPSW switchdev driver seems to have the same flush problem.
cpsw_switchdev_event_work() in drivers/net/ethernet/ti/cpsw_switchdev.c
still has:

	if (!fdb->added_by_user || fdb->is_local)
		break;
	...
	cpsw_ale_del_ucast(cpsw->ale, (u8 *)fdb->addr, port,
			   fdb->vid ? ALE_VLAN : 0, fdb->vid);

cpsw_init_host_port() in cpsw_new.c enables ALE_VLAN_AWARE, so the nonzero
vid mismatch described in the commit message applies there too.
cpsw_switchdev_event() queues DEL_TO_DEVICE work without any filtering.

Should cpsw_switchdev.c also use the new
cpsw_ale_del_ucast_dynamic_by_port() helper, or is that planned as a
separate fix?

> diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
> index e202bba49480..86bcea5744e0 100644
> --- a/drivers/net/ethernet/ti/cpsw_ale.c
> +++ b/drivers/net/ethernet/ti/cpsw_ale.c

[ ... ]

> @@ -441,6 +441,48 @@ static int cpsw_ale_find_ageable(struct cpsw_ale *ale)
>  	return -ENOENT;
>  }
>  
> +int cpsw_ale_del_ucast_dynamic_by_port(struct cpsw_ale *ale, const u8 *addr,
> +				       int port, u16 vid)
> +{
> +	u32 ale_entry[ALE_ENTRY_WORDS];
> +	int type, ucast_type, idx;
> +	u8 entry_addr[6];
> +	int deleted = 0;
> +	int entry_vid;
> +
> +	for (idx = 0; idx < ale->params.ale_entries; idx++) {
> +		cpsw_ale_read(ale, idx, ale_entry);

[ ... ]

> +		memset(ale_entry, 0, sizeof(ale_entry));
> +		cpsw_ale_set_entry_type(ale_entry, ALE_TYPE_FREE);
> +		cpsw_ale_write(ale, idx, ale_entry);

[Severity: High]

This is a pre-existing issue: the existing switchdev ucast add/del and VLAN
ops can already race here. This patch adds a new full-table read/write
walker and runs it much more often.

ALE table accesses go through a shared indirect window: the index goes into
ALE_TABLE_CONTROL, then the ALE_TABLE words are read or written.
cpsw_ale.c has no internal lock. The only thing serializing this loop is
rtnl_lock() taken by the switchdev work.

am65_cpsw_nuss_ndo_slave_set_rx_mode() is called on the legacy
ndo_set_rx_mode path in __dev_set_rx_mode(). It runs under
netif_addr_lock_bh() without rtnl. It calls cpsw_ale_flush_multicast(),
which reads every ALE_TYPE_ADDR/ALE_TYPE_VLAN_ADDR row, including unicast
rows, and always writes it back:

	for (idx = 0; idx < ale->params.ale_entries; idx++) {
		cpsw_ale_read(ale, idx, ale_entry);
		...
		cpsw_ale_write(ale, idx, ale_entry);
	}

An unprivileged user can reach that path without rtnl:

setsockopt(IPV6_ADD_MEMBERSHIP)
  __ipv6_sock_mc_join()
    __ipv6_dev_mc_inc()
      igmp6_group_added()
        dev_mc_add()
          __dev_mc_add()
            __dev_set_rx_mode()
              am65_cpsw_nuss_ndo_slave_set_rx_mode()
                cpsw_ale_flush_multicast()

Suppose cpsw_ale_flush_multicast() reads row N, this function then frees
row N, and cpsw_ale_flush_multicast() writes its stale copy back. Doesn't
the deleted dynamic entry come back?

The ALE_TABLE_CONTROL writes from the two paths could also interleave.
Could one path then read another row's contents, or write its words to the
wrong index? That would free or overwrite an unrelated VLAN, persistent or
multicast row.

Should ALE table accesses be serialized by a lock inside cpsw_ale?

> +		deleted++;
> +
> +		if (vid)
> +			return 0;
> +	}
> +
> +	return deleted ? 0 : -ENOENT;
> +}
> +EXPORT_SYMBOL_GPL(cpsw_ale_del_ucast_dynamic_by_port);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924052146.594157-1-danishanwar%40ti.com
