From: Romit Dasgupta <romit@ti.com>
Subject: Re: Strange boot messages on mainline + omap3_defconfig
Date: Fri, 18 Dec 2009 18:05:16 +0530
Message-ID: <4B2B7704.7030707@ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB031DB9AB9D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55041 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727AbZLRMfW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Dec 2009 07:35:22 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id nBICZIHR025464
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 18 Dec 2009 06:35:20 -0600
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB031DB9AB9D@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> This was on a 3630 SDP.
> 
> Won't be looking at this for a while, so just reporting it.
> 
> - Anand
> 
> 0x588
> [    0.000000] mux: Unknown ball offset 0x58a
> [    0.000000] mux: Unknown ball offset 0x0
> [    0.000000] mux: Unknown ball offset 0x2
CONFIG_OMAP_PACKAGE_CBP is undefined for you IMHO.
