From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC][PATCH 1/2] OMAP4: sDMA drvier: adding OMAP kConfig option CONFIG_OMAP_DMA_DESCRIPTOR_LOAD
Date: Wed, 12 Aug 2009 16:39:25 -0700
Message-ID: <87k518ppoy.fsf@deeprootsystems.com>
References: <0680EC522D0CC943BC586913CF3768C003790C62AD@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.171]:51837 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752532AbZHLXj0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Aug 2009 19:39:26 -0400
Received: by wf-out-1314.google.com with SMTP id 26so115449wfd.4
        for <linux-omap@vger.kernel.org>; Wed, 12 Aug 2009 16:39:27 -0700 (PDT)
In-Reply-To: <0680EC522D0CC943BC586913CF3768C003790C62AD@dbde02.ent.ti.com> (Venkatraman S.'s message of "Thu\, 13 Aug 2009 01\:31\:34 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

"S, Venkatraman" <svenkatr@ti.com> writes:

> The hardware feature is available on OMAP4430 and also expected to be 
> in OMAP3630. Hence the feature flag will control the inclusion of the additional functions.
>
> Addition of omap kconfig option CONFIG_OMAP_DMA_DESCRIPTOR_LOAD.

Short version: (a.k.a caveman version)

- Compile-time option: bad.
- Run-time option: good.

Long version: 

Without looking at the docs, I would hope that the some revision reg
or similar would report whether this feature is available or not.  The
user configuring the kernel should not have to know whether his SoC
has this feature or not.

Kevin
