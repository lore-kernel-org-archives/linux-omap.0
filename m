From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv7 00/36] ARM: OMAP: clock data conversion to DT
Date: Fri, 11 Oct 2013 22:26:08 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1310112223570.27397@utopia.booyaka.com>
References: <1380098922-30340-1-git-send-email-t-kristo@ti.com> <524EE00F.7010208@ti.com> <20131007021556.GV8949@atomide.com> <52525642.8010307@ti.com> <20131007154103.GW8949@atomide.com> <20131007190322.GY8949@atomide.com> <alpine.DEB.2.02.1310091551540.30199@utopia.booyaka.com>
 <alpine.DEB.2.02.1310091858411.30199@utopia.booyaka.com> <525654AE.7060009@ti.com> <alpine.DEB.2.02.1310111749180.27397@utopia.booyaka.com> <5258421D.8030006@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:60892 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751807Ab3JKW0K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Oct 2013 18:26:10 -0400
In-Reply-To: <5258421D.8030006@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, mturquette@linaro.org, linux-omap@vger.kernel.org, nm@ti.com, khilman@linaro.org, pdeschrijver@nvidia.com, rnayak@ti.com, bcousson@baylibre.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, swarren@nvidia.com, mark.rutland@arm.com

On Fri, 11 Oct 2013, Tero Kristo wrote:

> Well, even if you sign something, you can still update it. Writing any
> software to true OTP memory is one way to commit suicide IMO. How many nasty
> bugs have you seen with ROM code? Also, if people want to make their custom
> security solutions which are not supported by the kernel, why should the
> kernel care about it? We don't know the details, and can't influence the
> design, so we can't prepare for it anyway.

The point is that newer kernels need to be compatible with older DT data: 
that's the "stable ABI" criterion that's been discussed quite a bit.  The 
worst-case scenario if the bindings are at a top-level node and not fully 
cooked is that it can make it very difficult, if not impossible, to have 
this forward compatibility for the DT data without having extremely nasty 
hacks.


- Paul
