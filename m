From: Tony Lindgren <tony@atomide.com>
Subject: Re: World writeable MUX
Date: Fri, 4 Feb 2011 11:53:21 -0800
Message-ID: <20110204195321.GZ3322@atomide.com>
References: <20110204124352.GH30543@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:45699 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752424Ab1BDTxq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Feb 2011 14:53:46 -0500
Content-Disposition: inline
In-Reply-To: <20110204124352.GH30543@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

* Felipe Balbi <balbi@ti.com> [110204 04:42]:
> Hi Tony,
> 
> I saw a few patches floating around regarding world writeable sysfs
> files and decided to grep around arch/arm/*omap* to try and see if we
> were safe. Turns out anyone can change MUX entries via the debugfs
> interface:
> 
> static void __init omap_mux_dbg_create_entry(
> 				struct omap_mux_partition *partition,
> 				struct dentry *mux_dbg_dir)
> {
> 	struct omap_mux_entry *e;
> 
> 	list_for_each_entry(e, &partition->muxmodes, node) {
> 		struct omap_mux *m = &e->mux;
> 
> 		(void)debugfs_create_file(m->muxnames[0], S_IWUGO, mux_dbg_dir,
> 					  m, &omap_mux_dbg_signal_fops);
> 	}
> }
> 
> is that really expected ? I guess not, attached there's a small patch to
> fix that one.

Heh, no it should not be like that, thanks will queue as a fix.

Tony
