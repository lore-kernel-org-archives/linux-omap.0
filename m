Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106C242DA3F;
	Mon,  5 Oct 2026 09:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791191412; cv=none; b=SyQesf0XvRsFIrT4x6I6eqgGLsVkA9FqtMp9IoZ8aHJ6oHB8H1/x+QHpIdMJVYiwi5wavX/BH1rUAtpjk2N/oD6ngkiQL3/neHrAo4wMh91C8jhnBEJi76il7swY/uMYyHvrauvs85KPvJg52msF95KZEOBFZonzkN5QEHjnFtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791191412; c=relaxed/simple;
	bh=0K1au8SS1GEggiDGLagKsHeLHmNn/D5/t/VC9FLmq8U=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HCtv0xrI4wt6hm53xdZ4v7WtV6ideT1mjac/Hor3j+QsuJhkecQHCG92X8oE1hLjwSZnMMpEJ8Z9u1Sm/8VSMoGcodF+eesRVShXyZUjrKy2uMeUyV4J5RD6DX3VdjPh38ueBw2r/NFbrYu40WM/BfaEpnjYPKUv0Y/Nl/9ipT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNcLwQas; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNcLwQas"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12DA41F000FF;
	Mon,  5 Oct 2026 09:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791191411;
	bh=lkfn8AuQz27PW+tdpf8ePuRoGUvuL1e8OngqnS6Bok8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LNcLwQasRffEPupRT5c73IDvF2HHrdLim9jRgTl+tSeX3gI5RbDX03gs5tl1PKhH+
	 EV6qLpUEsT126OaPPZwWJ/v4gKbYjgRgaThjlsD5GKp+Er6bwPr7iYGH4/yL5FI7Bx
	 dIkn+4rl94Lpr+GQtCVuc5sZM3xE3GCN+wv7CaoGB76+YttdJRgRr1jMcbjEClxGvu
	 f6lv2Ur0FZNWksuhMvJXss7/CrD+p1Ju/QBTXYM4cFh/9qrQYGsVUOYHRDK6qtmerf
	 /QVf+V+vYnHveksX1iORWCGoufvHL1MO3L73b5cEJ+mutrwD/FrRWfCD7uecowKe5V
	 rSv36J0X/Fy+g==
Subject: Re: [PATCH net v3] net: ti: am65-cpsw-switchdev: flush dynamic FDB
 entries by port on delete
From: netdev-bot+sashiko@kernel.org
To: danishanwar@ti.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, s-vadapalli@ti.com, rogerq@kernel.org,
 kees@kernel.org, stefan.wiehler@nokia.com, arnd@arndb.de, horms@kernel.org,
 c-vankar@ti.com, vigneshr@ti.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Date: Mon, 05 Oct 2026 09:10:09 +0000
Message-ID: <179119140962.434549.1894065404447339257@kernel.org>
In-Reply-To: <20261001090820.1605711-1-danishanwar@ti.com>
References: <20261001090820.1605711-1-danishanwar@ti.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 2 (1) · Medium: 1 (4) · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix does not close the bug class its commit message
  describes, 'Dynamic (hardware-learned) ALE entries are not removed on…
- [High] Remote L2 traffic can now force many full ALE MMIO scans while
  RTNL is held.
- [Medium] The patch removes the `!fdb->added_by_user` gate from the
  SWITCHDEV_FDB_DEL_TO_DEVICE path in am65_cpsw_switchdev_event_work()…
- [Low] The runtime PM reference added to the FDB event work only matters
  when no port is open, and in that state the ALE has already been…
- [Low] The submission justifies a full ALE walk on every dynamic delete
  with the claim that 'The ALE size is small (max 512 entries on the…

Pre-existing issues:
- [High] Nothing serializes ALE table accesses, and this patch adds a
  frequent new full-table walker that races with existing non-RTNL ALE…
- [Medium] This problem wasn't introduced by this patch, but the patch
  makes it more visible.
- [Medium] This problem wasn't introduced by this patch.
- [Medium] This problem wasn't introduced by this patch.
- [Medium] This problem wasn't introduced by this patch.

--

net: ti: am65-cpsw-switchdev: flush dynamic FDB entries by port on delete

This patch lets dynamic (not user-added) FDB deletes reach the ALE in the
am65-cpsw and cpsw switchdev event work. It does this through a new helper,
cpsw_ale_del_ucast_dynamic_by_port(), which matches on (addr, port) and
treats vid 0 as a wildcard. It also takes a runtime PM reference around
the ALE accesses in the FDB event work.

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

[Severity: Medium]
This isn't a bug introduced by this patch, but the patch makes it more
visible. These are the only pm_runtime calls in am65-cpsw-switchdev.c and
cpsw_switchdev.c. The other switchdev handlers write the same ALE without
a runtime PM reference:

am65_cpsw_port_stp_state_set()
	ret = cpsw_ale_control_set(cpsw->ale, port->port_id,
				   ALE_PORT_STATE, cpsw_state);

The same is true of am65_cpsw_port_attr_br_flags_set() ->
cpsw_ale_set_unreg_mcast(), the vlan_add/vlan_del and mdb_add/mdb_del
handlers, and their counterparts in cpsw_switchdev.c.

The port-down sequence named in the commit message also reaches the STP
handler, through deferred switchdev work:

NETDEV_DOWN -> br_stp_disable_port() -> br_set_state(BR_STATE_DISABLED)
    (SWITCHDEV_F_DEFER) -> am65_cpsw_port_stp_state_set()
        -> cpsw_ale_control_set()

That can run after the last port's asynchronous pm_runtime_put() has
already suspended the device.

If the new references are needed, do the sibling handlers need them too?
If they are not needed, are the new ones redundant?

> +
>  		if (memcmp(port->slave.mac_addr, (u8 *)fdb->addr, ETH_ALEN) == 0)
>  			port_id = HOST_PORT_NUM;
>  
>  		cpsw_ale_add_ucast(cpsw->ale, (u8 *)fdb->addr, port_id,
>  				   fdb->vid ? ALE_VLAN : 0, fdb->vid);
>  		am65_cpsw_fdb_offload_notify(port->ndev, fdb);

[Severity: Medium]
This is a pre-existing issue, but the return value of cpsw_ale_add_ucast()
is ignored here, and SWITCHDEV_FDB_OFFLOADED is always sent.

If cpsw_ale_add_ucast() finds no matching, free or ageable row, it returns
-ENOMEM without writing anything:

cpsw_ale_add_ucast()
	if (idx < 0)
		idx = cpsw_ale_find_ageable(ale);
	if (idx < 0)
		return -ENOMEM;

Can the bridge then set BR_FDB_OFFLOADED on an entry that is not in
hardware? cpsw_switchdev_event_work() does the same thing with
cpsw_fdb_offload_notify().

> +		pm_runtime_put(cpsw->dev);
>  		break;
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
Flushes are not the only source of dynamic deletes. With this gate gone,
does bridge software ageing now free live ALE rows too?

br_fdb_cleanup() expires ordinary learned entries with
fdb_delete(br, f, true), which leads to:

fdb_delete() -> fdb_notify(RTM_DELNEIGH) -> br_switchdev_fdb_notify()
    -> SWITCHDEV_FDB_DEL_TO_DEVICE (added_by_user=0, is_local=0)
        -> am65_cpsw_switchdev_event_work()
            -> cpsw_ale_del_ucast_dynamic_by_port()

Neither TI driver handles SWITCHDEV_ATTR_ID_BRIDGE_AGEING_TIME, and
neither sends SWITCHDEV_FDB_ADD_TO_BRIDGE. So the software FDB entry is
refreshed only by frames that reach the host port. Known unicast that the
hardware forwards port-to-port never refreshes it.

The bridge entry expires after ageing_time (300s by default), or after
forward_delay during a topology change. The DEL then frees the ALE row,
even if the hardware has it marked as touched and in active use. With
vid=0 this happens in every VLAN. Unicast to that station then floods
until the station transmits again.

The v3 changelog says the ageing trade-off "has been documented in the
commit message". The commit message doesn't mention that bridge software
ageing now removes hardware FDB entries. Could that be documented, or
could the driver avoid this behaviour?

The same applies to cpsw_switchdev_event_work().

[Severity: High]
Does this fully fix the problem the commit message describes?

  Dynamic (hardware-learned) ALE entries are not removed on FDB flush and
  sit stale until the ALE hardware ages them out ~30 seconds later.

The new code only reacts to per-entry SWITCHDEV_FDB_DEL_TO_DEVICE
notifications. The bridge sends those only for entries in its own
software FDB, and it only learns from frames that reach the CPU. The ALE
learns from all ingress traffic.

For example, after a flush, A sends a frame to an unknown B. The frame
floods to the host, so the bridge learns A. B replies to the now-known A,
and the switch forwards the reply in hardware. The ALE learns B, but the
bridge does not. On the next flush or port disable no DEL is sent for B,
so B's ALE row stays stale until hardware ageout.

The commit message also says:

  Dynamic deletes are the only way to remove a hardware-learned entry
  early, so drop that gate for the delete path.

Is that accurate? The driver could fast-age a port's dynamic unicast
entries itself, the way DSA's port_fast_age does. For example, it could
do this from am65_cpsw_port_stp_state_set() and cpsw_port_stp_state_set()
on DISABLED, BLOCKING and LISTENING transitions.
cpsw_ale_flush_multicast() already walks the table by port mask in a
similar way. Today the STP handlers only write ALE_PORT_STATE:

am65_cpsw_port_stp_state_set()
	ret = cpsw_ale_control_set(cpsw->ale, port->port_id,
				   ALE_PORT_STATE, cpsw_state);

A per-port fast-age would also avoid the ageing side effect described
above.

> -		if (memcmp(port->slave.mac_addr, (u8 *)fdb->addr, ETH_ALEN) == 0)
> -			port_id = HOST_PORT_NUM;
>  
> -		cpsw_ale_del_ucast(cpsw->ale, (u8 *)fdb->addr, port_id,
> -				   fdb->vid ? ALE_VLAN : 0, fdb->vid);
> +		ret = pm_runtime_resume_and_get(cpsw->dev);
> +		if (ret < 0) {
> +			netdev_err(port->ndev, "%s: failed to resume device: %d\n", __func__, ret);
> +			break;
> +		}

[Severity: Low]
When does this reference actually make a difference? Every open port
holds a PM reference from am65_cpsw_nuss_ndo_slave_open() or
cpsw_ndo_open(). When the last port stops, the ALE is cleared and
disabled before that reference is dropped:

am65_cpsw_nuss_common_stop()  (usage_count == 1)
cpsw_ndo_stop()               (usage_count <= 1)
    cpsw_ale_stop()
	cpsw_ale_control_set(ale, 0, ALE_CLEAR, 1);
	cpsw_ale_control_set(ale, 0, ALE_ENABLE, 0);

So the resume only matters when the ALE is already empty. In that case
cpsw_ale_del_ucast_dynamic_by_port() scans an empty table and cannot
delete anything. Each dynamic DEL queued when the last port goes down
(one per learned MAC) powers the device up just to do that scan.

On the ADD side, the entry is written into a cleared, disabled ALE, and
SWITCHDEV_FDB_OFFLOADED is still sent. cpsw_ale_start() then clears it
again on the next open.

The commit message says "an ADD/DEL that reaches the ALE needs its own
reference". The reference only avoids MMIO to a suspended device; the ALE
update itself has no effect. Is the commit message misleading here?
Would pm_runtime_get_if_active() be a better fit, or skipping the ALE
access when no port is open?

> +
> +		if (!fdb->added_by_user) {
> +			cpsw_ale_del_ucast_dynamic_by_port(cpsw->ale,
> +							   (u8 *)fdb->addr,
> +							   port_id,
> +							   fdb->vid);

[Severity: High]
Can remote L2 traffic now force many full ALE scans while RTNL is held?

Before this patch, dynamic DEL work items returned right after
rtnl_lock(). Now each one walks ale->params.ale_entries rows: 512 on
am64-cpswxg and 1024 on cpsw_new. Each row costs one MMIO write and three
MMIO reads. The whole table is scanned when vid is 0, and also when
nothing matches.

Untrusted traffic can generate dynamic DELs. br_fdb_update() sends one
every time a MAC moves:

br_fdb_update()
	if (unlikely(source != READ_ONCE(fdb->dst) &&
		     !test_bit(BR_FDB_STICKY, &fdb->flags))) {
		br_switchdev_fdb_notify(br, fdb, RTM_DELNEIGH);

So a source MAC that alternates between two ports causes a DEL on every
move.

Flooding random source MACs from a single port also works, because
fdb_max_learned is unlimited by default. When those entries age out,
br_fdb_cleanup() sends one DEL per entry, and each DEL is a full scan
that finds nothing.

Every notification also allocates a GFP_ATOMIC work item, with no bound
on how many. Could this cause long RTNL contention and a growing backlog
of queued work on small SoCs?

The same applies to cpsw_switchdev_event_work().

> +		} else {
> +			if (memcmp(port->slave.mac_addr, (u8 *)fdb->addr, ETH_ALEN) == 0)
> +				port_id = HOST_PORT_NUM;
> +			cpsw_ale_del_ucast(cpsw->ale, (u8 *)fdb->addr, port_id,
> +					   fdb->vid ? ALE_VLAN : 0, fdb->vid);

[Severity: Medium]
This is a pre-existing issue, but am65_cpsw_switchdev_event() and
cpsw_switchdev_event() queue a separate work item for each FDB
notification:

	queue_work(system_long_wq, &switchdev_work->work);

system_long_wq is created with alloc_workqueue("events_long", WQ_PERCPU, 0)
and is not ordered. The workers serialize on rtnl_lock but can acquire it
in any order.

If a user-added ADD is followed by a DEL for the same entry, can they run
as DEL then ADD? That would leave a stale ALE_UCAST_PERSISTANT entry in
hardware after the user has deleted it.

> +		}
> +		pm_runtime_put(cpsw->dev);
>  		break;
>  	default:
>  		break;
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

[Severity: Low]
The v2 changelog justifies a full walk on every dynamic delete with:

  The ALE size is small (max 512 entries on the largest supported device)

Is that right for cpsw_switchdev.c? cpsw_init_common() in cpsw_priv.c
sets ale_params.dev_id = "cpsw", and the "cpsw" entry in
cpsw_ale_id_match has .tbl_entries = 1024. On that driver, every vid=0
delete and every delete that finds no match walks 1024 rows.

> +		cpsw_ale_read(ale, idx, ale_entry);

[Severity: High]
This is a pre-existing issue, but this patch adds a new full-table walker
that runs often. Nothing serializes ALE table accesses.

cpsw_ale_read() and cpsw_ale_write() share one indirect window: write the
index to ALE_TABLE_CONTROL, then access the ALE_TABLE words. There is no
ALE lock.

This walk runs from the switchdev work, holding only rtnl_mutex.
am65_cpsw_nuss_ndo_slave_set_rx_mode() calls cpsw_ale_set_allmulti(),
cpsw_ale_flush_multicast() and cpsw_ale_add_mcast() holding only
netif_addr_lock_bh. An unprivileged user can reach that path without
RTNL:

IPV6_ADD_MEMBERSHIP -> ipv6_sock_mc_join() -> igmp6_group_added()
    -> dev_mc_add() -> am65_cpsw_nuss_ndo_slave_set_rx_mode()
        -> cpsw_ale_flush_multicast()

cpsw_ale_flush_multicast() writes back every ADDR/VLAN_ADDR row. The
index write here can land between the other walker's index write and its
word reads or commit. If it does, the other walker reads or commits the
wrong row's contents.

It can also go the other way: this loop could read a row other than idx
and then write ALE_TYPE_FREE to idx.

Separately, am65_cpsw_nuss_suspend() calls cpsw_ale_dump() with no lock,
while this work can still run on the non-freezable system_long_wq.

Can this free or overwrite VLAN, persistent unicast or multicast rows?

> +		type = cpsw_ale_get_entry_type(ale_entry);

[ ... ]

> diff --git a/drivers/net/ethernet/ti/cpsw_switchdev.c b/drivers/net/ethernet/ti/cpsw_switchdev.c
> index 7e06aac388a60..7fbebe666da81 100644
> --- a/drivers/net/ethernet/ti/cpsw_switchdev.c
> +++ b/drivers/net/ethernet/ti/cpsw_switchdev.c

[ ... ]

> @@ -393,12 +395,20 @@ static void cpsw_switchdev_event_work(struct work_struct *work)
>  
>  		if (!fdb->added_by_user || fdb->is_local)
>  			break;
> +
> +		ret = pm_runtime_resume_and_get(cpsw->dev);
> +		if (ret < 0) {
> +			dev_err(cpsw->dev, "%s: failed to resume device: %d\n", __func__, ret);
> +			break;
> +		}

[Severity: Medium]
This is a pre-existing issue, and it is not related to this change.
cpsw_remove() in cpsw_new.c and am65_cpsw_nuss_remove() in
am65-cpsw-nuss.c both call pm_runtime_resume_and_get() and return early
if it fails:

am65_cpsw_nuss_remove()
	ret = pm_runtime_resume_and_get(&pdev->dev);
	if (ret < 0) {
		/* Note, if this error path is taken, we're leaking some
		 * resources.
		 */
		...
		return;
	}

That return happens before am65_cpsw_unregister_notifiers() or
cpsw_unregister_notifiers(), and before the netdev and devlink
unregistration. If the module is unloaded after that, do the switchdev
and netdevice notifiers stay registered, pointing into freed module text?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001090820.1605711-1-danishanwar%40ti.com
