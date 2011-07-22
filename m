From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC/PATCH 6/7] OMAP: omap_device: device register functions now
 take platform_device pointer
Date: Fri, 22 Jul 2011 00:16:06 -0600
Message-ID: <20110722061606.GA18383@ponder.secretlab.ca>
References: <1311292338-11830-1-git-send-email-khilman@ti.com>
 <1311292338-11830-8-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:60805 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752172Ab1GVGQJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Jul 2011 02:16:09 -0400
Received: by yia27 with SMTP id 27so1035045yia.19
        for <linux-omap@vger.kernel.org>; Thu, 21 Jul 2011 23:16:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1311292338-11830-8-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, "G. Manjunath Kondaiah" <manjugk@ti.com>, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

On Thu, Jul 21, 2011 at 04:52:17PM -0700, Kevin Hilman wrote:
> The internal device register functions do not need or use any omap_device
> internals, so pass in a platform_device pointer instead of an omap_device
> pointer.
> 
> Signed-off-by: Kevin Hilman <khilman@ti.com>

FWIW, all 6 of these cleanups look sane.

Reviewed-by: Grant Likely <grant.likely@secretlab.ca>

