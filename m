From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 05/10] arm: omap: omap2plus_defconfig: enable ECAP and
 EHRPWM
Date: Fri, 21 Nov 2014 16:31:54 -0800
Message-ID: <20141122003154.GL7046@atomide.com>
References: <1416334028-7766-1-git-send-email-balbi@ti.com>
 <1416334028-7766-5-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:28288 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752314AbaKVAcG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Nov 2014 19:32:06 -0500
Content-Disposition: inline
In-Reply-To: <1416334028-7766-5-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

* Felipe Balbi <balbi@ti.com> [141118 10:08]:
> Many of AM335x and AM437x hook backlight to
> one of these two devices. By enabling their
> drivers we make sure pwm-backlight can do
> its thing.

Applying patches 1 - 5 to omap-for-v3.19/soc thanks.

Tony
