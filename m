From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 14/14] ARM: OMAP3: clock: remove legacy clock data
Date: Wed, 5 Mar 2014 08:28:37 -0800
Message-ID: <20140305162837.GB4983@atomide.com>
References: <1393924700-6510-1-git-send-email-t-kristo@ti.com>
 <1393924700-6510-15-git-send-email-t-kristo@ti.com>
 <20140304173242.GB17470@atomide.com>
 <5316D318.8080405@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58202 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573AbaCEQ2m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Mar 2014 11:28:42 -0500
Content-Disposition: inline
In-Reply-To: <5316D318.8080405@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, nm@ti.com, mturquette@linaro.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [140304 23:35]:
> On 03/04/2014 07:32 PM, Tony Lindgren wrote:
> >* Tero Kristo <t-kristo@ti.com> [140304 01:22]:
> >>This is no longer needed as clock data is provided through DT.
> >
> >And this one we cannot apply yet until omap3 is booting in device tree
> >only mode.
> 
> What is missing to achieve this? Some boards are not booting in DT
> mode yet or?

It seems that the last missing pieces are the DSS bindings and
.dts file for the pandora. At least I can't think of anything
else that's missing or could not be done using pdata-quirks.c.

Regards,

Tony
