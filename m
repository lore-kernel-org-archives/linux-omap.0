Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DE2421227;
	Mon,  5 Oct 2026 09:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791192158; cv=none; b=LZ2zor7LcMDRgz5NtdAc0weqH6+psMi55/Bt/hMVmCsE9mDS7eSjJDovBcNprYct0XOymY4O/WvEr/8heeAnAtlSZUwwDKlF30ye64A/oaEe7pL7XQAQqN/B3bHV6L3g0bZqawuTx1t/kcHG7QY+PMy4aHvcM6vqYghdfJT4S3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791192158; c=relaxed/simple;
	bh=E1m4ilYYVXCfuRdtsDHWvcsOkYyMF5SZ9U2dox83XEQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I1QFS4J6v6ngWD3kePhF7Ex2Z31Azov/ND+eeUaWvALJX3S5iqUPf0iJgqXyLktzw8eoJ6bndXm0kXRalVGoI0pqoSjD0AOrHZ2x6mbtWyAvQWJZErHQfFhhplkCyIWF5f2d0RIt/SgxEP7q5TKJeNPFBrmwFSx91KBc9I9N4gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8FMR+LJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8FMR+LJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A401F000FF;
	Mon,  5 Oct 2026 09:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791192156;
	bh=v+bMomR95TmPtYDJDuNH1XnXtSJ+M2HNNZgZhUWDe+Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=e8FMR+LJx3A7bneu8YcoA6/BIfTbnR8x7ZQ9ZsEwpCK2z4jO0HUDynMcYXbobZBUP
	 ulYOfQ+fXIzw5Wxn78naAfJjPWmQWskwjizx9/BT4NDHQz6tlATN/K3+OWW2mSHDn+
	 EbM2nOyeJS4/i9KjVT5KsUyAgYlw8QdIx5Y+M9Zky+0sSOejKseYqomlqP5GvE0cVF
	 Sz8dgkaSGFpLo87D6PSNBPvpVtI7fw/1JMXiNPvFjUWUGs/+BsWUIpp/OUWO1L3fbe
	 UfUXL3HPLx+9xq+Rn45bw6Hgnsmh5UHikK6gby3Dq6zpR9o+gkJzkJT/+4k/cU8CNw
	 8eW+udlpqCrlA==
Subject: Re: [PATCH net v3] net: ti: am65-cpsw-switchdev: flush dynamic FDB
 entries by port on delete
From: netdev-bot+sashiko@kernel.org
To: danishanwar@ti.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, s-vadapalli@ti.com, rogerq@kernel.org,
 kees@kernel.org, stefan.wiehler@nokia.com, arnd@arndb.de, horms@kernel.org,
 c-vankar@ti.com, vigneshr@ti.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Date: Mon, 05 Oct 2026 09:22:34 +0000
Message-ID: <179119215496.434549.12930720686957329697@kernel.org>
In-Reply-To: <20261001090820.1605711-2-danishanwar@ti.com>
References: <20261001090820.1605711-2-danishanwar@ti.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 (5) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Every SWITCHDEV_FDB_DEL_TO_DEVICE for a learned bridge entry now
  makes am65_cpsw_switchdev_event_work()/cpsw_switchdev_event_work()…
- [Medium] This patch removes the `added_by_user` gate from the
  SWITCHDEV_FDB_DEL_TO_DEVICE path in both…
- [Medium] The commit message says 'vid=0 is only ever passed when
  vlan_filtering is off', and that claim is the justification for…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the patch
  applies the runtime-PM rule unevenly.
- [Medium] This problem wasn't introduced by this patch, but in both FDB
  ADD workers, am65_cpsw_switchdev_event_work() and…
- [Medium] This problem wasn't introduced by this patch, but if
  pm_runtime_resume_and_get() fails in am65_cpsw_nuss_remove()…
- [Medium] Access to the ALE table goes through one shared indirect
  window.
- [Medium] This problem wasn't introduced by this patch, but the new PM
  reference in the FDB ADD path matters only when every port is down.

--

net: ti: am65-cpsw-switchdev: flush dynamic FDB entries by port on delete

This patch drops the added_by_user gate on the switchdev FDB delete path
in both am65-cpsw and the older cpsw driver. Learned entries are now
removed by a new helper, cpsw_ale_del_ucast_dynamic_by_port(), which
matches on (addr, port) and treats vid 0 as a wildcard. It also takes a
runtime PM reference around the ALE accesses in the switchdev event work.

> diff --git a/drivers/net/ethernet/ti/am65-cpsw-switchdev.c b/drivers/net/ethernet/ti/am65-cpsw-switchdev.c
> index 53cdac272b583..bc4e19e2373f5 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-switchdev.c
> +++ b/drivers/net/ethernet/ti/am65-cpsw-switchdev.c

[ ... ]

> @@ -383,12 +385,20 @@ static void am65_cpsw_switchdev_event_work(struct work_struct *work)
>  
>  		if (!fdb->added_by_user || fdb->is_local)
>  			break;
> +
> +		ret = pm_runtime_resume_and_get(cpsw->dev);
> +		if (ret < 0) {
> +			netdev_err(port->ndev, "%s: failed to resume device: %d\n", __func__, ret);
> +			break;
> +		}
> +

[Severity: Medium]
This isn't a bug introduced by this patch, but the runtime PM reference is
added only in the FDB work. The other switchdev ALE accessors in this
file still touch the ALE with no PM reference and no netif_running()
check:

  am65_cpsw_port_stp_state_set() -> cpsw_ale_control_set()
  am65_cpsw_port_attr_br_flags_set() -> cpsw_ale_set_unreg_mcast()
  am65_cpsw_port_vlan_add()/del() -> cpsw_ale_vlan_add_modify(),
      cpsw_ale_add_ucast(), cpsw_ale_del_vlan(), cpsw_ale_del_ucast(),
      cpsw_ale_del_mcast()
  am65_cpsw_port_mdb_add()/del()

In contrast, am65_cpsw_nuss_ndo_slave_add_vid() and kill_vid() return
early when the interface is not running. Otherwise they wrap the ALE
writes in pm_runtime_resume_and_get()/pm_runtime_put().

Once the last am65_cpsw_nuss_ndo_slave_stop() drops its reference, the
device can be runtime-suspended (unless CPTS forbids runtime PM).

Can bridge VLAN, MDB or STP operations then write ALE registers on a
suspended module, for example when a down port is enslaved?

Whether those writes are actually lost depends on the K3 power-domain
behaviour. cpsw_switchdev.c has the same split.

>  		if (memcmp(port->slave.mac_addr, (u8 *)fdb->addr, ETH_ALEN) == 0)
>  			port_id = HOST_PORT_NUM;
>  
>  		cpsw_ale_add_ucast(cpsw->ale, (u8 *)fdb->addr, port_id,
>  				   fdb->vid ? ALE_VLAN : 0, fdb->vid);
>  		am65_cpsw_fdb_offload_notify(port->ndev, fdb);

[Severity: Medium]
This is a pre-existing issue, but the return value of cpsw_ale_add_ucast()
is ignored here, and am65_cpsw_fdb_offload_notify() is called either way.
When there is no matching, free or ageable slot, cpsw_ale_add_ucast()
returns without writing anything:

drivers/net/ethernet/ti/cpsw_ale.c:cpsw_ale_add_ucast() {
    ...
	if (idx < 0)
		idx = cpsw_ale_find_ageable(ale);
	if (idx < 0)
		return -ENOMEM;
    ...
}

Would the bridge then mark the static entry as offloaded even though the
hardware does not have it? cpsw_switchdev_event_work() does the same with
cpsw_fdb_offload_notify().

> +		pm_runtime_put(cpsw->dev);
>  		break;

[Severity: Medium]
This isn't a bug introduced by this patch, but the new PM reference only
matters when every port is down. By then, am65_cpsw_nuss_common_stop()
has already called cpsw_ale_stop(), which sets ALE_CLEAR and clears
ALE_ENABLE, and the last PM reference has been dropped.

This path then resumes the device, writes a persistent ucast entry into
the stopped ALE and reports it as offloaded. When the first port is
opened again, cpsw_ale_start() clears the table:

drivers/net/ethernet/ti/cpsw_ale.c:cpsw_ale_start() {
    ...
	cpsw_ale_control_set(ale, 0, ALE_ENABLE, 1);
	cpsw_ale_control_set(ale, 0, ALE_CLEAR, 1);
    ...
}

switchdev_bridge_port_offload() is called with NULL notifiers and replay
disabled, so nothing adds the entry back.

Doesn't the bridge then show the static entry as offloaded while the ALE
no longer has it?

The same looks true for static entries added while ports were up, after
any cycle where all ports go down and come back up. cpsw_new seems to
behave the same way.

>  	case SWITCHDEV_FDB_DEL_TO_DEVICE:
>  		fdb = &switchdev_work->fdb_info;
> @@ -397,13 +407,27 @@ static void am65_cpsw_switchdev_event_work(struct work_struct *work)
>  			   fdb->addr, fdb->vid, fdb->added_by_user,
>  			   fdb->offloaded, port_id);
>  
> -		if (!fdb->added_by_user || fdb->is_local)
> +		if (fdb->is_local)
>  			break;

[Severity: Medium]
Without the added_by_user check, does this path also act on deletes from
the bridge's own software ageing, and not only on explicit flushes?

br_fdb_cleanup() calls fdb_delete(br, f, true) for every expired learned
entry:

net/bridge/br_fdb.c:br_fdb_cleanup() {
    ...
			if (!hlist_unhashed(&f->fdb_node))
				fdb_delete(br, f, true);
    ...
}

br_switchdev_fdb_notify() then sends SWITCHDEV_FDB_DEL_TO_DEVICE with
added_by_user=0.

Neither driver handles SWITCHDEV_ATTR_ID_BRIDGE_AGEING_TIME or sends
SWITCHDEV_FDB_ADD_TO_BRIDGE. So f->updated in the bridge is refreshed only
by frames that reach the CPU. Unicast that the ALE forwards between ports
never refreshes it.

For a station whose traffic is switched in hardware, the bridge entry
expires after the ageing time (300s by default). The DEL that follows
makes cpsw_ale_del_ucast_dynamic_by_port() write ALE_TYPE_FREE over the
live ALE row. With vid 0 it does this for every VLAN.

Wouldn't unicast to that station then flood as unknown unicast until the
ALE relearns it, and then happen again every ageing interval? The same
applies to cpsw_switchdev_event_work() in cpsw_switchdev.c.

The v3 changelog says the ageing trade-off is documented in the commit
message, but the only ageing the message mentions is the ~30 second ALE
hardware ageout. Could the commit message describe this case?

>  
> -		cpsw_ale_del_ucast(cpsw->ale, (u8 *)fdb->addr, port_id,
> -				   fdb->vid ? ALE_VLAN : 0, fdb->vid);
> +		ret = pm_runtime_resume_and_get(cpsw->dev);
> +		if (ret < 0) {
> +			netdev_err(port->ndev, "%s: failed to resume device: %d\n", __func__, ret);
> +			break;
> +		}
> +
> +		if (!fdb->added_by_user) {
> +			cpsw_ale_del_ucast_dynamic_by_port(cpsw->ale,
> +							   (u8 *)fdb->addr,
> +							   port_id,
> +							   fdb->vid);
> +		} else {
> +			if (memcmp(port->slave.mac_addr, (u8 *)fdb->addr, ETH_ALEN) == 0)
> +				port_id = HOST_PORT_NUM;
> +			cpsw_ale_del_ucast(cpsw->ale, (u8 *)fdb->addr, port_id,
> +					   fdb->vid ? ALE_VLAN : 0, fdb->vid);
> +		}
> +		pm_runtime_put(cpsw->dev);
>  		break;

[Severity: Medium]
This is a pre-existing issue and the patch does not touch this code. It is
relevant here because this work holds a port pointer and only a
dev_hold() on the netdev.

If pm_runtime_resume_and_get() fails in am65_cpsw_nuss_remove(), or in
cpsw_remove() in cpsw_new.c, the function returns early:

drivers/net/ethernet/ti/am65-cpsw-nuss.c:am65_cpsw_nuss_remove() {
    ...
	ret = pm_runtime_resume_and_get(&pdev->dev);
	if (ret < 0) {
		/* Note, if this error path is taken, we're leaking some
		 * resources.
		 */
		...
		return;
	}

	am65_cpsw_unregister_notifiers(common);
    ...
}

That skips am65_cpsw_unregister_notifiers()/cpsw_unregister_notifiers()
and the netdev cleanup. The driver core still releases the devm
resources, including the common structure and the port array.

Can registered notifiers, live netdevs, or queued switchdev work then
dereference freed driver state? The in-code comment only describes this
as leaking resources.

> diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
> index e202bba494807..d3d6a1ef894ac 100644
> --- a/drivers/net/ethernet/ti/cpsw_ale.c
> +++ b/drivers/net/ethernet/ti/cpsw_ale.c

[ ... ]

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

[Severity: High]
For every slot in ale->params.ale_entries, this walk does one
ALE_TABLE_CONTROL write and ALE_ENTRY_WORDS reads. It exits early only
when vid is nonzero and a match is found. With vid 0, or with a MAC that
is not in the table, it always scans the whole table.

Every learned-entry DEL now reaches this loop with rtnl_lock held. Could a
remote L2 peer keep rtnl held continuously?

Moving a source MAC between bridge ports produces an immediate DEL, with
no rate limit:

net/bridge/br_fdb.c:br_fdb_update() {
    ...
			if (unlikely(source != READ_ONCE(fdb->dst) &&
				     !test_bit(BR_FDB_STICKY, &fdb->flags))) {
				br_switchdev_fdb_notify(br, fdb, RTM_DELNEIGH);
    ...
}

A flood of random source MACs creates one learned entry per MAC, and each
entry produces a DEL when it ages out.

The notifier allocates one GFP_ATOMIC work item per event and does not
coalesce them. Once DELs arrive faster than one walk takes, the
system_long_wq backlog would grow without bound as well.

The v2 changelog justifies the cost with "max 512 entries". However, the
legacy CPSW entry in the cpsw_ale_dev_id table has:

		.dev_id = "cpsw",
		.tbl_entries = 1024,

and j721e-cpswxg sizes its table from ALE_STATUS in multiples of
ALE_TABLE_SIZE_MULTIPLIER (1024). Is the bound in the changelog accurate?

> +		type = cpsw_ale_get_entry_type(ale_entry);
> +		if (type != ALE_TYPE_ADDR && type != ALE_TYPE_VLAN_ADDR)
> +			continue;
> +		if (cpsw_ale_get_mcast(ale_entry))
> +			continue;
> +		ucast_type = cpsw_ale_get_ucast_type(ale_entry);
> +		if (ucast_type == ALE_UCAST_PERSISTANT ||
> +		    ucast_type == ALE_UCAST_OUI)
> +			continue;
> +		if (cpsw_ale_get_port_num(ale_entry, ale->port_num_bits) != port)
> +			continue;
> +		cpsw_ale_get_addr(ale_entry, entry_addr);
> +		if (!ether_addr_equal(entry_addr, addr))
> +			continue;
> +		entry_vid = cpsw_ale_get_vlan_id(ale_entry);
> +		if (vid && entry_vid != vid)
> +			continue;

[Severity: Medium]
The commit message justifies the wildcard this way:

  vid=0 is only ever passed when vlan_filtering is off

Does that still hold after vlan_filtering is toggled at runtime?

br_vlan_filter_toggle() flips BROPT_VLAN_ENABLED and recalculates
promiscuity, the group address and the forward mask. It does not flush or
rekey the FDB, and neither driver handles
SWITCHDEV_ATTR_ID_BRIDGE_VLAN_FILTERING.

Learned entries with key.vlan_id == 0 from before the toggle survive it.
They are no longer refreshed, because learning now uses the frame's VID,
and later they age out or are flushed. br_switchdev_fdb_populate()
copies the stored key:

net/bridge/br_switchdev.c:br_switchdev_fdb_populate() {
    ...
	item->vid = fdb->key.vlan_id;
    ...
}

So a DEL with vid=0 and added_by_user=0 can arrive while vlan_filtering
is on.

Wouldn't this loop then free the MAC's dynamic rows on that port for
every VLAN? That would include rows the bridge still holds as valid vid-N
entries.

> +
> +		memset(ale_entry, 0, sizeof(ale_entry));
> +		cpsw_ale_set_entry_type(ale_entry, ALE_TYPE_FREE);
> +		cpsw_ale_write(ale, idx, ale_entry);

[Severity: Medium]
This is a pre-existing issue, but this walk makes it much easier to hit.
cpsw_ale_read() and cpsw_ale_write() share one indirect window
(ALE_TABLE_CONTROL plus the ALE_TABLE words). struct cpsw_ale has no
lock, and this function holds only rtnl_lock.

Two am65 paths use the same window without rtnl.

The first is am65_cpsw_nuss_ndo_slave_set_rx_mode(). It calls
cpsw_ale_set_allmulti(), cpsw_ale_flush_multicast() and
cpsw_ale_add_mcast() while holding only the netdev address lock. An
unprivileged IPv6 multicast join can reach it:

  __ipv6_sock_mc_join()->__ipv6_dev_mc_inc()->igmp6_group_added()
      ->dev_mc_add()

The second is am65_cpsw_nuss_suspend(). It calls cpsw_ale_dump() without
rtnl and without flushing the switchdev work. That work runs on the
unfreezable system_long_wq, and bridge ageing keeps producing DELs
during suspend.

Can interleaved CONTROL writes make one side read or commit another
slot's contents?

For example, the suspend dump could save slot j's data as slot i, and
cpsw_ale_restore() in am65_cpsw_nuss_resume() would then write that
back. In the other direction, the CONTROL write in this walk could
replace a concurrent writer's staged words, so the writer commits a copy
of a different entry.

The set_rx_mode path needs a non-promiscuous port in switch mode.
cpsw_new is not affected through set_rx_mode, because its rx_mode_work
takes rtnl_lock.

> +		deleted++;
> +
> +		if (vid)
> +			break;
> +	}
> +
> +	return deleted ? 0 : -ENOENT;
> +}
> +EXPORT_SYMBOL_GPL(cpsw_ale_del_ucast_dynamic_by_port);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001090820.1605711-2-danishanwar%40ti.com
