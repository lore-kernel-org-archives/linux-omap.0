From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH v3 2/5] mfd: tps65217: Set PMIC to shutdown on PWR_EN
 toggle
Date: Wed, 21 Nov 2012 14:47:58 +0100
Message-ID: <20121121134758.GS18738@sortiz-mobl>
References: <1353404927-14412-1-git-send-email-anilkumar@ti.com>
 <1353404927-14412-3-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:56627 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753083Ab2KUNsD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Nov 2012 08:48:03 -0500
Content-Disposition: inline
In-Reply-To: <1353404927-14412-3-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: AnilKumar Ch <anilkumar@ti.com>
Cc: a.zummo@towertech.it, tony@atomide.com, grant.likely@secretlab.ca, broonie@opensource.wolfsonmicro.com, rob.herring@calxeda.com, rtc-linux@googlegroups.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Colin Foe-Parker <colin.foeparker@logicpd.com>

Hi Anilkumar,

On Tue, Nov 20, 2012 at 03:18:44PM +0530, AnilKumar Ch wrote:
> From: Colin Foe-Parker <colin.foeparker@logicpd.com>
> 
> Set tps65217 PMIC status to OFF if power enable toggle is supported.
> By setting this bit to 1 to enter PMIC to OFF state when PWR_EN pin
> is pulled low. Also adds a DT flag to specify that device pmic
> supports shutdown control or not.
> 
> Signed-off-by: Colin Foe-Parker <colin.foeparker@logicpd.com>
> [anilkumar@ti.com: move the additions to tps65217 MFD driver]
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> ---
>  .../devicetree/bindings/regulator/tps65217.txt     |    4 ++++
>  drivers/mfd/tps65217.c                             |   12 ++++++++++++
>  2 files changed, 16 insertions(+)
Applied, thanks.
I suppose you're not expecting the whole patchset to go through one tree ?

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
