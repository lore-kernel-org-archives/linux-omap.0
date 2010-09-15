From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 1/2] Revert "OMAP: omap_device: add
 omap_device_is_valid()"
Date: Wed, 15 Sep 2010 16:38:16 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1009151637050.458@utopia.booyaka.com>
References: <1284489714-14705-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37999 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753940Ab0IOWiR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Sep 2010 18:38:17 -0400
In-Reply-To: <1284489714-14705-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

On Tue, 14 Sep 2010, Kevin Hilman wrote:

> From: Kevin Hilman <khilman@ti.com>
> 
> This reverts commit 0007122ad85cc36b1c18c0b59344093ca210d206.
> 
> The dereference method of checking for a valid omap_device when
> wrapping a platform_device is rather unsafe and dangerous.
> 
> Instead, a better way of checking for a valid omap-device is
> to use a common parent device for all omap_devices, then a check
> can simply be made using the device parent.  The only user of this
> API was the initial version of the runtime PM core for OMAP.  This
> has now been switched to check device parent, so there are no more
> users of this API.
> 
> Signed-off-by: Kevin Hilman <khilman@ti.com>

Agreed, this is a much better approach.

Acked-by: Paul Walmsley <paul@pwsan.com>


- Paul
