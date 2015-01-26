From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: OMAP: Add hwlock-base-id property to
 hwspinlock nodes
Date: Mon, 26 Jan 2015 12:55:39 -0800
Message-ID: <20150126205538.GH28663@atomide.com>
References: <1421269385-51381-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.ore.mailhop.org ([54.68.34.165]:57567 "EHLO
	smtp1.ore.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756024AbbAZU6o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Jan 2015 15:58:44 -0500
Content-Disposition: inline
In-Reply-To: <1421269385-51381-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>

* Suman Anna <s-anna@ti.com> [150114 13:06]:
> Add the generic property "hwlock-base-id" to the hwspinlock DT nodes
> on all applicable OMAP SoCS (OMAP4, OMAP5, DRA7, AM33xx and AM43xx).
> This common property is required by the hwspinlock core to be able
> to translate client locks properly. All the current OMAP SoCs only
> have a single instance of the IP, and so will use a common value of 0.

As it seems the base-id binding is still under a discussion,
I'll untag this one. Suman, please resend once the related
spinlock changes are queued.

Thanks,

Tony
