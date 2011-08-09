From: Scott Wood <scottwood@freescale.com>
Subject: Re: How to handle named resources with DT?
Date: Tue, 9 Aug 2011 13:26:29 -0500
Message-ID: <4E417BD5.8080409@freescale.com>
References: <4E40FC88.5090403@ti.com>	<20110809162907.GA630@manju-WNB7PBC4801-0006>	<4E4166F0.9050401@ti.com>	<CACxGe6tbEW1EZhqXy78EZVM_sQLH0Qbr7QOzbgbsKBRn1FtVrg@mail.gmail.com> <4E4172A8.3030101@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from va3ehsobe003.messaging.microsoft.com ([216.32.180.13]:38547
	"EHLO VA3EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750780Ab1HIS0m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Aug 2011 14:26:42 -0400
In-Reply-To: <4E4172A8.3030101@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 08/09/2011 12:47 PM, Cousson, Benoit wrote:
> On 8/9/2011 7:23 PM, Grant Likely wrote:
>> There is no analogous mechanism for _byname in the device tree.  The
>> DT binding for a device must explicitly state what order the register
>> ranges are in.  The driver will need to be adapted.
> 
> That seems to be a small regression for my point of view. Relying on the
> order is not super safe. This is not very readable either. That's for
> that exact reason that we changed our drivers to use
> platform_get_resource_byname. That's probably the reason why that API is
> there as well.
> For the same IP, the number of entries can vary depending of the SoC
> revision.
> By using the _byname, we can check if the resource is there or not
> without having to care about the position.

You could have a named u32 property that contains the reg index, e.g.:

dev {
	reg = <0x20000 0x200 0x24000 0x200>;
	foo-reg = <0>;
	bar-reg = <1>;
};

-Scott

