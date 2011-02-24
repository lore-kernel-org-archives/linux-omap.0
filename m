From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 09/13] OMAP: McBSP: use omap_device APIs to modify
 SYSCONFIG
Date: Thu, 24 Feb 2011 11:10:38 -0800
Message-ID: <20110224191038.GD20560@atomide.com>
References: <1298540817-15874-1-git-send-email-kishon@ti.com>
 <1298540817-15874-10-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:39523 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755545Ab1BXTKn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Feb 2011 14:10:43 -0500
Content-Disposition: inline
In-Reply-To: <1298540817-15874-10-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, broonie@opensource.wolfsonmicro.com, jhnikula@gmail.com, peter.ujfalusi@nokia.com, p-basak2@ti.com, charu@ti.com, shubhrajyoti@ti.com

* Kishon Vijay Abraham I <kishon@ti.com> [110224 01:50]:
> McBSP2/3 in OMAP3 has sidetone feature which requires autoidle
> to be disabled before starting the sidetone. Also SYSCONFIG
> register has to be set with smart idle or no idle depending on the
> dma op mode (threshold or element sync). For doing these operations
> dynamically at runtime, omap_device APIs are used to modify SYSCONFIG register.

I've modified this patch to compile by leaving out the omap_device idle calls.

Please send those changes as a separate patch and coordinate it with
Kevin's PM changes.


Regards,

Tony
