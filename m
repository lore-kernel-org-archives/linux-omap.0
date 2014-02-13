From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: add missing ARCH_HAS_OPP
Date: Thu, 13 Feb 2014 14:57:50 -0800
Message-ID: <20140213225749.GG28216@atomide.com>
References: <1389816038-17363-1-git-send-email-nm@ti.com>
 <52E901B3.5070307@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:50323 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751923AbaBMW6C (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Feb 2014 17:58:02 -0500
Content-Disposition: inline
In-Reply-To: <52E901B3.5070307@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nikhil.nd@ti.com, t-kristo@ti.com

* Nishanth Menon <nm@ti.com> [140129 05:29]:
> Hi Tony,
> On 01/15/2014 02:00 PM, Nishanth Menon wrote:
> > OMAP5, DRA7, AM43xx all have OPPs. So select the same to allow SoC
> > only configuration boot to work with OPP.
> > 
> > Reported-by: Nikhil Devshatwar <nikhil.nd@ti.com>
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > ---
> > 
> > For DRA7, depends on: https://patchwork.kernel.org/patch/3465411/
> 
> Considering that dependent patch is now on linus master,
> a gentle ping -> The patch does apply on latest linus master commit
> 0e47c969c65e213421450c31043353ebe3c67e0c

Thanks applying into omap-for-v3.14/fixes.

Tony
