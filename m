From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCHv9 03/18] TEMP: OMAP3xxx: hwmod data: add PRM hwmod
Date: Wed, 12 Oct 2011 10:16:26 +0200
Message-ID: <4E954CDA.10107@ti.com>
References: <1316781986-30642-1-git-send-email-t-kristo@ti.com> <1316781986-30642-4-git-send-email-t-kristo@ti.com> <alpine.DEB.2.00.1110101320180.5205@utopia.booyaka.com> <4E934D79.4080000@ti.com> <alpine.DEB.2.00.1110101416530.5205@utopia.booyaka.com> <4E936F0E.9050203@ti.com> <alpine.DEB.2.00.1110101725140.5205@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40092 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751119Ab1JLIQc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Oct 2011 04:16:32 -0400
In-Reply-To: <alpine.DEB.2.00.1110101725140.5205@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Kristo, Tero" <t-kristo@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 10/11/2011 1:26 AM, Paul Walmsley wrote:
> On Tue, 11 Oct 2011, Cousson, Benoit wrote:
>
>> In fact the device name does not have to match the hwmod name. So we can just
>> create an "omap2_prm" omap_device for OMAP2, "omap3_prm" omap_device for
>> OMAP3...
>> That will allow the relevant PRM  driver to be bound to the proper device.
>
> Incidentally, given that we would be using the hwmod name and the version
> number to determine the appropriate omap_device name, what IP version
> numbers should we assign to these PRM IP blocks for different SoCs?

It can just be 1, 2 and 3... The idea is just to differentiate the IP 
for each OMAP.

Regards,
Benoit

