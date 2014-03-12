From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 5/9] ARM: dts: omap3-overo: Add HSUSB PHY
Date: Wed, 12 Mar 2014 10:19:56 -0700
Message-ID: <20140312171955.GB30897@atomide.com>
References: <1394220139-1760-1-git-send-email-florian.vaussard@epfl.ch>
 <1394220139-1760-6-git-send-email-florian.vaussard@epfl.ch>
 <531D9452.6040501@ti.com>
 <531DD6A8.7010406@epfl.ch>
 <531EDAAC.8030509@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53987 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754442AbaCLRUD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Mar 2014 13:20:03 -0400
Content-Disposition: inline
In-Reply-To: <531EDAAC.8030509@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: florian.vaussard@epfl.ch, Benoit Cousson <bcousson@baylibre.com>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Roger Quadros <rogerq@ti.com> [140311 02:46]:
> 
> Any sane design would maintain register offsets but it doesn't seem so with
> omap34xx vs omap36xx. So my assumption was wrong.
> 
> I'll ack this patch.

OK thanks, I'll apply the whole series with your ack to omap-for-v3.15/dt-overo.

Regards,

Tony
