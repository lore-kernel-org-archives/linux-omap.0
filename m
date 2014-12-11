From: Nishanth Menon <nm@ti.com>
Subject: Re: omap3505: HECC support and DT ?
Date: Thu, 11 Dec 2014 10:04:07 -0600
Message-ID: <5489C077.6070806@ti.com>
References: <CAL8zT=izk+xk=v0M0F5DSgSySaGvkPWWZdCd43i8Z6bwQt7MAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57766 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934282AbaLKQEb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Dec 2014 11:04:31 -0500
In-Reply-To: <CAL8zT=izk+xk=v0M0F5DSgSySaGvkPWWZdCd43i8Z6bwQt7MAg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 12/11/2014 08:44 AM, Jean-Michel Hautbois wrote:
> Hi !
> 
> I have a custom board with a AM3505.
> I am trying to use linux 3.18 and I have difficulties making it work.
> What is needed in order to get it declared in DT ?
usually look at examples of an board file closely resembling the one
that you are working on and look at the commit that introduced it..
usually just Makefile and dts is needed.

> Is it still needed to have a board-am3517-myboard.c ?

ideally not. even for devices that are yet to be "dtfied" they
platform data goes to arch/arm/mach-omap2/pdata-quirks.c

See arch/arm/boot/dts/am3517-craneboard.dts as an example.

> 
> I have a few drivers like that I need to bring up (a Micrel KSZ8873
> for example) where the drivers exist, but a DT binding seems to be
> missing.

without checking the status of micrel driver in question, generically
speaking: not all drivers in linux kernel have been converted to
device tree. if your board uses one such driver, it is usually
strongly recommended to convert such a driver to DT and then integrate.

> But I may have missed the information, hence my question :).


-- 
Regards,
Nishanth Menon
