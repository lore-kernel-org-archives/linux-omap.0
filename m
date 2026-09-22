Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAA7386C21;
	Tue, 22 Sep 2026 08:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790064981; cv=none; b=HBzrOuyzTWKcTe2BePjqO38iORoLGNcP+ku81zUdfbr2EiaX8Ou1FLEIU3DjNm5vwoQnDxnFL3dFMjMw4/+5SpqzLEKOwsu4lfNF//TqBEnCqaLBjLb/DGTBMsQchv78fv1sfP0QVNGYdohFxtreFHthL6qBc+oXiyUD7R/NB5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790064981; c=relaxed/simple;
	bh=BuTVsnydVMlOpXAKBEWqj71dcPdmU1jkMss8beXiBjo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=de9oWlAPiSDp+lEdoG0F8LAAi9h+hBqevDj0kCFKXyGf/bsOkSREtduWmdLy9sDctFD1MaxNxreSP5AbG5OSYqZxqz3GTbPlDv4u2NIXn11KoD/AnXn2fOns6kTMLiNnhCo5Mkm5jKlsQhMUT2QblHKU52iQ+IH8kDaewf/tyhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnriIg+Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnriIg+Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB411F000FF;
	Tue, 22 Sep 2026 08:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790064978;
	bh=gOk4uYV7AmQiIV5I3BISJRVheE9g6ivZNXTPgLuvCDE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AnriIg+ZhXJyWVxHbinL0tNToxHlkD048VcwpjOs390gXHXcW5OLm/D/kyHTFL6oL
	 UyIU1LJWKEKnyLVNSgtl1hnE719qfz9ucONGEiS46d5HmRMQ94Ojmhh6BMsZe/yVcA
	 1N0p/7v0vazn+xe4xoHxkoiLVB4vODt7XBEkqcGzROECCGFq5XqMNXvEUBBpkNWioF
	 ACOvfJmP2pMDaYyL8/N3D+0HxxZRIak0Pzg7GWVOqwxpW3faueHaDcg5ts1P9ZzpdN
	 u47nwbXKRFoi7zzpaCqajyLsnqs4QVbIz2ryAy/2KYOm8vRAVdo31LTTuxJ+8ql7P0
	 0TLvGwJJ2pAJA==
Subject: Re: [PATCH net] net: ti: am65-cpsw-switchdev: flush dynamic FDB
 entries by port on delete
From: netdev-bot+sashiko@kernel.org
To: danishanwar@ti.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, s-vadapalli@ti.com, rogerq@kernel.org,
 kees@kernel.org, stefan.wiehler@nokia.com, c-vankar@ti.com, horms@kernel.org,
 arnd@arndb.de, vigneshr@ti.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Date: Tue, 22 Sep 2026 08:16:16 +0000
Message-ID: <179006497666.2160803.14768308117153644313@kernel.org>
In-Reply-To: <20260918075926.3616434-1-danishanwar@ti.com>
References: <20260918075926.3616434-1-danishanwar@ti.com>
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

Critical: 0 · High: 1 · Medium: 2 (1) · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] New cross-module ALE helper
  `cpsw_ale_del_ucast_dynamic_by_port()` is added to…
- [Medium] In am65_cpsw_switchdev_event_work() the `!fdb->added_by_user`
  gate is dropped for SWITCHDEV_FDB_DEL_TO_DEVICE, but only the `vid ==…
- [Medium] Dropping the `!fdb->added_by_user` gate makes every hardware-
  learned (dynamic) bridge FDB delete run an unbounded full ALE table…

Pre-existing issues:
- [Medium] cpsw_ale_del_ucast_dynamic_by_port() performs a full-table
  read-modify-write walk over the ALE indirect access window…
- [Low] The identical stale-dynamic-FDB defect remains in the sibling
  legacy switchdev driver drivers/net/ethernet/ti/cpsw_switchdev.c…

--

net: ti: am65-cpsw-switchdev: flush dynamic FDB entries by port on delete

The patch drops the added_by_user gate in the SWITCHDEV_FDB_DEL_TO_DEVICE
arm of am65_cpsw_switchdev_event_work() so dynamic FDB deletes reach the
ALE, and adds cpsw_ale_del_ucast_dynamic_by_port() to clear dynamic rows
for a MAC on a port regardless of vid when the bridge reports vid=0.

> diff --git a/drivers/net/ethernet/ti/am65-cpsw-switchdev.c b/drivers/net/ethernet/ti/am65-cpsw-switchdev.c
> index 53cdac272b58..8b4640809cf5 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-switchdev.c
> +++ b/drivers/net/ethernet/ti/am65-cpsw-switchdev.c
> @@ -397,13 +397,23 @@ static void am65_cpsw_switchdev_event_work(struct work_struct *work)
>  			   fdb->addr, fdb->vid, fdb->added_by_user,
>  			   fdb->offloaded, port_id);
>  
> -		if (!fdb->added_by_user || fdb->is_local)
> +		if (fdb->is_local)
>  			break;
>  		if (memcmp(port->slave.mac_addr, (u8 *)fdb->addr, ETH_ALEN) == 0)
>  			port_id = HOST_PORT_NUM;
>  
> -		cpsw_ale_del_ucast(cpsw->ale, (u8 *)fdb->addr, port_id,
> -				   fdb->vid ? ALE_VLAN : 0, fdb->vid);
> +		if (!fdb->added_by_user && !fdb->vid)
> +			/* vid=0 here just means "bridge doesn't know the
> +			 * real vid" (vlan_filtering=0) -- the dynamic entry
> +			 * may be stored under any nonzero vid, or several.
> +			 * Delete by (addr, port) instead of guessing a vid.
> +			 */
> +			cpsw_ale_del_ucast_dynamic_by_port(cpsw->ale,
> +							   (u8 *)fdb->addr,
> +							   port_id);
> +		else
> +			cpsw_ale_del_ucast(cpsw->ale, (u8 *)fdb->addr, port_id,
> +					   fdb->vid ? ALE_VLAN : 0, fdb->vid);

[Severity: Medium]
What happens to dynamic deletes that carry a nonzero vid (bridge with
vlan_filtering=1)?  They now land in the else arm, and
cpsw_ale_del_ucast() resolves the row through cpsw_ale_match_addr(),
which compares only entry type, vlan_id and MAC:

drivers/net/ethernet/ti/cpsw_ale.c:cpsw_ale_match_addr() {
	...
		if (cpsw_ale_get_vlan_id(ale_entry) != vid)
			continue;
		cpsw_ale_get_addr(ale_entry, entry_addr);
		if (ether_addr_equal(entry_addr, addr))
			return idx;
	...
}

The port argument of cpsw_ale_del_ucast() is never used, and no
ucast_type filtering happens, so the row that gets blanked may belong to
a different port or be an ALE_UCAST_PERSISTANT row.

The MAC roaming case looks reachable: br_fdb_update() emits a dynamic
RTM_DELNEIGH for the old port while the ALE has already re-learned the
MAC on the new port:

net/bridge/br_fdb.c:br_fdb_update() {
	...
			if (unlikely(source != READ_ONCE(fdb->dst) &&
				     !test_bit(BR_FDB_STICKY, &fdb->flags))) {
				br_switchdev_fdb_notify(br, fdb, RTM_DELNEIGH);
				WRITE_ONCE(fdb->dst, source);
	...
}

The ADD arm still keeps its added_by_user gate, so nothing reprograms the
row afterwards.  Before this patch the gate made that path unreachable
for dynamic entries.

Should the vid != 0 dynamic case also go through a port-aware and
ucast_type-aware delete, so both arms of the new conditional agree on
which rows a dynamic delete may clear?

[Severity: Medium]
With the added_by_user gate gone, every hardware-learned delete now runs
a full ALE table walk in cpsw_ale_del_ucast_dynamic_by_port() while the
rtnl_lock() taken at the top of am65_cpsw_switchdev_event_work() is held.
The helper has no early exit, since it deliberately clears rows under all
vids, so each event costs ale_entries times six MMIO accesses (64 entries
on cpsw2g, 512 on am64-cpswxg, more on j721e-cpswxg).

The event rate is driven by network traffic: learning, ageing, flush and
especially roaming, where one RTM_DELNEIGH is emitted per roam.  An
off-box host can keep this going by sourcing frames with the MAC of a
host known on another bridge port.

Is the added rtnl hold time and MMIO load per untrusted FDB event
acceptable here, or would an early exit / bounded search be preferable?

[Severity: Low]
This isn't a bug introduced by this patch, but the legacy sibling driver
drivers/net/ethernet/ti/cpsw_switchdev.c still has the exact code this
patch replaces in its SWITCHDEV_FDB_DEL_TO_DEVICE arm:

drivers/net/ethernet/ti/cpsw_switchdev.c:cpsw_switchdev_event_work() {
	...
		if (!fdb->added_by_user || fdb->is_local)
			break;
	...
		cpsw_ale_del_ucast(cpsw->ale, (u8 *)fdb->addr, port,
				   fdb->vid ? ALE_VLAN : 0, fdb->vid);
	...
}

cpsw_new.c also sets ALE_VLAN_AWARE unconditionally in switch mode, so
both premises stated in the changelog seem to hold there as well.  Since
the new helper is declared in the shared cpsw_ale.h consumed by both
drivers, was leaving cpsw_switchdev.c unconverted intentional?  A note in
the changelog about the scope would help.

>  		break;
>  	default:
>  		break;
> diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
> index e202bba49480..1a2aceda3dbe 100644
> --- a/drivers/net/ethernet/ti/cpsw_ale.c
> +++ b/drivers/net/ethernet/ti/cpsw_ale.c

[ ... ]

> @@ -441,6 +441,40 @@ static int cpsw_ale_find_ageable(struct cpsw_ale *ale)
>  	return -ENOENT;
>  }
>  
> +int cpsw_ale_del_ucast_dynamic_by_port(struct cpsw_ale *ale, const u8 *addr,
> +				       int port)
> +{
> +	u32 ale_entry[ALE_ENTRY_WORDS];
> +	int type, ucast_type, idx;
> +	u8 entry_addr[6];
> +	int deleted = 0;
> +
> +	for (idx = 0; idx < ale->params.ale_entries; idx++) {
> +		cpsw_ale_read(ale, idx, ale_entry);

[Severity: Medium]
This is a pre-existing property of cpsw_ale.c rather than something the
patch introduces, but the new helper adds one more unlocked
read-modify-write walk over the shared ALE indirect access window:

drivers/net/ethernet/ti/cpsw_ale.c:cpsw_ale_read() {
	writel_relaxed(idx, ale->params.ale_regs + ALE_TABLE_CONTROL);
	for (i = 0; i < ALE_ENTRY_WORDS; i++)
		ale_entry[i] = readl_relaxed(ale->params.ale_regs +
					     ALE_TABLE + 4 * i);
	...
}

There are no locks anywhere in cpsw_ale.c, and other table transactions
such as am65_cpsw_nuss_ndo_slave_set_rx_mode() ->
cpsw_ale_flush_multicast() run under netif_addr_lock_bh() rather than the
rtnl_lock held by the switchdev worker.  Should anything ever interleave,
one transaction's staged words can be committed under the other's index,
and cpsw_ale_flush_multicast() writes back every ADDR/VLAN_ADDR row it
reads, which could restore a row this helper just cleared.

Is there an assumption documented somewhere that all ALE table accessors
run under rtnl?

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
> +
> +		memset(ale_entry, 0, sizeof(ale_entry));
> +		cpsw_ale_set_entry_type(ale_entry, ALE_TYPE_FREE);
> +		cpsw_ale_write(ale, idx, ale_entry);
> +		deleted++;
> +	}
> +
> +	return deleted ? 0 : -ENOENT;
> +}

[Severity: High]
Is an EXPORT_SYMBOL_GPL() missing here?  The neighbouring ALE entry
points used across module boundaries all have one:

drivers/net/ethernet/ti/cpsw_ale.c
	EXPORT_SYMBOL_GPL(cpsw_ale_add_ucast);
	...
	EXPORT_SYMBOL_GPL(cpsw_ale_del_ucast);

The only caller, am65_cpsw_switchdev_event_work() in
am65-cpsw-switchdev.c, is linked into a different module than
cpsw_ale.o:

drivers/net/ethernet/ti/Makefile
	ti-cpsw-ale-y += cpsw_ale.o
	...
	obj-$(CONFIG_TI_K3_AM65_CPSW_NUSS) += ti-am65-cpsw-nuss.o ti-cpsw-sl.o ti-cpsw-ale.o
	ti-am65-cpsw-nuss-y := am65-cpsw-nuss.o am65-cpsw-ethtool.o
	ti-am65-cpsw-nuss-$(CONFIG_TI_K3_AM65_CPSW_SWITCHDEV) += am65-cpsw-switchdev.o

With CONFIG_TI_K3_AM65_CPSW_NUSS=m and
CONFIG_TI_K3_AM65_CPSW_SWITCHDEV=y, does modpost report
"cpsw_ale_del_ucast_dynamic_by_port" [drivers/net/ethernet/ti/ti-am65-cpsw-nuss.ko]
undefined?  Built-in configurations would hide this.

>  
>  static void cpsw_ale_flush_mcast(struct cpsw_ale *ale, u32 *ale_entry,
>  				 int port_mask)
>  {

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918075926.3616434-1-danishanwar%40ti.com
