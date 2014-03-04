From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 13/14] ARM: OMAP24xx: clock: remove legacy clock data
Date: Tue, 4 Mar 2014 13:28:11 -0800
Message-ID: <20140304212811.GA8705@atomide.com>
References: <1393924700-6510-1-git-send-email-t-kristo@ti.com>
 <1393924700-6510-14-git-send-email-t-kristo@ti.com>
 <20140304173200.GA17470@atomide.com>
 <5316217C.2070906@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:22487 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756002AbaCDV2S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Mar 2014 16:28:18 -0500
Content-Disposition: inline
In-Reply-To: <5316217C.2070906@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, nm@ti.com, mturquette@linaro.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [140304 10:58]:
> On 03/04/2014 07:32 PM, Tony Lindgren wrote:
> >* Tero Kristo <t-kristo@ti.com> [140304 01:22]:
> >>This is no longer needed as clock data is provided through DT.
> >
> >Looks like there's a new error even before applying this patch in
> >the series as I'm now getting the following oops on n8x0. So cannot
> >test this patch yet.
> 
> Is this with OMAP2 only boot?

Yeah that's with omap2 only.

Tony
