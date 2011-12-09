From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/3] arm/dts: OMAP: Remove bootargs node from board
 files
Date: Thu, 8 Dec 2011 16:55:37 -0800
Message-ID: <20111209005537.GL31337@atomide.com>
References: <y>
 <1323190149-6492-3-git-send-email-b-cousson@ti.com>
 <4EDE59B8.1070808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:22777 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753249Ab1LIAzm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Dec 2011 19:55:42 -0500
Content-Disposition: inline
In-Reply-To: <4EDE59B8.1070808@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Benoit Cousson <b-cousson@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@secretlab.ca>

* Rob Herring <robherring2@gmail.com> [111206 09:35]:
> Benoit,
> 
> On 12/06/2011 10:49 AM, Benoit Cousson wrote:
> > Since 3.2, the CONFIG_ARM_ATAG_DTB_COMPAT config allows
> > an old bootloader to still use ATAG to provide cmdline.
> > 
> > Remove chosen/bootargs from the DTS board files.
> > 
> > Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> > Cc: Rob Herring <rob.herring@calxeda.com>
> 
> Acked-by: Rob Herring <rob.herring@calxeda.com>

Thanks applying patches 1 & 2 into omap dt branch.
Still wondering if we should combine patch 3 into
some other cleanup to avoid extra churn..

Tony
