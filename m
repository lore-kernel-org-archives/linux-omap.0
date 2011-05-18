From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PM-WIP/voltdm_c][PATCH 02/11] OMAP3+: PM: voltage: add
 required debugfs interfaces
Date: Wed, 18 May 2011 10:59:48 +0300
Message-ID: <20110518075948.GD6815@atomide.com>
References: <1305695854-9638-1-git-send-email-nm@ti.com>
 <1305695854-9638-3-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:35221 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755127Ab1ERH7x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 May 2011 03:59:53 -0400
Content-Disposition: inline
In-Reply-To: <1305695854-9638-3-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: kevin <khilman@ti.com>, linux-omap <linux-omap@vger.kernel.org>

* Nishanth Menon <nm@ti.com> [110518 08:13]:
> Kevin's patch:
> OMAP3+: voltage: remove unneeded debugfs interface
> 
> removed ability to check the voltages in the domains.
> This puts a crunch on validation we can do, hence we
> re-introduce them back in
 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm/mach-omap2/voltage.c |   66 +++++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/voltage.h |    1 +
>  2 files changed, 67 insertions(+), 0 deletions(-)

Hmm, this seems to be adding the debug code instead?

Tony
