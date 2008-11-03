From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH] BRIDGE Power Management cleanup
Date: Mon, 03 Nov 2008 13:19:59 +0200 (EET)
Message-ID: <20081103.131959.108134469.Hiroshi.DOYU@nokia.com>
References: <27F9C60D11D683428E133F85D2BB4A5303E1038299@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:20517 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755141AbYKCLUe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Nov 2008 06:20:34 -0500
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A5303E1038299@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: x00omar@ti.com
Cc: linux-omap@vger.kernel.org, vpasam@ti.com, bshah@ti.com, grgupta@ti.com

Hi Omar,

I want to try this patch, but would it be possible to tell me which
patches are expected to be applied in advance of this one?

I tried with pm-20081006 branch but it didn't succeed.

  Hiroshi DOYU

From: "ext Ramirez Luna, Omar" <x00omar@ti.com>
Subject: [PATCH] BRIDGE Power Management cleanup
Date: Fri, 31 Oct 2008 20:38:43 -0500

> Hi All,
> 
> Here it is Bridge Power Management cleanup patch that applies in top of currently bridge patches series for linux-omap kernel.
> 
> ---
> 
> From: Ramesh Gupta <grgupta@ti.com>
> Date: Fri, 31 Oct 2008 18:09:16 -0500
> Subject: [PATCH] BRIDGE Power Management cleanup
> 
> 1. Removed DISABLE_BRIDGE_* Flags.
> 2. Used platform_data for calling the functions.
> 3. Check for CONFIG_CPU_FREQ added while boosting the opp.
> 4. Removed CONFIG_OMAP3_PM flag.
