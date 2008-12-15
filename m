From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Provide the set_power at TWL4030 MMC
Date: Mon, 15 Dec 2008 10:59:17 -0800
Message-ID: <20081215185915.GY10664@atomide.com>
References: <20081127075345.GA17896@july> <200811270912.11557.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62898 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004AbYLOS7i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Dec 2008 13:59:38 -0500
Content-Disposition: inline
In-Reply-To: <200811270912.11557.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Kyungmin Park <kmpark@infradead.org>, linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [081127 09:12]:
> On Wednesday 26 November 2008, Kyungmin Park wrote:
> > Custom board powered by VAUX2 and VAUX4 for MMC instead of VMMC
> > Also it uses VMMC for MMC core power not voltage.
> > 
> > MMC1: uses VMMC1(voltage) and VMMC2(Vdd)
> > MMC2: uses VAUX2(voltage) and VAUX4(Vdd)
> > 
> > To address this issue, platform uses its custom power function.
> 
> It would be a lot cleaner to do this with the regulator
> framework ... e.g. board init code associates each MMC
> controller with a few regulators using logical IDs, and
> the HSMMC glue just uses those regulators.

Let's hold on with this patch until we first have the pending patches
in the mainline, and can then convert the existing code to use regulator
fwk. Then let's update this patch and apply it.

Regards,

Tony
