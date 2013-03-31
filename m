From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 3/8] ARM: OMAP2+: hwmod: Always have OCP_SYSCONFIG.ENAWAKEUP
 enabled
Date: Sun, 31 Mar 2013 01:32:14 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1303310132000.6436@utopia.booyaka.com>
References: <1361354272-18089-1-git-send-email-santosh.shilimkar@ti.com> <1361354272-18089-4-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:35854 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755296Ab3CaBcP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 30 Mar 2013 21:32:15 -0400
In-Reply-To: <1361354272-18089-4-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, rnayak@ti.com, linux@arm.linux.org.uk, khilman@deeprootsystems.com, tony@atomide.com, sourav.poddar@ti.com, vaibhav.bedia@ti.com, linux-arm-kernel@lists.infradead.org

On Wed, 20 Feb 2013, Santosh Shilimkar wrote:

> From: Rajendra Nayak <rnayak@ti.com>
> 
> Get rid of all complexities around when to enable OCP_SYSCONFIG.ENAWAKEUP.
> It should be safe to have this set *always* for all IP blocks which
> have this control. It should be a *dont care* when the IP is in
> NO/FORCE modes of sidle/mstandby. As for the SMART/SMART_WKUP modes
> of sidle/mstandby the framework anyway sets this always.
> 
> Tested-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> Tested-by: Sourav Poddar <sourav.poddar@ti.com>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Some of the comments here:

http://marc.info/?l=linux-omap&m=136469345727226&w=2

apply to this patch as well.


- Paul
