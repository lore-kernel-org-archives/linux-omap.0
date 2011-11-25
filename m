From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv6 1/6] regulator: core: add support for external
 get/set_voltage
Date: Fri, 25 Nov 2011 18:48:32 +0000
Message-ID: <20111125184832.GK5315@opensource.wolfsonmicro.com>
References: <1322238562-19943-1-git-send-email-t-kristo@ti.com>
 <1322238562-19943-2-git-send-email-t-kristo@ti.com>
 <20111125165214.GG5315@opensource.wolfsonmicro.com>
 <1322241632.13828.10.camel@sokoban>
 <20111125172945.GJ5315@opensource.wolfsonmicro.com>
 <1322243943.13828.13.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:57711 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751445Ab1KYSsf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Nov 2011 13:48:35 -0500
Content-Disposition: inline
In-Reply-To: <1322243943.13828.13.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, lrg@ti.com, gg@slimlogic.co.uk, rnayak@ti.com, b-cousson@ti.com

On Fri, Nov 25, 2011 at 07:59:03PM +0200, Tero Kristo wrote:
> On Fri, 2011-11-25 at 17:29 +0000, Mark Brown wrote:

> > No, that's clearly going to break multi-board kernel images.  If this
> > is something board specific platform/device tree data sounds like the
> > way forwards.

> Okay, so I will update this patch with proper locking and you should be
> okay with that approach? Usually in the omap case we just want to switch
> to using the external controller during init time and leave it be like
> that, there is no really use-case as such for runtime switching of
> controller, except maybe for some experimental / debug usage.

No - as I said "platform/device tree data sounds like the way forwards."
