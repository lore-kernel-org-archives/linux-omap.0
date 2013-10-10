From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv7 00/36] ARM: OMAP: clock data conversion to DT
Date: Thu, 10 Oct 2013 10:18:06 +0300
Message-ID: <525654AE.7060009@ti.com>
References: <1380098922-30340-1-git-send-email-t-kristo@ti.com> <524EE00F.7010208@ti.com> <20131007021556.GV8949@atomide.com> <52525642.8010307@ti.com> <20131007154103.GW8949@atomide.com> <20131007190322.GY8949@atomide.com> <alpine.DEB.2.02.1310091551540.30199@utopia.booyaka.com> <alpine.DEB.2.02.1310091858411.30199@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42692 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750799Ab3JJHSk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Oct 2013 03:18:40 -0400
In-Reply-To: <alpine.DEB.2.02.1310091858411.30199@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, mturquette@linaro.org
Cc: linux-omap@vger.kernel.org, nm@ti.com, khilman@linaro.org, pdeschrijver@nvidia.com, rnayak@ti.com, bcousson@baylibre.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, swarren@nvidia.com, mark.rutland@arm.com

On 10/09/2013 09:59 PM, Paul Walmsley wrote:
> Eh, one correction:
>
> On Wed, 9 Oct 2013, Paul Walmsley wrote:
>
>> We could easily wind up with kernels that won't boot at all when used
>> with newer DT data.
>
> This is a misstatement of the issue: the concern here is that newer
> kernels may not boot at all with older DT data - which could easily be in
> locked areas of the flash or firmware.

I wonder who would be crazy enough to put DT data into a locked area, 
and to what purpose. If you can update the kernel, there is no point 
locking down DT data, this will just cause you unnecessary misery.

-Tero

