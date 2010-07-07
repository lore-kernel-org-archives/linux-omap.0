From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 0/3] Devkit8000: Use DIE id to initialize dm9000 MAC
 address
Date: Wed, 7 Jul 2010 15:09:42 +0300
Message-ID: <20100707120942.GP1920@atomide.com>
References: <1278378604-15802-1-git-send-email-kanru@0xlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61336 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752882Ab0GGMJt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jul 2010 08:09:49 -0400
Content-Disposition: inline
In-Reply-To: <1278378604-15802-1-git-send-email-kanru@0xlab.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kan-Ru Chen <kanru@0xlab.org>
Cc: linux-omap@vger.kernel.org, Thomas Weber <weber@corscience.de>

* Kan-Ru Chen <kanru@0xlab.org> [100706 04:09]:
> This patch series add the omap_get_die_id interface and use that
> function to construct a MAC address for use by dm9000.

Thanks, I've applied these into omap for-next branch.

Regards,

Tony
