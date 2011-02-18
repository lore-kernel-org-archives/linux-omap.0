From: archit taneja <archit@ti.com>
Subject: Re: [PATCH] OMAP: DSS2: Have separate irq handlers for DISPC and
 DSI
Date: Fri, 18 Feb 2011 15:55:58 +0530
Message-ID: <4D5E4936.7040807@ti.com>
References: <1297952702-13419-1-git-send-email-archit@ti.com>	 <91F20383AC6A5F4DB94C692112281213B4C15EBB91@dlee07.ent.ti.com>	 <4D5E3D35.9000902@ti.com>	 <AANLkTik119ZB8+mR-MzXHUbZdxDo966HWehE8LeCxpWZ@mail.gmail.com> <1298022650.24062.20.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43198 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753673Ab1BRKYk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Feb 2011 05:24:40 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1IAObFK016929
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 18 Feb 2011 04:24:39 -0600
In-Reply-To: <1298022650.24062.20.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "Turquette, Mike" <mturquette@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>

On Friday 18 February 2011 03:20 PM, Valkeinen, Tomi wrote:
> On Fri, 2011-02-18 at 03:45 -0600, Turquette, Mike wrote:
>
> <snip>
>
>> PRM_IRQSTATUS_* registers will have status bits set even when the
>> corresponding PRM_IRQENABLE_* bits are not set.  The common assumption
>> was that status bits would not be set if interrupts weren't enabled
>> and this caused us some issues in prcm_interrupt_handler some time
>> back.  I don't know how DSS_IRQSTATUS works under the hood, but be
>> careful of such assumptions :-)

And, there is no DSS_IRQENABLE at all in our case :)

>
> That's how DISPC_IRQ* and DSI_IRQ* also works. But that's not what this
> discussion was about =). DISPC and DSI have a shared interrupt line, and
> there's a DSS_IRQSTATUS register with two bits, telling if the interrupt
> was for DISPC or DSI.
>
>   Tomi
>
>

