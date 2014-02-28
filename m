From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: omap3 clocks: simplify ssi aliases
Date: Fri, 28 Feb 2014 14:03:06 -0800
Message-ID: <20140228220302.GF13624@atomide.com>
References: <52DE24DA.8050104@ti.com>
 <1390315061-14441-1-git-send-email-sre@debian.org>
 <20140213224914.GD28216@atomide.com>
 <20140214012546.GA7996@earth.universe>
 <52FE1E8D.7010807@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:22477 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752147AbaB1WDT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Feb 2014 17:03:19 -0500
Content-Disposition: inline
In-Reply-To: <52FE1E8D.7010807@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Sebastian Reichel <sre@debian.org>, mturquette@linaro.org, bcousson@baylibre.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [140214 05:50]:
> On 02/14/2014 03:25 AM, Sebastian Reichel wrote:
> >On Thu, Feb 13, 2014 at 02:49:14PM -0800, Tony Lindgren wrote:
> >>* Sebastian Reichel <sre@debian.org> [140121 06:39]:
> >>>update aliases for the ssi clocks ssi_ssr_fck, ssi_sst_fck and ssi_ick
> >>>to make them consistent for omap34xx and omap36xx. This makes it
> >>>possible to reference the clocks from generic omap3 dts files.
> >>
> >>Is this needed as a fix for v3.14-rc? If so, please let me know
> >>and ack if you want me to take it.
> >
> >The SSI driver will not arrive before 3.15 and 3.14 dts files do not
> >contain any SSI nodes.
> >
> >Thus it should be enough to queue it for 3.15 if it goes via the
> >same tree as the SSI dts patches.
> >
> >-- Sebastian
> >
> 
> The patch itself looks good to me, so acked.

Thanks applying into omap-for-v3.15/dt with Tero's ack.

Tony
