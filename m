From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 0/5 V2 RESEND] ARM: OMAP: TLL driver implementation for
 USB host driver
Date: Mon, 2 Jul 2012 16:31:20 +0200
Message-ID: <20120702143120.GF22065@sortiz-mobl>
References: <1340709962-15726-1-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:58814 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750793Ab2GBOUF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Jul 2012 10:20:05 -0400
Content-Disposition: inline
In-Reply-To: <1340709962-15726-1-git-send-email-keshava_mgowda@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Keshava Munegowda <keshava_mgowda@ti.com>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, balbi@ti.com, parthab@india.ti.com, paul@pwsan.com, b-cousson@ti.com, sshtylyov@mvista.com

Hi Keshava,

On Tue, Jun 26, 2012 at 04:56:02PM +0530, Keshava Munegowda wrote:
> The TLL configuration is removed from the UHH driver and implemented as
> a seperate platform driver. Now, the UHH driver configures the TLL
> through API's exported by the TLL platform driver. The TLL is an
> has independent hardware mod structure for in OMAP3 and later chips,
> hence an dedicated platform driver is created.
I'm sort of ok with that split although the new driver is definitely not an
MFD one, but I guess there's no better place for it.
Now, a few comments before applying it:

- I'd appreciate to get ACKs from e.g. Tony for the OMAP parts.
- Patch #3 doesn't apply on top of my for-next branch. Would you mind rebasing
  it properly ?
- Fix the coypright years to 2012.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
