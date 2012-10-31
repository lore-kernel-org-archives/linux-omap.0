From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] capebus moving omap_devices to mach-omap2
Date: Wed, 31 Oct 2012 15:16:09 -0700
Message-ID: <20121031221608.GD15766@atomide.com>
References: <1351783082-11411-1-git-send-email-panto@antoniou-consulting.com>
 <20121031175219.GH12739@atomide.com>
 <C9715CB7-D3E2-4CA7-8A93-2B10E8B70640@antoniou-consulting.com>
 <20121031180935.GL12739@atomide.com>
 <50918223.6080003@ti.com>
 <8AD2F7AF-8315-442B-A394-1A38DAB29F52@antoniou-consulting.com>
 <20121031212639.GQ12739@atomide.com>
 <8B058B00-6C21-4410-A24B-75651D49F6EC@antoniou-consulting.com>
 <20121031214310.GA15766@atomide.com>
 <E08E316D-E7C5-4AFC-8C82-6423E5128FAA@antoniou-consulting.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:33918 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759307Ab2JaWQM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Oct 2012 18:16:12 -0400
Content-Disposition: inline
In-Reply-To: <E08E316D-E7C5-4AFC-8C82-6423E5128FAA@antoniou-consulting.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: Benoit Cousson <b-cousson@ti.com>, linux-kernel@vger.kernel.org, Koen Kooi <koen@dominion.thruhere.net>, Matt Porter <mporter@ti.com>, Russ Dill <Russ.Dill@ti.com>, linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>

* Pantelis Antoniou <panto@antoniou-consulting.com> [121031 15:02]:
> 
> So when device's node is 'disabled' of_platform_device_create_pdata()
> will not create the device.
> 
> Now, of course it is possible to re-trigger the platform's probe method
> to be called, and in fact I do so in the capebus patches.

You should fix this in generic way then rather than working
around it in capebus. The same problem exists changing
between different functionality for the shared pins,
let's say between USB pins and UART pins if you want a
serial debug console on some phone.

Regards,

Tony
