From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/8] OMAP4: hwmod data: Add McSPI
Date: Thu, 17 Feb 2011 09:05:14 -0800
Message-ID: <20110217170514.GS20795@atomide.com>
References: <1297938289-8678-1-git-send-email-b-cousson@ti.com>
 <1297938289-8678-3-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:32255 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756941Ab1BQRFi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Feb 2011 12:05:38 -0500
Content-Disposition: inline
In-Reply-To: <1297938289-8678-3-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: paul@pwsan.com, khilman@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>

Hi,

Noticed one cosmetic thing below.

* Benoit Cousson <b-cousson@ti.com> [110217 02:23]:
> Update omap4 hwmod file with McSPI info.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Signed-off-by: Charulatha V <charu@ti.com>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> Reviewed-by: Kevin Hilman <khilman@ti.com>
> ---
  ^^^ That should not be here, it shows up in your commit.

> [b-cousson@ti.com: Remove dev_attr to prevent dependency
> with device code. It will have to be re-added along with
> the original series]

As the above should be part of the commit too. Care to
refresh your branch for that?

Regards,

Tony
