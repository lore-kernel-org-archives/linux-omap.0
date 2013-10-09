From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv7 00/36] ARM: OMAP: clock data conversion to DT
Date: Wed, 9 Oct 2013 12:24:21 -0700
Message-ID: <20131009192420.GE8313@atomide.com>
References: <1380098922-30340-1-git-send-email-t-kristo@ti.com>
 <524EE00F.7010208@ti.com>
 <20131007021556.GV8949@atomide.com>
 <52525642.8010307@ti.com>
 <20131007154103.GW8949@atomide.com>
 <20131007190322.GY8949@atomide.com>
 <alpine.DEB.2.02.1310091551540.30199@utopia.booyaka.com>
 <alpine.DEB.2.02.1310091858411.30199@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:32805 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753074Ab3JITY1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Oct 2013 15:24:27 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1310091858411.30199@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>, mturquette@linaro.org, linux-omap@vger.kernel.org, nm@ti.com, khilman@linaro.org, pdeschrijver@nvidia.com, rnayak@ti.com, bcousson@baylibre.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, swarren@nvidia.com, mark.rutland@arm.com

* Paul Walmsley <paul@pwsan.com> [131009 12:07]:
> Eh, one correction:
> 
> On Wed, 9 Oct 2013, Paul Walmsley wrote:
> 
> > We could easily wind up with kernels that won't boot at all when used 
> > with newer DT data.
> 
> This is a misstatement of the issue: the concern here is that newer 
> kernels may not boot at all with older DT data - which could easily be in 
> locked areas of the flash or firmware.

That's easy to avoid by allowing any combination of DT defined clocks,
loadable module clocks and /lib/firmware clocks depending on the use
case.

The older kernels have the clocks defined in DT, the newer kernels just
need to parse them.

Regards,

Tony
