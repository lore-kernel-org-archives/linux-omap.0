From: Tony Lindgren <tony@atomide.com>
Subject: Re: Booting 3.9.0-rc2 on Beaglebone ?
Date: Tue, 19 Mar 2013 11:33:48 -0700
Message-ID: <20130319183347.GF16413@atomide.com>
References: <513F9394.6010306@mimc.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:32162 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757277Ab3CSSdu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Mar 2013 14:33:50 -0400
Content-Disposition: inline
In-Reply-To: <513F9394.6010306@mimc.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Jackson <mpfj-list@mimc.co.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

* Mark Jackson <mpfj-list@mimc.co.uk> [130312 13:48]:
> I'm struggling to get the latest kernel git to load on my beaglebone.
> 
> Error: unrecognized/unsupported machine ID (r1 = 0x00000e05).
> 
> I guess I'm missing some vital step ?

We're changing the mainline kernel tree to use device tree
based booting only.

So you need to either upgrade your bootloader to support device
tree based booting, or enable CONFIG_ARM_APPENDED_DTB and
ARM_ATAG_DTB_COMPAT in your .config and build u-image manually
with the .dtb appended to the zImage. Doing make dtbs will generate
you the am335x-bone.dtb to append.

Regards,

Tony
