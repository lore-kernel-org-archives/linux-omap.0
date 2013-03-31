From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/8] ARM: OMAP2+: hwmod: Remove unused _HWMOD_WAKEUP_ENABLED
 flag
Date: Sun, 31 Mar 2013 01:58:39 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1303310158280.6436@utopia.booyaka.com>
References: <1361354272-18089-1-git-send-email-santosh.shilimkar@ti.com> <1361354272-18089-2-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:35947 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755421Ab3CaB6k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 30 Mar 2013 21:58:40 -0400
In-Reply-To: <1361354272-18089-2-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, rnayak@ti.com, linux@arm.linux.org.uk, khilman@deeprootsystems.com, tony@atomide.com, sourav.poddar@ti.com, vaibhav.bedia@ti.com, linux-arm-kernel@lists.infradead.org

On Wed, 20 Feb 2013, Santosh Shilimkar wrote:

> From: Rajendra Nayak <rnayak@ti.com>
> 
> _HWMOD_WAKEUP_ENABLED is currently unused across the hwmod
> framework. Just get rid of it, so we have one less flag to
> worry about.
> 
> Tested-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Thanks, queued for 3.9.

- Paul
