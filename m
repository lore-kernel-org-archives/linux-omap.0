From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap3: Add minimal OMAP3 IGEP module support.
Date: Fri, 1 Oct 2010 16:19:47 -0700
Message-ID: <20101001231947.GJ3117@atomide.com>
References: <1285971985-5662-1-git-send-email-eballetbo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:57087 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751735Ab0JAXTx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 19:19:53 -0400
Content-Disposition: inline
In-Reply-To: <1285971985-5662-1-git-send-email-eballetbo@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Enric Balletbo i Serra <eballetbo@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Enric Balletbo i Serra <eballetbo@gmail.com> [101001 15:18]:
> The OMAP3 IGEP module is a low-power, high performance production-ready
> system-on-module (SOM) based on TI's OMAP3 family.

Looks OK to me, but also looks like you're missing the uncompress.h
DEBUG_LL/EARLY_PRINTK entry?

Regards,

Tony
