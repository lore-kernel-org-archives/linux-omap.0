From: Romit Dasgupta <romit@ti.com>
Subject: Re: Strange boot messages on mainline + omap3_defconfig
Date: Fri, 18 Dec 2009 18:07:01 +0530
Message-ID: <4B2B776D.8000709@ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB031DB9AB9D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52359 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751060AbZLRMhJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Dec 2009 07:37:09 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id nBICb2Rq032376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 18 Dec 2009 06:37:04 -0600
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB031DB9AB9D@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Gadiyar, Anand wrote:
> I get some "mux: Unknown ball ..." messages booting
> v2.6.33-rc1 from Linux' tree (built with the omap3_defconfig).
> 
> This was on a 3630 SDP.
> 
> Won't be looking at this for a while, so just reporting it.
> 
> - Anand
> 
> 0x588
> [    0.000000] mux: Unknown ball offset 0x58a
> [    0.000000] mux: Unknown ball offset 0x58c
> [    0.000000] mux: Unknown ball offset 0x58e
> [    0.000000] mux: Unknown ball offset 0x590
> [    0.000000] mux: Unknown ball offset 0x578
> [    0.000000] mux: Unknown ball offset 0x57a
> [    0.000000] mux: Unknown ball offset 0x57c
> [    0.000000] mux: Unknown ball offset 0x57e
> [    0.000000] mux: Unknown ball offset 0x580
> [    0.000000] mux: Unknown ball offset 0x582
> [    0.000000] mux: Unknown ball offset 0x584
> [    0.000000] mux: Unknown ball offset 0x586
> [    0.000000] mux: Unknown ball offset 0x570
> [    0.000000] mux: Unknown ball offset 0x572
> [    0.000000] mux: Unknown ball offset 0x40
> [    0.000000] mux: Unknown ball offset 0x0
> [    0.000000] mux: Unknown ball offset 0x2
> 
> ....
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
Try this in you .config
CONFIG_OMAP_PACKAGE_CBB=y
CONFIG_OMAP_PACKAGE_CUS=y
CONFIG_OMAP_PACKAGE_CBP=y

