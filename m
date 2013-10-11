From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv7 00/36] ARM: OMAP: clock data conversion to DT
Date: Fri, 11 Oct 2013 17:54:27 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1310111749180.27397@utopia.booyaka.com>
References: <1380098922-30340-1-git-send-email-t-kristo@ti.com> <524EE00F.7010208@ti.com> <20131007021556.GV8949@atomide.com> <52525642.8010307@ti.com> <20131007154103.GW8949@atomide.com> <20131007190322.GY8949@atomide.com> <alpine.DEB.2.02.1310091551540.30199@utopia.booyaka.com>
 <alpine.DEB.2.02.1310091858411.30199@utopia.booyaka.com> <525654AE.7060009@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:58046 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754410Ab3JKRy2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Oct 2013 13:54:28 -0400
In-Reply-To: <525654AE.7060009@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, mturquette@linaro.org, linux-omap@vger.kernel.org, nm@ti.com, khilman@linaro.org, pdeschrijver@nvidia.com, rnayak@ti.com, bcousson@baylibre.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, swarren@nvidia.com, mark.rutland@arm.com

On Thu, 10 Oct 2013, Tero Kristo wrote:

> On 10/09/2013 09:59 PM, Paul Walmsley wrote:
> > Eh, one correction:
> > 
> > On Wed, 9 Oct 2013, Paul Walmsley wrote:
> > 
> > > We could easily wind up with kernels that won't boot at all when used
> > > with newer DT data.
> > 
> > This is a misstatement of the issue: the concern here is that newer
> > kernels may not boot at all with older DT data - which could easily be in
> > locked areas of the flash or firmware.
> 
> I wonder who would be crazy enough to put DT data into a locked area, and to
> what purpose. If you can update the kernel, there is no point locking down DT
> data, this will just cause you unnecessary misery.

The DT data will be used by bootloaders also :-(

In situations where the bootloaders are signed and locked, the security 
people are also insisting that the DT data be signed and locked.


- Paul
