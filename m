From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 2/4] ARM: OMAP2/3: intc: Add DT support for TI interrupt
 controller
Date: Fri, 9 Dec 2011 17:58:26 +0100
Message-ID: <4EE23E32.2060503@ti.com>
References: <1323291049-24964-1-git-send-email-b-cousson@ti.com> <1323291049-24964-3-git-send-email-b-cousson@ti.com> <4EDFD88B.8060008@gmail.com> <4EE0D0E6.3060202@ti.com> <4EE20B38.8050006@gmail.com> <4EE2209E.2040209@ti.com> <4EE227A4.2030209@gmail.com> <4EE2320D.2030309@ti.com> <4EE2335C.7050902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55988 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751215Ab1LIQ6l (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Dec 2011 11:58:41 -0500
In-Reply-To: <4EE2335C.7050902@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: tony@atomide.com, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 12/9/2011 5:12 PM, Rob Herring wrote:
> On 12/09/2011 10:06 AM, Cousson, Benoit wrote:

[...]

>> Mmm, I'm probably missing something here.
>>
>> My point is that even in the DT case I do have some devices that are
>> initialized without DT for the moment and thus cannot get access to the
>> interrupt-controller node and then cannot retrieve the domain information.
>>
>> How can I ensure the proper hwirq ->  irq translation then for such devices?
>> Only the one created by DT will have the correct irq number.
>
> Okay, I missed that aspect of it. So I guess 0 base is fine for now.

Cool, thanks.
I'll repost early next week to take into account your other comments.

Thanks,
Benoit
