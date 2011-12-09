From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP3: hsmmc: fix MMC 2 setup for AM35x
Date: Thu, 8 Dec 2011 16:31:42 -0800
Message-ID: <20111209003142.GG31337@atomide.com>
References: <1322559468-5883-1-git-send-email-grinberg@compulab.co.il>
 <4EE10F20.5080806@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:20646 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750836Ab1LIAbo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Dec 2011 19:31:44 -0500
Content-Disposition: inline
In-Reply-To: <4EE10F20.5080806@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Igor Grinberg <grinberg@compulab.co.il> [111208 10:53]:
> ping
> 
> Tony,
> I'd like this to go into 3.3, can it?
> 
> On 11/29/11 11:37, Igor Grinberg wrote:
> > AM35x MMC 2 controller has internal clock loopback setting which cannot
> > be utilized without this patch and thus SDIO devices connected to this
> > controller and depend on this setting will fail to initialize.

Yes seems OK for now so applying into omap driver branch.

Regards,

Tony
