From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] ARM: OMAP4+: PM: centralize static dependency
 mapping table
Date: Mon, 10 Nov 2014 16:02:44 -0800
Message-ID: <20141111000243.GI31454@atomide.com>
References: <1413922949-22300-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:26894 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203AbaKKAD2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Nov 2014 19:03:28 -0500
Content-Disposition: inline
In-Reply-To: <1413922949-22300-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tero Kristo <t-kristo@ti.com>

* Nishanth Menon <nm@ti.com> [141021 13:23]:
> Hi,
> 
> This is a small step towards getting rid of static dependency logic
> from mach-omap2. As part of this, we split the list of static dep
> map from the function implementing it. This should eventually aid in
> helping remove the tables from the kernel to the device tree at a
> later point in time of cleanup.
> 
> Series based on v3.18-rc1 and could be a 3.19-rc1 material.

Applying into omap-for-3.19/soc thanks.

Tony
