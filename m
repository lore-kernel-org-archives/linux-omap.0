From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH] Fix build breakage in omap-usb-host.c
Date: Tue, 1 May 2012 11:56:46 +0200
Message-ID: <20120501095646.GA20224@sortiz-mobl>
References: <1335084498-17918-1-git-send-email-Russ.Dill@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:57161 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754663Ab2EAJ4r (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 May 2012 05:56:47 -0400
Content-Disposition: inline
In-Reply-To: <1335084498-17918-1-git-send-email-Russ.Dill@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <Russ.Dill@ti.com>
Cc: linux-omap@vger.kernel.org, Keshava Munegowda <Keshava_mgowda@ti.com>

Hi Russ,

On Sun, Apr 22, 2012 at 01:48:18AM -0700, Russ Dill wrote:
> 'ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset issue' removes the include for
> linux/gpio.h from omap-usb-host.c. This include indirectly includes plat/cpu.h
> which is required by omap-usb-host.c. Fix the build breakage by including
> it directly.
> 
> Signed-off-by: Russ Dill <Russ.Dill@ti.com>
Patch applied, thanks.
I'm planning to send an MFD pull request including this fix to Linus,
in time for rc6.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
