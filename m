From: Afzal Mohammed <afzal@ti.com>
Subject: Re: [PATCH 1/2] ARM: OMAP2+: hwmod: rt address space index for DT
Date: Wed, 24 Jul 2013 19:08:13 +0530
Message-ID: <51EFD8C5.8030505@ti.com>
References: <4bb04ee7bcb8ca73d5fc43049ba029471b9cdda3.1373036932.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50323 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750795Ab3GXNix (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Jul 2013 09:38:53 -0400
In-Reply-To: <4bb04ee7bcb8ca73d5fc43049ba029471b9cdda3.1373036932.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Paul Walmsley <paul@pwsan.com>, Benoit Cousson <benoit.cousson@linaro.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, benoit.cousson@gmail.com

Hi Paul, Benoit,

On 7/5/2013 8:43 PM, Afzal Mohammed wrote:

> Address space is being removed from hwmod database and DT information
> in <reg> property is being used. Currently the 0th index of device
> address space is used to map for register target address. This is not
> always true, eg. cpgmac has it's sysconfig in second address space.
>
> Handle it by specifying index of device address space to be used for
> register target. As default value of this field would be zero with
> static initialization, existing behaviour of using first address space
> for register target while using DT would be kept as such.

This series is required to fix the wrong register target address being 
picked up by hwmod for cpgmac on am335x.

Issue happened during last merge window cleanup, where address space was 
removed from hwmod, and in turn DTS was relied upon for address 
space(Earlier having the address space in hwmod did not cause any issue 
as 'ADDR_TYPE_RT' was used to specify proper address space index).

Please help this series reach mainline for v3.11

Regards
Afzal

