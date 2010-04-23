From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v4 1/1] Registering sgx device and it's platform data
Date: Fri, 23 Apr 2010 09:44:39 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1004230943370.29720@utopia.booyaka.com>
References: <19F8576C6E063C45BE387C64729E7394044E1EB744@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:53063 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757680Ab0DWPok (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Apr 2010 11:44:40 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044E1EB744@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Agarwal, Preshit" <preshit.agarwal@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "Pais, Allen" <allen.pais@ti.com>

On Thu, 22 Apr 2010, Agarwal, Preshit wrote:

> In this patch SGX powervr_device is registered with it's platform specific
> data to provide information about setting constraint through
> omap_pm_set_min_bus_tput.
> This patch removes the requirement of EXPORT_SYMBOL for the same function.
> 
> Signed-off-by: Preshit Agarwal <preshit.agarwal@ti.com>

Reviewed-by: Paul Walmsley <paul@pwsan.com>

That's the right way to pass these function pointers.


- Paul
