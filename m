From: Kevin Hilman <khilman@ti.com>
Subject: Re: [GIT PULL] OMAP: omap_device cleanup for v3.2
Date: Thu, 15 Sep 2011 16:56:32 -0700
Message-ID: <87y5xps6kv.fsf@ti.com>
References: <87mxe5tlzv.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:49635 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934969Ab1IOX4g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Sep 2011 19:56:36 -0400
Received: by mail-yi0-f42.google.com with SMTP id 12so2758691yib.29
        for <linux-omap@vger.kernel.org>; Thu, 15 Sep 2011 16:56:35 -0700 (PDT)
In-Reply-To: <87mxe5tlzv.fsf@ti.com> (Kevin Hilman's message of "Thu, 15 Sep
	2011 16:38:12 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Russell King <rmk@arm.linux.org.uk>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Kevin Hilman <khilman@ti.com> writes:

> Please pull this omap_device cleanup series for v3.2.  This sets the
> groundwork for Benoit's DT infrastructure work.

Turns out this series has a dependency on a patch[1] in Russell's
for-next branch.

Russell, any chance of picking this patch into your devel-stable so we
have a fixed point to merge with?

Thanks,

Kevin


[1]
commit 456f69c544d4298e921dc0c606492cdbaa60b34b
Author: Kevin Hilman <khilman@deeprootsystems.com>
Date:   Tue Sep 6 21:04:10 2011 +0100

    ARM: 7082/1: platform_device: pdev_archdata: add omap_device pointer
    
    Add omap_device pointer to the ARM-specific arch data in the
    platform_device.  This will be used to attach OMAP-specific
    device-data to the platform device with device lifetime.
    
    Suggested-by: Russell King <rmk+kernel@arm.linux.org.uk>
    
    Acked-by: Grant Likely <grant.likely@secretlab.ca>
    Signed-off-by: Kevin Hilman <khilman@ti.com>
    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
